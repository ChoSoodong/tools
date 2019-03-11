//
//  LocationManager.h
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

extern NSString * const LocationChangedNotification;
extern NSString * const LocationNameChangedNotification;
extern NSString * const LocationAuthChangedNotification;
extern NSString * const LocationErrorNotification;

@interface LocationManager : NSObject <CLLocationManagerDelegate>


//Call startTracking to begin location services. If you do not explicitly call startTracking,
//the first time you access the sharedInstance, it will be called internally.
+ (void) startTracking;
+ (LocationManager*) sharedInstance;


// Cached results
- (CLLocation*) currentLocation;
- (NSString*)    currentLocationName;
- (NSString*)    currentCityName;
- (NSString*)    currentStateName;

- (bool) hasValidLocation;

- (void) startTracking;
- (void) stopTracking;
- (void) startTrackingSignificantLocationChanges;
- (void) stopTrackingSignificantLocationChanges;

// Configuration Properties
@property (assign, setter = setDistsanceThreshold:) CLLocationDistance distanceThreshold;    // Defaults to 10 meters
@property (assign) NSTimeInterval timeThreshold;            // Defaults to 30 minutes (time is in seconds)
@property (assign) bool monitorLocationName;                // Defaults to NO
@property (assign) bool delayLocationUpdates;               // Defaults to NO
@property (assign) NSTimeInterval locationUpdateDelay;      // Defaults to 1 second


@end


