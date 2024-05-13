//
//  YXNetwork.m
//  SDKTT
//
//  Created by 姚肖 on 2024/4/9.
//

#import "YXNetwork.h"
#import <CommonCrypto/CommonDigest.h>

@implementation YXNetwork

+ (instancetype)sharedManager {
    static YXNetwork *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[YXNetwork alloc] init];
    });
    return _sharedSingleton;
}

- (void)sendRequest:(NSString *)urlString params:(NSDictionary *_Nullable)params method:(NSString *)method successBlock:(YXRequestSuccessBlock)successBlock failureBlcok:(YXRequestFailureBlock)faileBlock {
    
    NSString *curTime = [self nowTime];
    NSString *nonce = [self randomString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
       cachePolicy:NSURLRequestUseProtocolCachePolicy
       timeoutInterval:10.0];
    NSMutableDictionary *headers = [@{
       @"AppKey": @"appkey",
       @"X-custom-traceid": @"008f3354-6d1d-469e-8aa6-8a674b8f8a32",
       @"User-Agent": @"Apifox/1.0.0 (https://www.apifox.cn)",
       @"Nonce": nonce,
       @"CurTime": curTime,
       @"CheckSum": [self sha1HashWithAppSecret:@"appscret" nonce:nonce curTime:curTime],
       @"Accept": @"*/*",
       @"Host": @"open.yunxinapi.com",
       @"Connection": @"keep-alive"
    } mutableCopy];

    [request setAllHTTPHeaderFields:headers];

    [request setHTTPMethod:@"GET"];
    
    if (method.length > 0) {
        [request setHTTPMethod:method];
    }
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [request setAllHTTPHeaderFields:headers];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        NSData *postData = [[NSData alloc] initWithData:jsonData];
        [request setHTTPBody:postData];
    }

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error) {
          NSLog(@"%@", error);
           dispatch_async(dispatch_get_main_queue(), ^{
               faileBlock(error);
           });
       } else {
          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
          NSError *parseError = nil;
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          NSLog(@"%@",responseDictionary);
           dispatch_async(dispatch_get_main_queue(), ^{
               successBlock(responseDictionary);
           });
       }
    }];
    [dataTask resume];
}

- (NSString *)randomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:128];
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    for (int i = 0; i < 12; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }

    return randomString;
}

- (NSString *)nowTime {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeStamp = [currentDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d", (int)timeStamp];
}

- (NSString *)sha1HashWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce curTime:(NSString *)curTime {
    NSString *inputString = [NSString stringWithFormat:@"%@%@%@", appSecret, nonce, curTime]; // 拼接字符串
    const char *cstr = [inputString cStringUsingEncoding:NSUTF8StringEncoding]; // 将NSString转换为C字符串
    NSData *data = [NSData dataWithBytes:cstr length:inputString.length]; // 将C字符串转换为NSData
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH]; // 20字节的数组用于存储哈希值
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest); // 计算SHA1哈希值
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2]; // 用于存储16进制字符
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]]; // 将哈希值转换为16进制字符追加到字符串中
    }
    return output; // 返回16进制字符
}

@end
