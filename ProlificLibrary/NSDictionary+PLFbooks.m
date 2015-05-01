//
//  NSDictionary+PLFbooks.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "NSDictionary+PLFbooks.h"

@implementation NSDictionary(PLFbooks)

- (NSString *)author{
    NSString *str = self[@"author"];
    return str;
}

- (NSString *)categories{
    NSString *str = self[@"categories"];
    return str;
}

- (NSNumber *)id{
    NSString *str = self[@"id"];
    NSNumber *n = @([str intValue]);
    return n;
}

- (NSString *)lastCheckedOut{
    NSString *str = self[@"lastCheckedOut"];
    return str;
}

- (NSString *)lastCheckedOutBy{
    NSString *str = self[@"lastCheckedOutBy"];
    return str;
}

- (NSString *)publisher{
    NSString *str = self[@"publisher"];
    return str;
}

- (NSString *)title{
    NSString *str = self[@"title"];
    return str;
}

- (NSString *)url{
    NSString *str = self[@"url"];
    return str;
}

@end
