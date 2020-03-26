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

#define APIKEY @"e33d6d132f3f10c719d71ad8b3149066"

@interface Network ()

@end

@implementation Network


//MARK: Function to call from DetailsViewController
+(void) fetchGenresWith: (NSString *) movieID withCompletionHandler: (void (^)(NSArray *))completionHandler {
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US", movieID, APIKEY ]];
    
    [request setHTTPMethod:@"GET"];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        if (error) {
            NSLog(@"Request error fetch genres");
//            NSLog(@"Request error fetch genres: %@", error);
            return;
        }
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *genres = [Parser parseGenreswithJson:json];
        completionHandler(genres);
    }] resume];
}

//MARK: Function to call in ListViewController passing "now_playing" or "popular"
+ (void) fetchMovies:(NSString *) type onPage:(int) page withCompletionHandler: (void (^)(NSArray *))completionHandler{
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US&page=%@", type, APIKEY, [NSString stringWithFormat:@"%d",page] ]];
    
    [request setHTTPMethod:@"GET"];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        if (error) {
            NSLog(@"Request error on page: %d ---",page);
//            NSLog(@"Request error on page: %d --- %@",page, error);
            return;
        }
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *array = [Parser parseMoviesWithJson: json];
        completionHandler(array);
    }] resume];
}

//MARK: private function
+(void) fetchPosterWithPath: (NSString *) poster_path withCompletionHandler: (void (^)(NSData *))completionHandler{
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500/%@",poster_path]];
    [request setHTTPMethod:@"GET"];
    [request setURL: url];
        
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        if (error) {
            NSLog(@"Request error fetch poster");
//            NSLog(@"Request error fetch poster: %@", error);
            return;
        }
        completionHandler(data);
    }] resume];
}

@end

