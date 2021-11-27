//
//  SGSensitiveWordsTool
//
//  Created by kingsic on 2017/3/16.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import "SGSensitiveWordsTool.h"
#define EXIST @"isExists"

@interface SGSensitiveWordsTool()
@property (nonatomic,strong) NSMutableDictionary *root;
@property(nonatomic,strong)NSMutableArray *rootArray;
@property (nonatomic,assign) BOOL isFilterClose;
@end

@implementation SGSensitiveWordsTool

static SGSensitiveWordsTool *instance;

- (NSMutableArray *)rootArray {
    if (!_rootArray) {
        _rootArray = [NSMutableArray array];
    }
    return _rootArray;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

// 复写init方法
- (instancetype)init {
    if (self) {
        self = [super init];
        // 加载本地文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SensitiveWords" ofType:@"txt"];
        [self initFilter:filePath];
    }
    return self;
}

/**
 *  加载本地的敏感词库
 *
 *  @param filepath         敏感词文件的路径
 */
- (void)initFilter:(NSString *)filepath {
    
    self.root = [NSMutableDictionary dictionary];

    NSString *fileString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];

    [self.rootArray removeAllObjects];
    [self.rootArray addObjectsFromArray:[fileString componentsSeparatedByString:@"|"]];

    for (NSString *str in self.rootArray) {
        // 插入字符，构造节点
        [self insertWords:str];
    }
}

/**
 * 判断文本中是否含有敏感词
 *
 * @param string        文本字符串
 *
 * @return 是否含有敏感词
 */
- (BOOL)includeSensitiveWords:(NSString *)string {
    
    if (self.isFilterClose || !self.root) {
        return NO;
    }
    
    NSMutableString *result = result = [string mutableCopy];
    
    for (int i = 0; i < string.length; i++) {
        NSString *subString = [string substringFromIndex: i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            } else {
                num ++;
                node = node[word];
            }

            // 敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                return YES;
            }
        }
    }
    return NO;
}


- (void)insertWords:(NSString *)words {
    NSMutableDictionary *node = self.root;
    for (int i = 0; i < words.length; i ++) {
        NSString *word = [words substringWithRange:NSMakeRange(i, 1)];
        if (node[word] == nil) {
            node[word] = [NSMutableDictionary dictionary];
        }
        node = node[word];
    }
    // 敏感词最后一个字符标识
    node[EXIST] = [NSNumber numberWithInt:1];
}

/**
 * 将文本中含有的敏感词进行替换
 *
 * @param string        文本字符串
 * @param tempWord        替换的字符
 *
 * @return 过滤完敏感词之后的文本
 */
- (NSString *)replaceSensitiveWords:(NSString *)string withWord:(NSString *)tempWord {
    
    if (self.isFilterClose || !self.root) {
        return string;
    }
    
    NSMutableString *result = result = [string mutableCopy];
    
    for (int i = 0; i < string.length; i ++) {
        NSString *subString = [string substringFromIndex: i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            } else {
                num ++;
                node = node[word];
            }
            
            // 敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                NSMutableString *symbolStr = [NSMutableString string];
                for (int k = 0; k < num; k ++) {
                    [symbolStr appendString:tempWord];
                }
                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
                i += j;
                break;
            }
        }
    }
    return result;
}

- (void)freeFilter {
    self.root = nil;
}

- (void)stopFilter:(BOOL)b {
    self.isFilterClose = b;
}


@end
