//
//  SystemInfo.m
//  CPUMenuBar
//
//  Created by Austin Feight on 5/9/14.
//  Copyright (c) 2014 Austin Feight. All rights reserved.
//

#import "SystemInfo.h"

@implementation SystemInfo

- (NSNumber *) _numControlEntry:(NSString *)ctlKey {
  
  size_t size = sizeof( uint64_t ); uint64_t ctlValue = 0;
  if ( sysctlbyname([ctlKey UTF8String], &ctlValue, &size, NULL, 0) == -1 ) return nil;
  return [NSNumber numberWithUnsignedLongLong:ctlValue];
}

#pragma mark - The Meat

- (NSNumber *) getNumCPUs {
  return [self _numControlEntry:kSysInfoKeyCPUCount];
}
- (NSNumber *) getCPUUsage{
  return [[NSNumber alloc] init];
}

- (void)start {
  int mib[2U] = { CTL_HW, HW_NCPU };
  size_t sizeOfNumCPUs = sizeof(_numCPUs);
  int status = sysctl(mib, 2U, &_numCPUs, &sizeOfNumCPUs, NULL, 0U);
  if(status)
    _numCPUs = 1;
  
  _CPUUsageLock = [[NSLock alloc] init];
  _updateTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(updateInfo:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateInfo:(NSTimer *)timer {
  natural_t numCPUsU = 0U;
  kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &_cpuInfo, &_numCpuInfo);
  if(err == KERN_SUCCESS) {
    [_CPUUsageLock lock];
    
    NSMutableArray *usages = [NSMutableArray new];
    for(unsigned i = 0U; i < _numCPUs; ++i) {
      float inUse, total;
      if(_prevCpuInfo) {
        inUse = (
                 (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                 + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                 + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                 );
        total = inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
      } else {
        inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
        total = inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
      }
      
      float usage = inUse / total;
      [usages addObject:[NSNumber numberWithFloat:usage]];
      NSLog(@"Core: %u Usage: %f", i, usage);
    }
    [_CPUUsageLock unlock];
    
    if(_prevCpuInfo) {
      size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCpuInfo;
      vm_deallocate(mach_task_self(), (vm_address_t)_prevCpuInfo, prevCpuInfoSize);
    }
    
    _prevCpuInfo = _cpuInfo;
    _numPrevCpuInfo = _numCpuInfo;
    
    _cpuInfo = NULL;
    _numCpuInfo = 0U;
    
    [_delegate newInfoArrived:usages];
  } else {
    NSLog(@"Error!");
    [NSApp terminate:nil];
  }
}

@end
