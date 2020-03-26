//
//  Network.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 20/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@interface Network : NSObject
+ (void) fetchGenresWith: (NSString *) movieID withCompletionHandler: (void (^)(NSArray *))completionHandler;
+ (void) fetchMovies:(NSString *) movieId  withCompletionHandler: (void (^)(NSArray *))completionHandler;
+ (void) fetchPosterWithPath: (NSString *) poster_path withCompletionHandler: (void (^)(NSData *))completionHandler;
@end
