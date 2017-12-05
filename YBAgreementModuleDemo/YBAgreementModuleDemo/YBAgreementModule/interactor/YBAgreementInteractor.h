//
//  YBAgreementInteractor.h
//  YoubanLoan
//
//  Created by asance on 2017/8/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBaseInteractor.h"
#import "YBAgreementConfig.h"

@interface YBAgreementInteractor : YBBaseInteractor<YBAgreementViewControllerToInteractorPopline>

@property(weak, nonatomic) id<YBAgreementInteractorToPresenterPipline> output;

@end
