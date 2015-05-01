//
//  PLFhttpClient.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface PLFhttpClient: AFHTTPSessionManager

+ (PLFhttpClient *)sharedPLFHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

typedef void (^PLFDataSubmissionBlock)(NSArray * PLFbooks);
typedef void (^PLFDataErrorBlock)(NSURLSessionDataTask *task, NSError *error);

// GET books
- (void)getAllBooksWithSuccessHandler:(PLFDataSubmissionBlock)successBlock
                      andWithErrorHandler:(PLFDataErrorBlock)errorBlock;


@end

