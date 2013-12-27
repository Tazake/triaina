//
//  TriainaWebView.h
//  TriainaSample
//
//  Created by Sano Taketo on 12/07/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriainaWebViewAdapter.h"

@interface TriainaWebView : UIWebView

@property (nonatomic, strong) TriainaWebViewAdapter *adapter;
@property (nonatomic, weak) IBOutlet id webBridgeDelegate;

- (void)prepareAdapter; // override if model-class is overridden.

@end
