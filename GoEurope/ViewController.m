//
//  ViewController.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "ViewController.h"
#import "ResultTableViewCell.h"
#import "ContentManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIStackView *buttonsStackView;
@property (weak, nonatomic) IBOutlet UIButton *trainButton;
@property (weak, nonatomic) IBOutlet UIButton *busButton;
@property (weak, nonatomic) IBOutlet UIButton *flightButton;
@property (weak, nonatomic) IBOutlet UIView *buttonUnderlineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonUnderlineViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonUnderlineViewLeftMargin;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;

@property(strong, nonatomic) NSArray<ResultItem *> * dataSource;
@property(nonatomic) NSInteger numberOfRequests;
@property(nonatomic) ContentOrderType orderType;
@property(nonatomic) ContentTypeTransportType transportType;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_orderType = ContentOrderTypeDeparture;
	_transportType = ContentTypeTransportTypeTrain;
	
	[self updateResults];
}

#pragma mark - TableView delegate and data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [_dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	ResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultTableViewCellID"];
	ResultItem * item = _dataSource[indexPath.row];
	
	NSString * timeInterval = [NSString stringWithFormat:@"%@ - %@",item.departureTime, item.arrivalTime];
	NSString * direct = [item.numberOfChanges integerValue] == 0 ? @"Direct" : [NSString stringWithFormat:@"%ld stops", (long)[item.numberOfChanges integerValue]];
	
	NSString * cost = [NSString stringWithFormat:@"€%@",item.price];
	[cell setLogo:item.logo timeInterval:timeInterval directValue:direct duration:item.durationString cost:cost];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return  70;
}

#pragma mark - Header button actions
- (IBAction)didTapTrainButton:(id)sender {
	_transportType = ContentTypeTransportTypeTrain;
	[self updateResults];
	[self focusOnButton:sender];
}

- (IBAction)didTapBusButton:(id)sender {
	_transportType = ContentTypeTransportTypeBus;
	[self updateResults];
	[self focusOnButton:sender];
}

- (IBAction)didTapFlightButton:(id)sender {
	_transportType = ContentTypeTransportTypeFlight;
	[self updateResults];
	[self focusOnButton:sender];
}

- (void)updateResults{
	[self requestStarted];
	[[ContentManager sharedContentManager] fetchResultsForTransportType:_transportType order:_orderType withBlock:^(NSArray<ResultItem *> *arr) {
		_dataSource = arr;
		[self requestFinished];
	} failureBlock:^(NSError *error) {
		[self requestFinished];
		[self showErrorMessage:error];
	}];

}

- (void)requestStarted{
	_numberOfRequests++;
	_tableView.userInteractionEnabled = NO;
	_tableView.layer.opacity = 0.1;
}

- (void)requestFinished{
	_numberOfRequests--;
	if(_numberOfRequests == 0){
		_tableView.userInteractionEnabled = YES;
		_tableView.layer.opacity = 1.0;
		[_tableView reloadData];
	}
}
- (void)focusOnButton:(UIButton *)button{
	[UIView animateWithDuration:0.5 animations:^{
		self.buttonUnderlineViewWidth.constant = button.frame.size.width;
		self.buttonUnderlineViewLeftMargin.constant = button.frame.origin.x;
		[self.view layoutIfNeeded];
	}];
}

- (void) showErrorMessage:(NSError *) error{
	UIAlertController * alert = [[UIAlertController alloc] init];
	alert.message = error.localizedDescription;
	[alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)didTapSortButton:(id)sender {
	UIAlertController * alert = [[UIAlertController alloc] init];
	alert.title = @"Select Order";
	[alert addAction:[UIAlertAction actionWithTitle:@"Departure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		_orderButton.titleLabel.text = @"Ordered by: Departure";
		_orderType = ContentOrderTypeDeparture;
		[self updateResults];
	}]];
	[alert addAction:[UIAlertAction actionWithTitle:@"Arrival" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		_orderButton.titleLabel.text = @"Ordered by: Arrival";
		_orderType = ContentOrderTypeArrival;
		[self updateResults];
	}]];
	[alert addAction:[UIAlertAction actionWithTitle:@"Duration" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		_orderButton.titleLabel.text = @"Ordered by: Duration";
		_orderType = ContentOrderTypeDuration;
		[self updateResults];
	}]];
	
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
