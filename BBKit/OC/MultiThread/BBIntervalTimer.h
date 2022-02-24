//
//  BBIntervalTimer.h
//  BBKitDemo
//
//  Created by mo jun on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 计时器block封装
@interface BBIntervalTimer : NSObject

- (instancetype)initIntervalTimerWithInterval:(NSTimeInterval)interval
                                scheduleBlock:(void (^)(void))scheduleBlock;

+ (instancetype)createIntervalTimerWithInterval:(NSTimeInterval)interval
                                  scheduleBlock:(void (^)(void))scheduleBlock;

/// 启动计时器
- (void)start;

/// 关闭计时器
- (void)stop;

/// 暂停计时器
- (void)suspend;


@end

NS_ASSUME_NONNULL_END
