//
//  MasterViewController.h
//  CPUMenuBar
//
//  Created by Austin Feight on 8/11/12.
//  Copyright (c) 2012 Austin Feight. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SystemInfo.h"

@interface MasterViewController : NSViewController <SystemInfoDelegate>

@property (strong) NSMutableArray *barItems;
@property (strong) SystemInfo *systemInfo;

@property (strong) NSImage *usage0;
@property (strong) NSImage *usage1;
@property (strong) NSImage *usage2;
@property (strong) NSImage *usage3;
@property (strong) NSImage *usage4;
@property (strong) NSImage *usage5;
@property (strong) NSImage *usage6;
@property (strong) NSImage *usage7;
@property (strong) NSImage *usage8;
@property (strong) NSImage *usage9;
@property (strong) NSImage *usage10;

- (void)start;

@end
