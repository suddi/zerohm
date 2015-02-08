#import <Foundation/Foundation.h>

#import "ZColor.h"

@interface ZResistor : NSObject {
    ZColor* colors[4]; // resistor always have 4 color strips, we just hard code it 
}

- (id) init;
- (void) release;

// defines the four color bands on the resistor
- (int) firstValue;
- (int) secondValue;
- (int) multiplier;
- (NSString*) tolerance;

- (ZColor*) getColor: (int) idx;
- (BOOL) removeColor: (int) idx;
- (BOOL) isNullColor: (int) idx;
- (void) setColor: (ZColor*) color index: (int) idx;

- (BOOL) isFull;
- (NSString*) resistorString;
- (NSString*) conveyorString;

@end

void InitializeGenerator();
ZResistor* GenerateResistor();
