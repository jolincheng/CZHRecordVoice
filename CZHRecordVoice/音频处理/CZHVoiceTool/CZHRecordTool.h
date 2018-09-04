//
//  CZHRecordTool.h
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CZHRecordToolDelegate <NSObject>

/**
 * 准备中
 */
- (void)czh_prepareToRecording;

/**
 * 录音中
 */
- (void)czh_recording;

/**
 * 录音失败
 */
- (void)czh_recordingFailed:(NSString *)failedMessage;

@end

@interface CZHRecordTool : NSObject

@property (nonatomic,copy, readonly) NSString *recordPath;
@property (nonatomic,assign) BOOL isRecording;
///代理
@property (nonatomic, weak) id<CZHRecordToolDelegate> delegate;
singtonInterface

/**
 *  开始录音
 */
- (void)czh_beginRecordWithRecordPath:(NSString *)recordPath;

/**
 *  结束录音
 */
- (void)czh_endRecord;

/**
 *  暂停录音
 */
- (void)czh_pauseRecord;

/**
 *  删除录音
 */
- (void)czh_deleteRecord;

/**
 *  返回分贝值
 */
- (float)czh_updateLevels;

@end
