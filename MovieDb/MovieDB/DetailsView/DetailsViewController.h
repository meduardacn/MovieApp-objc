//
//  DetailsViewController.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"


@interface DetailsViewController : UIViewController{
    Network* network;
}
@property(nonatomic,retain) Network* network;

-(void)fetchMovieDetails: (Movie *)  movie;
-(void)getMovieDetails: (NSString *)  movieId;

@end
