//
//  YBAgreementPresenter.h
//  YoubanLoan
//
//  Created by asance on 2017/8/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBBasePresenter.h"
#import "YBAgreementConfig.h"

@interface YBAgreementPresenter : YBBasePresenter<YBAgreementInteractorToPresenterPipline>

@property(weak, nonatomic) id<YBAgreementPresenterToViewControllerPipline> output;

@end
