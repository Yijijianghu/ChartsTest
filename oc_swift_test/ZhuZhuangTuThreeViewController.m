//
//  ZhuZhuangTuThreeViewController.m
//  oc_swift_test
//
//  Created by admin on 2018/3/2.
//  Copyright © 2018年 admin. All rights reserved.
//
#define KScreenWidth     [UIScreen mainScreen].bounds.size.width
#define KScreenHeight         [UIScreen mainScreen].bounds.size.height

#import "oc_swift_test-Swift.h"
#import "BarChartsHelper.h"

#import "ZhuZhuangTuThreeViewController.h"

@interface ZhuZhuangTuThreeViewController ()
    @property (nonatomic,retain)CombinedChartView *combineChartView;
@property (nonatomic, weak) BarChartView *barChartView;
@property (nonatomic, weak) CombinedChartView *combineChartView1;
@property (nonatomic, weak) CombinedChartView *combineChartView2;
@end

@implementation ZhuZhuangTuThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];

    [self danZhuZhexianTu];

}


#pragma mark - 初始化界面

-(void)danZhuZhexianTu
{
    [self createCombineChartViewWithLineValues:@[@"46",@"29",@"30",@"70",@"10"] xValues:@[@"15",@"20",@"25",@"30",@"35"] yValues:@[@"35",@"20",@"75",@"30",@"95"] title:@"单柱和折线图" lineTitle:@"line" barTitle:@"type2" index:0];
}
//柱和折线图
- (void)createCombineChartViewWithLineValues:(NSArray *)lineVals xValues:(NSArray *)xVals yValues:(NSArray *)yVals title:(NSString *)title lineTitle:(NSString *)line barTitle:(NSString *)bar index:(NSInteger)index
{
    CombinedChartView *combine = [[CombinedChartView alloc] init];
    self.combineChartView1 = combine;
    self.combineChartView1.frame = CGRectMake(0, 200, self.view.frame.size.width, 400);
    [self.view addSubview:combine];
    
    //添加图表标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake((self.view.frame.size.width-100)/2, 150, 100, 30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithRGBHex:0x595959];
    [self.view addSubview:titleLabel];
    BarChartsHelper *helper = [[BarChartsHelper alloc] init];
    [helper setBarChart:combine lineValues:lineVals xValues:xVals yValues:yVals lineTitle:line barTitle:bar];
}

-(void)initWithControl
{
    CombinedChartView *combine = [[CombinedChartView alloc] init];
    self.combineChartView = combine;
    combine.frame = CGRectMake(0, KScreenHeight/2, KScreenWidth, KScreenHeight/2);
    combine.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    [self.view addSubview:combine];
    
    //我自己的工具类
//    BarChartsHelper *helper = [[BarChartsHelper alloc] init];
    [self setCombineBarChart:self.combineChartView xValues:@[@"15",@"20",@"25",@"30",@"35"] lineValues:@[@"30",@"10",@"50",@"30",@"60"] bar1Values:@[@"80",@"40",@"60",@"30",@"70"] bar2Values:@[@"60",@"30",@"53",@"20",@"45"] lineTitle:@"line" bar1Title:@"bar1" bar2Title:@"bar2"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setCombineBarChart:(CombinedChartView *)combineChart xValues:(NSArray *)xValues lineValues:(NSArray *)lineValues bar1Values:(NSArray *)bar1Values bar2Values:(NSArray *)bar2Values lineTitle:(NSString *)lineTitle bar1Title:(NSString *)bar1Title bar2Title:(NSString *)bar2Title
    {
//        combineChart.descriptionText = @"";
        combineChart.pinchZoomEnabled = YES;
        combineChart.marker = [[ChartMarkerView alloc] init];
        combineChart.drawOrder = @[@0,@0,@2];//CombinedChartDrawOrderBar,CombinedChartDrawOrderLine 绘制顺序
        combineChart.doubleTapToZoomEnabled = NO;//取消双击放大
        combineChart.scaleYEnabled = NO;//取消Y轴缩放
        combineChart.dragEnabled = YES;//启用拖拽图表
        combineChart.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        combineChart.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        combineChart.highlightPerTapEnabled = NO;//取消单击高亮显示
        combineChart.highlightPerDragEnabled = NO;//取消拖拽高亮
        ChartXAxis *xAxis = combineChart.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelFont = [UIFont systemFontOfSize:15];
        xAxis.labelCount = xValues.count;
        xAxis.labelRotationAngle = -40;
        
        xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];//设置X轴显示的值
        
        //左侧Y轴设置
        ChartYAxis *leftAxis = combineChart.leftAxis;
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.axisMinimum = 0.0f;
        leftAxis.drawGridLinesEnabled = YES;
        
        float yMin = [[bar2Values valueForKeyPath:@"@min.floatValue"] floatValue]*0.9;
        float yMax = [[bar1Values valueForKeyPath:@"@max.floatValue"] floatValue]*1.1;
        leftAxis.axisMinimum = yMin;
        leftAxis.axisMaximum = yMax;
        
        //右侧Y轴
        ChartYAxis *rightAxis = combineChart.rightAxis;
        rightAxis.labelPosition = YAxisLabelPositionOutsideChart;
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.axisMinimum = 0;
        rightAxis.axisMaximum = 100;
        //设置图例
        ChartLegend *legend = combineChart.legend;
        legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        legend.orientation = ChartLegendOrientationHorizontal;
        legend.drawInside = NO;
        legend.direction = ChartLegendDirectionLeftToRight;
        legend.form = ChartLegendFormSquare;
        legend.formSize = 12;
        //设置数据
        CombinedChartData *data = [[CombinedChartData alloc] init];
        data.lineData = [self generateLineData:lineValues lineTitle:lineTitle];
        data.barData = [self generateCombineBarData:bar1Values bar2Values:bar2Values title1:bar1Title title2:bar2Title];
        combineChart.data = data;
        
        
        
        xAxis.axisMinimum = data.xMin - 1.0f;
        xAxis.axisMaximum = data.xMax + 1.0f;
        combineChart.extraBottomOffset = 10;
        combineChart.extraTopOffset = 30;
        [combineChart animateWithYAxisDuration:1.0];//添加Y轴动画
    }
    //生成线的数据
- (LineChartData *)generateLineData:(NSArray *)lineValues lineTitle:(NSString *)lineTitle
    {
        NSMutableArray *entries = [NSMutableArray array];
        for (int i = 0; i < lineValues.count; i++) {
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[lineValues[i] floatValue]];
            [entries addObject:entry];
        }
        
        LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:entries label:lineTitle];
        dataSet.colors = @[[UIColor greenColor]];
        dataSet.lineWidth = 2.5f;
        dataSet.circleColors = @[[UIColor redColor]];
        dataSet.circleHoleColor = [UIColor purpleColor];
        dataSet.axisDependency = AxisDependencyRight;
        dataSet.drawValuesEnabled = YES;//不绘制线的数据
        
        LineChartData *lineData = [[LineChartData alloc] initWithDataSet:dataSet];
        [lineData setValueFont:[UIFont systemFontOfSize:10]];
        
        return lineData;
    }
    //生成复杂的组合柱图的数据
- (BarChartData *)generateCombineBarData:(NSArray *)bar1Values bar2Values:(NSArray *)bar2Values title1:(NSString *)bar1Title title2:(NSString *)bar2Title
    {
        NSMutableArray *bar1Entries = [NSMutableArray array];
        NSMutableArray *bar2Entries = [NSMutableArray array];
        for (int i=0; i<bar1Values.count; i++) {
            BarChartDataEntry *barEntry = [[BarChartDataEntry alloc] initWithX:i y:[bar1Values[i] floatValue]];
            [bar1Entries addObject:barEntry];
        }
        for (int i=0; i<bar2Values.count; i++) {
            BarChartDataEntry *barEntry = [[BarChartDataEntry alloc] initWithX:i y:[bar2Values[i] floatValue]];
            [bar2Entries addObject:barEntry];
        }
        
        BarChartDataSet *dataSet1 = [[BarChartDataSet alloc]  initWithValues:bar1Entries label:bar1Title];
        dataSet1.colors = @[[UIColor grayColor]];
        dataSet1.valueColors = @[[UIColor orangeColor]];
        dataSet1.axisDependency = AxisDependencyLeft;
        dataSet1.drawValuesEnabled = NO;
        
        BarChartDataSet *dataSet2 = [[BarChartDataSet alloc]  initWithValues:bar2Entries label:bar2Title];
        dataSet2.colors = @[[UIColor brownColor]];
        dataSet2.valueColors = @[[UIColor orangeColor]];
        dataSet2.axisDependency = AxisDependencyLeft;
        dataSet2.drawValuesEnabled = NO;
        BarChartData *data = [[BarChartData alloc] initWithDataSets:@[dataSet1,dataSet2]];
        [data setValueFont:[UIFont systemFontOfSize:10]];
        data.barWidth = 0.9f;
        return data;
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
