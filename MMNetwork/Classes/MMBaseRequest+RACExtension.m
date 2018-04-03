//
//  MMBaseRequest+RACExtension.m
//  Network
//
//  Created by 陈佳炳 on 2018/4/3.
//  Copyright © 2018年 Mamaqunaer Inc. All rights reserved.
//

#import "MMBaseRequest+RACExtension.h"
#import "NSObject+RACDescription.h"

@implementation MMBaseRequest (RACExtension)

- (RACSignal *)rac_requestSignal {
    [self stop];
    @weakify(self);
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 开始请求
        [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [subscriber sendNext:[request responseJSONObject]];
            [subscriber sendCompleted];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [subscriber sendError:[request error]];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            @strongify(self);
            if (!self.isCancelled) {
                [self stop];
            }
        }];
    }] takeUntil:[self rac_willDeallocSignal]];
    
    //设置名称,便于调试
    #if DEBUG
        [signal setNameWithFormat:@"%@ -rac_mmRequest",  [self rac_description]];
    #endif

    return signal;
}

@end
