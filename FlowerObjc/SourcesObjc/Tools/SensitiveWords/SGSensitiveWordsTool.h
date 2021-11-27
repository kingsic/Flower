//
//  SGSensitiveWordsTool
//
//  此工具类用于对文本中的敏感词进行处理，以及判断文本中是否含有敏感词
//
//  Created by kingsic on 2017/3/16.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGSensitiveWordsTool : NSObject
/* 通过单例的方式创建对象 */
+ (instancetype)shared;

/**
 *  加载本地的敏感词库
 *
 *  @param filepath         敏感词文件的路径
 */
- (void)initFilter:(NSString *)filepath;

/**
 * 判断文本中是否含有敏感词
 *
 * @param string        文本字符串
 *
 * @return 是否含有敏感词
 */
- (BOOL)includeSensitiveWords:(NSString *)string;

/**
 * 将文本中含有的敏感词进行替换
 *
 * @param string        文本字符串
 * @param tempWord        替换的字符
 *
 * @return 过滤完敏感词之后的文本
 */
- (NSString *)replaceSensitiveWords:(NSString *)string withWord:(NSString *)tempWord;

@end
