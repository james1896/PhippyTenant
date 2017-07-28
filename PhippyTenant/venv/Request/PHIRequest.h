//
//  PHIRequest.h
//  Phippy
//
//  Created by toby on 21/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "TBRuquest.h"

@interface PHIRequest : TBRuquest

+ (void)storeWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure;

+ (void)goodsWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure;

+ (void)tourWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure;

+ (void)lifeWithParameters:(NSDictionary *)parameters success:(success)success failure:(failure)failure;


/**
 上传图片
 
 @param image <#image description#>
 @param name <#name description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)uploadImageWithImage:(UIImage *)image
                   ImageName:(NSString *)name
                     success:(success)success
                     failure:(failure)failure;

+ (void)uploadImageWithImages:(NSArray<UIImage *> *)images
                   ImageNames:(NSArray<NSString *> *) names
                     success:(success)success
                     failure:(failure)failure;

@end
