//
//  SenderTableViewCell.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/8/22.
//

#import "SenderTableViewCell.h"

@implementation SenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _messageView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
