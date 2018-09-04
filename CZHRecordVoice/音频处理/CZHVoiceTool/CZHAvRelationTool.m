//
//  CZHAvRelationTool.m
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/4.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHAvRelationTool.h"
#import "CZHAudioPlayer.h"
#import "CZHFileManager.h"
#import "CZHRecordTool.h"

@implementation CZHAvRelationTool

+ (NSString *)czh_getLocalPathWithVoiceUrl:(NSString *)voiceUrl {
    
    NSString *lastPath = [voiceUrl lastPathComponent];
    //先判断本地有没有
    NSString *localPath = [CZHFileManager czh_voiceUrlIsExistInLocalWithLastPathComponent:lastPath];
    
    if (localPath.length <= 0) {//不存在本地路径，把amr转成wav格式
        
        if ([voiceUrl hasSuffix:@"amr"]) {///如果语音网络地址结尾是amr
            ///转成wav存在本地
            localPath = [CZHFileManager czh_convertAMRToWavWithVoiceUrl:voiceUrl];
        } else {///如果语音网络地址结尾不是amr
            ///直接存在本地
            localPath = [CZHFileManager czh_saveWavWithVoiceUrl:voiceUrl];
        }
    }
    
    return localPath;
}

+ (AVAudioPlayer *)czh_playAudioWithLocalPath:(NSString *)localPath {
    
    NSString *wavLocalPath;
    
    if ([localPath hasSuffix:@"amr"]) {

        //判断wav文件存不存在
        wavLocalPath = [CZHFileManager czh_voiceUrlIsExistInLocalWithLastPathComponent:[localPath lastPathComponent]];
        
        if (wavLocalPath.length <= 0) {//不存在把amr格式转成wav格式
            wavLocalPath = [CZHFileManager czh_convertAMRToWavWithVoiceFilePath:localPath];
        }
    
        ///把amr格式的文件删除
        [CZHFileManager czh_removeFile:localPath];
        
    } else {
        wavLocalPath = localPath;
    }
    
    return [[CZHAudioPlayer shareInstance] czh_playAudioWith:wavLocalPath];
    
}



+ (AVAudioPlayer *)czh_playAudioWithVoiceUrl:(NSString *)voiceUrl {
    
    NSString *localPath = [self czh_getLocalPathWithVoiceUrl:voiceUrl];
    
    return [self czh_playAudioWithLocalPath:localPath];
    
}

+ (void)czh_stopAudio {
    
    //先暂停播放
    if ([CZHAudioPlayer shareInstance].isPlaying) {
        [[CZHAudioPlayer shareInstance] czh_stopCurrentAudio];
    }
}

@end
