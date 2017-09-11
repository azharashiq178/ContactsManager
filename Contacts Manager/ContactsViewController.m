//
//  ContactsViewController.m
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "ContactsViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "ContactsTableViewCell.h"
#import "DGActivityIndicatorView.h"
#import "AppDelegate.h"

@interface ContactsViewController ()
@property (nonatomic,strong) NSMutableArray *allKeysInDic;
@property (nonatomic,strong) NSDictionary *contactsDictionary;
@property (nonatomic,strong) NSMutableArray *sectionColor;
@property (nonatomic,strong) DGActivityIndicatorView *activityIndicatorView;
//@property (nonatomic,strong) NSMutableArray *appDel;
@end

@implementation ContactsViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setDelegate:self];
    AppDelegate *appD = [[UIApplication sharedApplication] delegate];
    if([appD.myStoredContacts count]!= 0){
        self.myContacts = appD.myStoredContacts;
//        self.contactsDictionary = @{@"A":[[NSMutableArray alloc] init],
//                                    @"B":[[NSMutableArray alloc] init],
//                                    @"C":[[NSMutableArray alloc] init],
//                                    @"D":[[NSMutableArray alloc] init],
//                                    @"E":[[NSMutableArray alloc] init],
//                                    @"F":[[NSMutableArray alloc] init],
//                                    @"G":[[NSMutableArray alloc] init],
//                                    @"H":[[NSMutableArray alloc] init],
//                                    @"I":[[NSMutableArray alloc] init],
//                                    @"J":[[NSMutableArray alloc] init],
//                                    @"K":[[NSMutableArray alloc] init],
//                                    @"L":[[NSMutableArray alloc] init],
//                                    @"M":[[NSMutableArray alloc] init],
//                                    @"N":[[NSMutableArray alloc] init],
//                                    @"O":[[NSMutableArray alloc] init],
//                                    @"P":[[NSMutableArray alloc] init],
//                                    @"Q":[[NSMutableArray alloc] init],
//                                    @"R":[[NSMutableArray alloc] init],
//                                    @"S":[[NSMutableArray alloc] init],
//                                    @"T":[[NSMutableArray alloc] init],
//                                    @"U":[[NSMutableArray alloc] init],
//                                    @"V":[[NSMutableArray alloc] init],
//                                    @"W":[[NSMutableArray alloc] init],
//                                    @"X":[[NSMutableArray alloc] init],
//                                    @"Y":[[NSMutableArray alloc] init],
//                                    @"Z":[[NSMutableArray alloc] init]};
        for(int i = 0 ;i < [self.myContacts count] ;i++){
            
            CNContact *contact = [self.myContacts objectAtIndex:i];
            if([contact.givenName length] != 0){
                
                NSString *myKey = [contact.givenName substringToIndex:1];
                [[self.contactsDictionary valueForKey:myKey] addObject:contact];
            }
        }
        [self.contactsTableView reloadData];
    }
//    self.myBanner.delegate = self;
//    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/1977871594";
//    self.myBanner.rootViewController = self;
////    [self.view addSubview:self.myBanner];
//    
//    GADRequest *request = [GADRequest request];
//    // Requests test ads on devices you specify. Your test device ID is printed to the console when
//    // an ad request is made. GADBannerView automatically returns test ads when running on a
//    // simulator.
//    request.testDevices = @[
//                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
//                            ];
//    [self.myBanner loadRequest:request];
//    NSLog(@"My Contact are in viewwillappear %@",self.myContacts);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myBanner.delegate = self;
    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/1977871594";
    self.myBanner.rootViewController = self;
    //    [self.view addSubview:self.myBanner];
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[
                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
                            ];
    [self.myBanner loadRequest:request];
    [self.tabBarController setDelegate:self];
    [self initNavigationBar];
    [self registerNibs];
    [self.contactsTableView setDelegate:self];
    [self.contactsTableView setHidden:YES];
    [self.contactsTableView setUserInteractionEnabled:NO];
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
    self.allKeysInDic = (NSMutableArray *)[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
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
    
    self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
    
    _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 -50, 0, 0);
    
    [self.view addSubview:_activityIndicatorView];
    
    [_activityIndicatorView setHidden:NO];
    
    [_activityIndicatorView startAnimating];
    
    
    [self fetchAllContacts];
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
-(void)initNavigationBar{
    UIImageView *navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    [navImage setContentMode:UIViewContentModeScaleAspectFit];
    navImage.image = [UIImage imageNamed:@"header_logo"];
//    self.navigationItem.titleView = navImage;
    self.navigationController.navigationBar.topItem.titleView = navImage;

}
-(void)fetchAllContacts{
    self.myContacts = [[NSMutableArray alloc] init];
    CNContactStore *store = [CNContactStore new];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted){
            //            CNContactStore *addressBook = [[CNContactStore alloc] init];
//            NSArray *keysToFetch = @[CNContactEmailAddressesKey,
//                                     CNContactFamilyNameKey,
//                                     CNContactGivenNameKey,
//                                     CNContactPhoneNumbersKey,
//                                     CNContactPostalAddressesKey,
//                                     CNContactOrganizationNameKey,
//                                     CNContactImageDataKey,
//                                     CNContactImageDataAvailableKey];
            NSArray * keysToFetch = @[[CNContactVCardSerialization descriptorForRequiredKeys]];
            
            
            
            CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
            [store enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                //            [self.groupOfContacts addObject:contact];
                [self.myContacts addObject:contact];
                if([contact.givenName length] != 0){
                    
                    NSString *myKey = [contact.givenName substringToIndex:1];
                    [[self.contactsDictionary valueForKey:myKey] addObject:contact];
                }
                else if ([contact.givenName length] == 0 && [contact.phoneNumbers count]!= 0){
                    NSString *myKey = [[[[contact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"] substringToIndex:1];
                    if([self.contactsDictionary valueForKey:myKey] == nil){
                        NSLog(@"No Key Found");
                        NSMutableDictionary *tmpDic = [self.contactsDictionary mutableCopy];
                        [tmpDic setObject:[[NSMutableArray alloc] init] forKey:myKey];
//                        [self.allKeysInDic addObject:myKey];
                        self.contactsDictionary = tmpDic;
//                        [self.contactsDictionary setValue:[[NSMutableArray alloc] init] forKey:myKey];
                        
                        [[self.contactsDictionary valueForKey:myKey] addObject:contact];
                    }
                    else
                        [[self.contactsDictionary valueForKey:myKey] addObject:contact];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                // code here
//                NSLog(@"My Contacts are in viewdidload %@",[self.myContacts objectAtIndex:0]);
                [self.contactsTableView setHidden:NO];
                [self.contactsTableView setUserInteractionEnabled:YES];
                
                [_activityIndicatorView stopAnimating];
                [self.contactsTableView reloadData];
                AppDelegate *appD = [[UIApplication sharedApplication] delegate];
                appD.myStoredContacts = self.myContacts;
                
            });
            
        }
        
    }];
}

-(void)registerNibs{
    [self.contactsTableView registerNib:[UINib nibWithNibName:@"ContactsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"contactCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contactsDictionary count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if([[self.contactsDictionary valueForKey:[NSString stringWithFormat:@"%@",[self.allKeysInDic objectAtIndex:section]]] count] == 0){
    
    
    if([[self.contactsDictionary valueForKey:[NSString stringWithFormat:@"%@",[[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]]] count] == 0){
        return 0;
    }
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 20, 20)];
    
    sectionTitleLabel.text = [[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    
    sectionTitleLabel.textColor = [UIColor whiteColor];
    sectionTitleLabel.textAlignment = NSTextAlignmentCenter;
    [sectionTitleLabel.layer setCornerRadius:10];
    [sectionTitleLabel setClipsToBounds:YES];
    [sectionTitleLabel setBackgroundColor:[self.sectionColor objectAtIndex:section]];
    
    [headerView addSubview:sectionTitleLabel];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(35, 15)];
    [linePath addLineToPoint:CGPointMake(tableView.frame.size.width-40, 15)];
    line.lineWidth = 0.5;
    line.path=linePath.CGPath;
    line.fillColor = [[self.sectionColor objectAtIndex:section] CGColor];
    line.strokeColor = [[self.sectionColor objectAtIndex:section] CGColor];
    [[headerView layer] addSublayer:line];

    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contactsDictionary valueForKey:[[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    if(cell == nil){
        cell = [[ContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
    }
//    cell.textLabel.text = @"Azher";
    CNContact *tmpContact = [[self.contactsDictionary valueForKey:[[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.87 green:0.89  blue:0.91 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.03 green:0.18 blue:0.36 alpha:1];
    
    NSString *tmpKey = [[[self.contactsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section];
     CNContact *tmpContact = [[self.contactsDictionary objectForKey:tmpKey] objectAtIndex:indexPath.row];
    CNContactStore *store = [CNContactStore new];
    CNContactViewController *picker;
    tmpContact = [store unifiedContactWithIdentifier:tmpContact.identifier keysToFetch:@[[CNContactViewController descriptorForRequiredKeys] ] error:nil];
    picker = [CNContactViewController viewControllerForContact:tmpContact];
    picker.contactStore = store;
    [picker setDelegate:self];
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
//    picker.edgesForExtendedLayout = UIRectEdgeTop;
    picker.edgesForExtendedLayout = UIRectEdgeBottom;
    [self.navigationController pushViewController:picker animated:YES];
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.contactsTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"Data passing");
}

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
@end
