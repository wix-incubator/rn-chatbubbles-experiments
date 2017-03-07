//
//  ALBubblesViewController.m
//  BubbleSmoothnessTest
//
//  Created by Leo Natan (Wix) on 27/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "ALBubblesViewController.h"
#import "BubbleTableViewCell.h"
#import "AppDelegate.h"
#import <React/RCTBridge.h>

@implementation ALBubblesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 44;
	
	[self.tableView registerClass:[BubbleTableViewCell class] forCellReuseIdentifier:@"React"];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
	
	BubbleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"React" forIndexPath:indexPath];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if(cell.reactView == nil)
	{
		[cell addReactForIndexPath:indexPath bridge:appDelegate.bridge moduleName:@"Discoteque" initialProperties:@{@"isSlowdownEnabled": @(appDelegate.isSlowdownEnabled), @"index": @(indexPath.row)}];
	}
	else
	{
		cell.reactView.appProperties = @{@"index": @(indexPath.row)};
	}
	
	cell.textLabel.text = @(indexPath.row).stringValue;
	
	return cell;
}

@end
