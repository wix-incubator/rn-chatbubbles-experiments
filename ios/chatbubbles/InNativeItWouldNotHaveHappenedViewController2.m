//
//  InNativeItWouldNotHaveHappenedViewController.m
//  chatbubbles
//
//  Created by Leo Natan (Wix) on 06/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "InNativeItWouldNotHaveHappenedViewController2.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface InNativeItWouldNotHaveHappenedViewController2 ()

@end

@implementation InNativeItWouldNotHaveHappenedViewController2

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSURL* jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
	RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"native_ml" initialProperties:nil launchOptions:nil];
	rootView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:rootView];
	
	[NSLayoutConstraint activateConstraints:@[[self.topLayoutGuide.bottomAnchor constraintEqualToAnchor:rootView.topAnchor],
											  [self.view.bottomAnchor constraintEqualToAnchor:rootView.bottomAnchor],
											  [self.view.leftAnchor constraintEqualToAnchor:rootView.leftAnchor],
											  [self.view.rightAnchor constraintEqualToAnchor:rootView.rightAnchor]]];
}

- (BOOL)automaticallyAdjustsScrollViewInsets
{
	return NO;
}

@end
