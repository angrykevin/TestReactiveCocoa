//
//  TBLocationManager.h
//  Teemo
//
//  Created by Wu Kevin on 11/8/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TBReverseGeocoder.h"

#define TBLocationManagerDidStartUpdatingNotification @"TBLocationManagerDidStartUpdatingNotification"
#define TBLocationManagerDidStopUpdatingNotification @"TBLocationManagerDidStopUpdatingNotification"
#define TBLocationManagerDidUpdateLocationNotification @"TBLocationManagerDidUpdateLocationNotification"
#define TBLocationManagerDidUpdateAddressNotification @"TBLocationManagerDidUpdateAddressNotification"


@interface TBLocationManager : NSObject<CLLocationManagerDelegate> {
  CLLocationManager *_locationManager;
  CLLocation *_location;
  BOOL _updating;
  
  TBReverseGeocoder *_reverseGeocoder;
}

@property(nonatomic, strong, readonly) CLLocationManager *locationManager;
@property(nonatomic, strong, readonly) CLLocation *location;
@property(nonatomic, readonly) BOOL updating;

@property(nonatomic, strong, readonly) TBReverseGeocoder *reverseGeocoder;

+ (TBLocationManager *)sharedObject;

- (void)launchLocationServiceIfNeeded;
- (void)shutdownLocationServiceIfNeeded;

- (void)requestAddressIfPossible;

@end
