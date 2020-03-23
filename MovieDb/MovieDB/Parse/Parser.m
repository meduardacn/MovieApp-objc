//
//  Parser.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 20/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Movie.h"
@interface Parser()
@end

@implementation Parser

- (Movie *) parseMovieWithJson:(NSDictionary *)json {
    Movie *movie = [[Movie alloc] init];
    
    NSString* allGenres = @"| ";
    for (NSDictionary *dictionary in [json objectForKey:@"genres"]) {
        allGenres = [allGenres stringByAppendingString: [dictionary valueForKey:@"name"] ];
        allGenres = [allGenres stringByAppendingString: @" | " ];
    }
    movie.genres = allGenres;
    movie.title = [json objectForKey:@"title"];
    movie.overview = [json objectForKey:@"overview"];
    movie.vote_average = [json objectForKey:@"vote_average"];
    movie.movieID = [json objectForKey:@"id"];
    movie.poster = [json objectForKey:@"poster_path"];
    return movie;
}

- (NSArray *) parseMoviesWithJson:(NSDictionary *)json{
    NSMutableArray *array = @[].mutableCopy;
    for(NSDictionary *dictionary in json){
        Movie *movie = [self parseMovieWithJson: dictionary];
        [array addObject:movie];
    }
    return array;
}

@end
