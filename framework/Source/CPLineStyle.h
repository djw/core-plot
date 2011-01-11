#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class CPColor;

@interface CPLineStyle : NSObject <NSCopying, NSMutableCopying> {
	@private
	CGLineCap lineCap;
//	CGLineDash lineDash; // We should make a struct to keep this information
	CGLineJoin lineJoin;
	CGFloat miterLimit;
	CGFloat lineWidth;
	NSArray *dashPattern;
	CGFloat patternPhase;
//	StrokePattern; // We should make a struct to keep this information
    CPColor *lineColor;
}

@property (nonatomic, readwrite, assign) CGLineCap lineCap;
@property (nonatomic, readwrite, assign) CGLineJoin lineJoin;
@property (nonatomic, readwrite, assign) CGFloat miterLimit;
@property (nonatomic, readwrite, assign) CGFloat lineWidth;
@property (nonatomic, readwrite, retain) NSArray *dashPattern;
@property (nonatomic, readwrite, assign) CGFloat patternPhase;
@property (nonatomic, readwrite, retain) CPColor *lineColor;

/// @name Factory Methods
/// @{
+(id)lineStyle;
///	@}

/// @name Drawing
/// @{
-(void)setLineStyleInContext:(CGContextRef)theContext;
///	@}

@end
