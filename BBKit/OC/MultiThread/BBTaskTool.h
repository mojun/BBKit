//
//  BBTaskTool.h
//  BBKitDemo
//
//  Created by mo jun on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BBTaskTool : NSObject

/*
 *  @brief 可取消同步任务
 *
 *  @param syncTaskBlock 任务block 如果返回YES 说明任务完成执行completion，如果为NO继续完成该任务
 *  @param (void (^)(BOOL success))completion success=YES 任务完成，success=NO 任务被用户取消
 */
- (void)startSyncTaskInBackground:(BOOL (^)(void))syncTaskBlock
                  completionBlock:(void (^)(BOOL success))completionBlock;

/*
 @brief 取消任务
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
