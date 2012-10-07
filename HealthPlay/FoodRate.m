//
//  FoodRate.m
//  HealthPlay
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "FoodRate.h"
#import "Constants.h"
#import "ProductDescriptionController.h"

@interface FoodRate ()
@end

@implementation FoodRate

- (id) initWithDelegate:(id<FoodRateDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (ZBarReaderViewController*) zbarController
{
    if (!_zbarController) {
        _zbarController = [ZBarReaderViewController new];
        _zbarController.readerDelegate = self;
        
        [_zbarController.scanner setSymbology: ZBAR_QRCODE
                                       config: ZBAR_CFG_ENABLE
                                           to: 0];
        _zbarController.readerView.zoom = 1.0;
    }
    
    return _zbarController;
}

- (void) processBarCode:(ZBarSymbol*)barcode
{
    NSURL *url = [NSURL URLWithString:[self buildRequestUrl:barcode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.delegate barcodeDetected:barcode urlRequest:request];
}

- (NSString*) buildRequestUrl:(ZBarSymbol*)barcode
{
    NSString *apiKey = [NSString stringWithFormat:@"apikey=%@", FOODUCATE_API_KEY];
    NSString *reason = @"reason=scan";
    NSString *upc = [NSString stringWithFormat:@"upc=%@", barcode.data];
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@&%@&%@",
                            FOODUCATE_PRODUCT_URL,
                            reason,
                            upc,
                            apiKey];
    NSLog(requestUrl);
    return requestUrl;
}

- (BOOL) barcodeIsSupported:(ZBarSymbol*)barcode
{
    return (barcode.type == ZBAR_UPCA || barcode.type == ZBAR_UPCE ||
            barcode.type == ZBAR_EAN8 || barcode.type == ZBAR_EAN13);
}

#pragma mark Delegate for the barcode scanner

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *barcodeToProcess = nil;
    for (id barcode in results) {
        if ([barcode isKindOfClass:[ZBarSymbol class]]) {
            if ([self barcodeIsSupported:(ZBarSymbol*)barcode]) {
                barcodeToProcess = (ZBarSymbol*)barcode;
                break;
            }
        }
    }
    
    [self processBarCode:barcodeToProcess];
}

@end
