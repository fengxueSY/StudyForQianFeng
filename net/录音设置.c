

//录音设置
NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
//设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
[recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
[recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
//录音通道数  1 或 2
[recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
//线性采样位数  8、16、24、32
[recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//录音的质量
[recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];