//
//  SYAShortVideoRecordViewController.m
//  SYAShortVideoWithSocial
//
//  Created by 乐家 on 2017/11/15.
//  Copyright © 2017年 lejiakeji. All rights reserved.
//

#import "SYAShortVideoRecordViewController.h"
#import "SYANoHighlightButton.h"
#import "SYARecorderFuncationSelectView.h"
#import "SYARecordTopToolContentView.h"
#import "SYARecordBottomToolContentView.h"
#import "SYARecorderFilterContentView.h"
#import "SYARecordFilterModel.h"
#import <MJExtension/MJExtension.h>
// 七牛
#import <PLShortVideoKit/PLShortVideoKit.h>
#import "PLSProgressBar.h"
#import "PLSDeleteButton.h"
//#import "EditViewController.h"
#import <Photos/Photos.h>
//#import "PhotoAlbumViewController.h"
#import "PLSEditVideoCell.h"
#import "PLSFilterGroup.h"
#import "PLSViewRecorderManager.h"
#import "PLSRateButtonView.h"
// KiWi
//#import "FaceTracker.h"
//#import "KWRenderManager.h"
//#import "Global.h"
//#import "KWUIManager.h"
@interface SYAShortVideoRecordViewController ()
<
PLShortVideoRecorderDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
PLSViewRecorderManagerDelegate,
PLSRateButtonViewDelegate
>
@property (nonatomic, weak) SYARecordBottomToolContentView *bottomRecordToolContentView;
@property (nonatomic, weak) SYANoHighlightButton *multiplePreBtn;
/** 滤镜 */
@property (nonatomic, strong) SYARecorderFilterContentView *filterContentView;
/** 滤镜模型 */
@property (nonatomic, strong) NSMutableArray <SYARecordFilterModel *>*filterModelArray;
// 视频录制
@property (nonatomic, strong) PLSVideoConfiguration *videoConfiguration;
@property (nonatomic, strong) PLSAudioConfiguration *audioConfiguration;
@property (nonatomic, strong) PLShortVideoRecorder *shortVideoRecorder;
@property (strong, nonatomic) PLSViewRecorderManager *viewRecorderManager;

// 录制前是否开启自动检测设备方向调整视频拍摄的角度（竖屏、横屏）
@property (assign, nonatomic) BOOL isUseAutoCheckDeviceOrientationBeforeRecording;
// 录制时是否使用滤镜
@property (assign, nonatomic) BOOL isUseFilterWhenRecording;
// 所有滤镜
@property (strong, nonatomic) PLSFilterGroup *filterGroup;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *filtersArray;
@end

@implementation SYAShortVideoRecordViewController

- (SYARecorderFilterContentView *)filterContentView {
    if (!_filterContentView) {
        _filterContentView = [[SYARecorderFilterContentView alloc] initWithFrame:CGRectMake(0, AppHeight - 71 - 60, AppWidth, 71+60)];
        [self.view addSubview:_filterContentView];
    }
    return _filterContentView;
}

- (NSMutableArray<SYARecordFilterModel *> *)filterModelArray {
    if (!_filterModelArray) {
        _filterModelArray = [NSMutableArray array];
    }
    return _filterModelArray;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 录制时默认关闭滤镜
        self.isUseFilterWhenRecording = YES;
        // 录制前默认打开自动检测设备方向调整视频拍摄的角度（竖屏、横屏）,项目只支持竖屏
//        self.isUseAutoCheckDeviceOrientationBeforeRecording = YES;
        if (self.isUseFilterWhenRecording) {
            // 滤镜
            self.filterGroup = [[PLSFilterGroup alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shortVideoRecorder startCaptureSession];
    self.navigationController.navigationBar.hidden = YES;
    // 默认打开美颜
    [self.shortVideoRecorder setBeautifyModeOn:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.shortVideoRecorder stopCaptureSession];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadView {
    [super loadView];
    [self setupShortVideoRecorder];
}



- (void)setupBaseUI {
    CGFloat topSpace = 20;
    if (AppHeight == 812) {
        topSpace = 44;
    }
    @weakify(self);
    // 头部工具栏
    SYARecordTopToolContentView *topRecordToolContentView = [[SYARecordTopToolContentView alloc] initWithFrame:CGRectMake(0, topSpace, AppWidth, 44)];
    [self.view addSubview:topRecordToolContentView];
    topRecordToolContentView.backBtnBlock = ^(){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    topRecordToolContentView.switchCameraBtnBlock = ^(){
        @strongify(self);
        [self.shortVideoRecorder toggleCamera];
    };
    topRecordToolContentView.nextStepBtnBlock = ^(){
        
    };

    // 右边工具栏
    SYARecorderFuncationSelectView *recorderFouncationView = [[SYARecorderFuncationSelectView alloc] initWithFrame:CGRectMake(AppWidth - 65, CGRectGetMaxY(topRecordToolContentView.frame)+40, 45, 60*3 + 20*2) titleArray:@[@[@"recorderBeauty",@"美颜开"],@[@"recorderFilter",@"滤镜"],@[@"recorderCountDown",@"倒计时"]]];
    recorderFouncationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:recorderFouncationView];
    recorderFouncationView.beautyBtnBlock = ^(BOOL isOpen){
        if (isOpen) {
            [self.shortVideoRecorder setBeautifyModeOn:YES];
        } else {
            [self.shortVideoRecorder setBeautifyModeOn:NO];
        }
    };
    recorderFouncationView.filterBtnBlock = ^(BOOL isOpen){
        if (isOpen) {
            self.bottomRecordToolContentView.hidden = YES;
            self.filterContentView.hidden = NO;
            self.filterContentView.filterModelArray = self.filterModelArray;
            self.filterContentView.filterGroup = self.filterGroup;
        } else {
            self.bottomRecordToolContentView.hidden = NO;
            self.filterContentView.hidden = YES;
        }
    };
    recorderFouncationView.timeBtnBlock = ^(){
        
    };
    // 底部倍数拍摄工具栏view
    SYARecordBottomToolContentView *bottomRecordToolContentView = [[SYARecordBottomToolContentView alloc] initWithFrame:CGRectMake(0, AppHeight - 140, AppWidth, 140)];
    [self.view addSubview:bottomRecordToolContentView];
    self.bottomRecordToolContentView = bottomRecordToolContentView;
}

- (void)setupShortVideoRecorder {
    // SDK 的版本信息
    self.videoConfiguration = [PLSVideoConfiguration defaultConfiguration];
    self.videoConfiguration.position = AVCaptureDevicePositionFront;
    self.videoConfiguration.videoFrameRate = 25;
    self.videoConfiguration.averageVideoBitRate = 1024*1000;
    self.videoConfiguration.videoSize = CGSizeMake(544, 960);
    self.videoConfiguration.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    self.audioConfiguration = [PLSAudioConfiguration defaultConfiguration];
    
    self.shortVideoRecorder = [[PLShortVideoRecorder alloc] initWithVideoConfiguration:self.videoConfiguration audioConfiguration:self.audioConfiguration];
    self.shortVideoRecorder.delegate = self;
    self.shortVideoRecorder.maxDuration = 10.0f; // 设置最长录制时长
    self.shortVideoRecorder.outputFileType = PLSFileTypeMPEG4;
    self.shortVideoRecorder.innerFocusViewShowEnable = YES; // 显示 SDK 内部自带的对焦动画
    self.shortVideoRecorder.previewView.frame = CGRectMake(0, 0, AppWidth, AppHeight);
    [self.view addSubview:self.shortVideoRecorder.previewView];

    // 默认关闭内部滤镜
    if (self.isUseFilterWhenRecording) {
        NSMutableArray *tempArray = [NSMutableArray array];
        // 滤镜资源
        self.filtersArray = [[NSMutableArray alloc] init];
        for (NSDictionary *filterInfoDic in self.filterGroup.filtersInfo) {
            NSString *name = [filterInfoDic objectForKey:@"name"];
            NSString *coverImagePath = [filterInfoDic objectForKey:@"coverImagePath"];

            NSDictionary *dic = @{
                                  @"name"            : name,
                                  @"coverImagePath"  : coverImagePath
                                  };
            [self.filtersArray addObject:dic];
            
            NSDictionary *filterDict = @{
                                        @"imageName" : coverImagePath ,
                                        @"filterName" : name,
                                            @"isSelected" : @0
                                         };
            [tempArray addObject:filterDict];
        }
        self.filterModelArray = [SYARecordFilterModel mj_objectArrayWithKeyValuesArray:tempArray];
    }
}

- (void)multipleBtnClick:(SYANoHighlightButton *)btn {
    NSInteger index = btn.tag;
    btn.selected = !btn.selected;
    if (self.multiplePreBtn != btn) {
        self.multiplePreBtn.selected = NO;
    } else {
        self.multiplePreBtn.selected = YES;
    }
    
    self.multiplePreBtn = btn;
}

#pragma mark -- PLShortVideoRecorderDelegate 摄像头／麦克风鉴权的回调
- (void)shortVideoRecorder:(PLShortVideoRecorder *__nonnull)recorder didGetCameraAuthorizationStatus:(PLSAuthorizationStatus)status {
    if (status == PLSAuthorizationStatusAuthorized) {
        [recorder startCaptureSession];
    }
    else if (status == PLSAuthorizationStatusDenied) {
        NSLog(@"Error: user denies access to camera");
    }
}

- (void)shortVideoRecorder:(PLShortVideoRecorder *__nonnull)recorder didGetMicrophoneAuthorizationStatus:(PLSAuthorizationStatus)status {
    if (status == PLSAuthorizationStatusAuthorized) {
        [recorder startCaptureSession];
    }
    else if (status == PLSAuthorizationStatusDenied) {
        NSLog(@"Error: user denies access to microphone");
    }
}

#pragma mark - PLShortVideoRecorderDelegate 摄像头采集的视频数据的回调
/// @abstract 获取到摄像头原数据时的回调, 便于开发者做滤镜等处理，需要注意的是这个回调在 camera 数据的输出线程，请不要做过于耗时的操作，否则可能会导致帧率下降
//- (CVPixelBufferRef)shortVideoRecorder:(PLShortVideoRecorder *)recorder cameraSourceDidGetPixelBuffer:(CVPixelBufferRef)pixelBuffer {
//    //此处可以做美颜/滤镜等处理
//    // 是否在录制时使用滤镜，默认是关闭的，NO
//    if (self.isUseFilterWhenRecording) {
//        PLSFilter *filter = self.filterGroup.currentFilter;
//        pixelBuffer = [filter process:pixelBuffer];
//    }
//
////    /* 横竖屏时更新sdk内置UI 坐标 */
////    [_UIManager resetScreemMode];
//
//
//    UIDeviceOrientation iDeviceOrientation = [[UIDevice currentDevice] orientation];
//    //    BOOL mirrored = !self.kwSdkUI.kwSdk.cameraPositionBack;
//    BOOL mirrored = NO;
//
//    cv_rotate_type cvMobileRotate;
//
//    switch (iDeviceOrientation) {
//        case UIDeviceOrientationPortrait:
//            cvMobileRotate = CV_CLOCKWISE_ROTATE_0;
//            break;
//
//        case UIDeviceOrientationLandscapeLeft:
//            cvMobileRotate = mirrored ?  CV_CLOCKWISE_ROTATE_90: CV_CLOCKWISE_ROTATE_270;
//            break;
//
//        case UIDeviceOrientationLandscapeRight:
//            cvMobileRotate = mirrored ? CV_CLOCKWISE_ROTATE_270 : CV_CLOCKWISE_ROTATE_90;
//            break;
//
//        case UIDeviceOrientationPortraitUpsideDown:
//            cvMobileRotate = CV_CLOCKWISE_ROTATE_180;
//            break;
//
//        default:
//            cvMobileRotate = CV_CLOCKWISE_ROTATE_0;
//            break;
//    }
//
//    /*********** 视频帧渲染 ***********/
//    [KWRenderManager processPixelBuffer:pixelBuffer];
//
//    return pixelBuffer;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
