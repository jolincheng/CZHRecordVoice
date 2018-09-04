//
//  ViewController.m
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

typedef NS_ENUM(NSInteger, ViewControllerButtonType) {
    ViewControllerButtonTypeCheck,
    ViewControllerButtonTypePlay,
    ViewControllerButtonTypeDelete
};

#import "ViewController.h"
#import "CZHRecordVoiceButton.h"
#import "NBLFileExplorer.h"
#import "CZHFileManager.h"
#import "CZHAudioPlayer.h"
#import "CZHAvRelationTool.h"

//

@interface ViewController ()<CZHRecordVoiceButtonDelegate, CZHAudioPlayerDelegate>
///<#注释#>
@property (nonatomic, weak) UIButton *playButton;
///<#注释#>
@property (nonatomic, weak) UIButton *deleteButton;
///<#注释#>
@property (nonatomic, copy) NSString *audioLocalPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self czh_setUpView];
    
    [CZHAudioPlayer shareInstance].delegate = self;
}


- (void)czh_setUpView {
    
    CGFloat recordButtonH = CZH_ScaleWidth(50);
    CGFloat recordButtonX = CZH_ScaleWidth(15);
    CGFloat recordButtonY = CZHScreenHeight - CZHSafeAreaBottomHeight - recordButtonH - CZH_ScaleWidth(15);
    CGFloat recordButtonW = CZHScreenWidth - recordButtonX * 2;
    CGRect recordButtonF = CGRectMake(recordButtonX, recordButtonY, recordButtonW, recordButtonH);
    
    CZHRecordVoiceButton *recordButton = [[CZHRecordVoiceButton alloc] init];
    recordButton.frame = recordButtonF;
    recordButton.delegate = self;
    [self.view addSubview:recordButton];
    
    
    CGFloat checkButtonX = recordButtonX;
    CGFloat checkButtonY = CZHNavigationBarHeight + CZH_ScaleWidth(15);
    CGFloat checkButtonW = recordButtonW;
    CGFloat checkButtonH = recordButtonH;
    CGRect checkButtonF = CGRectMake(checkButtonX, checkButtonY, checkButtonW, checkButtonH);
    UIButton *checkButton = [[UIButton alloc] init];
    checkButton.tag = ViewControllerButtonTypeCheck;
    checkButton.frame = checkButtonF;
    [checkButton setTitle:@"查看沙盒" forState:UIControlStateNormal];
    [checkButton setTitleColor:CZHColor(0xffffff) forState:UIControlStateNormal];
    checkButton.backgroundColor = CZHColor(0x0000ff);
    [checkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
 
    
    CGFloat playButtonX = recordButtonX;
    CGFloat playButtonY = checkButton.czh_bottom + CZH_ScaleWidth(15);
    CGFloat playButtonW = CZH_ScaleWidth(97);
    CGFloat playButtonH = CZH_ScaleWidth(97);
    CGRect playButtonF = CGRectMake(playButtonX, playButtonY, playButtonW, playButtonH);
    UIButton *playButton = [[UIButton alloc] init];
    playButton.tag = ViewControllerButtonTypePlay;
    playButton.frame = playButtonF;
    [playButton setBackgroundImage:[UIImage imageNamed:@"audio_play"] forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"audio_pause"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    playButton.hidden = YES;
    [self.view addSubview:playButton];
    self.playButton = playButton;
    
    
    CGFloat deleteButtonX = recordButtonX;
    CGFloat deleteButtonY = playButton.czh_bottom + CZH_ScaleWidth(15);
    CGFloat deleteButtonW = recordButtonW;
    CGFloat deleteButtonH = recordButtonH;
    CGRect deleteButtonF = CGRectMake(deleteButtonX, deleteButtonY, deleteButtonW, deleteButtonH);
    UIButton *deleteButton = [[UIButton alloc] init];
    deleteButton.tag = ViewControllerButtonTypeDelete;
    deleteButton.frame = deleteButtonF;
    [deleteButton setTitle:@"删除语音" forState:UIControlStateNormal];
    [deleteButton setTitleColor:CZHColor(0xffffff) forState:UIControlStateNormal];
    deleteButton.backgroundColor = CZHColor(0x0000ff);
    [deleteButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.hidden = YES;
    [self.view addSubview:deleteButton];
    self.deleteButton = deleteButton;
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == ViewControllerButtonTypeCheck) {
        
        [[NBLFileExplorer sharedExplorer] presentedByViewController:self];
        
    } else if (sender.tag == ViewControllerButtonTypePlay) {

        
        if ([CZHAudioPlayer shareInstance].isPlaying) {//正在播放，点击暂停
            
            sender.selected = NO;
            
            [[CZHAudioPlayer shareInstance] czh_pauseCurrentAudio];
            
        } else {//
            
            NSString *lastAudioLocalPath = [CZHAudioPlayer shareInstance].localPath;
            
            if ([CZHAudioPlayer shareInstance].progress > 0 && [lastAudioLocalPath isEqualToString:self.audioLocalPath]) {//播放进度大于0的时候直接恢复播放
                
                [[CZHAudioPlayer shareInstance] czh_resumeCurrentAudio];
                
            } else {//重新播放
                
                [CZHAvRelationTool czh_playAudioWithLocalPath:self.audioLocalPath];
                
                NSString *audioLocalPath = [CZHAudioPlayer shareInstance].localPath;
                
                self.audioLocalPath = audioLocalPath;
            }

            sender.selected = YES;
        }
        
        
    } else if (sender.tag == ViewControllerButtonTypeDelete) {
        
        if ([CZHFileManager czh_removeFile:self.audioLocalPath]) {//删除成功
            
            self.playButton.hidden = YES;
            self.deleteButton.hidden = YES;
            
            self.audioLocalPath = nil;
        }
        
    }

}

#pragma 播放代理
- (void)czh_audioPlayerPause {
    
}

- (void)czh_audioPlayerStop {
    self.playButton.selected = NO;
}

- (void)czh_audioPlayerFinish {
    
    self.playButton.selected = NO;
}

#pragma 录制按钮代理
- (void)czh_continueRecordingWithButton:(CZHRecordVoiceButton *)button {
    
    CZHLog(@"持续录制");
}

- (void)czh_didBeginRecordWithButton:(CZHRecordVoiceButton *)button {
    CZHLog(@"开始录制");
    ///开始录制停止播放
    [[CZHAudioPlayer shareInstance] czh_stopCurrentAudio];
}

- (void)czh_didCancelRecordWithButton:(CZHRecordVoiceButton *)button {
    CZHLog(@"取消录制");
}

- (void)czh_didFinishedRecordWithButton:(CZHRecordVoiceButton *)button audioLocalPath:(NSString *)audioLocalPath {
    CZHLog(@"结束录制返回路径=%@", audioLocalPath);
    
    //转换成amr的路径，文件大小大概只有原来的1/10，所以上传到服务器比较快，播放的时候记得转换成wav的
    if (audioLocalPath.length > 0) {
        
        self.audioLocalPath = audioLocalPath;
        
        self.playButton.hidden = NO;
        self.deleteButton.hidden = NO;
    }
}

- (void)czh_willCancelRecordWithButton:(CZHRecordVoiceButton *)button {
    CZHLog(@"将要取消录制");
}


@end
