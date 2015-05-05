//
//  PLFMasterViewController.m
//  ProlificLibrary
//
//  Created by Oat Liewsrisuk on 4/29/15.
//  Copyright (c) 2015 Me. All rights reserved.
//

#import "PLFMasterViewController.h"
#import "PLFhttpClient.h"
#import "PLFtableCell.h"
#import "PLFDetailViewController.h"

@interface PLFMasterViewController ()
@property (strong, nonatomic) NSMutableArray *booksArray;
@end

@implementation PLFMasterViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefreshControl];
    self.booksArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadBooks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)addBtnToAddBookViewController:(id)sender {
    [self performSegueWithIdentifier:@"addBookSegue" sender:self];
}

#pragma mark - Public
- (void)loadBooks {

    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        
        self.booksArray = [NSMutableArray arrayWithArray:returnData];
        [self.tableView reloadData];

    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
    
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient] getAllBooksWithSuccessHandler:submissionHandler
                                                   andWithErrorHandler:errorHandler];

}

- (void)deleteBook:(PLFbook *)book {
    
    //successBlock
    void (^submissionHandler)(NSArray *) = ^(NSArray *returnData) {
        [self.tableView reloadData];
    };
    
    //errorBlock
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        
        NSLog(@"%@",error);
        return;
    };
    
    [[PLFhttpClient sharedPLFHTTPClient] deleteBookWithData:book
                                        WithSuccessHandler:submissionHandler
                                        andWithErrorHandler:errorHandler];
    
}

- (void)reloadData{
    [self loadBooks];
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        //add text
        NSString *title = [NSString stringWithFormat:@"Written by Phong ©2015"];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];
    }
}


- (void)addRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor =  [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailSegue"]) {
        
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        PLFDetailViewController *viewController = (PLFDetailViewController *)navController.topViewController;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"%@",self.booksArray[indexPath.row]);
        viewController.book = self.booksArray[indexPath.row];
        
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PLFCell";
    PLFtableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        PLFtableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self.booksArray){
        PLFbook *book = self.booksArray[indexPath.row];
        cell.title.text = book.title;
        cell.author.text = book.author;
    }
    
    NSLog(@"%@",self.booksArray);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.booksArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //default height
    return 80;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    PLFbook *book = self.booksArray[indexPath.row];
    [self.booksArray removeObject:book];
    [self deleteBook:book];

}



@end
