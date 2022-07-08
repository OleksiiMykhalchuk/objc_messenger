//
//  MessageTableViewCell.h
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessengeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@end

NS_ASSUME_NONNULL_END
