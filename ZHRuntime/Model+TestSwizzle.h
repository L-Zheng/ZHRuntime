//
//  Model+TestSwizzle.h
//  05-runtime
//
//  Created by 李保征 on 2017/6/16.
//  Copyright © 2017年 heima. All rights reserved.
//

#import "Model.h"

@interface Model (TestSwizzle)


+ (void)originClassFunction;

+ (void)swizzledClassFunction;


- (void)originInstanceFunction;

- (void)swizzledInstanceFunction;

@end
