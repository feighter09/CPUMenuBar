//
//  MasterViewController.m
//  CPUMenuBar
//
//  Created by Austin Feight on 8/11/12.
//  Copyright (c) 2012 Austin Feight. All rights reserved.
//

#import "MasterViewController.h"



@implementation MasterViewController

- (id)init {
  if (self = [super init]) {
    [self initPics];
  }
  
  return self;
}

- (void)initPics {
  _usage0 = [NSImage imageNamed:@"CPU-Usage0"];
  _usage1 = [NSImage imageNamed:@"CPU-Usage1"];
  _usage2 = [NSImage imageNamed:@"CPU-Usage2"];
  _usage3 = [NSImage imageNamed:@"CPU-Usage3"];
  _usage4 = [NSImage imageNamed:@"CPU-Usage4"];
  _usage5 = [NSImage imageNamed:@"CPU-Usage5"];
  _usage6 = [NSImage imageNamed:@"CPU-Usage6"];
  _usage7 = [NSImage imageNamed:@"CPU-Usage7"];
  _usage8 = [NSImage imageNamed:@"CPU-Usage8"];
  _usage9 = [NSImage imageNamed:@"CPU-Usage9"];
  _usage10 = [NSImage imageNamed:@"CPU-Usage10"];
}

- (void)start {
  _barItems = [NSMutableArray new];
  for (int i = 0; i < 4; i++) {
    NSStatusItem *barItem = [[NSStatusBar systemStatusBar] statusItemWithLength:10];
    [_barItems addObject:barItem];
  }

  _systemInfo = [SystemInfo new];
  [_systemInfo setDelegate:self];
  [_systemInfo start];
}

- (void)newInfoArrived:(NSArray *)usages {
  [usages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSNumber *usage = (NSNumber *)obj;
    if ([usage isLessThan:@0.05])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage0];
    else if ([usage isLessThan:@0.15])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage1];
    else if ([usage isLessThan:@0.25])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage2];
    else if ([usage isLessThan:@0.35])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage3];
    else if ([usage isLessThan:@0.45])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage4];
    else if ([usage isLessThan:@0.55])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage5];
    else if ([usage isLessThan:@0.65])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage6];
    else if ([usage isLessThan:@0.75])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage7];
    else if ([usage isLessThan:@0.85])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage8];
    else if ([usage isLessThan:@0.95])
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage9];
    else
      [(NSStatusItem *)[_barItems objectAtIndex:idx] setImage:_usage10];
  }];
  
}

@end
