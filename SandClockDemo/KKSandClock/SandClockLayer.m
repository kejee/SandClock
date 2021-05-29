//
//  SandClockLayer.m
//  boboVideo
//
//  Created by apple on 2021/5/26.
//

#import "SandClockLayer.h"

#define ClockColor [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:213/255.0]
#define SandColor [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:213/255.0]
#define AnimationTime 3

@interface SandClockLayer ()
@property (nonatomic, strong) SandBoxTopLayer *topLayer;
@property (nonatomic, strong) SandBoxBottomLayer *bottomLayer;
@property (nonatomic, strong) SandLayer *sandLayer;


@end

@implementation SandClockLayer
//48 56
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    //图片尺寸48,56
    CGFloat topMargin = 3;//背景图片边缘
    CGFloat leftMargin = 7.6;
    CGFloat centerHoleHeight = 1;//中间孔
    CGFloat centerHoleWidth = 2;
    CGFloat sandWidth = centerHoleWidth;//沙子宽
    
    CGFloat boxWidth = self.frame.size.width - leftMargin * 2; //34
    CGFloat boxHeight = (self.frame.size.height - topMargin * 2 - centerHoleHeight)/2; //25

    self.masksToBounds = YES;

    self.topLayer = [[SandBoxTopLayer alloc]initWithFrame:CGRectMake(leftMargin, topMargin, boxWidth, boxHeight)];
    self.bottomLayer = [[SandBoxBottomLayer alloc]initWithFrame:CGRectMake(leftMargin, topMargin+boxHeight+centerHoleHeight, boxWidth, boxHeight)];
    self.sandLayer= [[SandLayer alloc]initWithFrame:CGRectMake((self.frame.size.width-sandWidth)/2, topMargin+boxHeight, sandWidth, boxHeight+centerHoleHeight)];

    [self addSublayer:self.topLayer];
    [self addSublayer:self.bottomLayer];
    [self addSublayer:self.sandLayer];

//    UIImageView *sandImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sandclock_bg"]];
//    [self addSublayer:sandImageView.layer];//ios 13无效
    UIImage *image = [UIImage imageNamed:@"sandclock_bg"];
    self.contents = (__bridge id)image.CGImage;
    
    [self startAnimation];
}


- (void)startAnimation {

    [self.topLayer startAnimation];
    [self.bottomLayer startAnimation];
    [self.sandLayer startAnimation];

    [self removeAllAnimations];

    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc]init];
    animation.keyPath = @"transform.rotation.z";
    animation.keyTimes = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.9],[NSNumber numberWithFloat:1.0]];
    animation.values = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:M_PI]];
    animation.duration = AnimationTime;
    [animation setRemovedOnCompletion:NO];
    animation.repeatCount = MAXFLOAT;
    CAMediaTimingFunction *EaseOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *EaseIn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions=@[EaseOut,EaseOut,EaseOut,EaseIn];
    animation.fillMode = kCAFillModeForwards;

    [self addAnimation:animation forKey:nil];

}

- (void)stopAnimation {
    [self removeAllAnimations];
    [self.topLayer stopAnimation];
    [self.bottomLayer stopAnimation];
    [self.sandLayer stopAnimation];
    
}

@end

#pragma mark - SandBoxTopLayer

@implementation SandBoxTopLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height*2/3)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height*2/3)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    
    CAShapeLayer *sublayer = [[CAShapeLayer alloc]init];
    sublayer.masksToBounds = YES;
    sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    sublayer.path = path.CGPath;
    
    //背景色
//    self.backgroundColor = [UIColor colorWithRed:232/255.0 green:159/255.0 blue:159/255.0 alpha:206/255.0].CGColor;

    self.mask = sublayer;
    
    self.mainLayer = [[CAShapeLayer alloc] init];
    self.mainLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.mainLayer.path = path.CGPath;
    self.mainLayer.fillColor = ClockColor.CGColor;
    
    [self addSublayer:self.mainLayer];
    
}

- (void)startAnimation {
    [self.mainLayer removeAllAnimations];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.keyTimes = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.9],[NSNumber numberWithFloat:1.0]];
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height*1.5)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height*1.5)];
    animation.values = @[v1,v2,v3];
    animation.duration = AnimationTime;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
//    animation.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.85 :0 :1 :1];

    animation.fillMode = kCAFillModeForwards;

    [self.mainLayer addAnimation:animation forKey:nil];
    
}

- (void)stopAnimation {
    [self.mainLayer removeAllAnimations];
}

@end

#pragma mark - SandBoxBottomLayer

@implementation SandBoxBottomLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(self.frame.size.width/2, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/3)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.width)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height/3)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2, 0)];
    [path closePath];
    
    CAShapeLayer *sublayer = [[CAShapeLayer alloc]init];
    sublayer.masksToBounds = YES;
    sublayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    sublayer.path = path.CGPath;
    
    //背景色
//    self.backgroundColor = [UIColor colorWithRed:232/255.0 green:159/255.0 blue:159/255.0 alpha:206/255.0].CGColor;
    
    self.mask = sublayer;
    
    self.mainLayer = [[CAShapeLayer alloc] init];
    self.mainLayer.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.mainLayer.path = path.CGPath;
    self.mainLayer.fillColor = ClockColor.CGColor;
    
    [self addSublayer:self.mainLayer];
    
}

- (void)startAnimation {
    [self.mainLayer removeAllAnimations];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.keyTimes = @[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.9],[NSNumber numberWithFloat:1.0]];
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height*1.5)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    animation.values = @[v1,v2,v3];
    animation.duration = AnimationTime;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
//    animation.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.85 :0 :1 :1];

    animation.fillMode = kCAFillModeForwards;

    [self.mainLayer addAnimation:animation forKey:nil];
    
}

- (void)stopAnimation {
    [self.mainLayer removeAllAnimations];
}

@end

#pragma mark - SandLayer

@implementation SandLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}

- (void)configUI {

    self.masksToBounds = YES;

    self.sand05Layer = [[CALayer alloc]init];
    self.sand05Layer.frame = CGRectMake(1, -3,1,1);
    self.sand05Layer.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand05Layer];

    self.sand05Layer1 = [[CALayer alloc]init];
    self.sand05Layer1.frame=CGRectMake(1, -10,1,2);
    self.sand05Layer1.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand05Layer1];

    self.sand03Layer = [[CALayer alloc]init];
    self.sand03Layer.frame=CGRectMake(0, -10,1,2);
    self.sand03Layer.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand03Layer];

    self.sand03Layer1 = [[CALayer alloc]init];
    self.sand03Layer1.frame=CGRectMake(1, -3,1,1);
    self.sand03Layer1.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand03Layer1];

    self.sand01Layer = [[CALayer alloc]init];
    self.sand01Layer.frame = CGRectMake(0, -3,1,1);
    self.sand01Layer.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand01Layer];

    self.sand01Layer1 = [[CALayer alloc]init];
    self.sand01Layer1.frame = CGRectMake(1, -10,1,2);
    self.sand01Layer1.backgroundColor = SandColor.CGColor;
    [self addSublayer:self.sand01Layer1];

}

- (void)startAnimation{
    [self addAnimation:0.5 WithLayer:self.sand05Layer];
    [self addAnimation:0.5 WithLayer:self.sand05Layer1];
    [self addAnimation:0.3 WithLayer:self.sand03Layer];
    [self addAnimation:0.3 WithLayer:self.sand03Layer1];
    [self addAnimation:0.1 WithLayer:self.sand01Layer];
    [self addAnimation:0.1 WithLayer:self.sand01Layer1];
}

- (void)addAnimation:(CFTimeInterval)duration WithLayer:(CALayer*)layer{
    [layer removeAllAnimations];
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.keyPath = @"position";
    animation.fromValue = [NSValue valueWithCGPoint:layer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(layer.position.x, self.frame.size.height)];
    animation.duration = duration;
    [animation setRemovedOnCompletion:NO];
    animation.repeatCount = MAXFLOAT;
    animation.valueFunction = [CAValueFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:nil];

}

- (void)stopAnimation {
    [self.sand05Layer removeAllAnimations];
    [self.sand05Layer1 removeAllAnimations];
    [self.sand03Layer removeAllAnimations];
    [self.sand03Layer1 removeAllAnimations];
    [self.sand01Layer removeAllAnimations];
    [self.sand01Layer1 removeAllAnimations];
}

@end
