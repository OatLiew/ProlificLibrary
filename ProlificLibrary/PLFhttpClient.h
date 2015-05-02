//
//  PLFhttpClient.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "AFHTTPSessionManager.h"

//define Type
typedef void (^PLFDataSubmissionBlock_GET)(NSArray * PLFbooks);
typedef void (^PLFDataSubmissionBlock_POST)(NSDictionary * PLFbooks);
typedef void (^PLFDataErrorBlock)(NSURLSessionDataTask *task, NSError *error);

@interface PLFhttpClient: AFHTTPSessionManager

+ (PLFhttpClient *)sharedPLFHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

// GET books
- (void)getAllBooksWithSuccessHandler:(PLFDataSubmissionBlock_GET)successBlock
                  andWithErrorHandler:(PLFDataErrorBlock)errorBlock;

// POST book
- (void)postBookWithData:(NSDictionary *)bookData
       WithSuccessHandler:(PLFDataSubmissionBlock_POST)successBlock
      andWithErrorHandler:(PLFDataErrorBlock)errorBlock;


@end

