//
//  AppDelegate.h
//  Contacts Manager
//
//  Created by Muhammad Azher on 08/08/2017.
//  Copyright © 2017 Muhammad Azher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic,strong) NSMutableArray *myStoredContacts;

- (void)saveContext;


@end

