//
//  CZHAvRelationTool.h
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/4.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CZHAvRelationTool : NSObject

/**
 * 判断网络语音在本地存不存在
 */
+ (NSString *)czh_getLocalPathWithVoiceUrl:(NSString *)voiceUrl;

/**
 * 播放语音本地路径
 */
+ (AVAudioPlayer *)czh_playAudioWithLocalPath:(NSString *)localPath;

/**
 * 播放网络语音
 */
+ (AVAudioPlayer *)czh_playAudioWithVoiceUrl:(NSString *)voiceUrl;
/**
 * 停止播放
 */
+ (void)czh_stopAudio;

@end
