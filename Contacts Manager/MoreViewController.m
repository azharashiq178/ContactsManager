//
//  MoreViewController.m
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "MoreViewController.h"
#import <StoreKit/StoreKit.h>
#import "DGActivityIndicatorView.h"


@interface MoreViewController ()
@property (nonatomic,strong) SKStoreProductViewController *storeProductViewController;
@property (nonatomic,strong) DGActivityIndicatorView *activityIndicatorView;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    [navImage setContentMode:UIViewContentModeScaleAspectFit];
    navImage.image = [UIImage imageNamed:@"header_logo"];
    self.myNavBar.topItem.titleView = navImage;
    
    _storeProductViewController = [[SKStoreProductViewController alloc] init];
    self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
    
    _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0);
    
    [self.view addSubview:_activityIndicatorView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMyApp:(id)sender {
//    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    // Configure View Controller
    [_activityIndicatorView setHidden:NO];
    
    [_activityIndicatorView startAnimating];
    if([SKStoreReviewController class]){
        [SKStoreReviewController requestReview];
        [_activityIndicatorView stopAnimating];
        
    }
//    [_storeProductViewController setDelegate:self];
//    [_storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"284417350"} completionBlock:^(BOOL result, NSError *error) {
//        if (error) {
//            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
//            
//        } else {
//            [_activityIndicatorView setHidden:YES];
//            
//            [_activityIndicatorView stopAnimating];
//            // Present Store Product View Controller
//            [self presentViewController:_storeProductViewController animated:YES completion:nil];
//        }
//    }];
}
- (IBAction)showMoreApps:(id)sender {
//    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    // Configure View Controller
    [_activityIndicatorView setHidden:NO];
    
    [_activityIndicatorView startAnimating];
    [_storeProductViewController setDelegate:self];
    [_storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"1258137713"} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            [_activityIndicatorView setHidden:YES];
            
            [_activityIndicatorView stopAnimating];
            UIAlertController *tmpController = [UIAlertController alertControllerWithTitle:@"Process Couldn't be completed" message:@"Cannot open appstore" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:tmpController animated:YES completion:nil];
            
        } else {
            // Present Store Product View Controller
            [_activityIndicatorView setHidden:YES];
            
            [_activityIndicatorView stopAnimating];
            [self presentViewController:_storeProductViewController animated:YES completion:nil];
        }
    }];
}
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [_storeProductViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
