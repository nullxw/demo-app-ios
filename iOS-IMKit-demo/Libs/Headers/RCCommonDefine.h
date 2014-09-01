//
//  RCCommonDefine.h
//  RongCloud
//
//  Created by Heq.Shinoda on 14-4-21.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#ifndef RongCloud_CommonDefine_h
#define RongCloud_CommonDefine_h

//---------------Macro Definination---------//
/**************************************************
 Description: Used for ARC mode or not.
 Author:    Hequn
 ***************************************************/
//- ARC not used -
#if ! __has_feature(objc_arc)
#define RCAutorelease(__obj) ([__obj autorelease]);
#define RCReturnAutoreleased RCAutorelease

#define RCRetain(__obj) ([__obj retain]);
#define RCReturnRetained RCRetain

#define RCRelease(__obj) ([__obj release]);
#else//__has_feature(objc_arc)
//- ARC used -
#define RCAutorelease(__obj)
#define RCReturnAutoreleased(__obj) (__obj)

#define RCRetain(__obj)
#define RCReturnRetained(__obj) (__obj)

#define RCRelease(__obj)
#endif//__has_feature(objc_arc)

#define SAFE_DELETE(p)  do\
    { \
        if(p != nil) \
        {\
            [p RCRelease]; \
            p = nil; \
        }\
    }while(0)


/**************************************************
 Description: common constanst.
 include notification-name, objectName, etc.
 ***************************************************/

#define KNotificationCenterRCMessageReceiver @"NotificationCenterRCMessageReceiver"


#define MESSAGE_TXT_OBJ_NAME    @"RC:TxtMsg"
#define MESSAGE_IMG_OBJ_NAME    @"RC:ImgMsg"
#define MESSAGE_VOICE_OBJ_NAME    @"RC:VcMsg"
#define MESSAGE_DIZNTF_OBJ_NAME    @"RC:DizNtf"
//#define MESSAGE_NTF_OBJ_NAME    @"RC:NtfMsg"
//#define MESSAGE_STATUS_OBJ_NAME    @"RC:StMsg"

//----App Environment，101-网络切换，102-应用进入后台，103-应用进入前台，104-锁屏，105-心跳, 106-解锁, 107-延时
typedef enum
{
    AppCurrentEnvironment_NetChanged = 101,
    AppCurrentEnvironment_Background,
    AppCurrentEnvironment_Foreground,
    AppCurrentEnvironment_ScreenLock,
    AppCurrentEnvironment_HeartBeat,
    AppCurrentEnvironment_ScreenUnLock,
    AppCurrentEnvironment_Background_Delay_Timeout
}KAppCurrentEnvironment;


//----client exception & error status----//
typedef enum
{
    ExceptionStatus_Success = 0,
    
    ExceptionStatus_Neterr_Channel_Invalid = 100,
    ExceptionStatus_Neterr_Connect_Fail    = 101,
    ExceptionStatus_Neterr_Send_Fail       = 102,
    
    ExceptionStatus_Ack_Timeout     = 900,
    ExceptionStatus_Send_Fail       = 901,
    ExceptionStatus_Connect_Timeout = 902,
    ExceptionStatus_Queryack_Nodata = 903,
    ExceptionStatus_Remote_Close    = 904,
    
    ExceptionStatus_Neterr_Disconnect_base    = 1000,
    ExceptionStatus_Neterr_disconnect_kick    = 1001,
    ExceptionStatus_Neterr_disconnect_unknown = 1002,
    
    ExceptionStatus_Connect_success               = 2000,
    ExceptionStatus_Connect_proto_version_error,
    ExceptionStatus_Connect_id_reject,
    ExceptionStatus_Connect_server_unavaliable,
    ExceptionStatus_Connect_user_or_pwd_error,
    ExceptionStatus_Connect_not_authorized,
    ExceptionStatus_Connect_redirect,
    
    ExceptionStatus_Net_unavaliable = 3001,
    ExceptionStatus_Navi_Connect_Fail = 3002,
    
    ExceptionStatus_Data_incomplete = 4001,
    //网络不可用，可用
    ExceptionStatus_NETWORK_ENABLE = 9001,
    ExceptionStatus_NETWORK_DISABLE,
} KExceptionStatus;

#endif//RongCloud_CommonDefine_h
