//
//  ViewController.m
//  FoodRate
//
//  Created by soedar on 6/10/12.
//  Copyright (c) 2012 PlayHealth. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "ProductDescriptionController.h"

@interface ViewController ()

@property ZBarReaderViewController *zbarController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchZBar:(id)sender
{
    self.zbarController = [ZBarReaderViewController new];
    self.zbarController.readerDelegate = self;
    
    [self.zbarController.scanner setSymbology: ZBAR_QRCODE
                          config: ZBAR_CFG_ENABLE
                              to: 0];
    self.zbarController.readerView.zoom = 1.0;
    
    [self presentViewController:self.zbarController animated:YES completion:nil];
}

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

- (void) processBarCode:(ZBarSymbol*)barcode
{
    NSURL *url = [NSURL URLWithString:[self buildRequestUrl:barcode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    ProductDescriptionController *productController = [[ProductDescriptionController alloc] initWithRequest:request];
    
    [self.zbarController dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:productController animated:YES completion:nil];
    }];
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
    
    return requestUrl;
}

- (BOOL) barcodeIsSupported:(ZBarSymbol*)barcode
{
    return (barcode.type == ZBAR_UPCA || barcode.type == ZBAR_UPCE ||
            barcode.type == ZBAR_EAN8 || barcode.type == ZBAR_EAN13);
}

@end