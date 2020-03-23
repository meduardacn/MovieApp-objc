//
//  ViewController.h
//  MovieDb
//
//  Created by Maria Eduarda Casanova Nascimento on 17/03/20.
//  Copyright © 2020 Maria Eduarda Casanova Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"

@interface ListViewController : UITableViewController{
    Network* network;
    NSArray* popular;
    NSArray* nowPlaying;
}

@property(nonatomic,retain) Network* network;
@property(nonatomic,retain) NSArray* popular;
@property(nonatomic,retain) NSArray* nowPlaying;

@end

