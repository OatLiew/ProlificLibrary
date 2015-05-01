//
//  NSDictionary+PLFbooks.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/30/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (PLFbooks)

- (NSString *)author;
- (NSString *)categories;
- (NSNumber *)id;
- (NSString *)lastCheckedOut;
- (NSString *)lastCheckedOutBy;
- (NSString *)publisher;
- (NSString *)title;
- (NSString *)url;

@end
