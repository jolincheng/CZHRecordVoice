//
//  CZHFileManager.h
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZHFileManager : NSObject


+ (NSString *)czh_folderPath;
// 音频文件保存的整个路径
+ (NSString *)czh_filePath;
// 删除文件
+ (BOOL)czh_removeFile:(NSString *)filePath;
///转换本地wav为本地amr
+ (NSString *)czh_convertWavtoAMRWithVoiceFilePath:(NSString *)voiceFilePath;
///把网络地址保存到本地
+ (NSString *)czh_saveWavWithVoiceUrl:(NSString *)voiceUrl;
///转换本地amr为wav本地音频
+ (NSString *)czh_convertAMRToWavWithVoiceFilePath:(NSString *)voiceFilePath;
///转换网络amr为wav本地音频
+ (NSString *)czh_convertAMRToWavWithVoiceUrl:(NSString *)voiceUrl;
///本地已经有，返回本地路径
+ (NSString *)czh_voiceUrlIsExistInLocalWithLastPathComponent:(NSString *)lastPathComponent;
@end
