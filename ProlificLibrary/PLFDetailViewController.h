//
//  PLFDetailViewController.h
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLFbook.h"

@interface PLFDetailViewController : UIViewController
@property (weak, nonatomic) PLFbook *book;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorLbl;
@property (weak, nonatomic) IBOutlet UILabel *publisherLbl;
@property (weak, nonatomic) IBOutlet UILabel *catergoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *checkoutLbl;


@end

