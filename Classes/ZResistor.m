#import "ZResistor.h"

@implementation ZResistor

- (id) init {
    memset(colors, 0, sizeof(ZColor*) * 4);
    return self;
}

- (int) firstValue {
    return [colors[0] numeric];
}

- (int) secondValue {
    return [colors[1] numeric];
}

- (int) multiplier {
    return [colors[2] multiplier];
}

- (NSString*) tolerance {
    if (colors[3] == nil)
        return @"20%";
    return [colors[3] tolerance];
}

- (ZColor*) getColor: (int) idx {
    return colors[idx];
}

- (BOOL) removeColor: (int) idx {
    if (colors[idx] == nil)
    {
        return NO;
    }
    [colors[idx] release];
    colors[idx] = nil;
    return YES;
}

- (BOOL) isNullColor: (int) idx {
    return colors[idx] == nil;
}

- (void) setColor: (ZColor*) color index: (int) idx {
    colors[idx] = color;
}

- (BOOL) isFull {
    for (int i = 0; i < 4; i++)
    {
        if (colors[i] == nil)
        {
            return NO;
        }
    }
    return YES;
}

- (void) release {
    if ([self retainCount] == 1) 
    {
        for (int i = 0; i < 4; i++) 
        {
            if (colors[i] != nil)
            {
                [colors[i] release];
            }
        }
    }
    [super release];
}

// generate formatted string to display the resistor value in the UI
- (NSString*) resistorString {
    NSString* finalString;
    // don't show scientific notcation if 10^0
    if([self multiplier] == 0) 
    {
        finalString = [NSString stringWithFormat:@"%d.%d \u03A9 \u00B1 %@",[self firstValue], 
                       [self secondValue],[self tolerance]];
    }
    else 
    {    
        finalString = [NSString stringWithFormat:@"%d.%d x 10^%d \u03A9 \u00B1 %@",
                       [self firstValue], [self secondValue],[self multiplier],[self tolerance]];
    }
    
    return finalString;
}

-(NSString*) conveyorString {
        NSString* finalString;
        // don't show scientific notcation if 10^0
        if([self multiplier] == 0) 
        {
            finalString = [NSString stringWithFormat:@"%d.%d \u03A9",[self firstValue], 
                           [self secondValue]];
        }
        else 
        {    
            finalString = [NSString stringWithFormat:@"%d.%d x 10^%d \u03A9",
                           [self firstValue], [self secondValue],[self multiplier]];
        }
        return finalString;
}        
@end



