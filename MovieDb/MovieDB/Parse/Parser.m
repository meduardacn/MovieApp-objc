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
+ (Movie *) parseMovie:(NSDictionary *)json;
@end

@implementation Parser
//MARK: public functions
+ (NSArray *) parseGenreswithJson:(NSDictionary *)json{
    NSMutableArray *genres = @[].mutableCopy;
    for (NSDictionary *dictionary in [json objectForKey:@"genres"]) {
        [genres addObject: [dictionary valueForKey:@"name"] ];
    }
    return genres;
}

+ (NSArray *) parseMoviesWithJson:(NSDictionary *)json{
    
    NSMutableArray *array = @[].mutableCopy;
    for(NSDictionary *dictionary in [json objectForKey:@"results"]){
        Movie *movie = [Parser parseMovie: dictionary];
        [array addObject:movie];
    }
    return array;
}

//MARK: private functions
+ (Movie *) parseMovie:(NSDictionary *)json {
    Movie *movie = [[Movie alloc] init];
    movie.title = [json objectForKey:@"title"];
    movie.overview = [json objectForKey:@"overview"];
    movie.vote_average = [json objectForKey:@"vote_average"];
    movie.movieID = [json objectForKey:@"id"];
    movie.poster_path = [json objectForKey:@"poster_path"];
    return movie;
}
@end
