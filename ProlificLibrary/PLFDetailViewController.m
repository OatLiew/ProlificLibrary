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
#import "UIImageView+AFNetworking.h"
#import "PLFAddBookViewController.h"

static NSString * const ORIGINAL_FORMAT = @"yyyy-MM-dd HH:mm:ss";
static NSString * const CONVERTED_FORMAT = @"MMMM dd, yyyy h:mm a";

@interface PLFDetailViewController ()
@end

@implementation PLFDetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //round image 
    self.bookImage.layer.cornerRadius = self.bookImage.frame.size.width / 2;
    self.bookImage.clipsToBounds = YES;
    self.bookImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.bookImage.layer.borderWidth = 1.0;
    self.bookImage.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
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
            book.author = self.book.author;
            book.title = self.book.title;
            book.publisher = self.book.publisher;
            book.categories = self.book.categories;
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

- (IBAction)editBtnPressed:(id)sender {
    [self performSegueWithIdentifier:@"editSegue" sender:self];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editSegue"]) {
        
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        PLFAddBookViewController *viewController = (PLFAddBookViewController *)navController.topViewController;
        viewController.book = self.book;
        
    }
}


#pragma mark - public
- (void)loadDetail:(PLFbook *)book{
    
    //successBlock
    void (^submissionHandler)(PLFbook *) = ^(PLFbook *returnData) {
        self.book = returnData;
        [self GetGoogleImages:self.book.title :self.book.author];
        [self loadDetailView];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        NSLog(@"%@",error);
        [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient]getBookWithData:book
                                     WithSuccessHandler:submissionHandler
                                    andWithErrorHandler:errorHandler];
}

- (void)loadDetailView{
    
    self.titleLbl.text = self.book.title;
    self.authorLbl.text = self.book.author;
    
    if([self.book.publisher length] > 0){
        NSString *convertedStr = [NSString stringWithFormat:@"Publisher: %@",self.book.publisher];
        self.publisherLbl.text = convertedStr;
    }
    
    if([self.book.categories length] > 0){
        NSString *convertedStr = [NSString stringWithFormat:@"Tag: %@",self.book.categories];
        self.catergoryLbl.text = convertedStr;
    }
    
    if([self.book.lastCheckedOut length] > 0){
        NSString *convertedDate = [self conVertDateTime:self.book.lastCheckedOut];
        NSString *convertedStr = [NSString stringWithFormat:@"Check out by %@, %@", self.book.lastCheckedOutBy,convertedDate];
        self.checkoutLbl.text = convertedStr;
    }
}

- (void)putToserver:(PLFbook *)bookParams{
    
    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        NSLog(@"%@",returnData);
        
        [self showAlert:@"Done"];
        [self loadDetail:self.book];
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

- (void)showAlert:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

//Convert dateTime Format
- (NSString *)conVertDateTime:(NSString *)dateTime{

    //get NSdate
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    dateFormatter.dateFormat = ORIGINAL_FORMAT;
    NSDate *date = [dateFormatter dateFromString: dateTime];
    
    //convert the format
    [dateFormatter setDateFormat:CONVERTED_FORMAT];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];
    NSString *convertedStr = [dateFormatter stringFromDate:date];
    
    return convertedStr;

}

- (void)GetGoogleImages:(NSString *)title :(NSString *)author{
    
    author = [author stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString * query = [NSString stringWithFormat:@"%@ +author+ %@", title, author];
    
    //successBlock
    void (^submissionHandler)(NSDictionary *) = ^(NSDictionary *returnData) {
        
        NSData *bookData = nil;
        NSString *imageURl = nil;
        
        //get the result
        NSArray *resultArray = [[[returnData objectForKey:@"responseData"] objectForKey:@"results"] valueForKey:@"url"];
        NSURL * imageURL = [NSURL URLWithString:[resultArray objectAtIndex:0]];

        for(int i = 0; i < [resultArray count]; i++){
            imageURl = [resultArray objectAtIndex:i];
            bookData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURl]];
            NSLog(@"URL INDEX: %d", i);
            
            //if image exists
            if(bookData != NULL){
                [self displayImage:imageURl];
                break;
            }
        }
        //hide animation
        [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        [MRProgressOverlayView dismissOverlayForView:self.view animated:YES];
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient]getImagesWithQuery:query
                                        WithSuccessHandler:submissionHandler
                                       andWithErrorHandler:errorHandler];
}

- (void)displayImage:(NSString *)imageUrl{
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.gpg"];
    
    //display image with Afnetworking
    [self.bookImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       self.bookImage.image = image;
                                       
                                   }
                                   failure:nil];
}

@end
