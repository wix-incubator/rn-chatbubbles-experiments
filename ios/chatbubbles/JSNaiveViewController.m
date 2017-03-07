//
//  JSNaiveViewController.m
//  chatbubbles
//
//  Created by Leo Natan (Wix) on 06/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "JSNaiveViewController.h"
#import "AppDelegate.h"
#import <React/RCTRootView.h>

@interface JSNaiveViewController ()

@end

@implementation JSNaiveViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
	RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:appDelegate.bridge moduleName:@"chatbubbles_js_naive" initialProperties:@{@"isSlowdownEnabled": @(appDelegate.isSlowdownEnabled)}];
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
