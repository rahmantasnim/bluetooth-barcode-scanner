//
//  Detector.m
//  Bluetooth Scanner
//
//  Created by Death on 7/24/15.
//  Copyright (c) 2015 rahman-berra. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import "Detector.h"

@implementation detector

- (void) metaDelegate:(AVCaptureOutput*)outputObj didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *foundBarcode = nil;
    UIAlertController* alert;
    UIAlertAction* defaultAction;
    
    for (AVMetadataObject *obj in metadataObjects) {
        // is it a barcode (not a face)
        if (![obj.type isEqualToString:@"AVMetadataObjectTypeFace"]) {
            foundBarcode = [(AVMetadataMachineReadableCodeObject *)obj stringValue];
        }
        if (foundBarcode != nil) {
            // --------- Display Alert ---------- //
            alert = [UIAlertController alertControllerWithTitle:@"Found Barcode" message:foundBarcode preferredStyle:UIAlertControllerStyleAlert];
            defaultAction = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction *handleSend) {}];
        }
    }
}

- (void) initSession {
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    NSError *error = nil;
    
    // --------- Input ---------- //
    
    // try to use back facing camera
    AVCaptureDevice *videoCamera;
    AVCaptureDevicePosition desiredPosition = AVCaptureDevicePositionBack;

    for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([d position] == desiredPosition) {
            videoCamera = d;
            break;
        }
    }
    // get default camera
    if(!videoCamera)
    {
        videoCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    // set input
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCamera error:&error];
    if(error == nil) {
        if ([captureSession canAddInput:videoInput]){
            [captureSession addInput:videoInput];
        }
    }
    
    // --------- Output ---------- //
    
    // create video feed output
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    CGRect  viewRect = [[UIScreen mainScreen] bounds];
    UIView *aView = [[UIView alloc] initWithFrame:viewRect];
    previewLayer.frame = aView.bounds;
    
    // get barcode (metadata) output
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    dispatch_queue_t barcodeQueue;
    barcodeQueue = dispatch_queue_create("com.rahman-berra.barcodeQueue", NULL);
    [metadataOutput setMetadataObjectsDelegate:(NSObject<delegator>) queue:barcodeQueue];
    
    [captureSession startRunning];

}
@end
