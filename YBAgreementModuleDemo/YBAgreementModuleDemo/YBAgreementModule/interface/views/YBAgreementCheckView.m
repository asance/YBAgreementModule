//
//  YBAgreementCheckView.m
//  test_CodeReview
//
//  Created by asance on 2017/10/9.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBAgreementCheckView.h"

@implementation YBAgreementCheckView

- (id)initWithFrame:(CGRect)frame
      agreementName:(NSString *)name
      agreementDesc:(NSString *)desc{
    self = [super initWithFrame:frame];
    if(self){
        self.agreementName = name;
        self.agreementDesc = desc;
        
        [self addSubview:self.willAgreeProtocolLabel];
        [self addSubview:self.willAgreeProtocolButton];
        
        self.willAgreeProtocolLabel.numberOfLines = 0;
        self.willAgreeProtocolLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self setWillAgreeProtocolLabelAttributedText];
    }
    return self;
}
- (void)setWillAgreeProtocolLabelAttributedText{
    //设置特效字体
    NSRange agreeRange = [self.agreementDesc rangeOfString:self.agreementName];
    if(NSNotFound==agreeRange.location){
        self.willAgreeProtocolLabel.text = self.agreementDesc;
        return;
    }
    NSString *totalString = [NSString stringWithFormat:@"%@",self.agreementDesc];
    NSMutableAttributedString *atrTitle = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    NSDictionary *leftAttrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:[NSNumber adaptToHeight:12]],NSFontAttributeName,
                                  [UIColor hexColor:@"cccccc"],NSForegroundColorAttributeName,nil];
    [atrTitle setAttributes:leftAttrDict range:NSMakeRange(0, agreeRange.location)];
    
    NSDictionary *midAttrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont systemFontOfSize:[NSNumber adaptToHeight:12]],NSFontAttributeName,
                                 [UIColor hexColor:@"0099ff"],NSForegroundColorAttributeName,nil];
    [atrTitle setAttributes:midAttrDict range:agreeRange];
    
    NSDictionary *rightAttrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:[NSNumber adaptToHeight:12]],NSFontAttributeName,
                                   [UIColor hexColor:@"cccccc"],NSForegroundColorAttributeName,nil];
    [atrTitle setAttributes:rightAttrDict range:NSMakeRange((agreeRange.length+agreeRange.location), (totalString.length-(agreeRange.length+agreeRange.location)))];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [atrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    
    self.willAgreeProtocolLabel.attributedText = atrTitle;
}

- (void)onAction{
    if(self.onAgreementCheckBlock){
        self.onAgreementCheckBlock(self.url);
    }
}

#pragma mark -
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat leftMargin = 0;
    CGFloat willAgreeProtocolLabelHeight = [self.willAgreeProtocolLabel textBoundingSizeWithMaxSize:CGSizeMake(width-leftMargin*2, 50)].height;

    willAgreeProtocolLabelHeight = MAX(willAgreeProtocolLabelHeight, 30);
    self.willAgreeProtocolLabel.frame = CGRectMake(leftMargin, 0, width-leftMargin*2, willAgreeProtocolLabelHeight);
    self.willAgreeProtocolButton.frame = CGRectMake(leftMargin, 0, width-leftMargin*2, willAgreeProtocolLabelHeight);
}
#pragma mark - Getter Setter
YBLabelGetter(willAgreeProtocolLabel, _willAgreeProtocolLabel, [UIFont systemFontOfSize:[NSNumber adaptToHeight:12]], @"", [UIColor hexColor:@"999999"], NSTextAlignmentLeft);

- (UIButton *)willAgreeProtocolButton{
    if(!_willAgreeProtocolButton){
        _willAgreeProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _willAgreeProtocolButton.backgroundColor = kClearColor;
        [_willAgreeProtocolButton setTitle:@"" forState:UIControlStateNormal];
        [_willAgreeProtocolButton addTarget:self action:@selector(onAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _willAgreeProtocolButton;
}

@end
