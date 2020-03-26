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

@interface ListViewController (){
    NSArray* popular;
    NSArray* nowPlaying;
    NSCache* cache;
}

- (void) loadPopularMovies;
- (void) loadNowPlayingMovies;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    cache = [[NSCache alloc] init];
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
    Movie* movie = nil;
    if(indexPath.section == 0) movie = [popular objectAtIndex: indexPath.row];
    else movie = [nowPlaying objectAtIndex: indexPath.row];
    cell.movie = movie;
    cell.moviePoster.layer.cornerRadius = 10;
    cell.movieTitle.text = movie.title;
    cell.movieDescription.text = movie.overview;
    cell.movieRate.text = [NSString stringWithFormat:@"%@",movie.vote_average];\

    __block NSData* posterData = [cache objectForKey:movie.poster_path];
    if(!posterData){
        [Network fetchPosterWithPath:movie.poster_path withCompletionHandler: ^(NSData* poster){
            [self->cache setObject:poster forKey:movie.poster_path];
            posterData = poster;
        }];
    }
    cell.moviePoster.image = [ UIImage imageWithData:posterData];
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
        DetailsViewController *detViewController = segue.destinationViewController;
        ListTableViewCell* cell = sender;
        detViewController.movie = cell.movie;
        detViewController.poster = cell.moviePoster.image;
    }
}

//MARK: private functions
- (void) loadPopularMovies{
    [Network fetchMovies: @("popular") withCompletionHandler: ^(NSArray* movies){
        self->popular = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void) loadNowPlayingMovies{
    [Network fetchMovies: @("now_playing") withCompletionHandler: ^(NSArray* movies){
        self->nowPlaying = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
@end
