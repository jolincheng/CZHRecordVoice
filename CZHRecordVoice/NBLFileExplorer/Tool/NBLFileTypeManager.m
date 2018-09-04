//
//  NBLFileTypeManager.m
//  NBLFileExplorer
//
//  Created by snb on 16/12/21.
//  Copyright © 2016年 neebel. All rights reserved.
//

#import "NBLFileTypeManager.h"

@implementation NBLFileTypeManager

+ (NBLFileType)parseFileType:(NSString *)extension
{
    NBLFileType fileType;
    
    extension = [extension lowercaseString];
    
    if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"JPG"]) {
        fileType = kNBLFileTypeJPG;
    } else if ([extension isEqualToString:@"jpeg"] || [extension isEqualToString:@"JPEG"]) {
        fileType = kNBLFileTypeJPEG;
    } else if ([extension isEqualToString:@"png"] || [extension isEqualToString:@"PNG"]) {
        fileType = kNBLFileTypePNG;
    } else if ([extension isEqualToString:@"gif"] || [extension isEqualToString:@"GIF"]) {
        fileType = kNBLFileTypeGIF;
    } else if ([extension isEqualToString:@"bmp"] || [extension isEqualToString:@"BMP"]) {
        fileType = kNBLFileTypeBMP;
    } else if ([extension isEqualToString:@"rar"] || [extension isEqualToString:@"RAR"]) {
        fileType = kNBLFileTypeRAR;
    } else if ([extension isEqualToString:@"zip"] || [extension isEqualToString:@"ZIP"]) {
        fileType = kNBLFileTypeZIP;
    } else if ([extension isEqualToString:@"xml"] || [extension isEqualToString:@"XML"]) {
        fileType = kNBLFileTypeXML;
    } else if ([extension isEqualToString:@"html"] || [extension isEqualToString:@"HTML"]) {
        fileType = kNBLFileTypeHTML;
    } else if ([extension isEqualToString:@"aspx"] || [extension isEqualToString:@"ASPX"]) {
        fileType = kNBLFileTypeASPX;
    } else if ([extension isEqualToString:@"css"] || [extension isEqualToString:@"CSS"]) {
        fileType = kNBLFileTypeCSS;
    } else if ([extension isEqualToString:@"js"] || [extension isEqualToString:@"JS"]) {
        fileType = kNBLFileTypeJS;
    } else if ([extension isEqualToString:@"txt"] || [extension isEqualToString:@"TXT"]) {
        fileType = kNBLFileTypeTXT;
    } else if ([extension isEqualToString:@"pdf"] || [extension isEqualToString:@"PDF"]) {
        fileType = kNBLFileTypePDF;
    } else if ([extension isEqualToString:@"doc"] || [extension isEqualToString:@"DOC"]) {
        fileType = kNBLFileTypeDOC;
    } else if ([extension isEqualToString:@"mp3"] || [extension isEqualToString:@"MP3"]) {
        fileType = kNBLFileTypeMP3;
    } else if ([extension isEqualToString:@"wma"] || [extension isEqualToString:@"WMA"]) {
        fileType = kNBLFileTypeWMA;
    } else if ([extension isEqualToString:@"aac"] || [extension isEqualToString:@"AAC"]) {
        fileType = kNBLFileTypeAAC;
    } else if ([extension isEqualToString:@"m4a"] || [extension isEqualToString:@"M4A"]) {
        fileType = kNBLFileTypeM4A;
    } else if ([extension isEqualToString:@"m4v"] || [extension isEqualToString:@"M4V"]) {
        fileType = kNBLFileTypeM4V;
    } else if ([extension isEqualToString:@"mp4"] || [extension isEqualToString:@"MP4"]) {
        fileType = kNBLFileTypeMP4;
    } else if ([extension isEqualToString:@"mov"] || [extension isEqualToString:@"MOV"]) {
        fileType = kNBLFileTypeMOV;
    } else if ([extension isEqualToString:@"wmv"] || [extension isEqualToString:@"WMV"]) {
        fileType = kNBLFileTypeWMV;
    } else if ([extension isEqualToString:@"avi"] || [extension isEqualToString:@"AVI"]) {
        fileType = kNBLFileTypeAVI;
    } else {
        fileType = kNBLFileTypeUnknown;
    }

    return fileType;
}


+ (UIImage *)searchFileLogoWithFileType:(NBLFileType)fileType
{
    NSString *fileTypeStr = nil;
    switch (fileType) {
        case kNBLFileTypeJPG:
            fileTypeStr = @"jpg";
            break;
            
        case kNBLFileTypeJPEG:
            fileTypeStr = @"jpeg";
            break;
            
        case kNBLFileTypePNG:
            fileTypeStr = @"png";
            break;
            
        case kNBLFileTypeGIF:
            fileTypeStr = @"gif";
            break;
            
        case kNBLFileTypeBMP:
            fileTypeStr = @"bmp";
            break;
            
        case kNBLFileTypeRAR:
            fileTypeStr = @"rar";
            break;
            
        case kNBLFileTypeZIP:
            fileTypeStr = @"zip";
            break;
            
        case kNBLFileTypeXML:
            fileTypeStr = @"xml";
            break;
            
        case kNBLFileTypeHTML:
            fileTypeStr = @"html";
            break;
            
        case kNBLFileTypeASPX:
            fileTypeStr = @"aspx";
            break;
            
        case kNBLFileTypeCSS:
            fileTypeStr = @"css";
            break;
            
        case kNBLFileTypeJS:
            fileTypeStr = @"js";
            break;
            
        case kNBLFileTypeTXT:
            fileTypeStr = @"txt";
            break;
            
        case kNBLFileTypePDF:
            fileTypeStr = @"pdf";
            break;
            
        case kNBLFileTypeDOC:
            fileTypeStr = @"doc";
            break;
            
        case kNBLFileTypeMP3:
            fileTypeStr = @"mp3";
            break;
            
        case kNBLFileTypeWMA:
            fileTypeStr = @"wma";
            break;
            
        case kNBLFileTypeAAC:
            fileTypeStr = @"aac";
            break;
            
        case kNBLFileTypeM4A:
            fileTypeStr = @"m4a";
            break;
            
        case kNBLFileTypeM4V:
            fileTypeStr = @"m4v";
            break;
            
        case kNBLFileTypeMP4:
            fileTypeStr = @"mp4";
            break;
            
        case kNBLFileTypeMOV:
            fileTypeStr = @"mov";
            break;
            
        case kNBLFileTypeWMV:
            fileTypeStr = @"wmv";
            break;
            
        case kNBLFileTypeAVI:
            fileTypeStr = @"avi";
            break;
            
        case kNBLFileTypeUnknown:
            fileTypeStr = @"file";
            break;
            
        default:
            break;
    }
    NSString *tmpStr = [NSString stringWithFormat:@"icon.bundle/%@", fileTypeStr];
    return [UIImage imageNamed:tmpStr];
}

@end
