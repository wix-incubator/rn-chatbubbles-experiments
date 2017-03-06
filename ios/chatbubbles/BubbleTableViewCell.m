//
//  BubbleTableViewCell.m
//  BubbleSmoothnessTest
//
//  Created by Leo Natan (Wix) on 27/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "BubbleTableViewCell.h"

@implementation BubbleTableViewCell
{
	NSURLSessionTask* _pendingImageTask;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	[_pendingImageTask cancel];
	_pendingImageTask = nil;
	
	self.attachmentImageView.image = nil;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	if(self.attachmentImageView != nil)
	{
		UIImageView* maskView = [UIImageView new];
		maskView.image = [UIImage imageNamed:@"bubble_min_tailless"];
		maskView.frame = CGRectMake(0, 0, 200, 200);
		self.attachmentImageView.maskView = maskView;
	}
}

- (void)loadImageWithURL:(NSURL*)url
{
	_pendingImageTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		_pendingImageTask = nil;
		
		if(error != nil)
		{
			return;
		}
		
		if(data == nil)
		{
			return;
		}
		
		UIImage* image = [UIImage imageWithData:data];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			self.attachmentImageView.image = image;
		});
	}];
	[_pendingImageTask resume];
}

@end
