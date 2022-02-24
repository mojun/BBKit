//
//  BBExpectationTimer.m
//  BBKitDemo
//
//  Created by mo jun on 2020/12/17.
//

#import "BBTimerExpectation.h"

@implementation BBTimerExpectation {
    dispatch_source_t _loopTimer;

    dispatch_source_t _timeoutTimer;

    void (^_loopBlock)(void);
    void (^_timeoutBlock)(void);

    BOOL _shouldPerformTimeout;
}

- (instancetype)initLoopExpectationTimerInterval:(NSTimeInterval)interval
                                       loopBlock:(void(^)(void))loopBlock
                                         timeout:(NSTimeInterval)timeout
                                    timeoutBlock:(void(^)(void))timeoutBlock
{
    if (self = [super init]) {
        _loopBlock = loopBlock;
        _timeoutBlock = timeoutBlock;
        _shouldPerformTimeout = YES;

        _loopTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));

        uint64_t interval_ = interval * NSEC_PER_SEC;
        dispatch_source_set_timer(_loopTimer, dispatch_time(DISPATCH_TIME_NOW, 0), interval_,0);

        dispatch_source_set_event_handler(_loopTimer, ^{
            if (_loopBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _loopBlock();
                });

            }
        });

        dispatch_source_set_cancel_handler(_loopTimer, ^{
            NSLog(@"cancel");
        });

        _timeoutTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));

        uint64_t timeout_ = timeout * NSEC_PER_SEC;
        dispatch_source_set_timer(_timeoutTimer, dispatch_time(DISPATCH_TIME_NOW, timeout_), DISPATCH_TIME_FOREVER,0);

        dispatch_source_set_event_handler(_timeoutTimer, ^{
            if (_shouldPerformTimeout && timeoutBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    timeoutBlock();
                });
            }
        });

        dispatch_source_set_cancel_handler(_timeoutTimer, ^{
            NSLog(@"cancel");
        });
    }
    return self;
}

+ (instancetype)createLoopExpectationTimerInterval:(NSTimeInterval)interval
                                         loopBlock:(void(^)(void))loopBlock
                                           timeout:(NSTimeInterval)timeout
                                      timeoutBlock:(void(^)(void))timeoutBlock
{
    return [[self alloc]initLoopExpectationTimerInterval:interval loopBlock:loopBlock timeout:timeout timeoutBlock:timeoutBlock];
}

- (void)dealloc{
    dispatch_source_cancel(_loopTimer);
    dispatch_source_cancel(_timeoutTimer);
    _loopTimer = nil;
    _timeoutTimer = nil;
}

- (void)start{
    _shouldPerformTimeout = YES;
    if (_loopTimer) {
        dispatch_resume(_loopTimer);
    }

    if (_timeoutTimer) {
        dispatch_resume(_timeoutTimer);
    }

}

- (void)turnOffTimeout{
    if (_shouldPerformTimeout) {
        if (_timeoutTimer) {
            dispatch_source_cancel(_timeoutTimer);
        }
    }
    _shouldPerformTimeout = NO;
}

- (void)turnOffLoop{
    if (_loopTimer) {
        dispatch_source_cancel(_loopTimer);
    }

}

@end
