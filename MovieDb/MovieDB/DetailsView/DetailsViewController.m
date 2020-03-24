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

@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *genres;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITextView *overviewText;
@property(nonatomic,retain) Network* network;

@end

@implementation DetailsViewController
@synthesize network, movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieTitle.text = movie.title;
    self.genres.text = movie.genres;
    self.score.text = [NSString stringWithFormat:@"%@",movie.vote_average];
    self.overviewText.text = movie.overview;
    
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

