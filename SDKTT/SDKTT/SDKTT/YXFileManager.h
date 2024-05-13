//
//  YXOne.h
//  YXSDK
//
//  Created by 姚肖 on 2023/5/18.
//

#import <Foundation/Foundation.h>

typedef void(^YXUploadProgressBlock)(float progress, NSInteger index);
typedef void(^YXUploadSuccessBlock)(NSString *_Nullable path);
typedef void(^YXUploadFailureBlock)(NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface YXFileManager : NSObject

+ (instancetype)sharedManager;

//Userdefalt存取
+ (void)saveValue:(NSString *)accid key:(NSString *)token;
+ (NSString *)getValueForKey:(NSString *)token;

//获取文件夹路径
+ (NSString *)filePath:(NSString *)groupName;
//往文件夹保存图片
+ (NSString *)saveFileToGroup:(NSString *)groupName data:(NSData *)data;
//从文件夹获取数据
+ (NSArray *)outPutFileFromGroup:(NSString *)groupName;
//删除文件夹
+ (BOOL)deleteGroup:(NSString *)groupName;
//删除文件
+ (BOOL)deleteFileWithPath:(NSString *)path;
/**
 *  下载
 *
 *  @param groupName 文件下载沙盒路径下文件夹名字
 */
- (NSURLSessionDownloadTask *)downLoadFile:(NSString *)URLString groupName:(NSString *)groupName
            progress:(YXUploadProgressBlock)uploadProgress
         success:(YXUploadSuccessBlock)success
         failure:(YXUploadFailureBlock)failure;

//取消下载
- (void)cancelDownLoad;

@end

NS_ASSUME_NONNULL_END
