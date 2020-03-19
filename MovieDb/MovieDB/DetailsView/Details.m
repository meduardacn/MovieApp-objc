//
//  Details.m
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 19/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Details.h"

@interface Details ()

@end

@implementation Details
@synthesize title, genres, overview,vote_average, movieID;

-(id)initWithJson:(NSDictionary*)json {
    if (self = [super init]) {
//        NSArray* genreslist = [json objectForKey:@"genres"];
//        for (int i = 0; i < genreslist.count; i++) {
//            NSLog(@"%@",genreslist[i][1]);
//        }
        self.title = [json objectForKey:@"title"];
        self.overview = [json objectForKey:@"overview"];
        self.vote_average = [json objectForKey:@"vote_average"];
        self.movieID = [json objectForKey:@"id"];
      }
    return self;
}
//
//-(void)dealloc {
//  [firstName release];
//  [lastName release];
//  [super dealloc];
//}
@end
