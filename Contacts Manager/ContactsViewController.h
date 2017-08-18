//
//  ContactsViewController.h
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface ContactsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *myNavBar;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet GADBannerView *myBanner;
@property (nonatomic,strong) NSMutableArray *myContacts;
@end
