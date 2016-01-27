//
//  enumFile.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/8.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#ifndef enumFile_h
#define enumFile_h


typedef enum : NSUInteger {
    enumEditTypeNormal,
    enumEditTypeDel,
} enumEditType;


typedef enum : NSUInteger {
    enumShareTypeNo,
    enumShareTypeShare,
    enumShareTypeToCustomer,
} enumShareType;

typedef enum : NSUInteger {
    enumNeedInitShareInfoNo,
    enumNeedInitShareInfoYes,
} enumNeedInitShareInfo;

#endif /* enumFile_h */
