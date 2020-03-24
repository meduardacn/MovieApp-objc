//
//  ViewController.m
//  MovieDb
//
//  Created by Maria Eduarda Casanova Nascimento on 17/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "DetailsViewController.h"

@interface ListViewController ()
- (void) loadPopularMovies;
- (void) loadNowPlayingMovies;
@end

@implementation ListViewController
@synthesize network, popular, nowPlaying;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self loadPopularMovies];
    [self loadNowPlayingMovies];
    
}

// MARK: - TableView Properties
- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = UITableViewHeaderFooterView.new;
    headerView.textLabel.text = section == 0 ? @"Popular Movies" : @"Now Playing";
    headerView.tintColor = UIColor .whiteColor;
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2 : 10;
}

// MARK: - Cell Properties
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cellID" forIndexPath:indexPath];
    if(indexPath.row < 3){
        // popular cell
        Movie* movie = [popular objectAtIndex: indexPath.row];
        cell.movie = movie;
        cell.moviePoster.layer.cornerRadius = 10;
        cell.moviePoster.image = [ UIImage imageWithData:movie.poster];
        cell.movieTitle.text = movie.title;
        cell.movieDescription.text = movie.overview;
        cell.movieRate.text = movie.vote_average;
    }else{
        // now_playing cell
        Movie* movie = [nowPlaying objectAtIndex: indexPath.row - 2];
        cell.movie = movie;
        cell.moviePoster.layer.cornerRadius = 10;
        cell.moviePoster.image = [ UIImage imageWithData:movie.poster];
        cell.movieTitle.text = movie.title;
        cell.movieDescription.text = movie.overview;
        cell.movieRate.text = movie.vote_average;
    }
    return cell;
}

// MARK: - Segue to DetailView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"detailSegue" sender:cell];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailSegue"]){
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; 
        DetailsViewController *detViewController = segue.destinationViewController; 
        ListTableViewCell* cell = sender;
        detViewController.movie = cell.movie;
        detViewController.cardImage.image = [UIImage imageWithData: cell.movie.poster];
        detViewController.movieTitle.text = cell.movie.title;
        detViewController.genres.text = cell.movie.genres;
        detViewController.score.text = cell.movie.vote_average;
        detViewController.overviewText.text = cell.movie.overview;
    }
}

//MARK: private functions
- (void) loadPopularMovies{
    [network fetchMovies: @("popular") withCompletionHandler: ^(NSArray* movies){
        self.popular = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
}

- (void) loadNowPlayingMovies{
    [network fetchMovies: @("now_playing") withCompletionHandler: ^(NSArray* movies){
        self.popular = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
@end
