//
//  SenderTableViewCell.h
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SenderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@end

NS_ASSUME_NONNULL_END
