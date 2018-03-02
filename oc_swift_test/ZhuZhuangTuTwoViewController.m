//
//  ZhuZhuangTuTwoViewController.m
//  oc_swift_test
//
//  Created by admin on 2018/3/2.
//  Copyright © 2018年 admin. All rights reserved.
//
#import "oc_swift_test-Swift.h"

#import "ZhuZhuangTuTwoViewController.h"

@interface ZhuZhuangTuTwoViewController ()
    @property (nonatomic,retain)BarChartView *barChartView;
@end

@implementation ZhuZhuangTuTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
 
    [self setsubviews];
}
    -(void)setsubviews
    {
        BarChartView *barChartView = [[BarChartView alloc] init];
        [self.view addSubview:barChartView];
        self.barChartView = barChartView;
        
        self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
        self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        
        self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.barChartView.dragEnabled = YES;//启用拖拽图表
        self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        ChartXAxis *xAxis = barChartView.xAxis;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.forceLabelsEnabled = YES;
        xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
        
        ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
        leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.forceLabelsEnabled = YES;
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
//        leftAxis.axisMinValue = 0;
        leftAxis.axisMinimum=0;
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        barChartView.rightAxis.enabled = NO;
        
        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
        limitLine.lineWidth = 2;
        limitLine.lineColor = [UIColor greenColor];
        limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
        limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
        [leftAxis addLimitLine:limitLine];//添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled = NO;//不显示图例说明
//        self.barChartView.descriptionText = @"";//不显示，就设为空字符串即可
//        数据源方法
        NSMutableArray *yValues = [[NSMutableArray alloc] init];

        // 产生20个随机立柱数据
        for (int i = 0; i < 20; i ++) {
            
            double y = (arc4random_uniform(40));
            
            BarChartDataEntry *yEntry = [[BarChartDataEntry alloc] initWithX:i + 5 y:y];
            
            [yValues addObject:yEntry];
        }
        
        BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yValues label:@"data set"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor blueColor]];
        
        //不在面板上直接显示数值
        set1.drawValuesEnabled = YES;
        
        // 赋值数据
        BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
        
        barChartView.data = data;
    }
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
