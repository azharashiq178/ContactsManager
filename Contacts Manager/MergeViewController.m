//
//  MergeViewController.m
//  Contacts Manager
//
//  Created by Muhammad Azher on 09/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import "MergeViewController.h"
#import "AppDelegate.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
//#import "ContactsTableViewCell.h"
#import "BFPaperCheckbox.h"
#import "MergeTableViewCell.h"
#import "DGActivityIndicatorView.h"


@interface MergeViewController ()
@property AppDelegate *appDel;
@property (nonatomic,strong) NSMutableArray *myContacts;
@property (nonatomic,strong) NSMutableDictionary *contactsDictionary;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (nonatomic,strong) NSArray *allKeysInDic;
@property (nonatomic,strong) NSMutableArray *sectionColor;
@property (nonatomic,strong) NSMutableArray *selectedSections;
@property (nonatomic,strong) NSMutableDictionary *rowIndicatorDic;
@property (nonatomic,strong) NSString *mergeType;
@property (nonatomic,strong) DGActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) NSMutableDictionary *cloneDictionary;
@property (nonatomic,strong) UIAlertController *alertController;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic,strong) UIBarButtonItem *myBackButton;
@end

@implementation MergeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myBanner.delegate = self;
    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/1977871594";
    self.myBanner.rootViewController = self;
    self.myBanner.delegate = self;
    
    
    GADRequest *request = [GADRequest request];
    
    request.testDevices = @[
                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
                            ];
    [self.myBanner loadRequest:request];
    self.myBackButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(showMergeOption)];
    self.navigationItem.leftBarButtonItem = self.myBackButton;
    
    
    [self.tabBarController setDelegate:self];
    UIImageView *tmpImageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    tmpImageview.image = [UIImage imageNamed:@"icons8-Name-80"];
    tmpImageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.byNameButton addSubview:tmpImageview];
    UIImageView *tmpImageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    tmpImageview1.image = [UIImage imageNamed:@"icons8-Phone-96"];
    tmpImageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.byPhoneButton addSubview:tmpImageview1];
    UIImageView *tmpImageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    tmpImageview2.image = [UIImage imageNamed:@"icons8-Email-100"];
    tmpImageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.byEmailButton addSubview:tmpImageview2];
    
//    NSLog(@"My size is %f", self.view.frame.size.width);
    
    if(self.view.frame.size.width <= 320){
        [self.byNameButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.byPhoneButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.byEmailButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }

    [self initNavigationBar];
    self.interstitial = [self createAndLoadInterstitial];

    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setDelegate:self];
    if([self.contactsDictionary count] == 0){
        [self registerNibs];
        self.appDel = [[UIApplication sharedApplication] delegate];
        self.rowIndicatorDic = [[NSMutableDictionary alloc] init];
        self.myContacts = self.appDel.myStoredContacts;
        [self.contactsTableView setHidden:YES];
        [self showMergeOption];
        
    }

//    self.myBanner.delegate = self;
//    self.myBanner.adUnitID = @"ca-app-pub-6412217023250030/1977871594";
//    self.myBanner.rootViewController = self;
//    self.myBanner.delegate = self;
//
//    
//    GADRequest *request = [GADRequest request];
//
//    request.testDevices = @[
//                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
//                            ];
//    [self.myBanner loadRequest:request];
    
//    NSLog(@"I got contacts from appdelegate %@",self.appDel.myStoredContacts);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hideMergeOption{
    [self.mergeByLabel setHidden:YES];
    [self.selectTypeLabe setHidden:YES];
    [self.byNameButton setHidden:YES];
    [self.byEmailButton setHidden:YES];
    [self.byPhoneButton setHidden:YES];
    self.myBackButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(showMergeOption)];
    [self.navigationItem setLeftBarButtonItem:self.myBackButton];
    [self.navigationItem setHidesBackButton:NO];
    [self.contactsTableView setHidden:NO];
}
-(void)showMergeOption{
    [self.contactsTableView setHidden:YES];
    [self.mergeByLabel setHidden:NO];
    [self.selectTypeLabe setHidden:NO];
    [self.byNameButton setHidden:NO];
    [self.byEmailButton setHidden:NO];
    [self.byPhoneButton setHidden:NO];
//    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = nil;
    //    _alertController = [UIAlertController alertControllerWithTitle:@"Please Select Type" message:@"Merge by:" preferredStyle:UIAlertControllerStyleActionSheet];
//    _alertController.popoverPresentationController.sourceView = self.view;
//    _alertController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
//    _alertController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height, 100, 100);
//    UIAlertAction *mergeByName = [UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.mergeType = @"Name";
//        [self mergeByName];
//        if (self.interstitial.isReady) {
//            [self.interstitial presentFromRootViewController:self];
//        }
//    }];
//    [_alertController addAction:mergeByName];
//    
//    UIAlertAction *mergeByphone = [UIAlertAction actionWithTitle:@"Phone Number" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.mergeType = @"Phone";
//        [self mergeByPhone];
////        self.interstitial = [self createAndLoadInterstitial];
//        if (self.interstitial.isReady) {
//            [self.interstitial presentFromRootViewController:self];
//        }
////        self.interstitial = [self createAndLoadInterstitial];
//        
//    }];
//    [_alertController addAction:mergeByphone];
//    
//    UIAlertAction *mergeByEmail = [UIAlertAction actionWithTitle:@"Email Address" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.mergeType = @"Email";
//        [self mergeByEmail];
//        if (self.interstitial.isReady) {
//            [self.interstitial presentFromRootViewController:self];
//        }
//    }];
//    [_alertController addAction:mergeByEmail];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        self.contactsDictionary = self.cloneDictionary;
//        [self.contactsTableView reloadData];
//    }];
//    [_alertController addAction:cancelAction];
//    [self presentViewController:_alertController animated:YES completion:nil];
}
-(void)initNavigationBar{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,70)];
    UIImageView *navImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    [navImage setContentMode:UIViewContentModeScaleAspectFit];
    navImage.image = [UIImage imageNamed:@"header_logo"];
    //    self.navigationItem.titleView = navImage;
    self.navigationController.navigationBar.topItem.titleView = navImage;
    
    
}
-(void)mergeByName{
    
    [self.tabBarController setDelegate:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
        
        _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 -50, 0, 0);
        
        [self.view addSubview:_activityIndicatorView];
        
        [_activityIndicatorView setHidden:NO];
        
        [_activityIndicatorView startAnimating];
        
        [self.contactsTableView setHidden:YES];
        
    });
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        self.contactsDictionary = [[NSMutableDictionary alloc] init];
        for(int i = 0 ;i < [self.myContacts count];i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            NSString *tmpName = [NSString stringWithFormat:@"%@ %@",tmpContact.givenName,tmpContact.familyName];
            if(![tmpName  isEqual: @""]){
                [self.contactsDictionary setObject:[[NSMutableArray alloc] init] forKey:tmpName];
            }
        }
        for(int i = 0 ;i < [self.myContacts count];i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            NSString *tmpName = [NSString stringWithFormat:@"%@ %@",tmpContact.givenName,tmpContact.familyName];
            if(![tmpName  isEqual: @""]){
                [[self.contactsDictionary valueForKey:tmpName] addObject:tmpContact];
            }
        }
        NSArray *allKeys = [self.contactsDictionary allKeys];
        for(int i = 0 ;i < [allKeys count] ;i++){
            NSString *tmpKey = [allKeys objectAtIndex:i];
            if([[self.contactsDictionary valueForKey:tmpKey] count] <= 1){
                [self.contactsDictionary removeObjectForKey:tmpKey];
            }
        }
        self.allKeysInDic = [self.contactsDictionary allKeys];
        [self initSectionColors];
        [self initSections];
        
        [self.contactsTableView setEditing:YES animated:YES];
        [self.contactsTableView setDelegate:self];
//        [self.contactsTableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Here");
            [self.activityIndicatorView stopAnimating];
            self.cloneDictionary = self.contactsDictionary;
            
            if([self.contactsDictionary count] == 0){
                NSLog(@"No Data found");
                [self showAlertControllerRegardingNoMatchingSearch];
            }
            else{
                [self.contactsTableView reloadData];
                [self.contactsTableView setHidden:NO];
            }
            
            
        });
        
    });
}
-(void)mergeByPhone{
    [self.tabBarController setDelegate:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
        
        _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 -50, 0, 0);
        
        [self.view addSubview:_activityIndicatorView];
        
        [_activityIndicatorView setHidden:NO];
        
        [_activityIndicatorView startAnimating];
        [self.contactsTableView setHidden:YES];
        
    });
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        self.contactsDictionary = [[NSMutableDictionary alloc] init];
        
        for(int i = 0 ;i < [self.myContacts count];i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            if([tmpContact.phoneNumbers count]!=0){
                [self.contactsDictionary setObject:[[NSMutableArray alloc] init] forKey:[[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]];
            }
        }
        for(int i = 0 ;i < [self.myContacts count] ;i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            if([tmpContact.phoneNumbers count] != 0){
                NSString *tmpKey = [[[tmpContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"];
                [[self.contactsDictionary valueForKey:tmpKey] addObject:tmpContact];
            }
        }
        NSArray *allKeys = [self.contactsDictionary allKeys];
        for(int i = 0 ;i < [allKeys count] ;i++){
            NSString *tmpKey = [allKeys objectAtIndex:i];
            if([[self.contactsDictionary valueForKey:tmpKey] count] <= 1){
                [self.contactsDictionary removeObjectForKey:tmpKey];
            }
        }
        self.allKeysInDic = [self.contactsDictionary allKeys];
        [self initSectionColors];
        [self initSections];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Here");
            [self.activityIndicatorView stopAnimating];
            [self.contactsTableView reloadData];
            self.cloneDictionary = self.contactsDictionary;
            [self.contactsTableView setHidden:NO];
            if([self.contactsDictionary count] == 0){
                NSLog(@"No Data found");
                [self showAlertControllerRegardingNoMatchingSearch];
                
            }
            
        });
        
    });
}
-(void)mergeByEmail{
    
    [self.tabBarController setDelegate:self];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:[UIColor blackColor] size:100.0f];
        
        _activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 -50, 0, 0);
        
        [self.view addSubview:_activityIndicatorView];
        
        [_activityIndicatorView setHidden:NO];
        
        [_activityIndicatorView startAnimating];
        [self.contactsTableView setHidden:YES];
        
    });
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        self.contactsDictionary = [[NSMutableDictionary alloc] init];
        
        for(int i = 0 ;i < [self.myContacts count];i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            if([tmpContact.emailAddresses count]!=0){
                [self.contactsDictionary setObject:[[NSMutableArray alloc] init] forKey:[[tmpContact.emailAddresses objectAtIndex:0] valueForKey:@"value"]];
            }
        }
        for(int i = 0 ;i < [self.myContacts count] ;i++){
            CNContact *tmpContact = [self.myContacts objectAtIndex:i];
            if([tmpContact.emailAddresses count] != 0){
                NSString *tmpKey = [[tmpContact.emailAddresses objectAtIndex:0] valueForKey:@"value"];
                [[self.contactsDictionary valueForKey:tmpKey] addObject:tmpContact];
            }
        }
        NSArray *allKeys = [self.contactsDictionary allKeys];
        for(int i = 0 ;i < [allKeys count] ;i++){
            NSString *tmpKey = [allKeys objectAtIndex:i];
            if([[self.contactsDictionary valueForKey:tmpKey] count] <= 1){
                [self.contactsDictionary removeObjectForKey:tmpKey];
            }
        }
        self.allKeysInDic = [self.contactsDictionary allKeys];
        [self initSectionColors];
        [self initSections];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Here");
            [self.activityIndicatorView stopAnimating];
            self.cloneDictionary = self.contactsDictionary;
            [self.contactsTableView reloadData];
            [self.contactsTableView setHidden:NO];
            if([self.contactsDictionary count] == 0){
                NSLog(@"No Data found");
                [self showAlertControllerRegardingNoMatchingSearch];
                
            }
            
        });
        
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contactsDictionary count];
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return [self.allKeysInDic objectAtIndex:section];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    if([self.contactsTableView numberOfRowsInSection:section] > 1){
        UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 90, 0, 40, 40)];
        [tmpButton setImage:[UIImage imageNamed:@"merge_icon"] forState:UIControlStateNormal];
        [tmpButton setBackgroundColor:[self.sectionColor objectAtIndex:section]];
        tmpButton.contentMode = UIViewContentModeScaleAspectFit;
        tmpButton.layer.cornerRadius = 20;
        tmpButton.clipsToBounds = YES;
        tmpButton.tag = section;
        [tmpButton addTarget:self action:@selector(didMergeButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [tmpButton setBackgroundColor:[self.sectionColor objectAtIndex:section]];
        [tmpButton setHidden:YES];
        
        
        BFPaperCheckbox *paperCheckbox = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 40, 0, 30, 30)];
        
        if([[self.selectedSections objectAtIndex:section] isEqualToString:@"YES"]){
            [paperCheckbox checkAnimated:YES];
            [tmpButton setHidden:NO];
            
        }
        
        [paperCheckbox addTarget:self action:@selector(didSelectCheckBox:) forControlEvents:UIControlEventTouchDown];
        
        paperCheckbox.tintColor = [UIColor blackColor];
        
        paperCheckbox.checkmarkColor = [UIColor blackColor];
        
        
        paperCheckbox.tag = section;
        
        [headerView addSubview:tmpButton];
        
        [headerView addSubview:paperCheckbox];
    }
    
    
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contactsDictionary valueForKey:[self.allKeysInDic objectAtIndex:section]] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MergeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mergeCell"];
    if(cell == nil){
        cell = [[MergeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mergeCell"];
    }
    
    
    
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(12, 0)];
    [linePath addLineToPoint:CGPointMake(12, 70)];
    line.lineWidth = 5;
    line.path=linePath.CGPath;
    line.fillColor = [[self.sectionColor objectAtIndex:indexPath.section] CGColor];
    line.strokeColor = [[self.sectionColor objectAtIndex:indexPath.section] CGColor];
    [[cell layer] addSublayer:line];
    
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
//        [cell.firstLastName setHidden:YES];
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    NSString *rowSelectionValue = [self.rowIndicatorDic valueForKey:[NSString stringWithFormat:@"%@",indexPath]];
//    if([rowSelectionValue isEqualToString:@"YES"]){
//        [self.contactsTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
//        [cell setEditing:YES animated:YES];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
//        [cell setSelected:YES animated:YES];
//        
//        
//        
//        
//    }
//    else{
////        [cell setEditing:NO];
//        [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:NO];
//    }
//    else{
//        [cell setSelected:NO animated:YES];
//        [cell setEditing:NO animated:YES];
//    }
//    NSArray *visibleCells = [tableView indexPathsForVisibleRows];
//    for(int i = 0 ;i < [visibleCells count] ;i++){
//        if(![[self.selectedSections objectAtIndex:[[visibleCells objectAtIndex:i] section]]  isEqualToString: @"YES"]){
////            [[self.contactsTableView cellForRowAtIndexPath:[visibleCells objectAtIndex:i]] setEditing:NO animated:NO];
//            [[tableView cellForRowAtIndexPath:[visibleCells objectAtIndex:i]] setEditing:NO];
//        }
//    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self.selectedSections objectAtIndex:indexPath.section]  isEqual: @"YES"]){
        NSString *rowSelectionValue = [self.rowIndicatorDic valueForKey:[NSString stringWithFormat:@"%@",indexPath]];
        if([rowSelectionValue isEqualToString:@"YES"]){
            
            [self.contactsTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [[self.contactsTableView cellForRowAtIndexPath:indexPath] setEditing:YES animated:YES];
            [self.contactsTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [[self.contactsTableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:YES];
            [[self.contactsTableView cellForRowAtIndexPath:indexPath] setShowsReorderControl:YES];
            [[self.contactsTableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setShowsReorderControl:YES];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            for (UIView *subview in [cell.contentView subviews]) {
//                if([subview isKindOfClass:[UIButton class]]){
//                    CGRect sFrame = subview.frame;
//                    CGPoint sPoint = subview.frame.origin;
//                    sPoint = CGPointMake(sPoint.x - 60, sPoint.y);
//                    sFrame = CGRectMake(sPoint.x, sPoint.y, sFrame.size.width, sFrame.size.height);
//                    [subview setFrame:sFrame];
//                    [subview setBackgroundColor:[UIColor blueColor]];
//                }
//                
//            }
//            [cell setSelected:YES];
        }
        else{
            [cell setEditing:NO];
            
        }
        
    }
//    else if ([tableView numberOfRowsInSection:indexPath.section] == 2){
////        [cell setEditing:YES animated:YES];
////        [cell setEditing:NO];
//        [cell setShowsReorderControl:YES];
//        [cell setShouldIndentWhileEditing:NO];
////        for (UIView *subview in [cell.contentView subviews]) {
////            if([subview isKindOfClass:[UIButton class]]){
////                CGRect sFrame = subview.frame;
////                CGPoint sPoint = subview.frame.origin;
////                sPoint = CGPointMake(sPoint.x - 60, sPoint.y);
////                sFrame = CGRectMake(sPoint.x, sPoint.y, sFrame.size.width, sFrame.size.height);
////                [subview setFrame:sFrame];
////                [subview setBackgroundColor:[UIColor blueColor]];
////            }
////            
////        }
//        
//        
//    }
    else{
        [cell setEditing:NO];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)registerNibs{
    [self.contactsTableView registerNib:[UINib nibWithNibName:@"MergeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mergeCell"];
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
-(IBAction)didMergeButtonTapped:(UIButton *)sender{
    if([self.contactsTableView numberOfRowsInSection:sender.tag] >1){
        NSArray *myTmpKeys = [self.contactsDictionary allKeys];
        NSString *tmpStr = [myTmpKeys objectAtIndex:sender.tag];
        NSMutableArray *myObjs = [self.contactsDictionary valueForKey:tmpStr];
        NSMutableArray *selectedContacts = [[NSMutableArray alloc] init];
        for(int i = 0 ;i < [myObjs count];i++){
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
            NSString *tmpSTr = [NSString stringWithFormat:@"%@",tmpIndexPath];
            if([[self.rowIndicatorDic valueForKey:tmpSTr]  isEqual: @"YES"]){
                [selectedContacts addObject:[myObjs objectAtIndex:i]];
            }
        }
        if([self.contactsTableView numberOfRowsInSection:sender.tag] ==2){
            selectedContacts = [[NSMutableArray alloc] init];
            NSArray *myTmpKeys = [self.contactsDictionary allKeys];
            NSString *tmpStr = [myTmpKeys objectAtIndex:sender.tag];
            NSMutableArray *myObjs = [self.contactsDictionary valueForKey:tmpStr];
            selectedContacts = myObjs;
        }
        if([selectedContacts count] == 1){
            NSLog(@"Can't merge One Contact");
        }
        else if([selectedContacts count] == 0){
            NSLog(@"No Contact Selected");
        }
        else{
            CNMutableContact *newContact = [[selectedContacts objectAtIndex:0] mutableCopy];
            CNContactStore *store = [[CNContactStore alloc] init];
            CNSaveRequest *request = [[CNSaveRequest alloc] init];
            for(int j = 1 ;j < [selectedContacts count] ;j++){
                CNContact *tmpContact2 = [selectedContacts objectAtIndex:j];
                if([newContact.familyName isEqualToString:@""]){
                    if(![tmpContact2.familyName isEqualToString:@""]){
                        newContact.familyName = tmpContact2.familyName;
                    }
                }
                if([newContact.organizationName isEqualToString:@""]){
                    if(![tmpContact2.organizationName isEqualToString:@""]){
                        newContact.organizationName = tmpContact2.organizationName;
                    }
                }
                if([newContact.phoneNumbers count] == 0){
                    if([tmpContact2.phoneNumbers count] != 0){
                        newContact.phoneNumbers = tmpContact2.phoneNumbers;
                    }
                }
                else{
                    NSMutableArray *phoneNumbersArray = [(NSMutableArray *)newContact.phoneNumbers mutableCopy];
                    
                    if([tmpContact2.phoneNumbers count] > 0){
                        for(int i = 0 ;i < [tmpContact2.phoneNumbers count];i++){
                            
                            CNLabeledValue *tmpLabel = [tmpContact2.phoneNumbers objectAtIndex:i];
                            if(![[[tmpLabel valueForKey:@"value"] valueForKey:@"digits"] isEqualToString: [[[newContact.phoneNumbers objectAtIndex:0] valueForKey:@"value"] valueForKey:@"digits"]])
                                [phoneNumbersArray addObject:tmpLabel];
                        }
                    }
                    NSArray *tmpPhoneNums = phoneNumbersArray;
                    newContact.phoneNumbers = tmpPhoneNums;
                }
                if([newContact.emailAddresses count] == 0){
                    if([tmpContact2.emailAddresses count]!= 0){
                        newContact.emailAddresses = tmpContact2.emailAddresses;
                    }
                }
                else{
                    NSMutableArray *tmpEmailsArray = (NSMutableArray *)[newContact.emailAddresses mutableCopy];
                    if([tmpContact2.emailAddresses count] > 0){
                        for(int i = 0; i< [tmpContact2.emailAddresses count]; i++){
                            CNLabeledValue *tmpLabel = [tmpContact2.emailAddresses objectAtIndex:i];
                            if(![[tmpLabel valueForKey:@"value"] isEqualToString: [[newContact.emailAddresses objectAtIndex:0] valueForKey:@"value"]])
                                [tmpEmailsArray addObject:tmpLabel];
                        }
                    }
                    NSArray *tmpEmails = tmpEmailsArray;
                    newContact.emailAddresses = tmpEmails;
                }
                if([newContact.postalAddresses count] == 0){
                    if([tmpContact2.postalAddresses count] != 0){
                        newContact.postalAddresses = tmpContact2.postalAddresses;
                    }
                }
                else{
                    NSMutableArray *tmpPostalAddressArray = (NSMutableArray *)[newContact.postalAddresses mutableCopy];
                    if([tmpContact2.emailAddresses count] > 0){
                        for(int i = 0 ;i < [tmpContact2.postalAddresses count];i++){
                            CNLabeledValue *tmpLabel = [tmpContact2.postalAddresses objectAtIndex:i];
                            [tmpPostalAddressArray addObject:tmpLabel];
                        }
                    }
                    NSArray *tmpPostalAddresses = tmpPostalAddressArray;
                    newContact.postalAddresses = tmpPostalAddresses;
                }
                NSLog(@"%@",newContact.imageData);
                if(newContact.imageData == nil){
                    if(tmpContact2.imageData != nil){
                        newContact.imageData = tmpContact2.imageData;
                    }
                }
                
                NSString *tmpKey;
                if([self.mergeType  isEqual: @"Name"]){
                    tmpKey = [NSString stringWithFormat:@"%@ %@",tmpContact2.givenName,tmpContact2.familyName];
                }
                else if ([self.mergeType isEqualToString:@"Phone"]){
                    tmpKey = [NSString stringWithFormat:@"%@",[[tmpContact2.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"]];
                }
                else if([self.mergeType isEqualToString:@"Email"]){
                    tmpKey = [NSString stringWithFormat:@"%@",[tmpContact2.phoneNumbers valueForKey:@"value"]];
                }
                
                NSArray *tmpContacts = [self.contactsDictionary valueForKey:tmpKey];
                for(int k = 0 ;k < [tmpContacts count];k++){
                    if(tmpContact2 == [tmpContacts objectAtIndex:k]){
                        [[self.contactsDictionary valueForKey:tmpKey] removeObjectAtIndex:k];
                        break;
                    }
                }
                
//                NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:j inSection:sender.tag];
//                int myIndex = [self getIndexOfSelectedIndexPaht:tmpPath];
//                [self.selectedCellsStates removeObjectAtIndex:myIndex];
//                [self.sectionsArray removeObjectAtIndex:myIndex];
                [request deleteContact:[tmpContact2 mutableCopy]];
//                NSLog(@"%lu",(unsigned long)[self.myContacts indexOfObject:tmpContact2]);
//                [store executeSaveRequest:request error:nil];
                [self.myContacts removeObjectAtIndex:[self.myContacts indexOfObject:tmpContact2]];
//                NSLog(@"My new Contact is %@",newContact);
                [self.selectedSections replaceObjectAtIndex:sender.tag withObject:@"NO"];
                int buttonRow = (int)[self.contactsTableView numberOfRowsInSection:sender.tag]/2;
                MergeTableViewCell *cell = [self.contactsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:buttonRow inSection:sender.tag]];
                
                for (UIView *subview in [cell.contentView subviews]) {
                    if([subview isKindOfClass:[UIButton class]]){
                        [subview removeFromSuperview];
                    }
                    
                }
                
//                self.totalMerged = j;
            }
            [request updateContact:newContact];
            [store executeSaveRequest:request error:nil];
            [self.contactsTableView reloadData];
        }
        
        NSMutableArray *tmpKeys = [self.rowIndicatorDic allKeys];
    }
    else if([self.contactsTableView numberOfRowsInSection:sender.tag] == 2){
        
    }
    else{
        
    }
    self.appDel.myStoredContacts = self.myContacts;
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Section no %ld",indexPath.section);
//    if([[self.selectedSections objectAtIndex:indexPath.section] isEqualToString:@"YES"]){
//        [tableView setEditing:YES animated:YES];
        return YES;
//    }
    
//    else
        return NO;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[self.selectedSections objectAtIndex:indexPath.section]  isEqual: @"YES"])
        return indexPath;
    else{
        NSLog(@"Can's edit");
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.87 green:0.89  blue:0.91 alpha:1]];
        [self.navigationController.navigationBar setTranslucent:NO];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.03 green:0.18 blue:0.36 alpha:1];
        NSArray *allKeys = [self.contactsDictionary allKeys];
        NSString *tmpKey = [allKeys objectAtIndex:indexPath.section];
        
        CNContact *myContact = [[self.contactsDictionary valueForKey:tmpKey] objectAtIndex:indexPath.row];
        CNContactStore *store = [CNContactStore new];
        myContact = [store unifiedContactWithIdentifier:myContact.identifier keysToFetch:@[[CNContactViewController descriptorForRequiredKeys] ] error:nil];
        CNContactViewController *picker = [[CNContactViewController alloc] init];
        picker = [CNContactViewController viewControllerForContact:myContact];
        picker.contactStore = store;
        picker.delegate = self;
        [picker setDelegate:self];
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
        picker.edgesForExtendedLayout = UIRectEdgeTop;
        [self.navigationController pushViewController:picker animated:YES];
        return nil;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[tableView cellForRowAtIndexPath:indexPath] setShowsReorderControl:YES];
    [[tableView cellForRowAtIndexPath:indexPath] setEditing:YES animated:YES];
    [self.rowIndicatorDic setObject:@"YES" forKey:[NSString stringWithFormat:@"%@",indexPath]];
}
-(IBAction)didSelectCheckBox:(BFPaperCheckbox *)sender{
    

    
    if([sender isChecked]){
        
        UIView *mySuperView = [sender superview];
        for(UIView *subview in mySuperView.subviews){
            if([subview isKindOfClass:[UIButton class]]){
                [subview setHidden:YES];
            }
        }
        
        [self.selectedSections removeObjectAtIndex:sender.tag];
        
        [self.selectedSections insertObject:@"NO" atIndex:sender.tag];

        for(int i = 0 ;i < [self.contactsDictionary count];i++){
            
            if(sender.tag == i){
                
                int numOfRowsInSection = (int)[self.contactsTableView numberOfRowsInSection:i];
                
                for(int j = 0 ;j < numOfRowsInSection ;j++){
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];

                    [self.contactsTableView deselectRowAtIndexPath:indexPath animated:YES];
                    
                    [[self.contactsTableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
                    
                    [[self.contactsTableView cellForRowAtIndexPath:indexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [self.rowIndicatorDic setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",indexPath]];
                }
            }
        }
    }
    else
    {
        UIView *mySuperView = [sender superview];
        for(UIView *subview in mySuperView.subviews){
            if([subview isKindOfClass:[UIButton class]]){
                [subview setHidden:NO];
            }
        }
        
        [self.selectedSections replaceObjectAtIndex:sender.tag withObject:@"YES"];
        
        NSLog(@"Section Index = %ld",(long)sender.tag);
        [self.contactsTableView setAllowsMultipleSelection:YES];
        [self.contactsTableView setAllowsSelectionDuringEditing:YES];
        [self.contactsTableView setAllowsMultipleSelectionDuringEditing:YES];
        
        
        [self.contactsTableView setEditing:YES];
        
        for(int i = 0 ;i < [self.contactsTableView numberOfRowsInSection:sender.tag];i++){
           
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
            
            [self.contactsTableView selectRowAtIndexPath:tmpIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            [[self.contactsTableView cellForRowAtIndexPath:tmpIndexPath] setEditing:YES animated:YES];
            
            [self.contactsTableView selectRowAtIndexPath:tmpIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            [[self.contactsTableView cellForRowAtIndexPath:tmpIndexPath] setSelected:YES animated:YES];
            
            [[self.contactsTableView cellForRowAtIndexPath:tmpIndexPath] setShowsReorderControl:YES];
            
            [[self.contactsTableView cellForRowAtIndexPath:tmpIndexPath] setSelectionStyle:UITableViewCellSelectionStyleNone];

            [self.rowIndicatorDic setObject:@"YES" forKey:[NSString stringWithFormat:@"%@",tmpIndexPath]];
            
//            ContactsTableViewCell *cell = [self.contactsTableView cellForRowAtIndexPath:tmpIndexPath];
//            
//            for (UIView *subview in [cell.contentView subviews]) {
//            
//                if([subview isKindOfClass:[UIButton class]]){
//                
//                    CGRect sFrame = subview.frame;
//                    
//                    CGPoint sPoint = subview.frame.origin;
//                    
//                    sPoint = CGPointMake(sPoint.x - 60, sPoint.y);
//                    
//                    sFrame = CGRectMake(sPoint.x, sPoint.y, sFrame.size.width, sFrame.size.height);
//                    
//                    [subview setFrame:sFrame];
//                    
//                    [subview setBackgroundColor:[self.sectionColor objectAtIndex:tmpIndexPath.section]];
//                }
//            }
        }
        NSArray *visibleCells = [self.contactsTableView indexPathsForVisibleRows];
        
        for(int i = 0 ;i < [visibleCells count];i++){
        
            if(![[self.selectedSections objectAtIndex:[[visibleCells objectAtIndex:i] section]]  isEqual: @"YES"]){
                
                [[self.contactsTableView cellForRowAtIndexPath:[visibleCells objectAtIndex:i]] setEditing:NO animated:NO];
            }
        }
        NSLog(@"Total Visible Cells are %@",visibleCells);
    }
}

- (void)reloadContactTableView{
    [self.contactsTableView reloadData];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.rowIndicatorDic setObject:@"NO" forKey:[NSString stringWithFormat:@"%@",indexPath]];
    [[tableView cellForRowAtIndexPath:indexPath] setEditing:NO animated:YES];
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return indexPath;
}
-(void)initSections{
    self.selectedSections = [[NSMutableArray alloc] init];
    for(int i = 0 ;i < [self.contactsDictionary count];i++){
        
        [self.selectedSections addObject:@"NO"];
    }
}
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"Here");
    NSArray *tmpKeys = [self.contactsDictionary allKeys];
//    NSMutableArray *tmpArray = [self.contactsDictionary objectForKey:[tmpKeys objectAtIndex:sourceIndexPath.section]];
    
    CNContact *contact1 = [[self.contactsDictionary valueForKey:[tmpKeys objectAtIndex:sourceIndexPath.section]] objectAtIndex:sourceIndexPath.row];
    CNContact *contact2 = [[self.contactsDictionary valueForKey:[tmpKeys objectAtIndex:sourceIndexPath.section]] objectAtIndex:destinationIndexPath.row];
    
    [[self.contactsDictionary valueForKey:[tmpKeys objectAtIndex:sourceIndexPath.section]] replaceObjectAtIndex:sourceIndexPath.row withObject:contact2];
    [[self.contactsDictionary valueForKey:[tmpKeys objectAtIndex:sourceIndexPath.section]] replaceObjectAtIndex:destinationIndexPath.row withObject:contact1];
    
    int myRow = (int)[tableView numberOfRowsInSection:sourceIndexPath.section] / 2;
    MergeTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:myRow inSection:sourceIndexPath.section]];
    for (UIView *subview in [cell.contentView subviews]) {
        if([subview isKindOfClass:[UIButton class]]){
            [subview removeFromSuperview];
        }
        
    }
    
    
    [self.contactsTableView reloadData];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.contactsDictionary = [[NSMutableDictionary alloc] init];
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.alertController dismissViewControllerAnimated:YES completion:nil];
//    [self showMergeOption];
    _alertController.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height, 100, 100);
}
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    self.contactsTableView.frame = CGRectMake(self.contactsTableView.frame.origin.x, self.contactsTableView.frame.origin.y, self.contactsTableView.frame.size.width, self.contactsTableView.frame.size.height - 50);
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
    if([self.contactsDictionary count] == 0){
        [self showAlertControllerRegardingNoMatchingSearch];
    }
}
- (IBAction)mergeByNameAction:(id)sender {
    [self hideMergeOption];
    self.mergeType = @"Name";
    [self mergeByName];
    
//    NSLog(@"my cout of name %d",[self.contactsDictionary count]);
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (IBAction)mergeByPhoneAction:(id)sender {
    [self hideMergeOption];
    self.mergeType = @"Phone";
    [self mergeByPhone];
    //        self.interstitial = [self createAndLoadInterstitial];
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (IBAction)mergeByEmailAction:(id)sender {
    [self hideMergeOption];
    self.mergeType = @"Email";
    [self mergeByEmail];
    NSLog(@"my cout of email %d",[self.contactsDictionary count]);
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}
-(void)showAlertControllerRegardingNoMatchingSearch{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Contact Matched" message:@"No Contacts found regarding search" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self showMergeOption];
        [self.contactsTableView setHidden:YES];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
