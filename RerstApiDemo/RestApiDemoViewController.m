//
//  RestApiDemoViewController.m
//  RestApiDemo
//
//  Created by Omer Gurarslan on 19/05/14.
//  Copyright (c) 2014 Lucid Bilg. Hiz. Ltd. Şti. All rights reserved.
//

#import "RestApiDemoViewController.h"

@interface RestApiDemoViewController ()
@property (nonatomic, strong)    NSDictionary *accountList;
@end

@implementation RestApiDemoViewController {
    NSArray *tableData;
}
@synthesize tableView = _tableView;
@synthesize accountList = _accountList;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Create the REST call string.
    NSInteger i = 1;
    NSString *restCallString = [NSString stringWithFormat:@"http://lucidcode-web-services.herokuapp.com/ajax/listAllPagified?pageNum=%d", (integer_t)i];
    
    // Create the URL to make the rest call
    NSURL *restURL = [NSURL URLWithString:restCallString];
    
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
    
    [NSURLConnection sendAsynchronousRequest:restRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (data.length > 0 && connectionError == nil) {
                                   self.accountList = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                                   NSLog(@"listOfAccounts = %@", [self.accountList objectForKey:@"accountList"]);
                                   [self.tableView reloadData];
                               }
                           }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.accountList objectForKey:@"accountList"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"accountList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[[self.accountList objectForKey:@"accountList"]objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
    
}

@end
