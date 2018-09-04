# CZHRecordVoice
录音功能，加上录音动画，录音文件会转换成amr文件减小上传文件大小

![这里写图片描述](https://img-blog.csdn.net/20180904163111392?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0h1cnJ5VXBDaGVuZw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

试用起来很方便，封装好了，各种代理方法处理

```
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

```

[简书地址](https://www.jianshu.com/p/882c41abccd1)
[博客地址](https://blog.csdn.net/HurryUpCheng)
