//
//  MeasureViewController.m
//  griptest
//
//  Created by MaggieWei on 15-3-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "MeasureViewController.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController

@synthesize enForceLabel;
@synthesize exForceLabel;
@synthesize maxForceLabel;

BOOL measureStarted;
OperationButton *ob;
CBCentralManager *mCentralManager;
NSTimer *hintTimer;
NSString *peripheralName=@"TAv22u-B653";
NSString *peripheralUUID=@"3D016391-F6EE-9433-EAFB-25A63D92FCEE";
NSString *serviceUUID=@"FFE0";
NSString *charUUID=@"FFE4";
CBPeripheral *mPeripheral;
CBService *mDataService;
CBCharacteristic *mDataChar;
NSString *dataLineStr;
GripForceCalculator *gfc;
float f1,f2,f3,f4;


//DataReceiver *dr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    measureStarted=NO;
    
    
    ob=[[[NSBundle mainBundle] loadNibNamed:@"OperationButton" owner:self options:nil] lastObject];
    [ob setFrame:self.OperationButtonArea.bounds];
    [self.OperationButtonArea addSubview:ob];
    UITapGestureRecognizer *operationBtnTapRec=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonTapped)];
    [ob addGestureRecognizer:operationBtnTapRec];
    
    mCentralManager=[[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    
    //dr=[[DataReceiver alloc]initWithHandler:self.barChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)operationButtonTapped{
    if(measureStarted){
        [mCentralManager cancelPeripheralConnection:mPeripheral];
        [ob changeStatus:stopped];
        //[dr stopListening];
        measureStarted=NO;
    }
    else{
        [mCentralManager connectPeripheral:mPeripheral options:nil];
        [ob changeStatus:listening];
        gfc=[[GripForceCalculator alloc] init];
        //[dr startListening];
        measureStarted=YES;
    }
}

#pragma mark - BLE
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            //The current state of the central manager is unknown; an update is imminent.
            //Available in iOS 5.0 and later.
            [self setHintText:@"The current state of the central manager is unknown; an update is imminent."];
            break;
        case CBCentralManagerStateResetting:
            //The connection with the system service was momentarily lost; an update is imminent.
            //Available in iOS 5.0 and later.
            [self setHintText:@"The connection with the system service was momentarily lost; an update is imminent."];
            break;
        case CBCentralManagerStateUnsupported:
            //The platform does not support Bluetooth low energy.
            //Available in iOS 5.0 and later.
            [self setHintText:@"手机或系统版本不支持！"];
            break;
        case CBCentralManagerStateUnauthorized:
            //The app is not authorized to use Bluetooth low energy.
            //Available in iOS 5.0 and later.
            [self setHintText:@"The app is not authorized to use Bluetooth low energy."];
            break;
        case CBCentralManagerStatePoweredOff:
            //Bluetooth is currently powered off.
            //Available in iOS 5.0 and later.
            [self setHintText:@"蓝牙功能已关闭，请开启蓝牙功能"];
            //TODO: connect again
            break;
        case CBCentralManagerStatePoweredOn:
            //Bluetooth is currently powered on and available to use.
            //Available in iOS 5.0 and later.
            [self setHintText:@"正在搜寻设备……"];
            CBUUID *mDeviceUUID=[CBUUID UUIDWithString:peripheralUUID];
            [mCentralManager scanForPeripheralsWithServices:nil options:nil];
            NSLog(@"scanning");
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"Discovered %@", peripheral.name);
    if([peripheral.name compare:peripheralName]==NSOrderedSame){
        //mPeripheral=peripheral;
        [mCentralManager stopScan];
        mPeripheral=peripheral;
        NSLog(@"Scanning stopped");
        [self setHintText:@"已搜索到设备，正在连接……"];
        /*[mCentralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES}];*/
       // [mCentralManager connectPeripheral:peripheral options:nil];

    }
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"Peripheral connected");
    mPeripheral=peripheral;
    peripheral.delegate = self;
    [self setHintText:@"设备连接成功！"];
    CBUUID *serviceToCon=[CBUUID UUIDWithString:serviceUUID];
    [peripheral discoverServices:@[serviceToCon]];
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    [self setHintText:@"已断开设备！"];
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    [self setHintText:[NSString stringWithFormat:@"连接失败，原因: %@",error.localizedDescription]];
    NSLog(@"%@",[NSString stringWithFormat:@"连接失败，原因: %@",error.localizedDescription]);
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //for (CBService *service in peripheral.services) {
    mDataService=(CBService *)[peripheral.services objectAtIndex:0];
    NSLog(@"Discovered service %@", mDataService);
    CBUUID *charToCon=[CBUUID UUIDWithString:charUUID];
    [peripheral discoverCharacteristics:@[charToCon] forService:mDataService];
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic);
    }
    mDataChar=(CBCharacteristic *)[service.characteristics objectAtIndex:0];
    [peripheral setNotifyValue:YES forCharacteristic:mDataChar];
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"%s",[characteristic.value bytes]);
    NSLog(@"er: %@",error.localizedDescription);
    //do nothing
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    dataLineStr=[[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    //NSLog(@"way2");
    //NSLog(@"%@",dataLineStr);
    //NSLog(@"er: %@",error.localizedDescription);
    [self convertDataAndPush:dataLineStr];
    
}

#pragma mark - hint label operations
-(void)setHintText:(NSString *)hint{
    self.bluetoothStateLabel.text=hint;
    if(self.bluetoothStateLabel.hidden){
        self.bluetoothStateLabel.hidden=NO;
    }
    if(hintTimer!=nil && hintTimer.valid){
        [hintTimer invalidate];
    }
    hintTimer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hintTimerFired) userInfo:nil repeats:NO];
}

-(void)hintTimerFired{
    self.bluetoothStateLabel.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - utils
-(void)convertDataAndPush:(NSString *)line{
    //NSLog(@"%@",line);
    NSArray *dataArray=[[line substringToIndex:line.length-2] componentsSeparatedByString:@" "];
    
    f1 = ([[dataArray objectAtIndex:0] floatValue] - 117) * 20.0 / (370 - 117);
    if(f1 <= 0.1) f1 = 0.0;
    
    f2 = ([[dataArray objectAtIndex:1] floatValue] - 101) * 20.0 / (400 - 101);
    if(f2 <= 0.1) f2 = 0.0;
    
    f3 = ([[dataArray objectAtIndex:2] floatValue] - 117) * 20.0 / (413 - 117);
    if(f3 <= 0.1) f3 = 0.0;
    
    f4 = ([[dataArray objectAtIndex:3] floatValue] - 107) * 20.0 / (425 - 107);
    if(f4 <= 0.1) f4 = 0.0;
    
    DataUnit *du=[DataUnit alloc];
    du.index=f1;
    du.middle=f2;
    du.ring=f3;
    du.little=f4;
    [self.barChartView onDataReceived:du];
    [gfc pushData:du];
    
    [ob valueLabel].text=[NSString stringWithFormat:@"%0.1f",f1+f2+f3+f4];
    maxForceLabel.text=[NSString stringWithFormat:@"%0.1f",gfc.maxForceTotal];
    exForceLabel.text=[NSString stringWithFormat:@"%0.1f",gfc.exForceTotal];
    enForceLabel.text=[NSString stringWithFormat:@"%0.1f",gfc.enForceTotal];    
}

@end
