//
//  Parser.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 20/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//
#import "Movie.h"

@interface Parser: NSObject

- (Movie *) parseMovie: (Movie *) movie withJson:(NSDictionary *)json;
- (Movie *) parseMovieWithJson:(NSDictionary *)json;
- (NSArray *) parseMoviesWithJson:(NSDictionary *)json;
@end
