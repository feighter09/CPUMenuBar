//
//  SystemInfo.h
//  CPUMenuBar
//
//  Created by Austin Feight on 5/9/14.
//  Copyright (c) 2014 Austin Feight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import <mach/mach.h>
#import <mach/processor_info.h>
#import <mach/mach_host.h>

static NSString* const kSysInfoVersionFormat  = @"%@.%@.%@ (%@)";
static NSString* const kSysInfoPlatformExpert = @"IOPlatformExpertDevice";

static NSString* const kSysInfoKeyOSVersion = @"kern.osrelease";
static NSString* const kSysInfoKeyOSBuild   = @"kern.osversion";
static NSString* const kSysInfoKeyModel     = @"hw.model";
static NSString* const kSysInfoKeyCPUCount  = @"hw.physicalcpu";
static NSString* const kSysInfoKeyLogicalCPUCount  = @"hw.logicalcpu";
static NSString* const kSysInfoKeyCPUFreq   = @"hw.cpufrequency";
static NSString* const kSysInfoKeyCPUBrand  = @"machdep.cpu.brand_string";

static NSString* const kSysInfoMachineNames       = @"MachineNames";
static NSString* const kSysInfoMachineiMac        = @"iMac";
static NSString* const kSysInfoMachineMacmini     = @"Mac mini";
static NSString* const kSysInfoMachineMacBookAir  = @"MacBook Air";
static NSString* const kSysInfoMachineMacBookPro  = @"MacBook Pro";
static NSString* const kSysInfoMachineMacPro      = @"Mac Pro";

@protocol SystemInfoDelegate <NSObject>

- (void)newInfoArrived:(NSArray *)usages;

@end

@interface SystemInfo : NSObject

@property (nonatomic, strong) id delegate;

@property processor_info_array_t cpuInfo, prevCpuInfo;
@property mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
@property unsigned numCPUs;

@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) NSLock *CPUUsageLock;

- (NSNumber *) _numControlEntry:(NSString *)ctlKey;

- (void) start;
- (NSNumber *) getNumCPUs;
- (NSNumber *) getCPUUsage;
@end
