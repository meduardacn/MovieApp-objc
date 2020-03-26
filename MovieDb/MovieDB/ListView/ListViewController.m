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
    NSMutableArray* popular;
    NSMutableArray* nowPlaying;
    NSCache<NSString*, NSData*> *cache;
    int page;
}
- (void) loadPopularMovies:(int)page;
- (void) loadNowPlayingMovies:(int)page;

@end

// Enum  TableView Sections
typedef NS_ENUM(NSInteger, TABLE_SECTION_ITEMS){
    TABLE_SECTION_Popular,
    TABLE_SECTION_Playing,
    TABLE_SECTION_Count
};

@implementation ListViewController
bool hasMoreMovies = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    page = 1;
    cache = [[NSCache alloc] init];
    popular = [[NSMutableArray alloc]init ];
    nowPlaying = [[NSMutableArray alloc]init ];
    [self loadPopularMovies:page];
    [self loadNowPlayingMovies:page];
}

// MARK: - TableView Properties
- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}

- (NSString *)tableSectionName:(TABLE_SECTION_ITEMS)item {
    switch (item) {
        case TABLE_SECTION_Popular: return @"Popular Movies";
        case TABLE_SECTION_Playing: return @"Now Playing";
        case TABLE_SECTION_Count: return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = UITableViewHeaderFooterView.new;
    headerView.textLabel.text = [self tableSectionName:section];
    headerView.tintColor = UIColor .whiteColor;
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TABLE_SECTION_Count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2 : nowPlaying.count;
}

// MARK: - Cell Properties
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cellID" forIndexPath:indexPath];
    Movie* movie = nil;
    if(popular.count == 0 || nowPlaying.count == 0) return cell;
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
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.moviePoster.image = [ UIImage imageWithData:poster];
            });
        }];
    }else{
        cell.moviePoster.image = [ UIImage imageWithData:posterData];
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
        DetailsViewController *detViewController = segue.destinationViewController;
        ListTableViewCell* cell = sender;
        detViewController.movie = cell.movie;
        detViewController.poster = cell.moviePoster.image;
    }
}

//MARK: private functions
- (void) loadPopularMovies:(int)page{
    [Network fetchMovies:@("popular") onPage: page withCompletionHandler: ^(NSArray* movies){
        [self->popular addObjectsFromArray:movies];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void) loadNowPlayingMovies: (int)page{
    [Network fetchMovies: @("now_playing") onPage: page withCompletionHandler: ^(NSArray* movies){
        [self->nowPlaying addObjectsFromArray: movies];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

//MARK: Pagination
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(nowPlaying.count>1){
        if(indexPath.row == nowPlaying.count-1){
            page++;
            [self loadNowPlayingMovies:page];
        }
    }
}

@end
