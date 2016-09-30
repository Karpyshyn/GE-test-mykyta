//
//  ResultTableViewCell.h
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

- (void)setLogo:(NSString *)logo timeInterval:(NSString *)timeInterval directValue:(NSString *)direct duration:(NSString *)duration cost:(NSString *)cost;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeRange;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *directness;

@end
