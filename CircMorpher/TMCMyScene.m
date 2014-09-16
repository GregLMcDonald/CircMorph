//
//  TMCMyScene.m
//  CircMorpher
//
//  Created by Greg McDonald on 2014-09-15.
//  Copyright (c) 2014 Tasty Morsels. All rights reserved.
//

#import "TMCMyScene.h"

@implementation TMCMyScene
{
    int frame_count;
    float flower_power;
    float flower_power_change;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        frame_count = 0;
        flower_power = 1.1;
        flower_power_change = 0.05;
        
        
        self.backgroundColor = [SKColor whiteColor];
        
        SKShapeNode *circle = [[SKShapeNode alloc] init];
        circle.name = @"flower";
        
        CGMutablePathRef circlePath = CGPathCreateMutable();
        
        
        float radius = 20.0;
        
        float xi = 500 + radius * cosf((0) * M_PI / 5.0);
        float yi = 500 + radius * sinf((0) * M_PI / 5.0);
        CGPathMoveToPoint(circlePath, NULL, xi, yi);

        NSMutableArray *points = [[NSMutableArray alloc]init];
        
        
        

        
        
        for (int i=1; i<=10; i++) {
            
            float xi = 500 + radius * cosf((i) * M_PI / 5.0);
            float yi = 500 + radius * sinf((i) * M_PI / 5.0);
            
            float cr = flower_power;
            float cx1 =  500 + cr * radius * cosf((i) * M_PI / 5.0);
            float cy1 = 500 + cr * radius * sinf((i) * M_PI / 5.0);
            float cx2 = 500 + cr * radius * cosf((i+1) * M_PI / 5.0);
            float cy2 = 500 + cr * radius * sinf((i+1) * M_PI / 5.0);
            
            float xf = 500 + radius * cosf((i+1) * M_PI / 5.0);
            float yf = 500 + radius * sinf((i+1) * M_PI / 5.0);
            
            
            [points addObject:[[SKShapeNode alloc]init]];
            
            [(SKShapeNode *)points.lastObject setPath:CGPathCreateWithEllipseInRect(CGRectMake(xi-5, yi-5, 10, 10), NULL)];
            [(SKShapeNode *)points.lastObject setFillColor:[SKColor blackColor]];
            [(SKShapeNode *)points.lastObject setStrokeColor:[SKColor greenColor]];
            
            
            
            
            CGPathAddCurveToPoint(circlePath, NULL,
                                  cx1, cy1,
                                  cx2, cy2,
                                  xf, yf);
        
            
        }
        
        circle.path = circlePath;
        
        CGPathRelease(circlePath);
        
        circle.strokeColor = [SKColor blackColor];
        circle.lineWidth = .01        ;
        circle.antialiased = YES;
        circle.fillColor = [SKColor yellowColor];
        
        [self addChild:circle];
        //for ( SKShapeNode *node in points){
        //    [self addChild:node];
        //}
        
        
    
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (frame_count == 1){
        //redraw path
        
        SKNode *circle = [self childNodeWithName:@"flower"];
        
        if (flower_power > 3.0){
            flower_power_change = -0.05;
        }
        if (flower_power < 1.2){
            flower_power_change = 0.05;
        }
        
        flower_power += flower_power_change;
            
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathMoveToPoint(circlePath, NULL, 600, 500);
        
        float radius = 20.0;
        
        for (int i=0; i<10; i++) {
            
            //float xi = 500 + radius * cosf((i) * M_PI / 5.0);
            //float yi = 500 + radius * sinf((i) * M_PI / 5.0);
            
            float cr = flower_power;
            float cx1 =  500 + cr * radius * cosf((i) * M_PI / 5.0);
            float cy1 = 500 + cr * radius * sinf((i) * M_PI / 5.0);
            float cx2 = 500 + cr * radius * cosf((i+1) * M_PI / 5.0);
            float cy2 = 500 + cr * radius * sinf((i+1) * M_PI / 5.0);
            
            float xf = 500 + radius * cosf((i+1) * M_PI / 5.0);
            float yf = 500 + radius * sinf((i+1) * M_PI / 5.0);
            
            
            CGPathAddCurveToPoint(circlePath, NULL,
                                  cx1, cy1,
                                  cx2, cy2,
                                  xf, yf);
            
        }
        
        [(SKShapeNode *)circle setPath:circlePath];
        
        frame_count = 0;
    }
    
    else {
        frame_count++;
    }
}

@end
