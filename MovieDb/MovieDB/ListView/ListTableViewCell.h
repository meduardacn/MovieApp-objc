//
//  ListTableViewCell.h
//  MovieDB
//
//  Created by Camile Ancines on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell{
    Movie* movie;
}

@property(nonatomic,retain) Movie* movie;
// MARK: - Cell Outlets
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;
@property (weak, nonatomic) IBOutlet UILabel *movieRate;


@end

NS_ASSUME_NONNULL_END
