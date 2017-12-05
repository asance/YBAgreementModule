//
//  YBAgreementViewController.m
//  DDKuaiqian
//
//  Created by asance on 2017/11/15.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "YBAgreementViewController.h"
#import "UIColor+HexInt.h"

@interface YBAgreementViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(strong, nonatomic) WKWebView *webView;
@property(strong, nonatomic) CALayer *myLayer;
@property(strong, nonatomic) UIView *myProgressView;
@end

@implementation YBAgreementViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"协议";
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height-64)];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.navigationDelegate = self;
    [self.webView setUIDelegate:self];
    [self.webView setMultipleTouchEnabled:YES];
    [self.webView setAutoresizesSubviews:YES];
    [self.webView.scrollView setAlwaysBounceVertical:YES];
    [self.webView setAllowsBackForwardNavigationGestures:true];
    
    [self.view addSubview:self.webView];
    
    UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onReplaceLongPressRecognizer)];
    longPre.minimumPressDuration = 0.2f;
    [self.webView addGestureRecognizer:longPre];
    
    self.myProgressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    self.myProgressView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.myProgressView];
    
    self.myLayer = [CALayer layer];
    self.myLayer.backgroundColor = [UIColor hexColor:@"0099ff"].CGColor;
    [self.myProgressView.layer addSublayer:self.myLayer];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setCustomBackItem];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    if(self.urlString.length){
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else if (self.htmlString.length){
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
    }
}

- (void)onCustomBackAction{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSString *toURLString = navigationAction.request.URL.absoluteString;
//    YBLog(@"%@",toURLString);
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.myProgressView.hidden = NO;
    [self.view bringSubviewToFront:self.myProgressView];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.myLayer.opacity = 1;
        self.myLayer.frame = CGRectMake(0, 0, (CGRectGetWidth(self.view.frame)*[change[NSKeyValueChangeNewKey] floatValue]), 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.myLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.myLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Recognizer
- (void)onReplaceLongPressRecognizer{
    
}
- (void)loadUbankWebsite{
    NSURL *url = [NSURL URLWithString:@"http://www.ddkuaiqian.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - Getter Setter
- (NSMutableURLRequest *)GetRequest:(NSURL *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"ios" forHTTPHeaderField:@"terminal"];
    [request setURL:url];
    return request;
}
@end
