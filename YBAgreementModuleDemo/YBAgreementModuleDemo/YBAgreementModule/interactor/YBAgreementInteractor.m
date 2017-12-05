//
//  YBAgreementInteractor.m
//  YoubanLoan
//
//  Created by asance on 2017/8/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBAgreementInteractor.h"
#import "YBBaseRequestWorker.h"
/**用户注册协议*/
const NSString *YBAgreementRegister         = @"register";
/**综合授权协议*/
const NSString *YBAgreementSynthAuth        = @"synth_auth";
/**借款授权综合协议*/
const NSString *YBAgreementLoanAuth         = @"loan_auth";
/**运营商授权协议*/
const NSString *YBAgreementOperatorAuth     = @"operator_auth";

@implementation YBAgreementInteractor

- (void)fetchAgreementInfoWithParams:(NSDictionary *)params{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",YB_GET_Agreement_URL,params[@"type"]];
    
    __weak __typeof(&*self)weakSelf = self;
    [self.requestWorker fetchDataInfoByGETMethodWithURL:url success:^(NSDictionary *resultObject) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if(!strongSelf) return;

        NSMutableDictionary *newResultObject = [[NSMutableDictionary alloc] init];
        //压返回值
        [newResultObject setObject:resultObject forKey:YB_KEY_DATA];
        //压参数
        if(params){
            [newResultObject setObject:params forKey:YB_KEY_PARAMS];
        }
        //压请求接口
        [newResultObject setObject:NSStringFromSelector(_cmd) forKey:YB_KEY_APISEL];

        [strongSelf presentAgreementInfo:newResultObject];
        
    } failure:^(YBErrorModel *error) {
        
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if(!strongSelf) return;
        
        NSMutableDictionary *newResultObject = [[NSMutableDictionary alloc] init];
        //压参数
        if(params){
            [newResultObject setObject:params forKey:YB_KEY_PARAMS];
        }
        //压请求接口
        [newResultObject setObject:NSStringFromSelector(_cmd) forKey:YB_KEY_APISEL];
        //压错误信息
        [newResultObject setObject:error forKey:YB_KEY_ERROR];
        
        [strongSelf presentAgreementInfo:newResultObject];
    }];
}

- (void)presentAgreementInfo:(NSDictionary *)object{
    if(!self.output) return;
    if(![self.output respondsToSelector:@selector(presentAgreementInfo:)]) return;
    
    [self.output presentAgreementInfo:object];
}

@end
