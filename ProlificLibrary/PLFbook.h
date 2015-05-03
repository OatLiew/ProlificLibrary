//
//  PLFbook.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 5/1/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFbook : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSString *lastCheckedOut;
@property (strong, nonatomic) NSString *lastCheckedOutBy;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSNumber *id;

@end
