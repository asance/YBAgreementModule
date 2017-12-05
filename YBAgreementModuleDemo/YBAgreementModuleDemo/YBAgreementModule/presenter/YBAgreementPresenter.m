//
//  YBAgreementPresenter.m
//  YoubanLoan
//
//  Created by asance on 2017/8/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBAgreementPresenter.h"

@implementation YBAgreementPresenter

- (void)presentAgreementInfo:(NSDictionary *)object{
    
    YBErrorModel *error = [object objectForKey:YB_KEY_ERROR];
    NSDictionary *params = [object objectForKey:YB_KEY_PARAMS];
    NSDictionary *dataObject = [object objectForKey:YB_KEY_DATA];
    NSString *apiSELString = [object objectForKey:YB_KEY_APISEL];
    
    BOOL didHandlingError = [self handlingError:error
                                         output:(id)self.output
                                    callbackSEL:@selector(didFetchAgreementInfo:)
                                         APISEL:NSSelectorFromString(apiSELString)
                                   APISELParams:params];
    
    if(didHandlingError) return;
    
    //自定处理控制器的返回数据
    [self.output didFetchAgreementInfo:dataObject];
}

@end
