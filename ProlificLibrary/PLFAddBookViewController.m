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
    
    //dismiss Keyboard on Background tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)submitBtnPressed:(id)sender {
    
    //check for empty Strings
    if(([self.titleTextField.text length] > 0) && ([self.authorTextField.text length] > 0)){
        
        //create New book
        PLFbook *book = [[PLFbook alloc] init];
        book.author = self.authorTextField.text;
        book.title = self.titleTextField.text;
        book.publisher = self.publisherTextField.text;
        book.categories = self.catergoriesTextField.text;
                
        [self postToServer:book];
    }
    else{

        [self showAlert:@"Plese Enter Author and Title"];
    }
}

//return Viewcontroller
- (IBAction)DoneBtnToMasterViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - public
- (void)postToServer:(PLFbook *)bookParams{

    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        NSLog(@"%@",returnData);
        
        [self showAlert:@"Submitted"];
        [self clearTextFields];

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

- (void)clearTextFields{

    self.titleTextField.text = @"";
    self.authorTextField.text = @"";
    self.catergoriesTextField.text = @"";
    self.publisherTextField.text = @"";
    
}

-(void)dismissKeyboard{
    
    [self.titleTextField resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    [self.catergoriesTextField resignFirstResponder];
    [self.publisherTextField resignFirstResponder];
}

#pragma mark - UITextfiled
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//hide keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self dismissKeyboard];
    return YES;
}


@end