//
//  MMBaseRequest+RACExtension.h
//  Network
//
//  Created by 陈佳炳 on 2018/4/3.
//  Copyright © 2018年 Mamaqunaer Inc. All rights reserved.
//

#import "MMBaseRequest.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MMBaseRequest (RACExtension)

- (RACSignal *)rac_requestSignal;

@end
