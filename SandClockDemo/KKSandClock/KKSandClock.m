//
//  KKSandClock.m
//  boboVideo
//
//  Created by apple on 2021/5/26.
//

#import "KKSandClock.h"
#import "SandClockLayer.h"

@interface KKSandClock ()
@property (nonatomic, strong) SandClockLayer *clockLayer;
@end

@implementation KKSandClock

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    self.backgroundColor = [UIColor clearColor];
    //固定48，56
    UIImage *bgImage = [UIImage imageNamed:@"sandclock_bg"];
    self.clockLayer = [[SandClockLayer alloc] initWithFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    [self.layer addSublayer:self.clockLayer];
    self.clockLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.clockLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)startAnimation {
    [self startAnimation];
    self.clockLayer.hidden = NO;
}
- (void)stopAnimation {
    [self stopAnimation];
    self.clockLayer.hidden = YES;
}


@end
