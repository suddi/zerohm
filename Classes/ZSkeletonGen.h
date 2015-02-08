#import <Foundation/Foundation.h>
#import "ZResistor.h"
#import "ZResistorRender.h"

#define MAX_RENDER_SIZE 16
#define MAX_SEG_SIZE 3
#define MAX_ALTERNATIVE_SIZE 6

@interface ZSkeletonGen : UIView {
    ZResistorRender* renders[MAX_RENDER_SIZE];
    ZResistor* alternatives[MAX_ALTERNATIVE_SIZE];
    int segSize[MAX_SEG_SIZE];
    int segCount;
    double target;
}

// generate the resistor template
- (void) generate: (double) scale multiplier: (int) mult;

// validate answer
- (BOOL) validate;

// find the right resistor render object according to location
- (ZResistorRender*) findResistorRender: (CGPoint)  p;

// generate possible resistors for user to use
- (ZResistor*) getAlternative: (int) idx;

@end

// generate a valid resistor that a resistor template can be made for
ZResistor* ZSkeletonGenerateResistor(double scale, int mult);
