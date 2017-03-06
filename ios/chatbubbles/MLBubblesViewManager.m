//
//  ALBubblesViewManager.m
//  chatbubbles
//
//  Created by Leo Natan (Wix) on 06/03/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "MLBubblesViewManager.h"
#import "BubbleTableViewCell.h"

@import UIKit;

@interface MLBubblesViewManager () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MLBubblesViewManager
{
	UITableView* _tableView;
	NSArray<NSDictionary*>* _bubbles;
}

- (UIView*)view
{
	if(_tableView)
	{
		return _tableView;
	}
	
	_tableView = [[[UIStoryboard storyboardWithName:@"NativeCellsML" bundle:nil] instantiateInitialViewController] tableView];
	[_tableView removeFromSuperview];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.rowHeight = UITableViewAutomaticDimension;
	_tableView.estimatedRowHeight = 150;
	
	return _tableView;
}

RCT_CUSTOM_VIEW_PROPERTY(bubbles, NSArray<NSDictionary*>*, UITableView)
{
	_bubbles = [RCTConvert NSArray:json];
	[view reloadData];
}

RCT_EXPORT_MODULE()

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _bubbles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary* bubble = _bubbles[indexPath.row];
	
	NSMutableString* identifier = [([bubble[@"owner"] isEqualToString:@"me"] ? @"BubbleCell" : @"OtherBubbleCell") mutableCopy];
	if([bubble[@"type"] isEqualToString:@"image"])
	{
		[identifier appendString:@"Image"];
	}
	
	BubbleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
	
	if([bubble[@"type"] isEqualToString:@"image"])
	{
//		[cell loadImageWithURL:[NSURL URLWithString:bubble[@"url"]]];
		cell.attachmentImageView.image = [UIImage imageNamed:@"1"];
	}
	else
	{
		cell.label.text = bubble[@"text"];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary* bubble = _bubbles[indexPath.row];
	
	if([bubble[@"type"] isEqualToString:@"image"])
	{
		return 208;
	}

	return [bubble[@"text"] boundingRectWithSize:CGSizeMake(250, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]} context:nil].size.height + 8 + 16;
}

@end
