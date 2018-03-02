//
//  XAxisValueFormatter.m
//  oc_swift_test
//
//  Created by admin on 2018/3/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "XAxisValueFormatter.h"

@implementation XAxisValueFormatter
/// 实现协议方法，返回 x 轴的数据

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
//    ClassLessonTestScoreListModel *model = self.xAxisDatas[(int)value - 1];
//    return [NSString stringWithFormat:@"%@", model.lessonNoText];
//    return [NSString stringWithFormat:@"%@",self.xAxisDatas[(int)value]];
    NSLog(@"---%f--%@",value,self.xAxisDatas);
    return self.xAxisDatas[(int)value];
}

@end
