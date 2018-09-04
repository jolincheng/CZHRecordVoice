//
//  CZHAudioPlayer.h
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/4.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol CZHAudioPlayerDelegate <NSObject>
//暂停播放
- (void)czh_audioPlayerPause;
///播放完成
- (void)czh_audioPlayerFinish;
///停止播放
- (void)czh_audioPlayerStop;
@end



@interface CZHAudioPlayer : NSObject
///
@property (nonatomic, copy, readonly) NSString *localPath;
/** 音频播放器 */
@property (nonatomic ,strong) AVAudioPlayer *player;
///播放进度
@property (nonatomic, assign, readonly) float progress;
///播放进度
@property (nonatomic, assign, readonly) BOOL isPlaying;
///代理
@property (nonatomic, weak) id<CZHAudioPlayerDelegate> delegate;

singtonInterface;

///播放音频
- (AVAudioPlayer *)czh_playAudioWith:(NSString *)audioPath;
/// 恢复播放音频
- (void)czh_resumeCurrentAudio;
///暂停播放
- (void)czh_pauseCurrentAudio;
///停止播放
- (void)czh_stopCurrentAudio;

@end
