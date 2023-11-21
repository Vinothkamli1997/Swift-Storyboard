//
//  ApiConstant.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/01/23.
//

import UIKit

enum ApiConstant {
    
    //Live URL
    static let base_Url = "https://yumbox.in/web/v1/"
    
    //Demo Url
//    static let base_Url = "https://demo.yumbox.in/web/v1/"
    
    //Salt Key
    static let salt_key = "yumboxtt@2022restapp"
        
    //LoginApi
    static let register =  base_Url + "signup/register"
    
    //Force Update
    static let forceUpdate = base_Url + "signup/appversion"
    
    //OTP Api
    static let otp = base_Url + "signup/mobilecheck"
    
    //cityApi
    static let city = base_Url + "outlet/city"
    
    //CITY OUTLET API
    static let outletlist = base_Url + "outlet/outletlist"
    
    //HomeScreen Api
    static let homeScreen = base_Url + "site/homepage"
    
    //WELCOME API
    static let welcomeApi = base_Url + "driver/getsupercoin"
    
    //Walllet EarnCoin Api
    static let WALLET_EARN_COIN_API = base_Url + "signup/get_event"
    
    //GoogleLogin Api
    static let GOOGLELOGIN = base_Url + "signup/register"
    
    //CakeDetail Screen Api
    static let CAKEDETAILSCREEN = base_Url + "site/getdishdetails"
    
    //DISCART VOUCHER API
    static let DISCARTVOUCHER = base_Url + "order/dishcart_voucher"

    //CUSINEWITH DISH API
    static let CUSINEWITHDISH = base_Url + "site/cuisinewithdish"
    
    //ADD FAVOURITE API
    static let ADDFAVOURITE = base_Url + "food/food_favorite_dish_add"
    
    //REMOVE FAVOURITE API
    static let REMOVEFAVOURITE = base_Url + "food/food_favorite_dish_remove"
    
    //LIKE FAVORITE API
    static let FAVORITEAPI = base_Url + "food/food_favorite_dish"
    
    //CKAEADD-ON SCREEN API
    static let CAKEADDON = base_Url + "site/dishdetails"
    
    //Addon APi
    static let ADDON_API = base_Url + "site/getaddon"
    
    //ADD TO CART API
    static let ADDTOCART = base_Url + "order/addtocart"
    
    //CARTSHOWING API
    static let CARTSHOWING = base_Url + "order/cart_showing"
    
    //CATEGORYWITHDISH API
    static let CATEGORYWITHDISH = base_Url + "site/categorywithdish"
    
    //FILTERAPI
    static let FILTER_API = base_Url + "search/filters"
    
    //CHECK FILTER API
    static let CHECKFILTER_API = base_Url + "search/filtercheck"
    
    //REMOVE FILTER API
    static let REMOVE_FILTER_API = base_Url + "search/filtereachdelete"
    
    //CLEARFILTER API
    static let CLEAR_FILTER_API = base_Url + "search/filterdelete"
    
    //FilterFetch Api
    static let FILTER_FETCH_API = base_Url + "search/filterfetch"
    
    //AddAdress
    static let ADD_ADDRESS_API = base_Url + "address/customer_address_add"
    
    //Address Showing Api
    static let ADDRESS_Sowing_API = base_Url + "address/customer_address_show"
    
    //Remove Address
    static let REMOVE_ADDESS_API = base_Url + "address/customer_address_remove"
    
    //Edit Address Api
    static let EDIT_ADDRESS_API = base_Url + "address/customer_address_edit"
    
    //Address Default Get Api
    static let ADDRESS_DEFAULT_GET_API = base_Url + "address/customer_address_default_get"
    
    //Address Default Edit Api
    static let ADDRESS_DEFAULT_EDIT_API = base_Url + "address/customer_address_default_edit"
    
    //Online Payment Api
    static let ONLINE_PAYMENT_API = base_Url + "order/online_payments"
    
    //Cart To Add Api
    static let CART_TO_ADD_API = base_Url + "order/cart_to_order"
    
    //Set DEL TYPE API
    static let SET_DEL_TYPE_API = base_Url + "order/getdeltype"
    
    //voucher list api
    static let VOUCHER_LIST_API = base_Url + "order/voucherlist"
    
    //Voucher Remove Api
    static let VOUCHER_REMOVE_API = base_Url + "order/voucher_remove"
    
    //VOUCHER APPLY API
    static let VOUCHER_APPLY_API = base_Url + "order/voucher_apply"
    
    //REDEEM COIN API
    static let REDEEM_COIN_API = base_Url + "driver/apply_coin"
    
    //Order History Screen
    static let ORDER_HISTORY_API = base_Url + "order/order_history"
    
    //Order Track Api
    static let ORDER_TRACK_API = base_Url + "order/ordertrack"
    
    //OrderSummary Api
    static let ORDER_SUMMARY_API = base_Url + "order/order_summery"
    
    //Account Api
    static let ACCOUNT_API = base_Url + "customer/profile"
    
    //Referral Api
    static let REFERRAL_API = base_Url + "customer/customerrefrel"
    
    //Profile Api
    static let PROFILE_API = base_Url + "customer/profile"
    
    //ProfileEdit Api
    static let PROFILE_EDIT_API = base_Url + "customer/profile_edit"
    
    //MobileNumber Update APi
    static let MOBILE_NUM_UPDATE_API = base_Url + "mobileverify/mobilevalid"
    
    //Update MobileNumber Verification
    static let UPDATE_MOBILE_VERIFY_API = base_Url + "mobileverify/mobileverifications"
    
    //Add Email api
    static let ADD_EMAIL_API = base_Url + "emailverify/emailvalid"
    
    //changeEmail Api
    static let CHANGE_EMAIL_API = base_Url + "mobileverify/mobile"
    
    //Email varify Api
    static let EMAIL_VERIFY_API = base_Url + "emailverify/emailverifications"
    
    //Apply Referral COde Api
    static let APPLY_REFERRAL_CODE = base_Url + "signup/apply_referal_id"
    
    static let ADD_EVENT_API = base_Url + "signup/relation"
    
    //Rating Api
    static let RATING_API = base_Url + "customer/ranking"
    
    //UpdateEvent Api
    static let UPDATE_EVENT_API = base_Url + "signup/updaterelation"
    
    //GetEventDetail
    static let GET_EVENT_DETAILS_API = base_Url + "signup/getrelation"
    
    //Addbonus EVent Api
    static let ADD_BONUS_API = base_Url + "signup/addbonusevent"
    
    //EarnCash GetClaim Api
    static let EarnCash_GetClaim = base_Url + "customer/get_claim"
    
    //EarnCash GetClaim Api
    static let EarnCash_CheckClaim = base_Url + "customer/check_claim"
    
    //EarnCash GetClaim Api
    static let EarnCash_ClaimApi = base_Url + "customer/check_claim"
    
    //EarnCash GetClaim Api
    static let downlineApi = base_Url + "customer/customer-referal-report"
    
    //EarnCash GetClaim Api
    static let notificationApi = base_Url + "order/notification-list"
    
    //EarnCash GetClaim Api
    static let getTextType = base_Url + "order/gettexttype"
    
    //EarnCash GetClaim Api
    static let paymentOptionApi = base_Url + "order/payment_options"
    
    //Rating and Review
    static let ratingAndReview = base_Url + "customer/review"
    
    //Rating and Review
    static let getSizeSaveDetails = base_Url + "signup/addquotation"
    
    //Rating and Review
    static let getSizeDetails = base_Url + "site/getsizedetails"
    
    //NewDwonline page api
    static let newDownLineApi = base_Url + "customer/claim"
    
    //NewDwonline page api
    static let remove_cart = base_Url + "order/remove_cart"
}
