//
//  NSError+BLLocalliszed.m
//  BLNetWorkBaseEngine
//
//  Created by boundlessocean on 2017/9/30.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import "NSError+BLLocalliszed.h"

@implementation NSError (BLLocalliszed)
- (NSString *)localizedDescription{
    NSString *errorDescription = @"未知错误";
    switch (self.code) {
            
        case 1:
            errorDescription = @"DNS查找失败";
            break;
            
        // SOCKS错误
        case 100:
        case 101:
        case 110:
        case 111:
        case 112:
        case 113:
        case 120:
        case 121:
        case 122:
        case 123:
        case 124:
            errorDescription = @"SOCKS错误";
            break;
            
        // FTP错误
        case 200:
            errorDescription = @"FTP错误";
            break;
            
            
            
        // 300-311 HTTP错误
        case 300:
        case 301:
            errorDescription = @"证书错误";
            break;
        case 302:
            errorDescription = @"连接丢失";
            break;
        case 303:
            errorDescription = @"服务器无法解析";
            break;
        case 304:
            errorDescription = @"重定向过多";
            break;
        case 305:
            errorDescription = @"URL格式错误";
            break;
        case 306:
        case 307:
        case 308:
        case 309:
        case 310:
        case 311:
            errorDescription = @"HTTP代理错误";
            break;
            
            
        // CFURLConnection和CFURLProtocol错误
        case -999:
            errorDescription = @"已取消";
            break;
        case -1000:
            errorDescription = @"URL格式错误";
            break;
        case -1001:
            errorDescription = @"连接超时";
            break;
        case -1002:
            errorDescription = @"不支持的URL";
            break;
        case -1003:
        case -1004:
            errorDescription = @"无法连接到服务器";
            break;
        case -1005:
            errorDescription = @"网络丢失";
            break;
        case -1006:
            errorDescription = @"DNS查找失败";
            break;
        case -1007:
            errorDescription = @"重定向过多";
            break;
        case -1008:
            errorDescription = @"服务器资源不可用";
            break;
        case -1009:
            errorDescription = @"请检查你的网络";
            break;
        case -1010:
            errorDescription = @"重定向URL错误";
            break;
        case -1011:
            errorDescription = @"服务器响应错误";
            break;
        case -1012:
        case -1013:
            errorDescription = @"需要身份验证";
            break;
        case -1014:
            errorDescription = @"检索资源为零";
            break;
        case -1015:
        case -1016:
        case -1017:
            errorDescription = @"响应数据格式错误";
            break;
        case -1018:
            errorDescription = @"请开启国际漫游";
            break;
        case -1019:
            errorDescription = @"设备正在通话";
            break;
        case -1020:
            errorDescription = @"请允许使用移动蜂窝数据";
            break;
        case -1021:
            errorDescription = @"未知错误";
            break;
        case -1022:
            errorDescription = @"App Transport Security策略需要使用安全连接，无法加载资源";
            break;
            
            
            
        // 文件操作错误
        case -1100:
            errorDescription = @"文件不存在";
            break;
        case -1101:
            errorDescription = @"文件为目录";
            break;
        case -1102:
            errorDescription = @"没有读取文件权限";
            break;
        case -1103:
            errorDescription = @"文件过大";
            break;
            
            
        // SSL错误
        case -1200:
            errorDescription = @"安全连接失败";
            break;
        case -1201:
            errorDescription = @"安全连接失败,服务器的证书的日期无效。";
            break;
        case -1202:
            errorDescription = @"安全连接失败,服务器的证书不受信任。";
            break;
        case -1203:
            errorDescription = @"安全连接失败,服务器的证书具有未知根。";
            break;
        case -1204:
            errorDescription = @"安全连接失败,服务器的证书尚未生效。";
            break;
        case -1205:
            errorDescription = @"安全连接失败,客户端的证书被拒绝。";
            break;
        case -1206:
            errorDescription = @"安全连接失败,服务器需要客户端证书。";
            break;
            
        // 下载和文件I / O错误
        case -2000:
            errorDescription = @"资源加载失败";
            break;
        case -3000:
            errorDescription = @"该文件无法创建";
            break;
        case -3001:
            errorDescription = @"该文件无法打开";
            break;
        case -3002:
            errorDescription = @"该文件无法关闭";
            break;
        case -3003:
            errorDescription = @"该文件无法写入";
            break;
        case -3004:
            errorDescription = @"该文件无法删除";
            break;
        case -3005:
            errorDescription = @"该文件无法移动";
            break;
        case -3006:
            errorDescription = @"下载失败,下载数据的解码在中途失败。";
            break;
        case -3007:
            errorDescription = @"下载失败,下载的数据的解码无法完成。";
            break;
            
        // Cookie错误
            
        case -4000:
            errorDescription = @"Cookie无法解析";
            break;
    }
    return errorDescription;
}
@end
