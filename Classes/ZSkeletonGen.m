#import <stdlib.h>
#import <stdio.h>
#import <string.h>

#import "ZSkeletonGen.h"

#define MAX_BASE 3

/*
 * each parallel unit is called a segment
 * in order to make it easier to calculate. all resistor inside the segment
 * is a fraction and the numerator of that value is called top, the
 * denominator is called base. The numerator of all those
 * resistors are the same, this make it easier for the user to calculate
 */
typedef struct {
    int    top;
    int    base[MAX_BASE];
    size_t sz;
} __segment_t;

/*
 * this is the key to making calculations easy.  
 * in each segment, we'll make the sum of base or
 * denominator to be 10. this make it easier for the user to divide
 */
static void __fill_random_segment(__segment_t* seg) {
    int idx = rand() % 3;

    switch (idx) {
    case 0:
    case 1:
        seg->sz = 2;
        seg->base[0] = seg->base[1] = 5;
        break;
    case 2:
        seg->sz = 1;
        seg->base[0] = 10;
        break;
    }
}

/* randomly generate all segments. the sum of segment is equal to num */
static size_t __create_all_segment(int num, __segment_t segment[]) {
    // split up total into sum
    int r = rand() % 10;
    if (r == 0) 
    {
        // don't split
        segment[0].top = num;
        do 
        {
            __fill_random_segment(&segment[0]);
        } 
        while (segment[0].sz == 1);
        
        return 1;
    } 
    else if (r > 0 && r < 5)
    {
        //split into two
        int half = num / 2;
        segment[0].top = rand() % half + half / 2;
        segment[1].top = num - segment[0].top;
        __fill_random_segment(&segment[0]);
        __fill_random_segment(&segment[1]);
        return 2;
    } 
    else 
    {
        //split into three
        int part = num / 3;
        segment[0].top = rand() % part + part / 2;
        segment[1].top = rand() % part + part / 2;
        segment[2].top = num - segment[0].top - segment[1].top;
        __fill_random_segment(&segment[0]);
        __fill_random_segment(&segment[1]);
        __fill_random_segment(&segment[2]);
        return 3;
    }
}

/* determine if two doubles are greater than, less than, or equal */
static int __doublecmp(const void* a, const void* b) {
    const double* p = a;
    const double* q = b;
    if (*(p) > (*q))
    {
        return 1;
    }
    else if (*(p) < (*q))
    {
        return -1;
    }
    else
    {
        return 0;
    }
}

/* sort all alternatives, and remove the equal values inside */
static size_t __sort_and_trim(double arr[], size_t sz)
{
    qsort(arr, sz, sizeof(double), __doublecmp);
    int i;
    for (i = 1; i < sz; i++) 
    {
        if (arr[i] == arr[i - 1])
        {
            memmove(&arr[i - 1], &arr[i], (sz - i) * sizeof(double));
            i--;
            sz--;
        }
    }
    return sz;
}

/*
 * build the resistor from double value, where b is the multiplier.
 * (i.e. the resistor value we're building is value * 10 ^ b)
 */
static ZResistor* __build_resistor(double value, int b) {
    int first, second, mult;
    if (value >= 10.0) 
    {
        first = ((int) value) / 10;
        second = ((int) value) % 10;
        mult = b + 1;
    } 
    else if (value >= 1.0)
    {
        first = ((int) value);
        second = (int) (value * 10) % 10;
        mult = b;
    } 
    else
    {
        first = (int) (value * 10);
        second = 0;
        mult = b - 1;
    }
    printf("%lf %d %d %d\n", value, first, second, mult);
    ZResistor* res = [[ZResistor alloc] init];
    [res setColor: [ZColor createColorWithNumeric: first] index: 0];
    [res setColor: [ZColor createColorWithNumeric: second] index: 1];
    [res setColor: [ZColor createColorWithMultiplier: mult] index: 2];
    [res setColor: [ZColor createColor: ZCOLOR_RED] index: 3];
    return res;
}

/*
 * scale is a random factor from [0, 1], the resistor value we're 
 * targeting (1 + scale) * 10 ^ mult.
 *
 * The reason for this is our split and random generate function will
 * work only if the num is smaller than 50. Additionally, if 2 resistors
 * are involved we can only reach 20, so we give the maximum value up to 20
 */
ZResistor* ZSkeletonGenerateResistor(double scale, int mult) {
    return __build_resistor(scale * 10 + 10, mult - 1);
}

@implementation ZSkeletonGen

/*
 * initialize will allocate all resources,
 * this is a private function
 */
- (void) initialize {
    srand(time(NULL));

    for (int i = 0; i < MAX_RENDER_SIZE; i++) 
    {
        renders[i] = [[ZResistorRender alloc] init];
        [renders[i] setBackgroundColor: [UIColor whiteColor]];
        [self addSubview: renders[i]];
        renders[i].hidden = YES;
    }
    //double scale = 1.0 * (rand() % 10) / 10;
    //[self generate: scale multiplier: 1];
}

- (id) initWithCoder: (NSCoder*) coder {
    self = [super initWithCoder: coder];
    [self initialize];
    return self;
}

- (id) init {
    self = [super init];
    [self initialize];
    return self;
}

/*
 * fill up the alternatives array, some values might be nil
 */
- (void) fillAternative : (double*) arr size : (int) sz base: (int) b {
    printf("sz %d\n", sz);
    for (int i = 0; i < sz; i++) 
    {
        alternatives[i] = __build_resistor(arr[i], b);
    }
    for (int i = sz; i < 4; i++)
    {
        alternatives[i] = nil;
    }
}

/*
 * randomly generate the value. it also will reset all the resistors in
 * the layout
 */
- (void) generate: (double) scale multiplier: (int) mult {
    printf("generate called %lf %d\n", scale, mult);
    __segment_t seg[3];
    memset(seg, 0, sizeof(__segment_t) * 3);
    int tot = scale * 10 + 10;
    target = tot * pow(10.0, mult - 1);
    segCount = __create_all_segment(tot, seg);

    for (int i = 0; i < segCount; i++) 
    {
        segSize[i] = seg[i].sz;
    }
	
    // reset all resistors
    for (int i = 0; i < MAX_RENDER_SIZE; i++)
    {
        //[renders[i].resistor release];
        renders[i].resistor = nil;
    }

    double res[MAX_SEG_SIZE * MAX_ALTERNATIVE_SIZE];
    int res_sz = 0;
    for (int i = 0; i < segCount ; i++) 
    {
        for (int j = 0; j < seg[i].sz; j++) 
        {
            res[res_sz++] = 1.0 * seg[i].top / seg[i].base[j];
            printf("%d %d %lf debug: top: %d\n", i, j, 1.0 * seg[i].top / seg[i].base[j], seg[i].top);
        }
    }
    res_sz = __sort_and_trim(res, res_sz);
    while (res_sz < 4) 
    {
        int top = rand() % (tot / 2) + tot / 4;
        int baseIdx = rand() % 4;
        if (baseIdx == 0)
        {
            res[res_sz++] = 1.0 * top;
        }
        else if (baseIdx == 1)
        {
            res[res_sz++] = 1.0 * top / 2;
        }
        else if (baseIdx == 2)
        {
            res[res_sz++] = 1.0 * top / 5;
        }
        else
        {
            res[res_sz++] = 1.0 * top / 10;
        }
    }
    res_sz = __sort_and_trim(res, res_sz);
    [self fillAternative: res size: res_sz base: mult];
}

/* onPaint event. draw the layout and wires */
- (void) drawRect : (CGRect) rect {
    if (segCount == 0)
    {
        return;
    }
    int x = [self bounds].origin.x + 40;
    int y = [self bounds].origin.y + 20;
    int width = [self bounds].size.width - 80;
    int height = [self bounds].size.height - 40;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < MAX_RENDER_SIZE; i++)
    {
        renders[i].hidden = YES;
    }
    int cnt = 0;
    int renderWidth = width / 3;
    int renderHeight = 20;
    for (int i = 0; i < segCount; i++) 
    {
        for (int j = 0; j < segSize[i]; j++) 
        {
            [renders[cnt] setFrame: CGRectMake(x + i * renderWidth + (width - segCount * renderWidth) / 2,
                                               y + (j + 1) * height / (segSize[i] + 1),
                                               renderWidth - 2,
                                               renderHeight)]; 
            renders[cnt].hidden = NO;
            [renders[cnt] setNeedsDisplay];
            cnt++;
        }
    }
    for (int i = 0; i <= segCount; i++)
    {
        int delta1 = -1;
        int delta2 = -1;
        int lx = x + i * renderWidth + (width - segCount * renderWidth) / 2 - 1;
        int ly1 = y + height / (segSize[i] + 1) + renderHeight / 2 - 1;
        int ly2 = y + height / (segSize[i - 1] + 1) + renderHeight / 2 - 1;
        
        if (i < segCount)
            delta1 = (segSize[i] - 1) * height / (segSize[i] + 1) + 2;
        if (i > 0)
            delta2 = (segSize[i - 1] - 1) * height / (segSize[i - 1] + 1) + 2;
        
        if (delta1 > delta2) 
        {
            CGContextMoveToPoint(ctx, lx, ly1);
            CGContextAddLineToPoint(ctx, lx, ly1 + delta1);
        } 
        else 
        {
            CGContextMoveToPoint(ctx, lx, ly2);
            CGContextAddLineToPoint(ctx, lx, ly2 + delta2);
        }
        CGContextStrokePath(ctx);
    }
}

/*
 * validate answer
 * if the user didn't finish filling up all the resistors, it will return NO
 */
- (BOOL) validate {
    int cnt = 0;
    double s = 0.0;
    for (int i = 0; i < segCount; i++) 
    {
        double segval = 0.0;
        for (int j = 0; j < segSize[i]; j++)
        {
            if ([renders[cnt] resistor] == nil)
            {
                return NO;
            }
            ZResistor* res = [renders[cnt] resistor];
            cnt++;
            double val = ([res firstValue] + 0.1 * [res secondValue])
                * pow(10.0, [res multiplier]);
            segval += 1.0 / val;
        }
        segval = 1.0 / segval;
        s += segval;
    }
    printf("%lf and target is %lf\n", s, target);
    return (s == target);
}

/* find the right resistor render object according to location */
- (ZResistorRender*) findResistorRender: (CGPoint) p {
    for (int i = 0; i < MAX_RENDER_SIZE; i++) 
    {
        if (renders[i].hidden == YES)
        {
            continue; // skip hidden resistors
        }
        // p is not rotated..., we have to rotate p's position		
        if (CGRectContainsPoint([renders[i] frame], CGPointMake(p.y - self.frame.origin.y, self.frame.size.width - p.x + self.frame.origin.x)))
        {
            return renders[i]; // resistor found
        }
    }
    return nil; // resistor not found
}

- (ZResistor*) getAlternative: (int) idx {
    return alternatives[idx];
}

@end
