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

-(void)fetchMovieDetails;
@end

@implementation DetailsViewController
@synthesize movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieTitle.text = movie.title;
    self.genres.text = movie.genres;
    self.score.text = [NSString stringWithFormat:@"%@",movie.vote_average];
    self.overviewText.text = movie.overview;
    
    [self fetchMovieDetails];
}

-(void)fetchMovieDetails {
    [Network fetchGenresWith: movie.movieID withCompletionHandler:^(NSArray* genres){
        NSString* allGenres = @("");
        for(NSString* genre in genres){
            allGenres = [allGenres stringByAppendingString: genre ];
            allGenres = [allGenres stringByAppendingString: @" " ];
        }
        self->movie.genres = allGenres;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.genres.text = self->movie.genres;
        });
    }];
}

@end

