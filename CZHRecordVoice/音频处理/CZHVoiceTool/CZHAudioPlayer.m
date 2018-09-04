//
//  CZHAudioPlayer.m
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/4.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHAudioPlayer.h"

@interface CZHAudioPlayer() <AVAudioPlayerDelegate>

@end

@implementation CZHAudioPlayer

singtonImplement(CZHAudioPlayer)

- (NSString *)localPath {
    return self.player.url.path;
}

- (AVAudioPlayer *)czh_playAudioWith:(NSString *)audioPath {
    
    NSString *lastAudioPath = self.player.url.path;
    //当前地址跟之前的一样
    if ([lastAudioPath isEqualToString:audioPath] && self.player.isPlaying == YES) {//同一个地址,正在播放
        //停止
        [self czh_pauseCurrentAudio];
        
        return nil;
    }
    //
    //    [self stopCurrentAudio]; // 播放之前 先结束当前播放
    // 设置为扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *url = [NSURL URLWithString:audioPath];
    if (url == nil) {
        url = [[NSBundle mainBundle] URLForResource:audioPath.lastPathComponent withExtension:nil];
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    //    NSLog(@"准备播放...%@",url);
    [self.player prepareToPlay];
    //    NSLog(@"播放...");
    [self.player play];
    return self.player;
}


- (void)czh_resumeCurrentAudio {
    [self.player play];
}

- (void)czh_pauseCurrentAudio {
    
    [self.player pause];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(czh_audioPlayerPause)]) {
        [self.delegate czh_audioPlayerPause];
    }
}

- (void)czh_stopCurrentAudio {
    
    [self.player stop];

    if (self.delegate && [self.delegate respondsToSelector:@selector(czh_audioPlayerStop)]) {
        [self.delegate czh_audioPlayerStop];
    }
    
}

- (float)progress {
    return self.player.currentTime / self.player.duration;
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSLog(@"----%@播放完", player);
    if (self.delegate && [self.delegate respondsToSelector:@selector(czh_audioPlayerFinish)]) {
        [self.delegate czh_audioPlayerFinish];
    }

    
}

@end
