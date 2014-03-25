//
//  TBReverseGeocoder.m
//  Teemo
//
//  Created by Wu Kevin on 12/19/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBReverseGeocoder.h"


@implementation TBReverseGeocoder


- (void)reverseGeocodeLocation:(CLLocation *)location
             completionHandler:(TBOperationCompletionHandler)completionHandler
{
  if ( location ) {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    NSMutableDictionary *context = [[NSMutableDictionary alloc] init];
    [context setObject:location forKey:@"location"];
    if ( completionHandler ) {
      [context setObject:[completionHandler copy] forKey:@"completionHandler"];
    }
    
    [self performSelector:@selector(parseLocationWithContext:)
               withObject:context
               afterDelay:1.0];
    
  }
}

- (void)cancelAndClear
{
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  
  _parameters = nil;
  
  [_connection clearDelegatesAndCancel];
  _location = nil;
  _result = nil;
  _parsing = NO;
  
}



- (NSDictionary *)addressDictionary
{
  NSArray *results = [_result objectForKey:@"results"];
  for ( NSDictionary *addressDictionary in results ) {
    NSArray *types = [addressDictionary objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"street_address"] ) {
      return addressDictionary;
    }
  }
  
  return nil;
}

- (NSString *)formattedAddress
{
  NSDictionary *addressDictionary = [self addressDictionary];
  return [addressDictionary objectForKey:@"formatted_address"];
}


- (NSString *)country
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"country"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)administrativeArea
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"administrative_area_level_1"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)subAdministrativeArea
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"administrative_area_level_2"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)locality
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"locality"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)subLocality
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"sublocality"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)thoroughfare
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"route"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)subThoroughfare
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"street_number"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}

- (NSString *)postalCode
{
  NSDictionary *addressDictionary = [self addressDictionary];
  
  NSArray *addressComponents = [addressDictionary objectForKey:@"address_components"];
  for ( NSDictionary *component in addressComponents ) {
    NSArray *types = [component objectForKey:@"types"];
    if ( [types hasObjectEqualTo:@"postal_code"] ) {
      return [component objectForKey:@"long_name"];
    }
  }
  
  return nil;
}




- (void)parseLocationWithContext:(NSDictionary *)context
{
  CLLocation *location = [context objectForKey:@"location"];
  TBOperationCompletionHandler completionHandler = [context objectForKey:@"completionHandler"];
  
  
  NSString *address = @"http://maps.googleapis.com/maps/api/geocode/json";
  
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
  [parameters setObject:@"true" forKey:@"sensor"];
  [parameters setObject:@"zh-CN" forKey:@"language"];
  
  if ( [_parameters count] > 0 ) {
    for ( NSString *key in [_parameters keyEnumerator] ) {
      NSString *value = [_parameters objectForKey:key];
      [parameters setObject:value forKey:key];
    }
  }
  
  NSString *latlng = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
  [parameters setObject:latlng forKey:@"latlng"];
  
  
  [_connection clearDelegatesAndCancel];
  
  _connection = [[TKURLConnectionOperation alloc] initWithAddress:[address stringByAddingQueryDictionary:parameters]
                                                  timeoutInterval:0.0
                                                      cachePolicy:0];
  
  __weak typeof(self) weakSelf = self;
  
  _connection.didStartBlock = ^(id object) {
    [weakSelf setParsing:YES];
  };
  
  _connection.didFailBlock = ^(id object) {
    //[weakSelf setLocation:nil];
    //[weakSelf setResult:nil];
    [weakSelf setParsing:NO];
    if ( completionHandler ) {
      NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
      completionHandler(nil, error);
    }
  };
  
  _connection.didFinishBlock = ^(id object) {
    id result = [NSJSONSerialization JSONObjectWithData:[object responseData]
                                                options:0
                                                  error:NULL];
    [weakSelf setLocation:location];
    [weakSelf setResult:result];
    [weakSelf setParsing:NO];
    if ( completionHandler ) {
      completionHandler(result, nil);
    }
  };
  
  [_connection startAsynchronous];
  
}

- (void)dealloc
{
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  
  _parameters = nil;
  
  [_connection clearDelegatesAndCancel];
  _location = nil;
  _result = nil;
  _parsing = NO;
}



- (CLLocation *)location
{
  return _location;
}

- (void)setLocation:(CLLocation *)location
{
  _location = location;
}


- (NSDictionary *)result
{
  return _result;
}

- (void)setResult:(NSDictionary *)result
{
  _result = result;
}


- (BOOL)parsing
{
  return _parsing;
}

- (void)setParsing:(BOOL)parsing
{
  _parsing = parsing;
}


@end
