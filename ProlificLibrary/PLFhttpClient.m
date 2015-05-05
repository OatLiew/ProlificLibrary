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
static NSString * const GETString = @"/books";
static NSString * const POSTString = @"/books/";

static NSString * const GoogleImagesURLString = @"https://ajax.googleapis.com/ajax/services/search/images";


@interface PLFhttpClient ()

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

//GET all books
- (void)getAllBooksWithSuccessHandler:(SubmissionBlockArray)successBlock
                  andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString,GETString];
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

// POST book
- (void)postBookWithData:(PLFbook *)book
      WithSuccessHandler:(SubmissionBlockArray)successBlock
     andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString, POSTString];
    NSURL *url = [NSURL URLWithString:string];
    
    NSDictionary *bookParams = @{@"author":book.author,
                                 @"title":book.title,
                                 @"publisher":book.publisher,
                                 @"categories":book.categories};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager POST:string parameters:bookParams success:^(NSURLSessionDataTask *task, id responseObject){
        
        //callBack
        successBlock((NSArray*)responseObject);
        NSLog(@"%@",responseObject);

        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];

}

//DELETE book
- (void)deleteBookWithData:(PLFbook *)book
        WithSuccessHandler:(SubmissionBlockArray)successBlock
       andWithErrorHandler:(PLFDataErrorBlock)errorBlock;
{
    
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString, book.url];
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager DELETE:string parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        //callBack
        successBlock((NSArray*)responseObject);
        NSLog(@"%@",responseObject);
        
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];
}

//GET detail Book
- (void)getBookWithData:(PLFbook *)book
     WithSuccessHandler:(SubmissionBlockPLFbook)successBlock
    andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString, book.url];
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager GET:string parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        //callBack
        successBlock((PLFbook*)responseObject);
        NSLog(@"%@",responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];
}


// PUT book
- (void)putBookWithData:(PLFbook *)book
     WithSuccessHandler:(SubmissionBlockArray)successBlock
    andWithErrorHandler:(PLFDataErrorBlock)errorBlock
{
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString, book.url];
    NSURL *url = [NSURL URLWithString:string];
    
    NSDictionary *bookParams = @{@"lastCheckedOutBy":book.lastCheckedOutBy};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager PUT:string parameters:bookParams success:^(NSURLSessionDataTask *task, id responseObject){
        
        //callBack
        successBlock((NSArray*)responseObject);
        NSLog(@"%@",responseObject);
        
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];
    
}

- (void)getImagesWithQuery:(NSString *)query
        WithSuccessHandler:(SubmissionBlockDictionary)successBlock
        andWithErrorHandler:(PLFDataErrorBlock)errorBlock;
{
    NSURL *url = [NSURL URLWithString:GoogleImagesURLString];
    NSDictionary *params = @{@"v":@"1.0",
                            @"q" : query};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager GET:GoogleImagesURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        
        //callBack
        successBlock(responseObject);
        NSLog(@"%@",responseObject);
        
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        //callBack
        errorBlock(task, error);
        NSLog(@"Failure: %@", error);
    }];

}



@end
