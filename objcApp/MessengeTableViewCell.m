//
//  MessageTableViewCell.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/3/22.
//

#import "MessengeTableViewCell.h"

@interface MessengeTableViewCell()
//@property (weak, nonatomic) IBOutlet UILabel *message;
@end

@implementation MessengeTableViewCell

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
