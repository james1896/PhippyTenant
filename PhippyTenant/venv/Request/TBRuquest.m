//
//  TBRuquest.m
//  TBBaseApp
//
//  Created by toby on 07/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "TBRuquest.h"
#import "AFNetworking.h"

@implementation TBRuquest

+ (instancetype)manager{
    
    return [[self alloc]init];
}


+ (void)POSTWithURL:(NSString *)url parameters:(NSDictionary *)parameters originalParas:(NSDictionary *)orgParas success:(success)success failure:(failure)failure{
//    [self POSTWithURL:url
//           parameters:parameters
//              success:^(NSURLSessionDataTask *task,
//                        id responseObject) {
//                  NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求成功):%@",url,orgParas,respodnseObject);
//              }
//              failure:^(NSURLSessionDataTask *task,
//                  NSError *error) {
//    
//                  NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求失败):%@",url,parameters,error);
//              }];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager POST:url
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task,
                           id  _Nullable responseObject) {
                     success(task,responseObject);
                     
#if showNetworkLog
                      NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求成功):%@",url,orgParas,responseObject);
#endif
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task,
                           NSError * _Nonnull error) {
                     failure(task,error);
#if showNetworkLog
                     NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求失败):%@",url,parameters,error);
#endif
                 }
     ];
}


+ (void)POSTWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager POST:url
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task,
                           id  _Nullable responseObject) {
                     success(task,responseObject);
        
                     NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求成功):%@",url,parameters,responseObject);
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task,
                           NSError * _Nonnull error) {
                    failure(task,error);
                     NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求失败):%@",url,parameters,error);
                 }
     ];
    
}

+ (void)GETWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:url
             parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task,
                          id  _Nullable responseObject) {
                    success(task,responseObject);
                    
                    NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求成功):%@",url,parameters,responseObject);
                }
                failure:^(NSURLSessionDataTask * _Nullable task,
                          NSError * _Nonnull error) {
                    
                    NSLog(@"\n输入URL:%@\n输入参数:%@\n输出参数(请求失败):%@",url,parameters,error);
                }];
}


+ (void)uploadImageWithURL:(NSString *)url
                    Images:(NSArray<UIImage *> *)images
                ImageNames:(NSArray<NSString *> *) names
                   success:(success)success
                   failure:(failure)failure{
    
    
    // 参数
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"name", @"name", @"idNum", @"idNumber", nil];
    
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    // 在parameters里存放照片以外的对象
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < images.count; i++) {
            
            UIImage *image = images[i];
            NSData *imageData = UIImagePNGRepresentation(image);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = names[i];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"files" fileName:[NSString stringWithFormat:@"%@.png",fileName] mimeType:@"image/png"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];

}




+ (void)uploadImageWithURL:(NSString *)url
                     Image:(UIImage *)image
                 ImageName:(NSString *)name
                   success:(success)success
                   failure:(failure)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImagePNGRepresentation(image);
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:[NSString stringWithFormat:@"%@.png",name]
                                mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
    
    //  上传文件 模板
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
    //
    //                                                         @"text/html",
    //
    //                                                         @"image/jpeg",
    //
    //                                                         @"image/png",
    //
    //                                                         @"application/octet-stream",
    //
    //                                                         @"text/json",
    //
    //                                                         nil];
    //
    //    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    //    [manager POST:@"http://10.66.67.81:8001/client/img" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //        UIImage *image = [UIImage imageNamed:@"diwen.png"];
    //        NSData *data = UIImagePNGRepresentation(image);
    //
    //        //上传的参数(上传图片，以文件流的格式)
    //        [formData appendPartWithFileData:data
    //                                    name:@"file"
    //                                fileName:@"diwen.png"
    //                                mimeType:@"image/png"];
    //
    //    } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"上传成功");
    //
    //
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        
    //        NSLog(@"上传失败%@",error);
    //        
    //        
    //        
    //    }];
}

@end
