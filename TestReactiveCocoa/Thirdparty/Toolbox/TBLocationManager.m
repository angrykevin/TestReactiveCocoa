//
//  TBLocationManager.m
//  Teemo
//
//  Created by Wu Kevin on 11/8/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBLocationManager.h"
#import <AddressBookUI/AddressBookUI.h>


@implementation TBLocationManager

- (void)dealloc
{
  _locationManager.delegate = nil;
  [_locationManager stopUpdatingLocation];
  
  [_reverseGeocoder cancelAndClear];
  
}

+ (TBLocationManager *)sharedObject
{
  static TBLocationManager *LocationManager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    LocationManager = [[self alloc] init];
  });
  return LocationManager;
}

- (void)launchLocationServiceIfNeeded
{
  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
  if ( status == kCLAuthorizationStatusAuthorized ) {
    TKPRINT(@"Authorized，启动服务。");
    [self startLocationService];
  } else if ( status == kCLAuthorizationStatusDenied ) {
    TKPRINT(@"Denied，不启动服务。");
  } else if ( status == kCLAuthorizationStatusNotDetermined ) {
    TKPRINT(@"Not Determined，启动服务, 让系统弹窗口。");
    [self startLocationService];
  } else if ( status == kCLAuthorizationStatusRestricted ) {
    TKPRINT(@"Restricted，不启动服务。");
  }
}

- (void)shutdownLocationServiceIfNeeded
{
  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
  if ( status == kCLAuthorizationStatusAuthorized ) {
    TKPRINT(@"Authorized, 授权了, 可能开启了服务, 应该关闭。");
    [self stopLocationService];
  } else if ( status == kCLAuthorizationStatusDenied ) {
    TKPRINT(@"Denied, 未授权, 未开启服务, 不需要关闭。");
  } else if ( status == kCLAuthorizationStatusNotDetermined ) {
    TKPRINT(@"Not Determined, 未决定, 未开启服务, 不需要关闭。");
  } else if ( status == kCLAuthorizationStatusRestricted ) {
    TKPRINT(@"Restricted, 不需要关闭。");
  }
}

- (void)requestAddressIfPossible
{
  if ( _reverseGeocoder == nil ) {
    _reverseGeocoder = [[TBReverseGeocoder alloc] init];
  }
  
  if ( _location ) {
    [_reverseGeocoder reverseGeocodeLocation:_location
                           completionHandler:^(id result, NSError *error) {
                             [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidUpdateAddressNotification
                                                                                 object:self];
                           }];
  }
}



- (void)startLocationService
{
  if ( _locationManager == nil ) {
    _locationManager = [[CLLocationManager alloc] init];
  }
  
  _locationManager.distanceFilter = 10;
  _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
  _locationManager.delegate = self;
  
  [_locationManager startUpdatingLocation];
  
  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
  if ( status == kCLAuthorizationStatusAuthorized ) {
    TKPRINT(@"Authorized, 授权了, 需要通知。");
    if ( !_updating ) {
      _updating = YES;
      [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidStartUpdatingNotification
                                                          object:self];
    }
  } else if ( status == kCLAuthorizationStatusDenied ) {
    TKPRINT(@"Denied, 未授权, 根本不会执行到这里。");
  } else if ( status == kCLAuthorizationStatusNotDetermined ) {
    TKPRINT(@"Not Determined, 未决定, 不需要通知。");
  } else if ( status == kCLAuthorizationStatusRestricted ) {
    TKPRINT(@"Restricted, 根本不会执行到这里。");
  }
  
}

- (void)stopLocationService
{
  _locationManager.delegate = nil;
  [_locationManager stopUpdatingLocation];
  //_locationManager = nil;
  
  if ( _updating ) {
    _updating = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidStopUpdatingNotification
                                                        object:self];
  }
  
}




- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  if ( status == kCLAuthorizationStatusAuthorized ) {
    TKPRINT(@"Authorized");
    if ( !_updating ) {
      _updating = YES;
      [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidStartUpdatingNotification
                                                          object:self];
    }
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
  } else if ( status == kCLAuthorizationStatusDenied ) {
    TKPRINT(@"Denied");
    _locationManager.delegate = nil;
    [_locationManager stopUpdatingLocation];
    if ( _updating ) {
      _updating = NO;
      [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidStopUpdatingNotification
                                                          object:self];
    }
  } else if ( status == kCLAuthorizationStatusNotDetermined ) {
    TKPRINT(@"Not Determined");
    // Do nothing here
  } else if ( status == kCLAuthorizationStatusRestricted ) {
    TKPRINT(@"Restricted");
    _locationManager.delegate = nil;
    [_locationManager stopUpdatingLocation];
    if ( _updating ) {
      _updating = NO;
      [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidStopUpdatingNotification
                                                          object:self];
    }
  }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  TKPRINTMETHOD();
  _location = [locations lastObject];
  [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidUpdateLocationNotification
                                                      object:self];
  
  [self requestAddressIfPossible];
  
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  TKPRINTMETHOD();
  _location = nil;
  [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidUpdateLocationNotification
                                                      object:self];
  
  [_reverseGeocoder cancelAndClear];
  [[NSNotificationCenter defaultCenter] postNotificationName:TBLocationManagerDidUpdateAddressNotification
                                                      object:self];
  
}

@end
