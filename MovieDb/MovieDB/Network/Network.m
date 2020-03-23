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

-(void) fetchMovieWithID: (NSString *) movieId withCompletionHandler: (void (^)(Movie *))completionHandler {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US", movieId, apiKey]];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        Movie *movie = [self->parser parseMovieWithJson: json];
        completionHandler(movie);
    }] resume];
}

-(void) fetchMovies:(NSString *) type  withCompletionHandler: (void (^)(NSArray *))completionHandler{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=%@&language=en-US&page=1", type, apiKey]];
    [request setURL: url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *array = [self->parser parseMoviesWithJson: json];
        completionHandler(array);
    }] resume];
}

@end

