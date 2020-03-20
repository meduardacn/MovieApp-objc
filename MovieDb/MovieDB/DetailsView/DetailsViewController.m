//
//  DetailsViewController.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"
#import "Details.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMovieDetails: @(419704)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.movieTitle.text = self.testemovie;
}

-(void)getMovieDetails: (NSString *)  movieId {
    Details *movie = [[Details alloc]init];
    NSData *dataJson;
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=e33d6d132f3f10c719d71ad8b3149066&language=en-US", movieId];
    
    NSURL *url = [NSURL URLWithString: urlString ];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL: url];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
            
            NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
            NSData *dataJson = [myString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:dataJson options:0 error:nil];
            [movie initWithJson: json];
        
    }] resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.movieTitle.text = movie.title;
        self.category.text = movie.genres;
        self.score.text = [NSString stringWithFormat:@"%@",movie.vote_average]; 
        self.overviewText.text = movie.overview;
    });
}

@end

