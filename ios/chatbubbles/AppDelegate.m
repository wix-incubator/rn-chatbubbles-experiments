/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridge.h>

#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation AppDelegate
{
	UIWindow* _infoWindow;
	UILabel* _infoLabel;
	NSByteCountFormatter* _byteFormatter;
	
	processor_info_array_t cpuInfo, prevCpuInfo;
	mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
	unsigned numCPUs;
	NSTimer *updateTimer;
	NSLock *CPUUsageLock;
	
	RCTBridge* _bridge;
	BOOL _slowdownEnabled;
}

- (void)switchValueDidChange:(UISwitch*)sender
{
	_slowdownEnabled = sender.isOn;
}

- (BOOL)isSlowdownEnabled
{
	return _slowdownEnabled;
}

- (RCTBridge*)bridge
{
	if(_bridge)
	{
		return _bridge;
	}
	
	NSURL* jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
	_bridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation moduleProvider:nil launchOptions:nil];
	
	return _bridge;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[[UIApplication sharedApplication] setValue:@(0) forKeyPath:@"statusBarWindow.alpha"];
		
		UIViewController* rootVC = [UIViewController new];
		
		_byteFormatter = [NSByteCountFormatter new];
		_byteFormatter.countStyle = NSByteCountFormatterCountStyleMemory;
		
		_infoWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
		_infoWindow.windowLevel = UIWindowLevelAlert + 1;
		
		_infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rootVC.view.bounds.size.width, 22)];
		_infoLabel.text = @"Test";
		_infoLabel.textAlignment = NSTextAlignmentCenter;
		_infoLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
		_infoLabel.textColor = [UIColor whiteColor];
		_infoLabel.backgroundColor = [UIColor blackColor];
		_infoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_infoLabel.userInteractionEnabled = NO;
		
		[rootVC.view addSubview:_infoLabel];
		
		[_infoWindow setRootViewController:rootVC];
		_infoWindow.hidden = NO;
		_infoWindow.userInteractionEnabled = NO;
		
		int mib[2U] = { CTL_HW, HW_NCPU };
		size_t sizeOfNumCPUs = sizeof(numCPUs);
		int status = sysctl(mib, 2U, &numCPUs, &sizeOfNumCPUs, NULL, 0U);
		if(status)
		{
			numCPUs = 1;
		}
		
		CPUUsageLock = [[NSLock alloc] init];
		
		[self startTimer];
	});
	
	return YES;
}

- (void)startTimer
{
	_infoLabel.text = [NSString stringWithFormat:@"Memory: %@", [_byteFormatter stringFromByteCount:[self currentMemoryUsage]]];
	
//	[self updateInfo];
	
	NSTimer* t = [NSTimer timerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
		[self startTimer];
	}];
	[[NSRunLoop mainRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
}

- (double)currentMemoryUsage
{
	struct task_basic_info info;
	mach_msg_type_number_t size = sizeof(info);
	kern_return_t kerr = task_info(mach_task_self(),
								   TASK_BASIC_INFO,
								   (task_info_t)&info,
								   &size);
	if(kerr == KERN_SUCCESS)
	{
		return info.resident_size;
	}
	
	return 0;
}

- (void)updateInfo
{
	natural_t numCPUsU = 0U;
	kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &cpuInfo, &numCpuInfo);
	if(err == KERN_SUCCESS) {
		[CPUUsageLock lock];
		
		for(unsigned i = 0U; i < numCPUs; ++i) {
			float inUse, total;
			if(prevCpuInfo) {
				inUse = (
						 (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
						 + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
						 + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
						 );
				total = inUse + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
			} else {
				inUse = cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
				total = inUse + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
			}
			
			NSLog(@"Core: %u Usage: %f",i,inUse / total);
		}
		[CPUUsageLock unlock];
		
		if(prevCpuInfo) {
			size_t prevCpuInfoSize = sizeof(integer_t) * numPrevCpuInfo;
			vm_deallocate(mach_task_self(), (vm_address_t)prevCpuInfo, prevCpuInfoSize);
		}
		
		prevCpuInfo = cpuInfo;
		numPrevCpuInfo = numCpuInfo;
		
		cpuInfo = NULL;
		numCpuInfo = 0U;
	} else {
		NSLog(@"Error!");
	}
}

@end
