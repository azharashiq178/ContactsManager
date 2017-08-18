//
//  MergeViewController.h
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface MergeViewController : UIViewController <UITabBarControllerDelegate,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavBar;
@property (strong, nonatomic) IBOutlet GADBannerView *myBanner;
@property (weak, nonatomic) IBOutlet UILabel *selectTypeLabe;
@property (weak, nonatomic) IBOutlet UILabel *mergeByLabel;
@property (weak, nonatomic) IBOutlet UIButton *byNameButton;
@property (weak, nonatomic) IBOutlet UIButton *byPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *byEmailButton;

- (IBAction)mergeByNameAction:(id)sender;
- (IBAction)mergeByPhoneAction:(id)sender;
- (IBAction)mergeByEmailAction:(id)sender;

@end
