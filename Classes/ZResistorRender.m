#import "ZResistorRender.h"


@implementation ZResistorRender

@synthesize resistor;

- (id) initWithCoder: (NSCoder*) coder {
    self = [super initWithCoder: coder];
    printf("init coder called\n");
    return self;
}

- (id) initWithResistor: (ZResistor*) _res {
    resistor = _res;
    return self;
}

// RGB colors for the color bands
static struct { int r, g, b; } __zcolor_rgb[] = {
    {0, 0, 0},
    {101, 67, 33},
    {224, 36, 16},
    {255, 127, 0},
    {255, 255, 0},
    {34, 139, 34},
    {0, 0, 203},
    {148, 0, 211},
    {128, 128, 128},
    {255, 255, 255},
    {212, 175, 55},
    {192, 192, 192}
};

// define relative scale to ensure that resistor can be drawn to custom sizes
static float __scale[] = {0.40f, 0.55f, 0.70f, 0.85f};
static float __scale_width = 0.07f;

// Fill resistor background color with gradient
static void __fill_resistor(CGContextRef ctx, CGRect rect) {
    CGFloat comp[] = {0.73, 0.77, 0.81, 1.0,  // Start color
                      0.56, 0.61, 0.67, 1.0};
    CGFloat loca[] = {0.0, 1.0};
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gr = CGGradientCreateWithColorComponents(cs, comp, loca, 2);
    CGPoint startP = {rect.origin.x, rect.origin.y};
    CGPoint endP = {rect.origin.x, rect.origin.y + rect.size.height};
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, gr, startP, endP, 0);
    CGContextRestoreGState(ctx);
}

// Determine boundaries of a color band
static CGRect __get_colorband_frame(int idx, CGRect rect) {
    int x = rect.origin.x;
    int y = rect.origin.y;
    int width = rect.size.width;
    int height = rect.size.height;

    return CGRectMake(x + width * __scale[idx], y, width * __scale_width, height);
}

// Fill each color band with the correct color based on color id
static void __fill_resistor_color(CGContextRef ctx, CGRect rect, ZResistor* res) {
    for (int i = 0; i < 4; i++)
    {
        ZColor* col = [res getColor: i];
        CGRect r = __get_colorband_frame(i, rect);
        if (col != nil) 
        {
            int cid = [col getColorId];
            CGContextSetRGBFillColor(ctx, __zcolor_rgb[cid].r * 1.0 / 255,
                                     __zcolor_rgb[cid].g * 1.0 / 255,
                                     __zcolor_rgb[cid].b * 1.0 / 255, 1.0);
            CGContextFillRect(ctx, r);
        } 
        else
        {
            CGContextStrokeRect(ctx, r);
        }
    }
}

UIColor* ZColorGetUIColor(ZColor* color) {
    return ColorGetUIColor([color getColorId]);
}

UIColor* ColorGetUIColor(int color) {
    return [UIColor colorWithRed: __zcolor_rgb[color].r * 1.0 / 255 
                           green: __zcolor_rgb[color].g * 1.0 / 255 
                            blue: __zcolor_rgb[color].b * 1.0 / 255 
                           alpha: 1.0];
}

- (CGRect) getColorBandPosition: (int) idx {
    return __get_colorband_frame(idx, [self frame]);
}

// Draws the resistor on screen
- (void) drawRect : (CGRect) rect {
    int x = [self bounds].origin.x;
    int y = [self bounds].origin.y;
    int height = [self bounds].size.height;
    int width  = [self bounds].size.width;

    // create the resistor shape
    CGRect resRect = CGRectMake(x + 5, y + 1, width - 10, height - 2);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0);
    
    // draw resistor and border
    CGContextAddRect(ctx, resRect);
    CGContextStrokePath(ctx);

    CGContextAddRect(ctx, resRect);
    __fill_resistor(ctx, resRect);
    
    // draw resistor leads on left and right
    CGContextMoveToPoint(ctx, x, y + height / 2);
    CGContextAddLineToPoint(ctx, x + 5, y + height / 2);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, x + width, y + height / 2);
    CGContextAddLineToPoint(ctx, x + width - 5, y + height / 2);
    CGContextStrokePath(ctx);

    // fill color bands
    __fill_resistor_color(ctx, resRect, resistor);
    
}

- (void) release {
    if ([self retainCount] == 1)
    {
        [resistor release];
    }
    [super release];
}

@end
