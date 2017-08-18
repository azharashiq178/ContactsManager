//
//  InternationalizeViewController.m
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "InternationalizeViewController.h"
#import "AppDelegate.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "NBPhoneNumberUtil.h"
#import "DGActivityIndicatorView.h"
//#import "ContactsTableViewCell.h"
#import "InternationalizeTableViewCell.h"


@interface InternationalizeViewController ()
@property (nonatomic,strong) NSMutableArray *myContacts;
@property (nonatomic,strong) DGActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) NSDictionary *contactsDictionary;
@property (nonatomic,strong) NSArray *allKeysInDic;
@property (nonatomic,strong) NSMutableArray *sectionColor;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation InternationalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myBanner.delegate = self;
    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/2144047657";
    self.myBanner.rootViewController = self;
    //    [self.myBanner setAutoloadEnabled:YES];
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[
                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
                            ];
    [self.myBanner loadRequest:request];
    [self.contactsTableView setHidden:YES];
    [self.contactsTableView setDelegate:self];
//    UIImageView *navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 60)];
//    [navImage setContentMode:UIViewContentModeScaleAspectFit];
//    navImage.image = [UIImage imageNamed:@"header_logo"];
//    self.myNavBar.topItem.titleView = navImage;
    [self initNavigationBar];
    self.interstitial = [self createAndLoadInterstitial];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    self.interstitial = [self createAndLoadInterstitial];
    [self.tabBarController setDelegate:self];
    
    
    if([self.contactsDictionary count] == 0){
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.myContacts = appDelegate.myStoredContacts;
        self.contactsDictionary = @{@"A":[[NSMutableArray alloc] init],
                                    @"B":[[NSMutableArray alloc] init],
                                    @"C":[[NSMutableArray alloc] init],
                                    @"D":[[NSMutableArray alloc] init],
                                    @"E":[[NSMutableArray alloc] init],
                                    @"F":[[NSMutableArray alloc] init],
                                    @"G":[[NSMutableArray alloc] init],
                                    @"H":[[NSMutableArray alloc] init],
                                    @"I":[[NSMutableArray alloc] init],
                                    @"J":[[NSMutableArray alloc] init],
                                    @"K":[[NSMutableArray alloc] init],
                                    @"L":[[NSMutableArray alloc] init],
                                    @"M":[[NSMutableArray alloc] init],
                                    @"N":[[NSMutableArray alloc] init],
                                    @"O":[[NSMutableArray alloc] init],
                                    @"P":[[NSMutableArray alloc] init],
                                    @"Q":[[NSMutableArray alloc] init],
                                    @"R":[[NSMutableArray alloc] init],
                                    @"S":[[NSMutableArray alloc] init],
                                    @"T":[[NSMutableArray alloc] init],
                                    @"U":[[NSMutableArray alloc] init],
                                    @"V":[[NSMutableArray alloc] init],
                                    @"W":[[NSMutableArray alloc] init],
                                    @"X":[[NSMutableArray alloc] init],
                                    @"Y":[[NSMutableArray alloc] init],
                                    @"Z":[[NSMutableArray alloc] init]};
        self.allKeysInDic = [[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self registerNibs];
        [self initSectionColors];
        
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // code here
//            //                NSLog(@"My Contacts are in viewdidload %@",[self.myContacts objectAtIndex:0]);
//            [self.contactsTableView setHidden:YES];
//            self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
//            
//            _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0);
//            
//            [self.view addSubview:_activityIndicatorView];
//            
//            [_activityIndicatorView setHidden:NO];
//            
//            [_activityIndicatorView startAnimating];
//            [self.contactsTableView setHidden:YES];
//            
//        });
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // Add code here to do background processing
            //
            //
            [self performInternationalization];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Here");
                [self.activityIndicatorView stopAnimating];
                [self.contactsTableView reloadData];
                [self.contactsTableView setHidden:NO];
                if (self.interstitial.isReady) {
                    [self.interstitial presentFromRootViewController:self];
                }
                
            });
            
        });
    }
    
    
    
    
//    [_activityIndicatorView stopAnimating];
}
-(void)viewWillAppear:(BOOL)animated{
    if([self.contactsDictionary count] == 0){
        [self.contactsTableView setHidden:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            // code here
            //                NSLog(@"My Contacts are in viewdidload %@",[self.myContacts objectAtIndex:0]);
            [self.contactsTableView setHidden:YES];
            self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
            
            _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0);
            
            [self.view addSubview:_activityIndicatorView];
            
            [_activityIndicatorView setHidden:NO];
            
            [_activityIndicatorView startAnimating];
            [self.contactsTableView setHidden:YES];
            
        });
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)performInternationalization{
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    for(int i = 0 ;i < [self.myContacts count];i++){
        
        CNMutableContact *tmpContact = [[self.myContacts objectAtIndex:i] mutableCopy];
        
        if([tmpContact.phoneNumbers count]!=0){
//            if([tmpContact.phoneNumbers count] >1){
                NSArray *tmpContactNum = tmpContact.phoneNumbers;
                NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                for(int j = 0 ;j < [tmpContact.phoneNumbers count] ;j++){
                    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
                    NSError *error = nil;
                    NSString *countryCode = [[[tmpContactNum objectAtIndex:j] valueForKey:@"value"] valueForKey:@"countryCode"];
                    
//                    NSString *countryName = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
                    
                    NBPhoneNumber *phoneNum = [phoneUtil parse:[NSString stringWithFormat:@"%@", [[[tmpContactNum objectAtIndex:j] valueForKey:@"value"] valueForKey:@"digits"]] defaultRegion:countryCode error:&error];
                    if(error == nil){
                        CNPhoneNumber *tmpPhoneNumber = [CNPhoneNumber phoneNumberWithStringValue:[phoneUtil format:phoneNum numberFormat:NBEPhoneNumberFormatE164 error:&error]];
                        
                        NSString *labelString = [[tmpContactNum objectAtIndex:j] valueForKey:@"label"];
                        
                        CNLabeledValue *tmpLabel = [CNLabeledValue labeledValueWithLabel:labelString value:tmpPhoneNumber];
                        
                        [tmpArray addObject:tmpLabel];
                    }
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//                    CollectionViewCell *cell = (CollectionViewCell *)[self.contactsCollectionView cellForItemAtIndexPath:indexPath];
//                    cell.countryFlag.image = [UIImage imageNamed:countryName];
                    
                }
                tmpContactNum = [[NSArray alloc] init];
                tmpContactNum = tmpArray;
                tmpContact.phoneNumbers = tmpContactNum;
                CNContact *newContact = tmpContact;
                [request updateContact:tmpContact];
            
            
                [self.myContacts removeObjectAtIndex:i];
                [self.myContacts insertObject:newContact atIndex:i];
                
                
                
//            }
//            else{
//                NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
//                NSError *error = nil;
//                NSString *countryCode = [[[tmpContact.phoneNumbers objectAtIndex:0] value] valueForKey:@"countryCode"];
//                
//                NSString *countryName = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
//                
//                NBPhoneNumber *phoneNum = [phoneUtil parse:[NSString stringWithFormat:@"%@",[[[tmpContact.phoneNumbers objectAtIndex:0] value] valueForKey:@"digits"]] defaultRegion:countryCode error:&error];
//                if(error == nil){
//                    CNPhoneNumber *tmpPhoneNumber = [[[tmpContact.phoneNumbers objectAtIndex:0] value] valueForKey:@"digits"];
//                    
//                    tmpPhoneNumber = [CNPhoneNumber phoneNumberWithStringValue:[phoneUtil format:phoneNum numberFormat:NBEPhoneNumberFormatE164 error:&error]];
//                    
//                    CNLabeledValue *tmpLabel = [CNLabeledValue labeledValueWithLabel:[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"label"] value:tmpPhoneNumber];
//                    tmpContact.phoneNumbers = @[tmpLabel];
//                    
////                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
////                    CollectionViewCell *cell = (CollectionViewCell *)[self.contactsCollectionView cellForItemAtIndexPath:indexPath];
////                    cell.countryFlag.image = [UIImage imageNamed:countryName];
//                    
//                    CNContact *newContact = tmpContact;
//                    
//                    
//                    NSError *error = nil;
//                    [request updateContact:tmpContact];
//                    [store executeSaveRequest:request error:&error];
//                    if(error!=nil){
//                        NSLog(@"%@",error);
//                    }
//                    
//                    [self.myContacts removeObjectAtIndex:i];
//                    [self.myContacts insertObject:newContact atIndex:i];
//                    //                    [self.myContacts addObject:newContact];
//                }
//            }
        }
    }
    [store executeSaveRequest:request error:nil];
    
    for (int i = 0; i < [self.myContacts count]; i++) {
        CNContact *tmpContact = [self.myContacts objectAtIndex:i];
        if([tmpContact.givenName length] != 0){
            
            NSString *myKey = [tmpContact.givenName substringToIndex:1];
            [[self.contactsDictionary valueForKey:myKey] addObject:tmpContact];
        }
    }
    
    NSLog(@"My Dict is %@",self.contactsDictionary);
    [self.contactsTableView reloadData];
    
//    [self.contactsCollectionView reloadData];
}
-(void)registerNibs{
    
    [self.contactsTableView registerNib:[UINib nibWithNibName:@"InternationalizeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"internationalize"];
}
-(void)initNavigationBar{
    UIImageView *navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    [navImage setContentMode:UIViewContentModeScaleAspectFit];
    navImage.image = [UIImage imageNamed:@"header_logo"];
    //    self.navigationItem.titleView = navImage;
    self.navigationController.navigationBar.topItem.titleView = navImage;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contactsDictionary count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.allKeysInDic objectAtIndex:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if([[self.contactsDictionary valueForKey:[NSString stringWithFormat:@"%@",[self.allKeysInDic objectAtIndex:section]]] count] == 0){
        return 0;
    }
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 30, 30)];
    titleLabel.text = [self.allKeysInDic objectAtIndex:section];
    [titleLabel setFont:[UIFont systemFontOfSize:26]];
    [headerView addSubview:titleLabel];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(-15, 0, 30, 30)];
    [colorView.layer setCornerRadius:15];
    [colorView setClipsToBounds:YES];
    [colorView setBackgroundColor:[self.sectionColor objectAtIndex:section]];
    [headerView addSubview:colorView];
    
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InternationalizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"internationalize"];
    if(cell == nil){
        cell = [[InternationalizeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"internationalize"];
    }
    //    cell.textLabel.text = @"Azher";
    CNContact *tmpContact = [[self.contactsDictionary valueForKey:[self.allKeysInDic objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    NSString *tmpStr;
    if(([tmpContact.givenName isEqualToString:@""]) && ([tmpContact.familyName isEqualToString:@""])){
        tmpStr = @"";
    }
    else if([tmpContact.givenName isEqualToString:@""]){
        NSString *myString = tmpContact.familyName;
        if(myString.length == 1){
            tmpStr = tmpContact.familyName;
        }
        else
            tmpStr = [NSString stringWithFormat:@"%@",[tmpContact.familyName substringToIndex:2]];
    }
    else if([tmpContact.familyName isEqualToString:@""]){
        NSString *myString = tmpContact.givenName;
        if(myString.length == 1){
            tmpStr = tmpContact.givenName;
        }
        else
            tmpStr = [NSString stringWithFormat:@"%@",[tmpContact.givenName substringToIndex:2]];
    }
    else{
        tmpStr = [NSString stringWithFormat:@"%@%@",[tmpContact.givenName substringToIndex:1],[tmpContact.familyName substringToIndex:1]];
    }
    cell.firstLastName.text = tmpStr;
    
    if(tmpContact.imageData!=nil){
        cell.personImage.image = [UIImage imageWithData:tmpContact.imageData];
        [cell.personImage setHidden:NO];
        [cell.firstLastName setHidden:YES];
    }
    else{
        [cell.firstLastName setHidden:NO];
        [cell.personImage setHidden:YES];
    }
    
    if([tmpContact.phoneNumbers count]!= 0){
        cell.personPhoneNo.text = [NSString stringWithFormat:@"%@",[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]];
    }
    else{
        cell.personPhoneNo.text = @"";
    }
    
    cell.firstName.text = [NSString stringWithFormat:@"%@ %@",tmpContact.givenName,tmpContact.familyName];
//    NSLog(@"%@",[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"countryCode"]);
    
    
//    cell.flagImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"countryCode"]]];
    
    if([tmpContact.phoneNumbers count]!=0){
        NSString *country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"countryCode"]];
        if(country != nil && ![country  isEqual: @""]){
            [cell.flagImage.layer setCornerRadius:15];
            cell.flagImage.clipsToBounds = YES;
            cell.flagImage.image = [UIImage imageNamed:country];
        }
        
        else
            cell.flagImage.image = nil;
    }
    
//    NSString *country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"countryCode"]];
//    if(country != nil && ![country  isEqual: @""]){
//        [cell.flagImage.layer setCornerRadius:15];
//        cell.flagImage.clipsToBounds = YES;
//        cell.flagImage.image = [UIImage imageNamed:country];
//    }
    
    else
        cell.flagImage.image = nil;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.textLabel.text = @"Azher";
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contactsDictionary valueForKey:[self.allKeysInDic objectAtIndex:section]] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)initSectionColors{
    self.sectionColor = [[NSMutableArray alloc] init];
    
    float INCREMENT = 0.01;
    
    for (float hue = 0.0; hue < 10000.0; hue += INCREMENT)
    {
        UIColor *color = [UIColor colorWithHue:hue
                                    saturation:3.0
                                    brightness:0.7
                                         alpha:1.0];
        
        CGFloat oldHue, saturation, brightness, alpha ;
        
        BOOL gotHue = [color getHue:&oldHue saturation:&saturation brightness:&brightness alpha:&alpha ];
        
        if (gotHue)
        {
            
            UIColor * newerColor = [ UIColor colorWithHue:hue saturation:0.5 brightness:brightness alpha:alpha ];
            
            [self.sectionColor addObject:newerColor];
            
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.87 green:0.89  blue:0.91 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.03 green:0.18 blue:0.36 alpha:1];
    CNContactStore *store = [CNContactStore new];
    
    CNContactViewController *picker = [[CNContactViewController alloc] init];
//    NSArray *myAllKeys = [self.contactsDictionary allKeys];
    NSString *tmpKey = [NSString stringWithFormat:@"%@", [_allKeysInDic objectAtIndex:indexPath.section]];
    CNContact *myContact = [[self.contactsDictionary valueForKey:tmpKey] objectAtIndex:indexPath.row];
    myContact = [store unifiedContactWithIdentifier:myContact.identifier keysToFetch:@[[CNContactViewController descriptorForRequiredKeys] ] error:nil];
    picker = [CNContactViewController viewControllerForContact:myContact];
    picker.contactStore = store;
    picker.delegate = self;
    [picker setDelegate:self];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    picker.edgesForExtendedLayout = UIRectEdgeTop;
    [self.navigationController pushViewController:picker animated:YES];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.contactsDictionary = [[NSDictionary alloc] init];
}
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    self.contactsTableView.frame = CGRectMake(self.contactsTableView.frame.origin.x, self.contactsTableView.frame.origin.y, self.contactsTableView.frame.size.width, self.contactsTableView.frame.size.height - 70);
    [self.contactsTableView reloadData];
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6412217023250030/1786299909"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}
@end
