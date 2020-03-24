//
//  DetailsViewController.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"
#import "Movie.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize network, movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.network = [[Network alloc] init];
    [self getMovieDetails: @(419704)];
}

-(void)fetchMovieDetails: (Movie *)  movie {
    [network fetchMovieDetails: movie withCompletionHandler: ^(Movie* movie){
        NSLog(@"%@", movie.title);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieTitle.text = movie.title;
            self.genres.text = movie.genres;
            self.score.text = [NSString stringWithFormat:@"%@",movie.vote_average];
            self.overviewText.text = movie.overview;
        });
    }];
}

//MARK: for testing
-(void)getMovieDetails: (NSString *)  movieId {
    [network fetchMovieWithID: movieId withCompletionHandler: ^(Movie* movie){
        NSLog(@"%@", movie.title);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.genres.text = movie.genres;
        });
    }];
}

@end

