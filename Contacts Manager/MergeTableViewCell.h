//
//  MergeTableViewCell.h
//  Contacts Manager
//
//  Created by Muhammad Azher on 11/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MergeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstLastName;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *personPhoneNo;
@end
