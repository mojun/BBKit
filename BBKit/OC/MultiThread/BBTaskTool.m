//
//  BBTaskTool.m
//  BBKitDemo
//
//  Created by mo jun on 2020/12/17.
//

#import "BBTaskTool.h"
#import "BBKit-Header.h"

@implementation BBTaskTool {
    BOOL isRunning;
}

- (void)startSyncTaskInBackground:(BOOL (^)(void))syncTaskBlock
                  completionBlock:(void (^)(BOOL success))completionBlock {
    if (!syncTaskBlock) {
        return;
    }

    isRunning = YES;

    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        while (!syncTaskBlock() && self->isRunning) {
            [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }

        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(self->isRunning);
            });
        }
    });
}


- (void)stop {
    isRunning = NO;
}

@end
