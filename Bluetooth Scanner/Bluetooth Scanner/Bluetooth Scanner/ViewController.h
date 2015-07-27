//
//  ViewController.h
//  Bluetooth Scanner
//
//  Created by Death on 7/17/15.
//  Copyright (c) 2015 rahman-berra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol delegator <NSObject>

- (void) metaDelegate:(AVCaptureOutput*)outputObj didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection;

@end

@interface ViewController : UIViewController

    - (void) initSession;

@end

