//
//  RailwayMapView.h
//  TrainSeat
//
//  Created by Jin Sasaki on 2014/11/07.
//  Copyright (c) 2014年 Jin Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Railway.h"

@interface RailwayMapView : UIView
{
    NSMutableArray *railwayBtnArray;

}
- (id)initWithFrame:(CGRect)frame stationButtons:(NSArray *)buttons stationOrder:(NSArray *)order matchList:(NSDictionary *)matchList railwayColor:(UIColor *)raiwayColor;
- (id)initWithFrame:(CGRect)frame stationButtons:(NSArray *)buttons railwayColor:(UIColor *)raiwayColor;

@property (nonatomic, copy) NSString *railwayName;
@property (nonatomic) UIColor *railwayColor;
@property (nonatomic) Railway *railway;
@end
