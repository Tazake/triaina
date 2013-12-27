//
//  TriainaSampleViewController.m
//  TriainaSample
//
//  Created by Sano Taketo on 12/07/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TriainaSampleViewController.h"

@interface TriainaSampleViewController ()

- (void)updateButtons;

@end

@implementation TriainaSampleViewController

@synthesize webView;
@synthesize urlField;
@synthesize triainaButton;
@synthesize backButton, forwardButton, refreshButton, stopButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    webView.delegate = self;
    webView.webBridgeDelegate = self;
    webView.adapter.logFilter = TriainaLogTypeInfo;
    webView.adapter.triainaEnabled = YES;
    
    [self updateButtons];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.webView = nil;
}


- (void)updateButtons
{
    forwardButton.enabled = webView.canGoForward;
    backButton.enabled = webView.canGoBack;
    stopButton.enabled = webView.loading;
    
    triainaButton.title = (webView.adapter.triainaEnabled) ? @"ON" : @"OFF";
    triainaButton.tintColor = (webView.adapter.triainaEnabled) ? UIColor.redColor : nil;
}

#pragma mark - IBActions

- (void)backButtonTapped:(id)sender
{
    [webView goBack];
}

- (void)forwardButtonTapped:(id)sender
{
    [webView goForward];
}

- (void)refreshButtonTapped:(id)sender
{
    [webView reload];
}

- (void)stopButtonTapped:(id)sender
{
    [webView stopLoading];
}

- (void)triainaButtonTapped:(id)sender
{
    webView.adapter.triainaEnabled = !webView.adapter.triainaEnabled;
    [self updateButtons];
}

#pragma mark - UIWebViewDelegate protocol

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
    urlField.text = aWebView.request.URL.absoluteString;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

#pragma mark - UITextFieldDelegate protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if(![textField.text hasPrefix:@"http"])
        textField.text = [NSString stringWithFormat:@"http://%@", textField.text];
    
    NSURL *url = [NSURL URLWithString:textField.text];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self updateButtons];
    urlField.text = textField.text;
    
    return YES;
}



@end
