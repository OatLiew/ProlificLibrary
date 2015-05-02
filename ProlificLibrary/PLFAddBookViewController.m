//
//  PLFAddBookViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFAddBookViewController.h"
#import "PLFhttpClient.h"
#import "PLFbook.h"

@interface PLFAddBookViewController ()

@end

@implementation PLFAddBookViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleTextField.delegate = self;
    self.authorTextField.delegate = self;
    self.catergoriesTextField.delegate = self;
    self.publisherTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)submitBtnPressed:(id)sender {
    
    //check for empty Strings
    if(([self.titleTextField.text length] > 0) && ([self.authorTextField.text length] > 0)){

        NSDictionary *booksParams = @{@"author":self.authorTextField.text,
                                      @"title":self.titleTextField.text,
                                      @"publisher":self.publisherTextField.text,
                                      @"categories":self.catergoriesTextField.text};
        
        [self postToServer:booksParams];
    }
    else{

        [self showAlert:@"Plese Enter Author and Title"];
    }
}

- (IBAction)DoneBtnToMasterViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - public
- (void)postToServer:(NSDictionary *)bookParams{

    //successBlock
    void (^submissionHandler)(NSDictionary *) = ^(NSDictionary *returnData) {
        NSLog(@"%@",returnData);
        
        [self showAlert:@"Submitted"];

    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        [self showAlert:@"Error"];
        
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient] postBookWithData:bookParams
                                       WithSuccessHandler:submissionHandler
                                      andWithErrorHandler:errorHandler];
    
}

- (void)showAlert:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UITextfiled
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//hide keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleTextField resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    [self.catergoriesTextField resignFirstResponder];
    [self.publisherTextField resignFirstResponder];
    
    return YES;
}


@end