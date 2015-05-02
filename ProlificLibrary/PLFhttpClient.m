//
//  PLFhttpClient.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//
#import "PLFhttpClient.h"
#import <Foundation/Foundation.h>

static NSString * const BaseURLString = @"http://prolific-interview.herokuapp.com/553fe2fc533778000964ac17";

@interface PLFhttpClient ()

@property(strong) NSDictionary *Books;

@end

@implementation PLFhttpClient

//Singleton pattern for one object
+ (PLFhttpClient *)sharedPLFHTTPClient
{
    static PLFhttpClient *_sharedPLFHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPLFHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    
    return _sharedPLFHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

//Get all books
- (void)getAllBooksWithSuccessHandler:(PLFDataSubmissionBlock_GET)successBlock
                  andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@/books", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];

    [manager GET:string parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){

        //callBack
        successBlock((NSArray*)responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
         NSLog(@"Failure: %@", error);
    }];
}

// Post book
- (void)postBookWithData:(NSDictionary *)bookParameters
      WithSuccessHandler:(PLFDataSubmissionBlock_POST)successBlock
     andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@/books/", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    [manager POST:string parameters:bookParameters success:^(NSURLSessionDataTask *task, id responseObject){
        
        NSLog(@"%@",responseObject);
        //callBack
        successBlock((NSDictionary*)responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];

}


@end
