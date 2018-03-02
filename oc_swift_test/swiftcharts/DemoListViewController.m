//
//  DemoListViewController.m
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//
#import "BarOneViewController.h"

#import "ZhuZhuangTuThreeViewController.h"

#import "ZhuZhuangTuTwoViewController.h"
#import "ZhuZhuangTuViewController.h"


#import "DemoListViewController.h"
#import "LineChart1ViewController.h"
#import "LineChart2ViewController.h"
#import "BarChartViewController.h"
#import "HorizontalBarChartViewController.h"
#import "CombinedChartViewController.h"
#import "PieChartViewController.h"
#import "PiePolylineChartViewController.h"
#import "ScatterChartViewController.h"
#import "StackedBarChartViewController.h"
#import "NegativeStackedBarChartViewController.h"
#import "AnotherBarChartViewController.h"
#import "MultipleLinesChartViewController.h"
#import "MultipleBarChartViewController.h"
#import "CandleStickChartViewController.h"
#import "CubicLineChartViewController.h"
#import "RadarChartViewController.h"
#import "ColoredLineChartViewController.h"
#import "SinusBarChartViewController.h"
#import "PositiveNegativeBarChartViewController.h"
#import "BubbleChartViewController.h"
#import "LineChartTimeViewController.h"
#import "LineChartFilledViewController.h"
#import "HalfPieChartViewController.h"

@interface DemoListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *itemDefs;
@end

@implementation DemoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setnavigation];
    
    self.title = @"Charts Demonstration";

    self.itemDefs = @[
                      @{
                          @"title": @"Line Chart 折线",
                          @"subtitle": @"A simple demonstration of the linechart.",
                          @"class": LineChart1ViewController.class
                          },
                      @{
                          @"title": @"Line Chart (Dual YAxis)双折",
                          @"subtitle": @"Demonstration of the linechart with dual y-axis.",
                          @"class": LineChart2ViewController.class
                          },
                      @{
                          @"title": @"Bar Chart柱状",
                          @"subtitle": @"A simple demonstration of the bar chart.",
                          @"class": BarChartViewController.class
                          },
                      @{
                          @"title": @"Horizontal Bar Chart水平柱",
                          @"subtitle": @"A simple demonstration of the horizontal bar chart.",
                          @"class": HorizontalBarChartViewController.class
                          },
                      @{
                          @"title": @"Combined Chart复合",
                          @"subtitle": @"Demonstrates how to create a combined chart (bar and line in this case).",
                          @"class": CombinedChartViewController.class
                          },
                      @{
                          @"title": @"Pie Chart扇",
                          @"subtitle": @"A simple demonstration of the pie chart.",
                          @"class": PieChartViewController.class
                          },
                      @{
                          @"title": @"Pie Chart with value lines扇备注",
                          @"subtitle": @"A simple demonstration of the pie chart with polyline notes.",
                          @"class": PiePolylineChartViewController.class
                          },
                      @{
                          @"title": @"Scatter Chart点状图",
                          @"subtitle": @"A simple demonstration of the scatter chart.",
                          @"class": ScatterChartViewController.class
                          },
                      @{
                          @"title": @"Bubble Chart球状",
                          @"subtitle": @"A simple demonstration of the bubble chart.",
                          @"class": BubbleChartViewController.class
                          },
                      @{
                          @"title": @"Stacked Bar Chart多层柱",
                          @"subtitle": @"A simple demonstration of a bar chart with stacked bars.",
                          @"class": StackedBarChartViewController.class
                          },
                      @{
                          @"title": @"Stacked Bar Chart Negative对称柱",
                          @"subtitle": @"A simple demonstration of stacked bars with negative and positive values.",
                          @"class": NegativeStackedBarChartViewController.class
                          },
                      @{
                          @"title": @"Another Bar Chart单一柱",
                          @"subtitle": @"Implementation of a BarChart that only shows values at the bottom.",
                          @"class": AnotherBarChartViewController.class
                          },
                      @{
                          @"title": @"Multiple Lines Chart复合折线",
                          @"subtitle": @"A line chart with multiple DataSet objects. One color per DataSet.",
                          @"class": MultipleLinesChartViewController.class
                          },
                      @{
                          @"title": @"Multiple Bars Chart复合柱状",
                          @"subtitle": @"A bar chart with multiple DataSet objects. One multiple colors per DataSet.",
                          @"class": MultipleBarChartViewController.class
                          },
                      @{
                          @"title": @"Candle Stick ChartK线",
                          @"subtitle": @"Demonstrates usage of the CandleStickChart.",
                          @"class": CandleStickChartViewController.class
                          },
                      @{
                          @"title": @"Cubic Line Chart立体折线",
                          @"subtitle": @"Demonstrates cubic lines in a LineChart.",
                          @"class": CubicLineChartViewController.class
                          },
                      @{
                          @"title": @"Radar Chart多维图",
                          @"subtitle": @"Demonstrates the use of a spider-web like (net) chart.",
                          @"class": RadarChartViewController.class
                          },
                      @{
                          @"title": @"Colored Line Chart多颜色折线",
                          @"subtitle": @"Shows a LineChart with different background and line color.",
                          @"class": ColoredLineChartViewController.class
                          },
                      @{
                          @"title": @"Sinus Bar Chart波形图",
                          @"subtitle": @"A Bar Chart plotting the sinus function with 8.000 values.",
                          @"class": SinusBarChartViewController.class
                          },
                      @{
                          
                          @"title": @"BarChart positive / negative柱状波形",
                          @"subtitle": @"This demonstrates how to create a BarChart with positive and negative values in different colors.",
                          @"class": PositiveNegativeBarChartViewController.class
                          },
                      @{
                          
                          @"title": @"Time Line Chart时间线",
                          @"subtitle": @"Simple demonstration of a time-chart. This chart draws one line entry per hour originating from the current time in milliseconds.",
                          @"class": LineChartTimeViewController.class
                          },
                      @{
                          
                          @"title": @"Filled Line Chart填充线",
                          @"subtitle": @"This demonstrates how to fill an area between two LineDataSets.",
                          @"class": LineChartFilledViewController.class
                          },
                      @{
                          
                          @"title": @"Half Pie Chart半圆",
                          @"subtitle": @"This demonstrates how to create a 180 degree PieChart.",
                          @"class": HalfPieChartViewController.class
                          }
                      ];
    //FIXME: Add TimeLineChart
}
-(void)setnavigation
    {
        UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(touchAddBtnAction)];
        
        UIBarButtonItem *right1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDoneBtnAction)];
        self.navigationItem.rightBarButtonItems=@[right,right1];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemDefs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *def = self.itemDefs[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = def[@"title"];
    cell.detailTextLabel.text = def[@"subtitle"];
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *def = self.itemDefs[indexPath.row];
    
    Class vcClass = def[@"class"];
    UIViewController *vc = [[vcClass alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 点击事件
    -(void)touchAddBtnAction
{
        Class zhuZhuangTuVc=BarOneViewController.class;
        UIViewController *vc=[[zhuZhuangTuVc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    
    }
    -(void)touchDoneBtnAction
    {
        Class zhuZhuangTuVc=ZhuZhuangTuThreeViewController.class;
        UIViewController *vc=[[zhuZhuangTuVc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

@end
