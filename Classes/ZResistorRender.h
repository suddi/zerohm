#import <Foundation/Foundation.h>

#import "ZResistor.h"

@interface ZResistorRender : UIView {
    ZResistor* resistor;
}

- (id) initWithResistor: (ZResistor*) res;
- (CGRect) getColorBandPosition: (int) idx;

@property (assign)  ZResistor* resistor;

@end

UIColor* ColorGetUIColor(int color);
UIColor* ZColorGetUIColor(ZColor* color);

