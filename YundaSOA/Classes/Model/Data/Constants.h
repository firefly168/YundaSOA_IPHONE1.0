//
//  Constants.h
//  YundaSOA_IPHONE
//
//  Created by tyson on 13-10-28.
//  Copyright (c) 2013年 com. All rights reserved.
//

#ifndef YundaSOA_IPHONE_Constants_h
#define YundaSOA_IPHONE_Constants_h

#ifdef DEBUG 
#ifdef Yunda_DEBUG
#define YundaLog(fmt, ...) NSLog((@"%@ [line %u]: " fmt), NSStringFromClass(self.class), __LINE__, ##__VA_ARGS__)
#else
#define YundaLog(...) /* */
#endif
#else
#define YundaLog(...) /* */
#endif

#define YundaWLog(fmt, ...) NSLog((@"%@ WARNING [line %u]: " fmt), NSStringFromClass(self.class), __LINE__, ##__VA_ARGS__)

#endif
