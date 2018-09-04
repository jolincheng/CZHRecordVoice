//
//  CZHRecordVoiceButton.h
//  CZHRecordVoice
//
//  Created by 程召华 on 2018/9/3.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZHRecordVoiceButton;
@protocol CZHRecordVoiceButtonDelegate <NSObject>

- (void)czh_didBeginRecordWithButton:(CZHRecordVoiceButton *)button;

- (void)czh_continueRecordingWithButton:(CZHRecordVoiceButton *)button;

- (void)czh_willCancelRecordWithButton:(CZHRecordVoiceButton *)button;

- (void)czh_didFinishedRecordWithButton:(CZHRecordVoiceButton *)button audioLocalPath:(NSString *)audioLocalPath;

- (void)czh_didCancelRecordWithButton:(CZHRecordVoiceButton *)button;
@end


@interface CZHRecordVoiceButton : UIButton

///代理
@property (nonatomic, weak) id<CZHRecordVoiceButtonDelegate> delegate;


@end
