//
//  MoreViewController.h
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import StoreKit;

@interface MoreViewController : UIViewController <SKStoreProductViewControllerDelegate>
- (IBAction)showMyApp:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavBar;
@end
