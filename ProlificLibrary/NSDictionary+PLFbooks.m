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
    str = [self checkforNull:str];
    return str;
}

- (NSString *)categories{
    NSString *str = self[@"categories"];
    str = [self checkforNull:str];
    return str;
}

- (NSNumber *)id{
    NSString *str = self[@"id"];
    NSNumber *n = @([str intValue]);
    return n;
}

- (NSString *)lastCheckedOut{
    NSString *str = self[@"lastCheckedOut"];
    str = [self checkforNull:str];
    return str;
}

- (NSString *)lastCheckedOutBy{
    NSString *str = self[@"lastCheckedOutBy"];
    str = [self checkforNull:str];
    return str;
}

- (NSString *)publisher{
    NSString *str = self[@"publisher"];
    str = [self checkforNull:str];
    return str;
}

- (NSString *)title{
    NSString *str = self[@"title"];
    str = [self checkforNull:str];
    return str;
}

- (NSString *)url{
    NSString *str = self[@"url"];
    str = [self checkforNull:str];
    return str;
}

//return empty string if value is Null
- (NSString *)checkforNull: (NSString *)str{
    
    if([str isKindOfClass:[NSNull class]])
        return @"";
    else
        return str;

}

@end
