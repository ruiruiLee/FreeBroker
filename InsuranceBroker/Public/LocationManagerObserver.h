//
//  LocationManagerObserver.h
//  SpringCare
//
//  Created by LiuZach on 15/4/13.
//  Copyright (c) 2015年 cmkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManagerObserver : NSObject<CLLocationManagerDelegate>
{
    CLGeocoder *geocoder ;
}
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, retain) CLLocationManager * locationManager ;
@property (nonatomic, copy) NSString* currentCity ;
@property (nonatomic, copy) NSString* currentDetailAdrress ;

+ (LocationManagerObserver *)sharedInstance;
- (void) startUpdateLocation;

@end
