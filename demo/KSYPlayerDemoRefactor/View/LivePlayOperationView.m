//
//  LivePlayOperationView.m
//  KSYPlayerDemo
//
//  Created by devcdl on 2017/9/12.
//  Copyright © 2017年 kingsoft. All rights reserved.
//

#import "LivePlayOperationView.h"
#import "UpdateVolumeAndBrightView.h"
#import "VideoModel.h"

@interface LivePlayOperationView ()
@property (nonatomic, strong) UIView             *aTopMaskView;
@property (nonatomic, strong) UIButton           *backButton;
@property (nonatomic, strong) UIButton           *screenShotButton;
@property (nonatomic, strong) UIButton           *screenRecordButton;

@property (nonatomic, strong) UIButton           *mirrorImageButton;
@property (nonatomic, strong) UIButton           *pictureRotateButton;
@property (nonatomic, strong) UIButton           *volumeButton;
@property (nonatomic, strong) UIButton           *praiseButton;

@property (nonatomic, strong) UILabel            *videoTitleLab;
@property (nonatomic, strong) VideoModel *videoModel;
@end

@implementation LivePlayOperationView

- (instancetype)initWithVideoModel:(VideoModel *)videoModel {
    if (self = [super init]) {
        _videoModel = videoModel;
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"LivePlayOperationView dealloced");
}

- (void)setFullScreen:(BOOL)fullScreen {
    _fullScreen = fullScreen;
    [self updateConstraintsHandler];
//    self.aTopMaskView.hidden = !fullScreen;
}

- (void)tapFullScreenMaskViewHandler {
    
}

#pragma mark --
#pragma mark -- UI metohd

- (void)setupUI {
//    [self addSubview:self.aTopMaskView];
    [self addSubview:self.backButton];
    [self addSubview:self.videoTitleLab];
    [self addSubview:self.screenShotButton];
    [self addSubview:self.screenRecordButton];
    [self addSubview:self.mirrorImageButton];
    [self addSubview:self.pictureRotateButton];
    [self addSubview:self.volumeButton];
    [self addSubview:self.praiseButton];
    [self configeConstraints];
}

- (UIView *)aTopMaskView {
    if (!_aTopMaskView) {
        _aTopMaskView = [[UIView alloc] init];
        _aTopMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _aTopMaskView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _backButton;
}

- (UIButton *)screenShotButton {
    if (!_screenShotButton) {
        _screenShotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_screenShotButton setImage:[UIImage imageNamed:@"screenShot"] forState:UIControlStateNormal];
        [_screenShotButton addTarget:self action:@selector(screenShotHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenShotButton;
}

- (UIButton *)screenRecordButton {
    if (!_screenRecordButton) {
        _screenRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_screenRecordButton setImage:[UIImage imageNamed:@"screenRecord"] forState:UIControlStateNormal];
        [_screenRecordButton addTarget:self action:@selector(screenRecordHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenRecordButton;
}

- (UIButton *)mirrorImageButton {
    if (!_mirrorImageButton) {
        _mirrorImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mirrorImageButton setImage:[UIImage imageNamed:@"mirror"] forState:UIControlStateNormal];
        [_mirrorImageButton addTarget:self action:@selector(mirrorHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mirrorImageButton;
}

- (UIButton *)pictureRotateButton {
    if (!_pictureRotateButton) {
        _pictureRotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pictureRotateButton setImage:[UIImage imageNamed:@"rotate"] forState:UIControlStateNormal];
        [_pictureRotateButton addTarget:self action:@selector(pictureRotateHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pictureRotateButton;
}

- (UIButton *)volumeButton {
    if (!_volumeButton) {
        _volumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_volumeButton setImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
        [_volumeButton addTarget:self action:@selector(volumeAdjustHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _volumeButton;
}

- (UIButton *)praiseButton {
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseButton setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        [_praiseButton addTarget:self action:@selector(praiseHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

- (UILabel *)videoTitleLab {
    if (!_videoTitleLab) {
        _videoTitleLab = [[UILabel alloc] init];
        _videoTitleLab.font = [UIFont systemFontOfSize:14];
        _videoTitleLab.textColor = [UIColor whiteColor];
        _videoTitleLab.textAlignment = NSTextAlignmentLeft;
        _videoTitleLab.text = _videoModel.VideoTitle;
    }
    return _videoTitleLab;
}

#pragma mark ------
#pragma mark - button clicked event

- (void)backAction {
    UIViewController *controller = nil;
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            controller = (UIViewController *)nextResponder;
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller popViewControllerAnimated:YES];
    } else {
        [controller.navigationController popViewControllerAnimated:YES];
    }
}

- (void)screenShotHandler {
    if (self.screenShotBlock) {
        self.screenShotBlock();
    }
}

- (void)screenRecordHandler {
    if (self.screenRecordeBlock) {
        self.screenRecordeBlock();
    }
}

- (void)mirrorHandler {
    if (self.mirrorBlock) {
        self.mirrorBlock();
    }
}

- (void)pictureRotateHandler {
    if (self.pictureRotateBlock) {
        self.pictureRotateBlock();
    }
}

- (void)volumeAdjustHandler {
    
}

- (void)praiseHandler {
    if (self.praiseBlock) {
        self.praiseBlock();
    }
}

#pragma mark --------
#pragma mark - confige constraints

- (void)configeConstraints {
//    [self.aTopMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.leading.top.trailing.equalTo(self);
//        make.height.mas_equalTo(57);
//    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self);
        make.width.height.mas_equalTo(60);
    }];
    [self.videoTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(31);
        make.centerY.equalTo(self.backButton);
    }];
    
    [self.screenRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-6);
        make.bottom.equalTo(self.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.mirrorImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-6);
        make.top.equalTo(self.mas_centerY).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.screenShotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-6);
        make.bottom.equalTo(self.screenRecordButton.mas_top).offset(-30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.pictureRotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-6);
        make.top.equalTo(self.mirrorImageButton.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(-6);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.volumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.praiseButton);
        make.right.equalTo(self.praiseButton.mas_left).offset(-23);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

- (void)updateConstraintsHandler {
//    [self.aTopMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_top);
//    }];

    if (_fullScreen) {
        [self.screenRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.top.equalTo(self.mas_centerY).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.mirrorImageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(6);
            make.centerY.equalTo(self.screenShotButton);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.screenShotButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.bottom.equalTo(self.mas_centerY).offset(-15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.pictureRotateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(6);
            make.centerY.equalTo(self.screenRecordButton);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    } else {
        [self.screenRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.bottom.equalTo(self.mas_centerY).offset(-15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.mirrorImageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.top.equalTo(self.mas_centerY).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.screenShotButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.bottom.equalTo(self.screenRecordButton.mas_top).offset(-30);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self.pictureRotateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.top.equalTo(self.mirrorImageButton.mas_bottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
}

@end