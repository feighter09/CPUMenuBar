//
//  AppDelegate.m
//  CPUMenuBar
//
//  Created by Austin Feight on 8/11/12.
//  Copyright (c) 2012 Austin Feight. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  NSLog(@"launch");
  _masterViewController = [MasterViewController new];
  [_masterViewController start];
}

@end
