//
//  BLEngineConfigure.h
//  BLNetWorkBaseEngine
//
//  Created by boundlessocean on 2017/9/28.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#ifndef BLEngineConfigure_h
#define BLEngineConfigure_h
#import "AFNetworking.h"
#import "NSError+BLLocalliszed.h"
/** 进度回调 */
typedef void (^ProgressBlock)(NSProgress * _Nonnull uploadProgress);
/** 完成回调 */
typedef void (^CompletionHandler)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error);
/** 文件上传 构造Body */
typedef void (^ConstructingBodyBlock)(id<AFMultipartFormData>  _Nonnull formData);
/** 下载文件 目标保存路径 */
typedef NSURL* _Nonnull (^DestinationPathBlock)(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response);

/** 请求配置 */
typedef void (^RequestSerializer)(AFHTTPRequestSerializer <AFURLRequestSerialization> * _Nonnull requestSerializer);
/** 响应配置 */
typedef void (^ResponseSerializer)(AFHTTPResponseSerializer <AFURLResponseSerialization> * _Nonnull responseSerializer);

typedef NS_ENUM(NSInteger,BLURLRequestType){
    /** GET请求 */
    BLURLRequestTypeGet,
    /** POST请求 */
    BLURLRequestTypePost,
    /** HEAD请求 */
    BLURLRequestTypeHead,
    /** PUT请求 */
    BLURLRequestTypePut,
    /** PATCH请求 */
    BLURLRequestTypepPatch,
    /** POST请求 */
    BLURLRequestTypepDelete,
    /** 上传 */
    BLURLRequestTypeUpload,
    /** 下载 */
    BLURLRequestTypeDownload
};

#endif /* BLEngineConfigure_h */
