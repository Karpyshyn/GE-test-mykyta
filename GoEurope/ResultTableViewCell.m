//
//  ResultTableViewCell.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ResultTableViewCell()
@end


@implementation ResultTableViewCell


- (void)setLogo:(NSString *)logo timeInterval:(NSString *)timeInterval directValue:(NSString *)direct duration:(NSString *)duration cost:(NSString *)cost{
	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:logo]
												  cachePolicy:NSURLRequestReturnCacheDataElseLoad
											  timeoutInterval:60];
	[_logoImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];
	
	_directness.text = direct;
	_timeRange.text = timeInterval;
	_duration.text = duration;
	_price.text = cost;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
