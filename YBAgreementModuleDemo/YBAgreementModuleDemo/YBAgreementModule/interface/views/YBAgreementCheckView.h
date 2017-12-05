//
//  YBAgreementCheckView.h
//  test_CodeReview
//
//  Created by asance on 2017/10/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBAgreementCheckView : UIView
@property(strong, nonatomic) UILabel *willAgreeProtocolLabel;
@property(strong, nonatomic) UIButton *willAgreeProtocolButton;

@property(copy, nonatomic) void(^onAgreementCheckBlock)(NSString *url);
@property(copy, nonatomic) NSString *url;
@property(copy, nonatomic) NSString *agreementName;
@property(copy, nonatomic) NSString *agreementDesc;

- (id)initWithFrame:(CGRect)frame
      agreementName:(NSString *)name
      agreementDesc:(NSString *)desc;

@end
