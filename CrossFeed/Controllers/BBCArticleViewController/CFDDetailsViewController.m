//
//  CFDBBCArticleViewController.m
//  CrossFeed
//
//  Created by Danil on 11/13/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDDetailsViewController.h"
#import "UIViewController+CFDErrorAlert.h"

@interface CFDDetailsViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic)IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (assign, nonatomic) CGPoint lastContentOffset;

@end

@implementation CFDDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.openedService;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.openedLink]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval: 15.0];

    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self createAlertForError:error];
    [self.activityIndicator stopAnimating];
}

#pragma mark - IBActions

- (IBAction)actionSwipeRight:(id)sender {
    [self.webView goBack];
}

- (IBAction)actionSwipeLeft:(id)sender {
    [self.webView goForward];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.lastContentOffset.y < scrollView.contentOffset.y) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else if (self.lastContentOffset.y > scrollView.contentOffset.y) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
