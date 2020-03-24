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
    Movie* movie;
}
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *genres;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITextView *overviewText;


@property(nonatomic,retain) Network* network;
@property(nonatomic,retain) Movie* movie;

-(void)fetchMovieDetails: (Movie *)  movie;
-(void)getMovieDetails: (NSString *)  movieId;

@end
