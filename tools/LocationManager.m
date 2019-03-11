//
//  LocationManager.m
//  AlphaPay
//
//  Created by xialan on 2019/2/16.
//  Copyright © 2019 HARAM. All rights reserved.
//

#import "LocationManager.h"

#if __has_feature(objc_arc)
#define UU_RELEASE(x)        (void)(0)
#define UU_RETAIN(x)        x
#define UU_AUTORELEASE(x)    x
#define UU_BLOCK_RELEASE(x) (void)(0)
#define UU_BLOCK_COPY(x)    [x copy]
#else
#define UU_RELEASE(x) [x release]
#define UU_RETAIN(x) [x retain]
#define UU_AUTORELEASE(x) [(x) autorelease]
#define UU_BLOCK_RELEASE(x) Block_release(x)
#define UU_BLOCK_COPY(x)    Block_copy(x)
#endif

NSString * const LocationChangedNotification = @"LocationChangedNotification";
NSString * const LocationNameChangedNotification = @"LocationNameChangedNotification";
NSString * const LocationAuthChangedNotification = @"LocationAuthChangedNotification";
NSString * const LocationErrorNotification = @"LocationErrorNotification";

@interface LocationManager()
@property (nonatomic, retain) CLLocationManager* clLocationManager;
@property (nonatomic, retain) CLLocation* clLocation;
@property (nonatomic, retain) NSString* locationName;
@property (nonatomic, retain) NSString* cityName;
@property (nonatomic, retain) NSString* stateName;
@property (nonatomic, retain) NSTimer* notificationTimer;
@end

static LocationManager* theLocationManager = nil;

@implementation LocationManager

+ (LocationManager*) sharedInstance
{
    if (theLocationManager == nil)
    {
        theLocationManager = [[LocationManager alloc] init];
    }
    
    return theLocationManager;
}

+ (void) startTracking
{
    //Just call the accessor...
    [LocationManager sharedInstance];
}

- (CLLocation*) currentLocation
{
    return self.clLocation;
}

- (NSString*) currentLocationName
{
    return self.locationName;
}

- (NSString*) currentCityName
{
    return self.cityName;
}

- (NSString*) currentStateName
{
    return self.stateName;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.distanceThreshold = 10.0f;        // 10 meters
        self.timeThreshold = 1800;            // 30 minutes
        self.monitorLocationName = NO;
        self.delayLocationUpdates = NO;
        self.locationUpdateDelay = 1.0f;    // 1 second
        
        if ([CLLocationManager locationServicesEnabled])
        {
            // Initialize the locationManager
            CLLocationManager* locManager = UU_AUTORELEASE([[CLLocationManager alloc] init]);
            locManager.delegate = self;
            
            locManager.desiredAccuracy = kCLLocationAccuracyBest;
            locManager.distanceFilter = self.distanceThreshold;
            self.clLocationManager = locManager;
            
            //Go!!!
            [self.clLocationManager startUpdatingLocation];
        }
    }
    return self;
}

- (void) startTracking
{
    [self.clLocationManager startUpdatingLocation];
}

- (void) stopTracking
{
    self.clLocation = nil;
    [self.clLocationManager stopUpdatingLocation];
}

- (void) startTrackingSignificantLocationChanges
{
    [self.clLocationManager startMonitoringSignificantLocationChanges];
}

- (void) stopTrackingSignificantLocationChanges
{
    [self.clLocationManager stopMonitoringSignificantLocationChanges];
}

- (void) setDistanceThreshold:(CLLocationDistance)distanceThreshold
{
    _distanceThreshold = distanceThreshold;
    self.clLocationManager.distanceFilter = distanceThreshold;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
{
    if (!self.clLocation ||
        !CLLocationCoordinate2DIsValid(self.clLocation.coordinate) ||
        [self.clLocation distanceFromLocation:newLocation] > self.distanceThreshold ||
        [self.clLocation.timestamp timeIntervalSinceDate:newLocation.timestamp] > self.timeThreshold ||
        newLocation.horizontalAccuracy < self.clLocation.horizontalAccuracy)
    {
        self.clLocation = newLocation;
        
        if (self.delayLocationUpdates)
        {
            [self.notificationTimer invalidate];
            self.notificationTimer = [NSTimer scheduledTimerWithTimeInterval:self.locationUpdateDelay target:self selector:@selector(postLocationChangedTimer:) userInfo:self.clLocation repeats:NO];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:LocationChangedNotification object:self.clLocation];
        }
        
        if (self.monitorLocationName)
        {
            [self queryLocationName:self.clLocation];
        }
    }
}

- (void) postLocationChangedTimer:(NSTimer*)timer
{
    CLLocation* location = timer.userInfo;
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationChangedNotification object:location];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationErrorNotification object:error];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationAuthChangedNotification object:@(status)];
}

- (void) queryLocationName:(CLLocation*)location
{
    CLGeocoder* geoCoder = UU_AUTORELEASE([[CLGeocoder alloc] init]);
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks, NSError* error)
     {
         if (error == nil && placemarks != nil && placemarks.count > 0)
         {
             CLPlacemark* info = [placemarks objectAtIndex:0];
             
             NSMutableString* sb = [NSMutableString string];
             if (info.locality != nil)
             {
                 [sb appendString:info.locality];
                 self.cityName = info.locality;
             }
             
             if (info.administrativeArea != nil)
             {
                 if (sb.length > 0)
                 {
                     [sb appendString:@", "];
                 }
                 [sb appendString:info.administrativeArea];
                 self.stateName = info.administrativeArea;
             }
             
             self.locationName = sb;
             [[NSNotificationCenter defaultCenter] postNotificationName:LocationNameChangedNotification object:sb];
         }
     }];
}

- (bool) hasValidLocation
{
    return ((self.clLocation != nil) && CLLocationCoordinate2DIsValid(self.clLocation.coordinate));
}

@end
