//
//  DetailViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFDetailViewController.h"
#import "PLFhttpClient.h"
@interface PLFDetailViewController ()
@end

@implementation PLFDetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetail:self.book];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public
- (void)loadDetail:(PLFbook *)book{
    
    //successBlock
    void (^submissionHandler)(PLFbook *) = ^(PLFbook *returnData) {
        self.book = returnData;
        [self loadDetailView];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient]getBookWithData:book
                                     WithSuccessHandler:submissionHandler
                                    andWithErrorHandler:errorHandler];

}

- (void)loadDetailView{
    
    self.titleLbl.text = self.book.title;
    self.authorLbl.text = self.book.author;
    self.publisherLbl.text = self.book.publisher;
    self.catergoryLbl.text = self.book.categories;
    self.checkoutLbl.text = self.book.lastCheckedOut;

}

@end
