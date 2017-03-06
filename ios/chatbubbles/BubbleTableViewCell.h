//
//  BubbleTableViewCell.h
//  BubbleSmoothnessTest
//
//  Created by Leo Natan (Wix) on 27/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>

@interface BubbleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *attachmentImageView;

- (void)loadImageWithURL:(NSURL*)URL;

@end
