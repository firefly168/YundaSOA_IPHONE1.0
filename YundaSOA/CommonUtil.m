//
//  CommonUtil.m
//  YundaSOA
//
//  Created by rangex on 13-7-1.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "CommonUtil.h"
#import "ResponseBean.h"
#import "SPController.h"
#import "UserInfoBean.h"

@class UserInfoBean;

static UserInfoBean *loginUser;

static const char kBase64PaddingChar = '=';
static const char *kBase64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static int currentModuleIndex = MODULE_INDEX_CALENDAR;

@implementation CommonUtil

+(UserInfoBean *) getLoginUser {
    return loginUser;
}

+(void) setLoginUser:(UserInfoBean *)user {
    loginUser = user;
}

+(int) getCurrentModuleIndex {
    return currentModuleIndex;
}

+(void) setCurrentModuleIndex:(int)module {
    if (currentModuleIndex < MODULE_INDEX_SEARCH || currentModuleIndex > MODULE_INDEX_CREATE) {
        return;
    }
    currentModuleIndex = module;
}

+(ResponseBean *) checkResBean:(id)obj reqID:(int)reqID moduleID:(NSString *)moduleID {
    return [self _checkResBean:obj reqID:reqID moduleID:moduleID delegate:nil message:nil];
}

+(ResponseBean *) checkResBean:(id)obj reqID:(int)reqID moduleID:(NSString *)moduleID delegate:(UIViewController *)delegate message:(NSString *)msg {
    return [self _checkResBean:obj reqID:reqID moduleID:moduleID delegate:delegate message:msg];
}

+(ResponseBean *) _checkResBean:(id) obj reqID:(int) reqID moduleID:(NSString *) moduleID delegate:(UIViewController *)delegate message:(NSString *)msg {
    ResponsePackage *res = obj;
    if (!obj || ![obj getParam]) {
        if (delegate) {
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [dialog show];
        }
        return nil;
    }

    if ([res getReqID] != reqID || (moduleID && ![[res getModule_id] isEqual:moduleID])) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"reqID or ModuleID incorrect" userInfo:nil];
    }
    NSString * success = [[res getParam] success];
    if (![COM_SUCCESS isEqual:success]) {
        if ([COM_NET_ERROR isEqual:success]) {
            if (delegate) {
                UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"提示" message:[@"网络通讯异常！" stringByAppendingString:[[res getParam] message]]  delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [dialog show];
            }
            return  nil;
        }
        if (delegate) {
            UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"提示" message:[msg stringByAppendingString:[[res getParam] message]]  delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [dialog show];
        }
        return nil;
    }
    return [res getParam];
}

+(void) setAutoLogin:(BOOL)autologin password:(NSString *)pwd {
    [[SPController getInstance] setBooleanValue:autologin forKey:AUTO_LOGIN];
    [[SPController getInstance] setValue:(autologin? [loginUser userId]:@"") forKey:AUTO_LOGIN_USERID];
    [[SPController getInstance] setValue:(autologin? [loginUser operatorId]:@"") forKey:AUTO_LOGIN_OPERID];
    [[SPController getInstance] setValue:(autologin? [loginUser roleIds]:@"") forKey:AUTO_LOGIN_ROLEIDS];
    [[SPController getInstance] setValue:(autologin? pwd:@"") forKey:AUTO_LOGIN_PWD];
    [[SPController getInstance] setValue:(autologin? [loginUser userName]:@"") forKey:AUTO_LOGIN_USERNAME];
}

+(NSString *) encodeBase64:(NSString *)src {
    NSData *data = [self baseEncode:[[src dataUsingEncoding:NSUTF8StringEncoding] bytes] length:[src length] charset:kBase64EncodeChars padded:YES];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+(NSData *)baseEncode:(const void *)bytes
               length:(NSUInteger)length
              charset:(const char *)charset
               padded:(BOOL)padded {
    // how big could it be?
    NSUInteger maxLength = CalcEncodedLength(length, padded);
    // make space
    NSMutableData *result = [NSMutableData data];
    [result setLength:maxLength];
    // do it
    NSUInteger finalLength = [self baseEncode:bytes
                                       srcLen:length
                                    destBytes:[result mutableBytes]
                                      destLen:[result length]
                                      charset:charset
                                       padded:padded];
    if (finalLength) {
        //        _GTMDevAssert(finalLength == maxLength, @"how did we calc the length wrong?");
    } else {
        // shouldn't happen, this means we ran out of space
        result = nil;
    }
    return result;
}

NSUInteger CalcEncodedLength(NSUInteger srcLen, BOOL padded) {
    NSUInteger intermediate_result = 8 * srcLen + 5;
    NSUInteger len = intermediate_result / 6;
    if (padded) {
        len = ((len + 3) / 4) * 4;
    }
    return len;
}

+(NSUInteger)baseEncode:(const char *)srcBytes
                 srcLen:(NSUInteger)srcLen
              destBytes:(char *)destBytes
                destLen:(NSUInteger)destLen
                charset:(const char *)charset
                 padded:(BOOL)padded {
    if (!srcLen || !destLen || !srcBytes || !destBytes) {
        return 0;
    }
    
    char *curDest = destBytes;
    const unsigned char *curSrc = (const unsigned char *)(srcBytes);
    
    // Three bytes of data encodes to four characters of cyphertext.
    // So we can pump through three-byte chunks atomically.
    while (srcLen > 2) {
        // space?
        //        _GTMDevAssert(destLen >= 4, @"our calc for encoded length was wrong");
        curDest[0] = charset[curSrc[0] >> 2];
        curDest[1] = charset[((curSrc[0] & 0x03) << 4) + (curSrc[1] >> 4)];
        curDest[2] = charset[((curSrc[1] & 0x0f) << 2) + (curSrc[2] >> 6)];
        curDest[3] = charset[curSrc[2] & 0x3f];
        
        curDest += 4;
        curSrc += 3;
        srcLen -= 3;
        destLen -= 4;
    }
    
    // now deal with the tail (<=2 bytes)
    switch (srcLen) {
        case 0:
            // Nothing left; nothing more to do.
            break;
        case 1:
            // One byte left: this encodes to two characters, and (optionally)
            // two pad characters to round out the four-character cypherblock.
            //            _GTMDevAssert(destLen >= 2, @"our calc for encoded length was wrong");
            curDest[0] = charset[curSrc[0] >> 2];
            curDest[1] = charset[(curSrc[0] & 0x03) << 4];
            curDest += 2;
            destLen -= 2;
            if (padded) {
                //                _GTMDevAssert(destLen >= 2, @"our calc for encoded length was wrong");
                curDest[0] = kBase64PaddingChar;
                curDest[1] = kBase64PaddingChar;
                curDest += 2;
            }
            break;
        case 2:
            // Two bytes left: this encodes to three characters, and (optionally)
            // one pad character to round out the four-character cypherblock.
            //            _GTMDevAssert(destLen >= 3, @"our calc for encoded length was wrong");
            curDest[0] = charset[curSrc[0] >> 2];
            curDest[1] = charset[((curSrc[0] & 0x03) << 4) + (curSrc[1] >> 4)];
            curDest[2] = charset[(curSrc[1] & 0x0f) << 2];
            curDest += 3;
            destLen -= 3;
            if (padded) {
                //                _GTMDevAssert(destLen >= 1, @"our calc for encoded length was wrong");
                curDest[0] = kBase64PaddingChar;
                curDest += 1;
            }
            break;
    }
    // return the length
    return (curDest - destBytes);
}

+(void) setVersion:(NSString *)version {
    mVersion = version;
}

+(NSString *) getVersion {
    return mVersion;
}

@end

