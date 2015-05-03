//
//  DetailViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFDetailViewController.h"
#import "PLFhttpClient.h"
#import <MRProgress/MRProgress.h> //animation framework for loading

@interface PLFDetailViewController ()
@end

@implementation PLFDetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    [self loadDetail:self.book];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)pressedCheckout:(id)sender {
    
    __block UITextField *NameTextField = [[UITextField alloc]init];
    
    //Create Alert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Your Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //Create Checkout Button
    UIAlertAction* checkOut = [UIAlertAction actionWithTitle:@"Check Out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        //Check for empty String
        if([NameTextField.text length] > 0){
            PLFbook *book = [[PLFbook alloc]init];
            book.url = self.book.url;
            book.lastCheckedOutBy = NameTextField.text;
            [self putToserver:book];
        }
        else{
            [self showAlert:@"Please Enter Name"];
        }
    }];
    
    //Create Cancel Button
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";
        NameTextField = textField;
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:checkOut];


    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - public
- (void)loadDetail:(PLFbook *)book{
    
    //successBlock
    void (^submissionHandler)(PLFbook *) = ^(PLFbook *returnData) {
        self.book = returnData;
        [self loadDetailView];
        [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient]getBookWithData:book
                                     WithSuccessHandler:submissionHandler
                                    andWithErrorHandler:errorHandler];

}

- (void)loadDetailView{
    
    self.titleLbl.text = self.book.title;
    self.authorLbl.text = self.book.author;
    self.publisherLbl.text = self.book.publisher;
    self.catergoryLbl.text = self.book.categories;
    self.checkoutLbl.text = self.book.lastCheckedOut;
}

- (void)putToserver:(PLFbook *)bookParams{
    
    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        NSLog(@"%@",returnData);
        
        [self showAlert:@"Done"];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        [self showAlert:@"Error"];
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient] putBookWithData:bookParams
                                       WithSuccessHandler:submissionHandler
                                      andWithErrorHandler:errorHandler];

}

//Show Alert
- (void)showAlert:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}



@end
