//
//  YXNetwork.h
//  SDKTT
//
//  Created by 姚肖 on 2024/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXRequestSuccessBlock)(NSDictionary *_Nullable response);
typedef void(^YXRequestFailureBlock)(NSError *_Nullable error);

@interface YXNetwork : NSObject

+ (instancetype)sharedManager;
- (void)sendRequest:(NSString *)urlString params:(NSDictionary *_Nullable)params method:(NSString *)method successBlock:(YXRequestSuccessBlock)successBlock failureBlcok:(YXRequestFailureBlock)faileBlock;

@end

NS_ASSUME_NONNULL_END
