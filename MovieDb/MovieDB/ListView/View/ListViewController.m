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
}

// MARK: - TableView Properties

-(double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = UITableViewHeaderFooterView.new;
    headerView.textLabel.text = section == 0 ? @"Popular Movies" : @"Now Playing";
    headerView.tintColor = UIColor .whiteColor;
    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 10;
}

// MARK: - Cell Properties

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cellID" forIndexPath:indexPath];
    
    cell.moviePoster.layer.cornerRadius = 10;
    cell.moviePoster.image = [UIImage imageNamed:@"moviePoster"];
    cell.movieTitle.text = @"isso é um título";
    cell.movieDescription.text = @"aqui vai a descrição pipipipopopo";
    cell.movieRate.text = @"9.0";
    
    return cell;
}

// MARK: - Segue to DetailView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"detailSegue" sender:cell];
}

@end
