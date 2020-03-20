//
//  Movie.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 19/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Movie : NSObject {
    NSString* title;
    NSString* genres;
    NSString* overview;
    NSString* vote_average;
    NSString* movieID;
}

@property(nonatomic,retain) NSString* title;
@property(nonatomic,retain) NSString* genres;
@property(nonatomic,retain) NSString* overview;
@property(nonatomic,retain) NSString* vote_average;
@property(nonatomic,retain) NSString* movieID;


@end
