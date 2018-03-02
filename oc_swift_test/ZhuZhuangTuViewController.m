//
//  ZhuZhuangTuViewController.m
//  oc_swift_test
//
//  Created by admin on 2018/3/2.
//  Copyright © 2018年 admin. All rights reserved.
//
#import "oc_swift_test-Swift.h"

#import "ZhuZhuangTuViewController.h"

@interface ZhuZhuangTuViewController ()<ChartViewDelegate>
    @property (nonatomic,retain) BarChartView *barChartView;
    @property (nonatomic,retain) BarChartData *data;
@end

@implementation ZhuZhuangTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self initWithControl];
}
    
#pragma mark - 初始化界面
    -(void)initWithControl
    {
        self.barChartView = [[BarChartView alloc] init];
        self.barChartView.delegate = self;//设置代理
        [self.view addSubview:self.barChartView];
        self.barChartView.frame=CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
        
        self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
        self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
//        self.barChartView.drawHighlightArrowEnabled = NO;//点击柱形图是否显示箭头
        self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        
        self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.barChartView.dragEnabled = YES;//启用拖拽图表
        self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        ChartXAxis *xAxis = self.barChartView.xAxis;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
//        xAxis.spaceBetweenLabels = 4;//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.spaceMin =4;
    
        xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
        
        
        ChartYAxis *rightAxis = self.barChartView.rightAxis;
        rightAxis.enabled = NO;//不绘制右边轴
        
        ChartYAxis *leftAxis = self.barChartView.leftAxis;
        leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
//        leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
//        leftAxis
//        leftAxis.axisMinValue = 0;//设置Y轴的最小值
        leftAxis.axisMinimum=0;
//        leftAxis.startAtZeroEnabled = YES;//从0开始绘制
        leftAxis.drawZeroLineEnabled =YES;
//        leftAxis.drawZeroLineEnabled
//        leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.axisMaximum =105;
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.labelCount = 5;
        leftAxis.forceLabelsEnabled = NO;
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
//        leftAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] init];//自定义格式
//        leftAxis.valueFormatter.positiveSuffix = @" $";//数字后缀单位
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿

        
        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
        limitLine.lineWidth = 2;
        limitLine.lineColor = [UIColor greenColor];
        limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
        limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
        [leftAxis addLimitLine:limitLine];//添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
        
   self.barChartView.legend.enabled = NO;//不显示图例说明
//        self.barChartView.descriptionText = @"";//不显示，就设为空字符串即可
        
        self.data = [self setData];
        //为柱形图提供数据
        self.barChartView.data = self.data;
        //设置动画效果，可以设置X轴和Y轴的动画效果
        [self.barChartView animateWithYAxisDuration:1.0f];
       
    }
    //为柱形图设置数据
- (BarChartData *)setData{
    
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:val xIndex:i];
       BarChartDataEntry *entry = [[BarChartDataEntry alloc]initWithX:val y:i];
        [yVals addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
//    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:nil];
    BarChartDataSet *set1 =[[BarChartDataSet alloc]initWithValues:yVals label:nil];
//    set1.barSpace = 0.2;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
//    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    BarChartData *data =[[BarChartData alloc]initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    
    LargeValueFormatter *formatter1 =[[LargeValueFormatter alloc]init];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    //自定义数据显示格式
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [formatter setPositiveFormat:@"#0.0"];
    [data setValueFormatter:formatter1];
    
    return data;
}
    - (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
        NSLog(@"---chartValueSelected---value: %g", entry.x);
    }
//    2.没有选中柱形图时的代理方法，代码如下：
    
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
//    当选中一个柱形图后，在空白处双击，就可以取消选择，此时会回调此方法.
//    </br>
//    3.捏合放大或缩小柱形图时的代理方法，代码如下：
    
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
//    4.拖拽图表时的代理方法
    
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
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
