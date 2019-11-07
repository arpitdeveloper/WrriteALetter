//
//  AppDelegate.h
//  WriteALetter
//
//  Created by Apple on 25/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

