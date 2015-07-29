//
//  Detector.h
//  Bluetooth Scanner
//
//  Created by Techbar on 7/27/15.
//  Copyright (c) 2015 rahman-berra. All rights reserved.
//

#ifndef Bluetooth_Scanner_Detector_h
#define Bluetooth_Scanner_Detector_h
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol delegator <NSObject>

- (void) metaDelegate:(AVCaptureOutput*)outputObj didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection;

@end

@interface detector : NSObject <delegator>

- (void) initSession;

@end

#endif
