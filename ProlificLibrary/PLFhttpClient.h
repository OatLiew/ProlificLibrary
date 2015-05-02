//
//  PLFhttpClient.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "PLFbook.h"

//define Type
typedef void (^SubmissionBlockArray)(NSArray * PLFbooks);
typedef void (^SubmissionBlockPLFbook)(PLFbook * PLFbooks);
typedef void (^PLFDataErrorBlock)(NSURLSessionDataTask *task, NSError *error);

@interface PLFhttpClient: AFHTTPSessionManager

+ (PLFhttpClient *)sharedPLFHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

// GET books
- (void)getAllBooksWithSuccessHandler:(SubmissionBlockArray)successBlock
                  andWithErrorHandler:(PLFDataErrorBlock)errorBlock;

// POST book
- (void)postBookWithData:(PLFbook *)book
       WithSuccessHandler:(SubmissionBlockArray)successBlock
      andWithErrorHandler:(PLFDataErrorBlock)errorBlock;

// Delete book
- (void)deleteBookWithData:(PLFbook *)book
        WithSuccessHandler:(SubmissionBlockArray)successBlock
       andWithErrorHandler:(PLFDataErrorBlock)errorBlock;

// GET each book
- (void)getBookWithData:(PLFbook *)book
        WithSuccessHandler:(SubmissionBlockPLFbook)successBlock
       andWithErrorHandler:(PLFDataErrorBlock)errorBlock;



@end

