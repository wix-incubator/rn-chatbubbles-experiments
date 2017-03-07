//
//  InNativeItWouldNotHaveHappenedViewController.m
//  chatbubbles
//
//  Created by Leo Natan (Wix) on 06/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "InNativeItWouldNotHaveHappenedViewController2.h"
#import "AppDelegate.h"
#import <React/RCTRootView.h>

@interface InNativeItWouldNotHaveHappenedViewController2 ()

@end

@implementation InNativeItWouldNotHaveHappenedViewController2

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
	RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:appDelegate.bridge moduleName:@"native_ml" initialProperties:@{@"isSlowdownEnabled": @(appDelegate.isSlowdownEnabled)}];
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
