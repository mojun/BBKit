//
//  BBExpectationTimer.h
//  BBKitDemo
//
//  Created by mo jun on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 在指定时间内达到预期 执行成功，或者失败
@interface BBTimerExpectation : NSObject

- (instancetype)initExpectationWithTimeout:(NSTimeInterval)timeout
                                successBlock:(void(^)(void))successBlock
                                   failBlock:(void(^)(void))failBlock;
/**
 *  @param timeout 超时
 *  @param successBlock 在timeout时间内达到期望调用成功回调
 *  @param failBlock 在timeout时间内未达到期望调用失败回调
 */
+ (instancetype)createExpectationWithTimeout:(NSTimeInterval)timeout
                                successBlock:(void(^)(void))successBlock
                                   failBlock:(void(^)(void))failBlock;
/// 启动期望
- (void)start;

/**
 *  达到期望调用
 */
- (void)fulfill;

/// 关闭期望
- (void)stop;

@end

NS_ASSUME_NONNULL_END
