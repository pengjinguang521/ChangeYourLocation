//
//  ViewController.m
//  02-经纬度反转
//
//  Created by lin on 15/9/22.
//  Copyright © 2015年 lin. All rights reserved.
//

#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (nonatomic, strong) CLGeocoder *geoCode;

@property (weak, nonatomic) IBOutlet UILabel *latitudeText;
@property (weak, nonatomic) IBOutlet UITextField *locationAddress;
@property (weak, nonatomic) IBOutlet UILabel *longatitudeText;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;


@end

@implementation ViewController

- (CLGeocoder *)geoCode {
    if (_geoCode == nil) {
        _geoCode = [[CLGeocoder alloc] init];
    }
    return _geoCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationAddress.text = @"上海金桥现代产业服务园区";
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)locationToDegree:(id)sender {
    
    [self.geoCode geocodeAddressString:self.locationAddress.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
             //NSLog(@"%@",placemarks);
            CLPlacemark *placeMark = [placemarks firstObject];
            
            self.latitudeText.text =[NSString stringWithFormat:@"%f",  placeMark.location.coordinate.latitude];
            
            self.longatitudeText.text = [NSString stringWithFormat:@"%f",  placeMark.location.coordinate.longitude];
            
            self.detailAddress.text = placeMark.name;
            
             [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 NSLog(@"%@",obj.name);
             }];
            
        }else  {
            NSLog(@"%@",error);
        }
    }];
}

- (IBAction)degreeToLocation:(id)sender {
    // 异步请求 转圈  菊花
    CLLocation *location= [[CLLocation alloc] initWithLatitude:31.57 longitude:120.90];
    [self.geoCode reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            //NSLog(@"%@",placemarks);
            CLPlacemark *placeMark = [placemarks firstObject];
            
            self.latitudeText.text =[NSString stringWithFormat:@"%f",  placeMark.location.coordinate.latitude];
            
            self.longatitudeText.text = [NSString stringWithFormat:@"%f",  placeMark.location.coordinate.longitude];
            
            //self.detailAddress.text = placeMark.name;
            
            //获取城市信息
            self.detailAddress.text =[NSString stringWithFormat:@"%@---%@", placeMark.locality,placeMark.subLocality];
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj.name);
            }];
            
        }else  {
            NSLog(@"%@",error);
            self.detailAddress.text = @"你要找的地址在地球上不存在";
        }
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
