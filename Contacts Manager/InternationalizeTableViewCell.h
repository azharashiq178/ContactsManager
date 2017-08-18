//
//  InternationalizeTableViewCell.h
//  Contacts Manager
//
//  Created by apple on 8/14/17.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InternationalizeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstLastName;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *personPhoneNo;
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;

@end
