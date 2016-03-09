//
//  InsurInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface InsurInfoModel : BaseModel

@property (nonatomic, strong) NSString *insuranceOrderId;//":1; //订单ID，考虑node.js提供
@property (nonatomic, strong) NSString *insuranceOrderUuid;//":khsdfushfysdfnskdfjslddsf; //订单uuid
@property (nonatomic, strong) NSString *insuranceOrderNo;;//":20160111XXXXX; //订单编号
@property (nonatomic, assign) NSInteger planType;//":"0"; //方案类型；0未选择(默认），1强制型，2大众型，3加强型，4自定义
@property (nonatomic, strong) NSString *planId;//":"1"; //方案ID
@property (nonatomic, assign) NSInteger insuranceType;//":1; //1车险，。。。
@property (nonatomic, strong) NSDate *createdAt;//":1; //创建时间
@property (nonatomic, assign) NSInteger orderStatus;//":"1"; //只会返回1

@property (nonatomic, assign) NSInteger orderOfferStatus;//":"1"; //订单报价状态；1等待报价，2报价失败(读取失败原因,StatusId,StatusMsg），3报价完成，4出单配送-未付款（货到付款），5出单配送-付款中，6出单配送-已付款，7付款失败，8交易成功，9已过期，10禁止流程操作当扫表状态为1或2的时候，进行报价

@property (nonatomic, strong) NSDate *orderOfferTime;//":"2016xxxx"; //订单报价时间
@property (nonatomic, strong) NSString *orderOfferStatusId;//":"1"; //订单状态对应的msgId
@property (nonatomic, strong) NSString *orderOfferStatusMsg;//":"信息不全"; //订单状态描述
@property (nonatomic, strong) NSString *orderOfferStatusStr;
@property (nonatomic, strong) NSString *orderOfferStatusDescr;//":"身份证信息不完整"; //经纪人手动备注描述
@property (nonatomic, assign) NSInteger orderOfferPayType;//":"0"; //0未支付，1货到付款，2微信支付，3支付宝
@property (nonatomic, assign) NSInteger orderOfferNums;//":"0"; //订单报价数量，默认0
@property (nonatomic, assign) float orderOfferOrigPrice;//":"0"; //原价 - 成功后才维护值
@property (nonatomic, assign) float orderOfferRatio;//":"0"; //折扣率 - 成功后才维护值
@property (nonatomic, assign) float orderOfferPayPrice;//":"0"; //实际支付价 - 成功后才维护值
@property (nonatomic, strong) NSString *customerName;//":"长得帅"; //经纪人姓名
@property (nonatomic, strong) NSString *customerPhone;//电话
@property (nonatomic, strong) NSString *carNo;//":"川A11111"; //投保车牌号
@property (nonatomic, strong) NSString *respAddr;//;":"/car_insur/car_insur_plan.html?orderId=0f5e240754e143bd97bb083041634987"; //点击地址，参数什么的都拼接好了，没有参数不跳转

@property (nonatomic, assign) NSInteger orderOfferPrintStatus;//0:等待出单 1:等待出单 2:出单配送中

@property (nonatomic, strong) NSString *planTypeName;
@property (nonatomic, strong) NSString *planOfferId;

@property (nonatomic, strong) NSString *productLogo;

@end
