//
//  BubbleTableViewCell.h
//  BubbleSmoothnessTest
//
//  Created by Leo Natan (Wix) on 27/02/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTRootView.h>

@interface BubbleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *attachmentImageView;

@property (nonatomic, strong) RCTRootView* reactView;

- (void)loadImageWithURL:(NSURL*)URL;
- (void)addReactForIndexPath:(NSIndexPath*)indexPath bridge:(RCTBridge*)bridge moduleName:(NSString*)moduleName initialProperties:(NSDictionary*)props;

@end
