//
//  Network.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 20/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "Movie.h"

@interface Network ()

-(void) fetchPoster: (NSString *) poster_path withCompletionHandler: (void (^)(NSData *))completionHandler;
@end

@implementation Network
@synthesize apiKey, request, parser;

- (id)init{
    self = [super init];
    if(self){
        self.apiKey = @"e33d6d132f3f10c719d71ad8b3149066";
        self.request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        self.parser = [[Parser alloc] init];
    }
    return self;
}

//MARK: Function to call in DetailsViewController passing movie
-(void) fetchMovieDetails: (Movie *) movie withCompletionHandler: (void (^)(Movie *))completionHandler {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US", movie.movieID, apiKey]];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        Movie *newMovie = [self->parser parseDetailsFrom: movie withJson:json];
        completionHandler(newMovie);
    }] resume];
}

//MARK: Function to call in ListViewController passing "now_playing" or "popular"
-(void) fetchMovies:(NSString *) type  withCompletionHandler: (void (^)(NSArray *))completionHandler{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US&page=1", type, apiKey]];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *array = [self->parser parseMoviesWithJson: json];
//        for(Movie* m in array){
//            [self fetchPoster: m.poster_path withCompletionHandler: ^(NSData* poster){
//                m.poster = poster;
//            }];
//        }
        completionHandler(array);
    }] resume];
}

//MARK: private function
-(void) fetchPoster: (NSString *) poster_path withCompletionHandler: (void (^)(NSData *))completionHandler{
      NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500/%@",poster_path]];
        [request setURL: url];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
          ^(NSData * _Nullable data,
            NSURLResponse * _Nullable response,
            NSError * _Nullable error) {
            completionHandler(data);
        }] resume];
    }

//MARK: function for testing
-(void) fetchMovieWithID: (NSString *) movieId withCompletionHandler: (void (^)(Movie *))completionHandler {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US", movieId, apiKey]];
    [request setURL: url];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        Movie *movie = [[Movie alloc] init];
        movie = [self->parser parseDetailsFrom: movie withJson:json];
        completionHandler(movie);
    }] resume];
}

@end

