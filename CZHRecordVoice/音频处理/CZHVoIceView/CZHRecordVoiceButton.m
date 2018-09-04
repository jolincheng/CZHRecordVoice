//
//  CZHRecordVoiceButton.m
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHRecordVoiceButton.h"
#import "CZHRecordVoiceHUD.h"
#import "CZHFileManager.h"
#import "CZHRecordTool.h"

@interface CZHRecordVoiceButton ()

///<#注释#>
@property (nonatomic, copy) NSString *audioLocalPath;

@end

@implementation CZHRecordVoiceButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    
    return [[CZHRecordVoiceButton alloc] init];
    
}


- (instancetype)init {
    
    if (self = [super init]) {
       
        [self czh_setView];
        
        [self czh_addGesture];
        
    }
    return self;
    
}

- (void)czh_setView {
    
    self.backgroundColor = CZHColor(0xf2f2f2);
    
    [self setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1.0].CGColor;
    
    self.titleLabel.font = CZHGlobelNormalFont(16);
    
    
}

- (void)czh_addGesture {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    
}

- (void)longPress:(UILongPressGestureRecognizer *)gr {
    
#warning---如果按钮是放在类似微信键盘上，这里的view使用button的superview self.superview
    CGPoint point = [gr locationInView:self];
    

    [CZHRecordVoiceHUD shareInstance].longTimeHandler = ^{//超过最长时间还在长按，主动让手势不可用
        gr.enabled = NO;
    };
    
    
    if (gr.state == UIGestureRecognizerStateBegan) {//长按开始
        CZHLog(@"---开始录音");
        [self czh_setButtonStateWithRecording];
        
        //            [CWRecorder shareInstance].delegate = self;
        
        NSString *audioLocalPath = [CZHFileManager czh_filePath];
        self.audioLocalPath = audioLocalPath;
        
        ///开始录音
        [[CZHRecordTool shareInstance] czh_beginRecordWithRecordPath:audioLocalPath];
        
        [[CZHRecordVoiceHUD shareInstance] czh_showHUDWithType:CZHRecordVoiceHUDTypeBeginRecord];
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(czh_didBeginRecordWithButton:)]) {
            [self.delegate czh_didBeginRecordWithButton:self];
        }
        
        
    }else if (gr.state == UIGestureRecognizerStateChanged) {//长按改变位置
        
        #warning---如果按钮是放在类似微信键盘上，这里的view使用button的superview的czh_height self.superview.czh_height
        if (point.y < 0 || point.y > self.czh_height) {//超出范围提示松开手指取消发送
            CZHLog(@"---松开取消");
            [self czh_setButtonStateWithCancel];
            
            [[CZHRecordVoiceHUD shareInstance] czh_showHUDWithType:CZHRecordVoiceHUDTypeReleaseToCancle];
            
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(czh_willCancelRecordWithButton:)]) {
                [self.delegate czh_willCancelRecordWithButton:self];
            }
            
        } else {//在范围内，提示上滑取消发送
            CZHLog(@"---松开结束");
            [self czh_setButtonStateWithRecording];
            
            [[CZHRecordVoiceHUD shareInstance] czh_showHUDWithType:CZHRecordVoiceHUDTypeRecording];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(czh_continueRecordingWithButton:)]) {
                [self.delegate czh_continueRecordingWithButton:self];
            }
            
        }
        
    } else if (gr.state == UIGestureRecognizerStateEnded) {//松开手指
       
        
        [[CZHRecordVoiceHUD shareInstance] czh_showHUDWithType:CZHRecordVoiceHUDTypeEndRecord];
       
        [self czh_cancelOrEndRecordWithPoint:point];
        
    } else if (gr.state == UIGestureRecognizerStateCancelled) {//手势不可用走
        
        [self czh_cancelOrEndRecordWithPoint:point];
        
        gr.enabled = YES;
        
    } else if (gr.state == UIGestureRecognizerStateFailed) {
        CZHLog(@"UIGestureRecognizerStateFailed---");
    } else if (gr.state == UIGestureRecognizerStatePossible) {
        CZHLog(@"UIGestureRecognizerStatePossible---");
    }
    
}

- (void)czh_cancelOrEndRecordWithPoint:(CGPoint)point {
    
    [self czh_setButtonStateWithNormal];
    [[CZHRecordTool shareInstance] czh_endRecord]; // 结束录音
    
   
#warning---如果按钮是放在类似微信键盘上，这里的view使用button的superview的czh_height self.superview.czh_height
    if (point.y < 0 || point.y > self.czh_height) {//超出范围不发送
        
        [[CZHRecordTool shareInstance] czh_deleteRecord];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(czh_didCancelRecordWithButton:)]) {
            [self.delegate czh_didCancelRecordWithButton:self];
        }
        
    } else {//在范围内，直接发送
        
        ///把wav转成amr，减小文件大小
        NSString *amrFilePath = [CZHFileManager czh_convertWavtoAMRWithVoiceFilePath:self.audioLocalPath];

        //删除wav文件
        [CZHFileManager czh_removeFile:self.audioLocalPath];
        
        //代理返回amr文件路径
        if (self.delegate && [self.delegate respondsToSelector:@selector(czh_didFinishedRecordWithButton:audioLocalPath:)]) {
            [self.delegate czh_didFinishedRecordWithButton:self audioLocalPath:amrFilePath];
        }
    }
}




- (void)czh_setButtonStateWithRecording
{
    self.backgroundColor = CZHColor(0xcccccc); //
    [self setTitle:@"松开 结束" forState:UIControlStateNormal];
}

- (void)czh_setButtonStateWithCancel
{
    self.backgroundColor = CZHColor(0xcccccc); //
    [self setTitle:@"松开 取消" forState:UIControlStateNormal];
}

- (void)czh_setButtonStateWithNormal
{
    self.backgroundColor = CZHColor(0xf2f2f2);
    [self setTitle:@"按住 说话" forState:UIControlStateNormal];
}


@end
