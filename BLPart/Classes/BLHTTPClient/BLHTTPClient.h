//
//  BLHTTPClient.h
//  BLNetWorkBaseEngine
//
//  Created by boundlessocean on 2017/9/28.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLEngineConfigure.h"

@interface BLRequsetModel : NSObject
@end


@interface BLHTTPClient : NSObject

NS_ASSUME_NONNULL_BEGIN


/** 请求配置 */
+ (void)configRequestSerializer:(RequestSerializer)requestSerializer;

/** 响应配置 */
+ (void)configResponseSerializer:(ResponseSerializer)responseSerializer;

/** 配置证书 */
+ (void)configCertificate:(NSString *)certificateName;

/**
 POST/GET/DELETE... 请求
 @param parameters 参数
 @param requestType 请求的方式 POST/GET 不传为POST
 @param completionHandler 请求完成处理
 @return 返回 BLBaseEngine 供调用者处理其他逻辑
 */
+ (__kindof NSURLSessionTask *)dataRequsetWithURL:(NSString *)URLString
                                      requestType:(BLURLRequestType)requestType
                                       parameters:(NSDictionary * __nullable)parameters
                                       completion:(CompletionHandler)completionHandler;


/**
 上传文件
 @param parameters 参数
 @param constructingBodyBlock 拼接Body
 @param completionHandler 请求完成处理
 @return 返回 BLBaseEngine 供调用者处理其他逻辑
 */
+ (__kindof NSURLSessionTask *)uploadRequestWithURL:(NSString *)URLString
                                         parameters:(NSDictionary * __nullable)parameters
                                   constructingBody:(ConstructingBodyBlock)constructingBodyBlock
                                           progress:(ProgressBlock)progressBlock
                                         completion:(CompletionHandler)completionHandler;


/**
 下载文件
 @param parameters 参数
 @param destinationPathBlock 目标存储路径
 @param completionHandler 请求完成处理
 @return 返回 BLBaseEngine 供调用者处理其他逻辑
 */
+ (__kindof NSURLSessionTask *)downloadRequestWithURL:(NSString *)URLString
                                           parameters:(NSDictionary * __nullable)parameters
                                      destinationPath:(DestinationPathBlock)destinationPathBlock
                                             progress:(ProgressBlock)progressBlock
                                           completion:(CompletionHandler)completionHandler;

NS_ASSUME_NONNULL_END
@end


