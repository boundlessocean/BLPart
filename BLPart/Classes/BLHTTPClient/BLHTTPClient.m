//
//  BLHTTPClient.m
//  BLNetWorkBaseEngine
//
//  Created by boundlessocean on 2017/9/28.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import "BLHTTPClient.h"

@interface BLRequsetModel()
/** 请求类型 */
@property (nonatomic ,assign) BLURLRequestType requestType;
/** 请求地址 */
@property(nonatomic,copy) NSString *URLString;
/** 请求参数 */
@property (nonatomic ,strong) NSDictionary *paremeters;
/** 进度 */
@property(nonatomic,copy) ProgressBlock progressBlock;
/** 构造Body */
@property(nonatomic,copy) ConstructingBodyBlock constructingBodyBlock;
/** 保存目标路径 */
@property(nonatomic,copy) DestinationPathBlock destinationPathBlock;
/** 请求完成回调 */
@property(nonatomic,copy) CompletionHandler completionHandler;

/**
 POST/GET/DELETE... 请求
 @param parameters 参数
 @param requestType 请求的方式 POST/GET 不传为POST
 @param completionHandler 请求完成处理
 @return 返回 BLBaseEngine 供调用者处理其他逻辑
 */
+ (instancetype)modelWithURL:(NSString *)URLString
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
+ (instancetype)modelUploadWithURL:(NSString *)URLString
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
+ (instancetype)modelDownloadWithURL:(NSString *)URLString
                          parameters:(NSDictionary * __nullable)parameters
                     destinationPath:(DestinationPathBlock)destinationPathBlock
                            progress:(ProgressBlock)progressBlock
                          completion:(CompletionHandler)completionHandler;

@end

@implementation BLRequsetModel

+ (instancetype)modelWithURL:(NSString *)URLString
                 requestType:(BLURLRequestType)requestType
                  parameters:(NSDictionary * __nullable)parameters
                  completion:(CompletionHandler)completionHandler{
    
    BLRequsetModel *model = [BLRequsetModel new];
    model.requestType = requestType;
    model.URLString = URLString;
    model.paremeters = parameters;
    model.completionHandler = completionHandler;
    return model;
}


+ (instancetype)modelUploadWithURL:(NSString *)URLString
                        parameters:(NSDictionary * __nullable)parameters
                  constructingBody:(ConstructingBodyBlock)constructingBodyBlock
                          progress:(ProgressBlock)progressBlock
                        completion:(CompletionHandler)completionHandler{
    BLRequsetModel *model = [BLRequsetModel new];
    model.requestType = BLURLRequestTypeUpload;
    model.URLString = URLString;
    model.paremeters = parameters;
    model.constructingBodyBlock = constructingBodyBlock;
    model.progressBlock = progressBlock;
    model.completionHandler = completionHandler;
    return model;
}

+ (instancetype)modelDownloadWithURL:(NSString *)URLString
                          parameters:(NSDictionary * __nullable)parameters
                     destinationPath:(DestinationPathBlock)destinationPathBlock
                            progress:(ProgressBlock)progressBlock
                          completion:(CompletionHandler)completionHandler{
    BLRequsetModel *model = [BLRequsetModel new];
    model.requestType = BLURLRequestTypeDownload;
    model.URLString = URLString;
    model.paremeters = parameters;
    model.destinationPathBlock = destinationPathBlock;
    model.progressBlock = progressBlock;
    model.completionHandler = completionHandler;
    return model;
}

@end










@interface BLHTTPClient ()

@end
@implementation BLHTTPClient

/** 网络请求管理类 */
static const AFHTTPSessionManager *sessionManager;


+ (void)initialize{
    [super initialize];
    sessionManager = [AFHTTPSessionManager manager];
}

#pragma mark - - Send Request

+ (NSURLSessionTask *)sendRequestWithRequestModel:(BLRequsetModel *)requestModel{
    NSURLSessionTask * sessionTask;
    switch (requestModel.requestType) {
        case BLURLRequestTypeGet:
            sessionTask = [self requestWithGetModel:requestModel];
            break;
        case BLURLRequestTypePost:
            sessionTask = [self requestWithPostModel:requestModel];
            break;
        case BLURLRequestTypeHead:
            sessionTask = [self requestWithHeadModel:requestModel];
            break;
        case BLURLRequestTypepPatch:
            sessionTask = [self requestWithPatchModel:requestModel];
            break;
        case BLURLRequestTypePut:
            sessionTask = [self requestWithPutModel:requestModel];
            break;
        case BLURLRequestTypepDelete:
            sessionTask = [self requestWithDeleteModel:requestModel];
            break;
        case BLURLRequestTypeUpload:
            sessionTask = [self requestWithUplaodModel:requestModel];
            break;
        case BLURLRequestTypeDownload:
            sessionTask = [self requestWithDownloadModel:requestModel];
            break;
    }
    return sessionTask;
}

+ (NSURLSessionDataTask *)requestWithGetModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager GET:requestModel.URLString
                  parameters:requestModel.paremeters
                    progress:requestModel.progressBlock
                     success:^(NSURLSessionDataTask * _Nonnull task,
                               id  _Nullable responseObject)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithPostModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager POST:requestModel.URLString
                   parameters:requestModel.paremeters
                     progress:requestModel.progressBlock
                      success:^(NSURLSessionDataTask * _Nonnull task,
                                id  _Nullable responseObject)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
    }
                      failure:^(NSURLSessionDataTask * _Nullable task,
                                NSError * _Nonnull error)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithHeadModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager HEAD:requestModel.URLString
                   parameters:requestModel.paremeters
                      success:^(NSURLSessionDataTask * _Nonnull task)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithPatchModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager PATCH:requestModel.URLString
                    parameters:requestModel.paremeters
                       success:^(NSURLSessionDataTask * _Nonnull task,
                                id  _Nullable responseObject)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
     } failure:^(NSURLSessionDataTask * _Nullable task,
                 NSError * _Nonnull error)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
     }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithPutModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager PUT:requestModel.URLString
                  parameters:requestModel.paremeters
                     success:^(NSURLSessionDataTask * _Nonnull task,
                                 id  _Nullable responseObject)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
     } failure:^(NSURLSessionDataTask * _Nullable task,
                 NSError * _Nonnull error)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
     }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithDeleteModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *dataTask =
    [sessionManager DELETE:requestModel.URLString
                     parameters:requestModel.paremeters
                        success:^(NSURLSessionDataTask * _Nonnull task,
                               id  _Nullable responseObject)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
     } failure:^(NSURLSessionDataTask * _Nullable task,
                 NSError * _Nonnull error)
     {
         !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
     }];
    return dataTask;
}

+ (NSURLSessionDataTask *)requestWithUplaodModel:(BLRequsetModel *)requestModel{
    NSURLSessionDataTask *uploadTask =
    [sessionManager POST:requestModel.URLString
                   parameters:requestModel.paremeters
    constructingBodyWithBlock:requestModel.constructingBodyBlock
                     progress:requestModel.progressBlock
                      success:^(NSURLSessionDataTask * _Nonnull task,
                                id  _Nullable responseObject)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, responseObject, nil);
    }
                      failure:^(NSURLSessionDataTask * _Nullable task,
                                NSError * _Nonnull error)
    {
        !requestModel.completionHandler ? :requestModel.completionHandler(task.response, nil, error);
    }];
    return uploadTask;
}

+ (NSURLSessionDownloadTask *)requestWithDownloadModel:(BLRequsetModel *)requestModel{
    NSError *serializationError;
    NSURLRequest *request = [sessionManager.requestSerializer requestWithMethod:@"GET"
                                                                           URLString:requestModel.URLString
                                                                          parameters:requestModel.paremeters
                                                                               error:&serializationError];
    if (serializationError) {
        if (requestModel.completionHandler) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(dispatch_get_main_queue(), ^{
                requestModel.completionHandler(nil,nil,serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    
    NSURLSessionDownloadTask *downloadTask =
    [sessionManager downloadTaskWithRequest:request
                                        progress:requestModel.progressBlock
                                     destination:requestModel.destinationPathBlock
                               completionHandler:^(NSURLResponse * _Nonnull response,
                                                   NSURL * _Nullable filePath,
                                                   NSError * _Nullable error)
    {
        !requestModel.completionHandler ? : requestModel.completionHandler(response,filePath,error);
    }];
    return downloadTask;
}

#pragma mark - - Public

+ (void)configCertificate:(NSString *)certificateName{
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:certificateName ofType:@"der"];
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:certSet];
    policy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = policy;
}

+ (void)configRequestSerializer:(RequestSerializer)requestSerializer{
    if (requestSerializer) {
        requestSerializer(sessionManager.requestSerializer);
    }
}

+ (void)configResponseSerializer:(ResponseSerializer)responseSerializer{
    if (responseSerializer) {
        responseSerializer(sessionManager.responseSerializer);
    }
}



/**
 POST/GET/DELETE... 请求
 */
+ (__kindof NSURLSessionTask *)dataRequsetWithURL:(NSString *)URLString
                       requestType:(BLURLRequestType)requestType
                        parameters:(NSDictionary * __nullable)parameters
                        completion:(CompletionHandler)completionHandler{
    BLRequsetModel *model = [BLRequsetModel modelWithURL:URLString
                                             requestType:requestType
                                              parameters:parameters
                                              completion:completionHandler];
    return [self sendRequestWithRequestModel:model];
}


/**
 上传文件
 */
+ (__kindof NSURLSessionTask *)uploadRequestWithURL:(NSString *)URLString
                          parameters:(NSDictionary * __nullable)parameters
                    constructingBody:(ConstructingBodyBlock)constructingBodyBlock
                            progress:(ProgressBlock)progressBlock
                          completion:(CompletionHandler)completionHandler{
    BLRequsetModel *model = [BLRequsetModel modelUploadWithURL:URLString
                                                    parameters:parameters
                                              constructingBody:constructingBodyBlock
                                                      progress:progressBlock
                                                    completion:completionHandler];
    return [self sendRequestWithRequestModel:model];
}


/**
 下载文件
 */
+ (__kindof NSURLSessionTask *)downloadRequestWithURL:(NSString *)URLString
                            parameters:(NSDictionary * __nullable)parameters
                       destinationPath:(DestinationPathBlock)destinationPathBlock
                              progress:(ProgressBlock)progressBlock
                            completion:(CompletionHandler)completionHandler{
    BLRequsetModel *model = [BLRequsetModel modelDownloadWithURL:URLString
                                                      parameters:parameters
                                                 destinationPath:destinationPathBlock
                                                        progress:progressBlock
                                                      completion:completionHandler];
    return [self sendRequestWithRequestModel:model];
}

@end


