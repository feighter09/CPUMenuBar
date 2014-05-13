//
//  AppDelegate.h
//  CPUMenuBar
//
//  Created by Austin Feight on 8/11/12.
//  Copyright (c) 2012 Austin Feight. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "MasterViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) IBOutlet MasterViewController *masterViewController;

@end
