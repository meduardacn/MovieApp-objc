//
//  ViewController.m
//  MovieDb
//
//  Created by Maria Eduarda Casanova Nascimento on 17/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"


@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - TableView Properties

-(double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *headerView = self.tableView.tableHeaderView;
//    headerView.backgroundColor = UIColor .whiteColor;
//    return headerView;
//    
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 0 ? @"Popular Movies" : @"Now Playing";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"cellID" forIndexPath:indexPath];
    
    return cell;
}

@end
