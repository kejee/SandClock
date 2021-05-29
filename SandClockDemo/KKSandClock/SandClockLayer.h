//
//  SandClockLayer.h
//  boboVideo
//
//  Created by apple on 2021/5/26.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SandClockLayer : CALayer
- (instancetype)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
@end

#pragma mark - SandBoxTopLayer

@interface SandBoxTopLayer : CALayer
@property (nonatomic, strong) CAShapeLayer *mainLayer;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
@end

#pragma mark - SandBoxBottomLayer

@interface SandBoxBottomLayer : CALayer
@property (nonatomic, strong) CAShapeLayer *mainLayer;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
@end

#pragma mark - SandLayer

@interface SandLayer : CALayer
@property (nonatomic, strong) CALayer *sand05Layer;
@property (nonatomic, strong) CALayer *sand05Layer1;

@property (nonatomic, strong) CALayer *sand03Layer;
@property (nonatomic, strong) CALayer *sand03Layer1;

@property (nonatomic, strong) CALayer *sand01Layer;
@property (nonatomic, strong) CALayer *sand01Layer1;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
