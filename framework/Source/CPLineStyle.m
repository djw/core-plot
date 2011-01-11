#import "CPLineStyle.h"
#import "CPLayer.h"
#import "CPColor.h"
#import "CPMutableLineStyle.h"

/** @brief Immutable wrapper for various line drawing properties.
 *
 *	@see See Apple's <a href="http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html#//apple_ref/doc/uid/TP30001066-CH211-TPXREF105">Quartz 2D</a>
 *	and <a href="http://developer.apple.com/documentation/GraphicsImaging/Reference/CGContext/Reference/reference.html">CGContext</a> 
 *	documentation for more information about each of these properties.
 *
 *  In general, you will want to create a CPMutableLineStyle if you want to customize properties.
 **/

@implementation CPLineStyle

/** @property lineCap
 *  @brief The style for the endpoints of lines drawn in a graphics context.
 **/
@synthesize lineCap;

/** @property lineJoin
 *  @brief The style for the joins of connected lines in a graphics context.
 **/
@synthesize lineJoin;

/** @property miterLimit
 *  @brief The miter limit for the joins of connected lines in a graphics context.
 **/
@synthesize miterLimit;

/** @property lineWidth
 *  @brief The line width for a graphics context.
 **/
@synthesize lineWidth;

/** @property dashPattern
 *  @brief The dash-and-space pattern for the line.
 **/
@synthesize dashPattern;

/** @property patternPhase
 *  @brief The starting phase of the line dash pattern.
 **/
@synthesize patternPhase;

/** @property lineColor
 *  @brief The current stroke color in a context.
 **/
@synthesize lineColor;

#pragma mark -
#pragma mark init/dealloc

/** @brief Creates and returns a new CPLineStyle instance.
 *  @return A new CPLineStyle instance.
 **/
+(id)lineStyle
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
	if ( self = [super init] ) {
		lineCap = kCGLineCapButt;
		lineJoin = kCGLineJoinMiter;
		miterLimit = 10.0;
		lineWidth = 1.0;
		dashPattern = nil;
		patternPhase = 0.0;
		lineColor = [[CPColor blackColor] retain];
	}
	return self;
}

-(void)dealloc
{
    [lineColor release];
	[dashPattern release];
	[super dealloc];
}

#pragma mark -
#pragma mark Drawing

/** @brief Sets all of the line drawing properties in the given graphics context.
 *  @param theContext The graphics context.
 **/
-(void)setLineStyleInContext:(CGContextRef)theContext
{
	CGContextSetLineCap(theContext, lineCap);
	CGContextSetLineJoin(theContext, lineJoin);
	CGContextSetMiterLimit(theContext, miterLimit);
	CGContextSetLineWidth(theContext, lineWidth);
	if ( dashPattern.count > 0 ) {
		CGFloat *dashLengths = (CGFloat *)calloc(dashPattern.count, sizeof(CGFloat));

		NSUInteger dashCounter = 0;
		for ( NSNumber *currentDashLength in dashPattern ) {
			dashLengths[dashCounter++] = [currentDashLength doubleValue];
		}
		
		CGContextSetLineDash(theContext, patternPhase, dashLengths, dashPattern.count);
		free(dashLengths);
	}
	CGContextSetStrokeColorWithColor(theContext, lineColor.cgColor);
}

#pragma mark -
#pragma mark NSCopying methods

-(id)copyWithZone:(NSZone *)zone
{
    CPLineStyle *styleCopy = [[CPLineStyle allocWithZone:zone] init];
 	
	styleCopy->lineCap = self->lineCap;
	styleCopy->lineJoin = self->lineJoin;
	styleCopy->miterLimit = self->miterLimit;
	styleCopy->lineWidth = self->lineWidth;
	styleCopy->dashPattern = [self->dashPattern copy];
	styleCopy->patternPhase = self->patternPhase;
    styleCopy->lineColor = [self->lineColor copy];
    
    return styleCopy;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    CPLineStyle *styleCopy = [[CPMutableLineStyle allocWithZone:zone] init];
 	
	styleCopy->lineCap = self->lineCap;
	styleCopy->lineJoin = self->lineJoin;
	styleCopy->miterLimit = self->miterLimit;
	styleCopy->lineWidth = self->lineWidth;
	styleCopy->dashPattern = [self->dashPattern copy];
	styleCopy->patternPhase = self->patternPhase;
    styleCopy->lineColor = [self->lineColor copy];
    
    return styleCopy;
}

@end
