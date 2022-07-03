//
//  MessageTableViewCell.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/3/22.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell()
//@property (weak, nonatomic) IBOutlet UILabel *message;
@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _messageView.layer.borderWidth = 1;
    _messageView.layer.cornerRadius = 10;
    _messageView.backgroundColor = UIColor.whiteColor;
    _messageView.layer.opacity = 0.8;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
