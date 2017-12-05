//
//  YBAgreementConfig.h
//  YoubanLoan
//
//  Created by asance on 2017/8/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *YBAgreementRegister;
extern NSString *YBAgreementSynthAuth;
extern NSString *YBAgreementLoanAuth;
extern NSString *YBAgreementOperatorAuth;

/**数据流从控制器流向转换器*/
@protocol YBAgreementViewControllerToInteractorPopline <NSObject>
@optional
/**
 * 获取协议信息
 * @param params 请求参数
 */
- (void)fetchAgreementInfoWithParams:(NSDictionary *)params;

@end

/**数据流从转换器流向展示器*/
@protocol YBAgreementInteractorToPresenterPipline <NSObject>
@optional
/**
 * 处理interactor返回的协议信息数据，
 * 可能包含错误参数，用YB_KEY_ERROR来获取。
 * 对应调用接口：-fetchAgreementInfoWithParams:。
 *
 * @param object 数据字典
 */
- (void)presentAgreementInfo:(NSDictionary *)object;

@end

/**数据流从展示器流向控制器*/
@protocol YBAgreementPresenterToViewControllerPipline <YBNetworkResponseErrorProtocol>
@optional
/**
 * 获取协议信息数据，控制器中需要的值都封装在回调字典里。
 * 对应调用接口：-fetchAgreementInfoWithParams:。
 * @param info 数据字典 NSDictionary对象
 */
- (void)didFetchAgreementInfo:(NSDictionary *)info;

@end
