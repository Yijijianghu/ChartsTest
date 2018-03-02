//
//  BarOneViewController.m
//  oc_swift_test
//
//  Created by admin on 2018/3/2.
//  Copyright © 2018年 admin. All rights reserved.
//
#import "oc_swift_test-Swift.h"

#import "BarOneViewController.h"
#import "DayAxisValueFormatter.h"

@interface BarOneViewController ()<ChartViewDelegate>

@property (nonatomic, strong)  BarChartView *chartView;
@property (nonatomic, strong)  UISlider *sliderX;
@property (nonatomic, strong)  UISlider *sliderY;
@property (nonatomic, strong)  UITextField *sliderTextX;
@property (nonatomic, strong)  UITextField *sliderTextY;

@end

@implementation BarOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"barONE";
    self.view.backgroundColor=[UIColor whiteColor];
    
    _chartView = [[BarChartView alloc] init];
    _chartView.frame = CGRectMake(0, 100, self.view.frame.size.width, 400);
    [self.view addSubview:_chartView];
    
    [self setupBarLineChartView:_chartView];
    _chartView.delegate = self;
    
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    
    _chartView.maxVisibleCount = 60;
    
    NSArray *xValues=@[@"13",@"14",@"15",@"16",@"17",@"18",@"19"];
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
//    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.granularity=1.0;
    xAxis.labelCount = 7;
    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    XYMarkerView *marker = [[XYMarkerView alloc]
                            initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                            font: [UIFont systemFontOfSize:12.0]
                            textColor: UIColor.whiteColor
                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                            xAxisValueFormatter: _chartView.xAxis.valueFormatter];
    marker.chartView = _chartView;
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
    
    
    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:@[@"日",@"周",@"月",@"年"]];
    segment.frame=CGRectMake(self.view.frame.size.width-20-200, 64, 200, 40);
    segment.tintColor=[UIColor blueColor];
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
    //添加监听
    [segment addTarget:self action:@selector(sementedControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];

    
    _sliderY=[[UISlider alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height-64-25, self.view.frame.size.width-30-20-60 , 10)];
    _sliderY.minimumValue=1;
    _sliderY.maximumValue=200;
    [_sliderY addTarget:self action:@selector(slidersValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sliderY];
    _sliderTextY=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sliderY.frame)+10, _sliderY.center.y-20, 60, 40)];
    [self.view addSubview:_sliderTextY];
    
    _sliderX=[[UISlider alloc]initWithFrame:CGRectMake(30, _sliderY.frame.origin.y-40, self.view.frame.size.width-30-20-60, 10)];
    _sliderX.minimumValue=1;
    _sliderX.maximumValue=500;
    [_sliderX addTarget:self action:@selector(slidersValueChanged:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:_sliderX];

    _sliderTextX=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sliderX.frame)+10, _sliderX.center.y-20, 60, 40)];
    [self.view addSubview:_sliderTextX];

    _sliderX.value = 12.0;
    _sliderY.value = 50.0;
    [self slidersValueChanged:nil];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    [self setDataCount:_sliderX.value + 1 range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    double start = 1.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = start; i < start + count + 1; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        if (arc4random_uniform(100) < 25) {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
        } else {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
        }
    }
    
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _chartView.data = data;
    }
}

- (void)optionTapped:(NSString *)key
{
    [super handleOption:key forChartView:_chartView];
}

#pragma mark - Actions

- (void)slidersValueChanged:(id)sender
{
    _sliderTextX.text = [@((int)_sliderX.value + 2) stringValue];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
}
-(void)sementedControlClick:(UISegmentedControl *)segm
{
    NSLog(@"sementedControlClick--%d",(int)segm.selectedSegmentIndex);
    switch (segm.selectedSegmentIndex) {
        case 0:
            {
                _sliderX.value=365;
            }
            break;
        case 1:
        {
            _sliderX.value=52;
        }
            break;
        case 2:
        {
            _sliderX.value=31;
        }
            break;
        case 3:
        {
            _sliderX.value=1;
        }
            break;
        default:
            break;
    }
    _sliderTextX.text = [@((int)_sliderX.value + 2) stringValue];
    
    [self updateChartData];
}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
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
