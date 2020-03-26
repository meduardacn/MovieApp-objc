//
//  DetailsViewController.h
//  MovieDB
//
//  Created by Maria Eduarda Casanova Nascimento on 18/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"


@interface DetailsViewController : UIViewController
@property(nonatomic,strong) UIImage* poster;
@property(nonatomic,strong) Movie* movie;

@end
