
/*
 * ----------------------------------------------------------------------
 * THIS FILE IS AUTOMATICALLY GENERATED. DO NOT EDIT.
 * Created by: /home/andrewm/working/mrtools-micca/micca/code/starpack/x86_64-linux-tcl8.6/micca/lib/application/micca_main.tcl simplebookstore.micca sbs_population.micca
 * Created on: Sat Sep 09 17:40:06 PDT 2017
 * This is micca version 1.0b7
 * ----------------------------------------------------------------------
 */

#ifndef BOOKSTORE_H_
#define BOOKSTORE_H_
#include "micca_rt.h"
#include <assert.h>
/*
 * Domain Interface Contents
 */
#include <time.h>
/*
 * Type Aliases
 */
typedef time_t DateType_t ;
typedef enum {AP_approved, AP_overlimit, AP_noAccount, AP_connectionFailed, AP_accountDataMismatch, AP_expired, AP_pending} APCode_t ;

/*
 * Domain Operations External Declarations
 */
extern void bookstore_changeSelectionQuantity(MRT_InstId, MRT_InstId, unsigned) ;

/*
 * External Operations Declarations
 */
extern void bookstore_CreditCardCompany_requestChargeApproval__EOP(MRT_InstId, char const *, char const *, char const *, DateType_t, unsigned, unsigned) ;
extern void bookstore_OnlineCustomer_chargeDeclined__EOP(MRT_InstId, char const *) ;
extern void bookstore_OnlineCustomer_chargeApproved__EOP(MRT_InstId, char const *) ;
extern void bookstore_OnlineCustomer_orderReportedDelivered__EOP(MRT_InstId, char const *) ;
extern void bookstore_ShippingCompanyEE_shipmentReadyForPickup__EOP(MRT_InstId) ;
extern void bookstore_ShippingClerkEE_shipmentReadyToPack__EOP(MRT_InstId, unsigned) ;

/*
 * Event Parameter Structure Declarations
 */
struct bookstore_CreditCardCharge_chargeProcessed__EPARAMS {
    APCode_t resultCode ;
} ;
static_assert(sizeof(struct bookstore_CreditCardCharge_chargeProcessed__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, CreditCardCharge, event, chargeProcessed, are too large") ;
struct bookstore_Order_subCharge__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType_t cardExpirationDate ;
    char const * cardholderName ;
} ;
static_assert(sizeof(struct bookstore_Order_subCharge__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, subCharge, are too large") ;
struct bookstore_Order_submitCharge__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType_t cardExpirationDate ;
    char const * cardholderName ;
} ;
static_assert(sizeof(struct bookstore_Order_submitCharge__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, submitCharge, are too large") ;
struct bookstore_Order_checkOut__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType_t cardExpirationDate ;
    char const * cardholderName ;
    char const * customerEmail ;
} ;
static_assert(sizeof(struct bookstore_Order_checkOut__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, checkOut, are too large") ;
struct bookstore_ProductSelection_changeQuantity__EPARAMS {
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ProductSelection_changeQuantity__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ProductSelection, event, changeQuantity, are too large") ;
struct bookstore_ProductSelection_addSelection__EPARAMS {
    char const * productID ;
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ProductSelection_addSelection__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ProductSelection, event, addSelection, are too large") ;
struct bookstore_Shipment_packed__EPARAMS {
    unsigned clerkID ;
} ;
static_assert(sizeof(struct bookstore_Shipment_packed__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Shipment, event, packed, are too large") ;
struct bookstore_Shipment_trackingNumberAssigned__EPARAMS {
    char const * shippingCompany ;
    char const * trackingNumber ;
} ;
static_assert(sizeof(struct bookstore_Shipment_trackingNumberAssigned__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Shipment, event, trackingNumberAssigned, are too large") ;
struct bookstore_Shipment_deliveryConfirmed__EPARAMS {
    DateType_t timeDelivered ;
} ;
static_assert(sizeof(struct bookstore_Shipment_deliveryConfirmed__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Shipment, event, deliveryConfirmed, are too large") ;
struct bookstore_ShoppingCart_checkOut__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType_t cardExpirationDate ;
    char const * cardholderName ;
    char const * customerEmail ;
    char const * customerName ;
    char const * customerPhone ;
    char const * shippingAddress ;
} ;
static_assert(sizeof(struct bookstore_ShoppingCart_checkOut__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ShoppingCart, event, checkOut, are too large") ;
struct bookstore_ShoppingCart_addSelection__EPARAMS {
    char const * productID ;
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ShoppingCart_addSelection__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ShoppingCart, event, addSelection, are too large") ;
struct bookstore_ShoppingCart_startCart__EPARAMS {
    char const * productID ;
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ShoppingCart_startCart__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ShoppingCart, event, startCart, are too large") ;

/*
 * Numeric encoding of classes, attributes and instances used by the portal
 * functions
 */
#define BOOKSTORE_CLASSCOUNT 37
/*
 * Class: Product Attribute Encoding
 */
#define BOOKSTORE_PRODUCT_CLASSID 0
#define BOOKSTORE_PRODUCT_ATTRCOUNT 7
#define BOOKSTORE_PRODUCT_COPYRIGHT_ATTRID 0
#define BOOKSTORE_PRODUCT_CURRENTLYAVAILABLE_ATTRID 1
#define BOOKSTORE_PRODUCT_DESCRIPTION_ATTRID 2
#define BOOKSTORE_PRODUCT_PRODUCTID_ATTRID 3
#define BOOKSTORE_PRODUCT_PRODUCTNAME_ATTRID 4
#define BOOKSTORE_PRODUCT_UNITPRICE_ATTRID 5
#define BOOKSTORE_PRODUCT_WEBSITE_ATTRID 6
/*
 * Class: Product Instance Encoding
 */
#define BOOKSTORE_PRODUCT_INSTCOUNT 3
#define BOOKSTORE_PRODUCT_MBXUML_INSTID 0
#define BOOKSTORE_PRODUCT_CMC_INSTID 1
#define BOOKSTORE_PRODUCT_MACWD_INSTID 2
/*
 * Class: Publisher Attribute Encoding
 */
#define BOOKSTORE_PUBLISHER_CLASSID 1
#define BOOKSTORE_PUBLISHER_ATTRCOUNT 5
#define BOOKSTORE_PUBLISHER_ADDRESS_ATTRID 0
#define BOOKSTORE_PUBLISHER_GROUPCODE_ATTRID 1
#define BOOKSTORE_PUBLISHER_NAME_ATTRID 2
#define BOOKSTORE_PUBLISHER_PUBLISHERCODE_ATTRID 3
#define BOOKSTORE_PUBLISHER_WEBSITE_ATTRID 4
/*
 * Class: Publisher Instance Encoding
 */
#define BOOKSTORE_PUBLISHER_INSTCOUNT 3
#define BOOKSTORE_PUBLISHER_MS_INSTID 2
#define BOOKSTORE_PUBLISHER_OTM_INSTID 1
#define BOOKSTORE_PUBLISHER_AW_INSTID 0
/*
 * Class: Author Attribute Encoding
 */
#define BOOKSTORE_AUTHOR_CLASSID 2
#define BOOKSTORE_AUTHOR_ATTRCOUNT 3
#define BOOKSTORE_AUTHOR_EMAIL_ATTRID 0
#define BOOKSTORE_AUTHOR_NAME_ATTRID 1
#define BOOKSTORE_AUTHOR_WEBSITE_ATTRID 2
/*
 * Class: Author Instance Encoding
 */
#define BOOKSTORE_AUTHOR_INSTCOUNT 2
#define BOOKSTORE_AUTHOR_SJM_INSTID 0
#define BOOKSTORE_AUTHOR_MJB_INSTID 1
/*
 * Class: Authorship Attribute Encoding
 */
#define BOOKSTORE_AUTHORSHIP_CLASSID 3
#define BOOKSTORE_AUTHORSHIP_ATTRCOUNT 2
#define BOOKSTORE_AUTHORSHIP_POSTCREDIT_ATTRID 0
#define BOOKSTORE_AUTHORSHIP_PRECREDIT_ATTRID 1
/*
 * Class: Authorship Instance Encoding
 */
#define BOOKSTORE_AUTHORSHIP_INSTCOUNT 2
#define BOOKSTORE_AUTHORSHIP_SJM_INSTID 0
#define BOOKSTORE_AUTHORSHIP_MJB_INSTID 1
/*
 * Class: AuthorshipSequence Attribute Encoding
 */
#define BOOKSTORE_AUTHORSHIPSEQUENCE_CLASSID 4
#define BOOKSTORE_AUTHORSHIPSEQUENCE_ATTRCOUNT 0
/*
 * Class: AuthorshipSequence Instance Encoding
 */
#define BOOKSTORE_AUTHORSHIPSEQUENCE_INSTCOUNT 1
#define BOOKSTORE_AUTHORSHIPSEQUENCE_MBXUML_INSTID 0
/*
 * Class: BookProduct Attribute Encoding
 */
#define BOOKSTORE_BOOKPRODUCT_CLASSID 5
#define BOOKSTORE_BOOKPRODUCT_ATTRCOUNT 4
#define BOOKSTORE_BOOKPRODUCT_BOOKNUMBER_ATTRID 0
#define BOOKSTORE_BOOKPRODUCT_SUBTITLE_ATTRID 1
#define BOOKSTORE_BOOKPRODUCT_TITLE_ATTRID 2
#define BOOKSTORE_BOOKPRODUCT_TITLECODE_ATTRID 3
/*
 * Class: BookProduct Instance Encoding
 */
#define BOOKSTORE_BOOKPRODUCT_INSTCOUNT 1
#define BOOKSTORE_BOOKPRODUCT_MBXUML_INSTID 0
/*
 * Class: RecordingProduct Attribute Encoding
 */
#define BOOKSTORE_RECORDINGPRODUCT_CLASSID 6
#define BOOKSTORE_RECORDINGPRODUCT_ATTRCOUNT 1
#define BOOKSTORE_RECORDINGPRODUCT_RUNNINGTIME_ATTRID 0
/*
 * Class: RecordingProduct Instance Encoding
 */
#define BOOKSTORE_RECORDINGPRODUCT_INSTCOUNT 1
#define BOOKSTORE_RECORDINGPRODUCT_CMC_INSTID 0
/*
 * Class: SoftwareProduct Attribute Encoding
 */
#define BOOKSTORE_SOFTWAREPRODUCT_CLASSID 7
#define BOOKSTORE_SOFTWAREPRODUCT_ATTRCOUNT 1
#define BOOKSTORE_SOFTWAREPRODUCT_PRODUCTVERSION_ATTRID 0
/*
 * Class: SoftwareProduct Instance Encoding
 */
#define BOOKSTORE_SOFTWAREPRODUCT_INSTCOUNT 1
#define BOOKSTORE_SOFTWAREPRODUCT_MACWD_INSTID 0
/*
 * Class: SpecialOrderProduct Attribute Encoding
 */
#define BOOKSTORE_SPECIALORDERPRODUCT_CLASSID 8
#define BOOKSTORE_SPECIALORDERPRODUCT_ATTRCOUNT 2
#define BOOKSTORE_SPECIALORDERPRODUCT_DAYSTODELIVER_ATTRID 0
#define BOOKSTORE_SPECIALORDERPRODUCT_SPECIALORDERINSTRUCTIONS_ATTRID 1
/*
 * Class: SpecialOrderProduct Instance Encoding
 */
#define BOOKSTORE_SPECIALORDERPRODUCT_INSTCOUNT 1
#define BOOKSTORE_SPECIALORDERPRODUCT_CMC_INSTID 0
/*
 * Class: StockedProduct Attribute Encoding
 */
#define BOOKSTORE_STOCKEDPRODUCT_CLASSID 9
#define BOOKSTORE_STOCKEDPRODUCT_ATTRCOUNT 4
#define BOOKSTORE_STOCKEDPRODUCT_QUANTITYONHAND_ATTRID 0
#define BOOKSTORE_STOCKEDPRODUCT_REORDERINCREMENT_ATTRID 1
#define BOOKSTORE_STOCKEDPRODUCT_REORDERINSTRUCTIONS_ATTRID 2
#define BOOKSTORE_STOCKEDPRODUCT_REORDERTHRESHOLD_ATTRID 3
/*
 * Class: StockedProduct Instance Encoding
 */
#define BOOKSTORE_STOCKEDPRODUCT_INSTCOUNT 2
#define BOOKSTORE_STOCKEDPRODUCT_MBXUML_INSTID 0
#define BOOKSTORE_STOCKEDPRODUCT_MACWD_INSTID 1
/*
 * Class: ProductCategory Attribute Encoding
 */
#define BOOKSTORE_PRODUCTCATEGORY_CLASSID 10
#define BOOKSTORE_PRODUCTCATEGORY_ATTRCOUNT 1
#define BOOKSTORE_PRODUCTCATEGORY_CATEGORYNAME_ATTRID 0
/*
 * Class: ProductCategory Instance Encoding
 */
#define BOOKSTORE_PRODUCTCATEGORY_INSTCOUNT 5
#define BOOKSTORE_PRODUCTCATEGORY_SOFTWARE_INSTID 4
#define BOOKSTORE_PRODUCTCATEGORY_MUSIC_INSTID 3
#define BOOKSTORE_PRODUCTCATEGORY_NON_FICTION_INSTID 2
#define BOOKSTORE_PRODUCTCATEGORY_BOOK_INSTID 0
#define BOOKSTORE_PRODUCTCATEGORY_FICTION_INSTID 1
/*
 * Class: CategoryGroup Attribute Encoding
 */
#define BOOKSTORE_CATEGORYGROUP_CLASSID 11
#define BOOKSTORE_CATEGORYGROUP_ATTRCOUNT 0
/*
 * Class: CategoryGroup Instance Encoding
 */
#define BOOKSTORE_CATEGORYGROUP_INSTCOUNT 2
#define BOOKSTORE_CATEGORYGROUP_FICTIONCAT_INSTID 0
#define BOOKSTORE_CATEGORYGROUP_NONFICTIONCAT_INSTID 1
/*
 * Class: Recording Attribute Encoding
 */
#define BOOKSTORE_RECORDING_CLASSID 12
#define BOOKSTORE_RECORDING_ATTRCOUNT 1
#define BOOKSTORE_RECORDING_TITLE_ATTRID 0
/*
 * Class: Recording Instance Encoding
 */
#define BOOKSTORE_RECORDING_INSTCOUNT 1
#define BOOKSTORE_RECORDING_CMC_INSTID 0
/*
 * Class: Artist Attribute Encoding
 */
#define BOOKSTORE_ARTIST_CLASSID 13
#define BOOKSTORE_ARTIST_ATTRCOUNT 1
#define BOOKSTORE_ARTIST_ARTISTNAME_ATTRID 0
/*
 * Class: Artist Instance Encoding
 */
#define BOOKSTORE_ARTIST_INSTCOUNT 2
#define BOOKSTORE_ARTIST_MJ_INSTID 0
#define BOOKSTORE_ARTIST_FS_INSTID 1
/*
 * Class: PerformanceCredit Attribute Encoding
 */
#define BOOKSTORE_PERFORMANCECREDIT_CLASSID 14
#define BOOKSTORE_PERFORMANCECREDIT_ATTRCOUNT 1
#define BOOKSTORE_PERFORMANCECREDIT_ROLE_ATTRID 0
/*
 * Class: PerformanceCredit Instance Encoding
 */
#define BOOKSTORE_PERFORMANCECREDIT_INSTCOUNT 2
#define BOOKSTORE_PERFORMANCECREDIT_MJ_INSTID 0
#define BOOKSTORE_PERFORMANCECREDIT_FS_INSTID 1
/*
 * Class: PerformanceCreditSequence Attribute Encoding
 */
#define BOOKSTORE_PERFORMANCECREDITSEQUENCE_CLASSID 15
#define BOOKSTORE_PERFORMANCECREDITSEQUENCE_ATTRCOUNT 0
/*
 * Class: PerformanceCreditSequence Instance Encoding
 */
#define BOOKSTORE_PERFORMANCECREDITSEQUENCE_INSTCOUNT 1
#define BOOKSTORE_PERFORMANCECREDITSEQUENCE_CMC_INSTID 0
/*
 * Class: RecordingFormat Attribute Encoding
 */
#define BOOKSTORE_RECORDINGFORMAT_CLASSID 16
#define BOOKSTORE_RECORDINGFORMAT_ATTRCOUNT 1
#define BOOKSTORE_RECORDINGFORMAT_FORMATNAME_ATTRID 0
/*
 * Class: RecordingFormat Instance Encoding
 */
#define BOOKSTORE_RECORDINGFORMAT_INSTCOUNT 1
#define BOOKSTORE_RECORDINGFORMAT_CD_INSTID 0
/*
 * Class: Platform Attribute Encoding
 */
#define BOOKSTORE_PLATFORM_CLASSID 17
#define BOOKSTORE_PLATFORM_ATTRCOUNT 1
#define BOOKSTORE_PLATFORM_PLATFORMNAME_ATTRID 0
/*
 * Class: Platform Instance Encoding
 */
#define BOOKSTORE_PLATFORM_INSTCOUNT 1
#define BOOKSTORE_PLATFORM_MACOSX_INSTID 0
/*
 * Class: ComputerSoftware Attribute Encoding
 */
#define BOOKSTORE_COMPUTERSOFTWARE_CLASSID 18
#define BOOKSTORE_COMPUTERSOFTWARE_ATTRCOUNT 1
#define BOOKSTORE_COMPUTERSOFTWARE_TITLE_ATTRID 0
/*
 * Class: ComputerSoftware Instance Encoding
 */
#define BOOKSTORE_COMPUTERSOFTWARE_INSTCOUNT 1
#define BOOKSTORE_COMPUTERSOFTWARE_MACWD_INSTID 0
/*
 * Class: Customer Attribute Encoding
 */
#define BOOKSTORE_CUSTOMER_CLASSID 19
#define BOOKSTORE_CUSTOMER_ATTRCOUNT 5
#define BOOKSTORE_CUSTOMER_EMAIL_ATTRID 0
#define BOOKSTORE_CUSTOMER_NAME_ATTRID 1
#define BOOKSTORE_CUSTOMER_PHONE_ATTRID 2
#define BOOKSTORE_CUSTOMER_PURCHASESMADE_ATTRID 3
#define BOOKSTORE_CUSTOMER_SHIPPINGADDRESS_ATTRID 4
/*
 * Class: Customer Instance Encoding
 */
#define BOOKSTORE_CUSTOMER_INSTCOUNT 20
/*
 * Class: Order Attribute Encoding
 */
#define BOOKSTORE_ORDER_CLASSID 20
#define BOOKSTORE_ORDER_ATTRCOUNT 6
#define BOOKSTORE_ORDER_CONTACTPHONE_ATTRID 0
#define BOOKSTORE_ORDER_DATEORDERPLACED_ATTRID 1
#define BOOKSTORE_ORDER_DELIVERYADDRESS_ATTRID 2
#define BOOKSTORE_ORDER_ORDERID_ATTRID 3
#define BOOKSTORE_ORDER_RECIPIENT_ATTRID 4
#define BOOKSTORE_ORDER_TOTALVALUE_ATTRID 5
/*
 * Class: Order Instance Encoding
 */
#define BOOKSTORE_ORDER_INSTCOUNT 20
/*
 * Class: OrderPlacement Attribute Encoding
 */
#define BOOKSTORE_ORDERPLACEMENT_CLASSID 21
#define BOOKSTORE_ORDERPLACEMENT_ATTRCOUNT 0
/*
 * Class: OrderPlacement Instance Encoding
 */
#define BOOKSTORE_ORDERPLACEMENT_INSTCOUNT 20
/*
 * Class: ProductSelection Attribute Encoding
 */
#define BOOKSTORE_PRODUCTSELECTION_CLASSID 22
#define BOOKSTORE_PRODUCTSELECTION_ATTRCOUNT 3
#define BOOKSTORE_PRODUCTSELECTION_QUANTITY_ATTRID 0
#define BOOKSTORE_PRODUCTSELECTION_SELECTIONVALUE_ATTRID 1
#define BOOKSTORE_PRODUCTSELECTION_UNITPRICEOFSELECTION_ATTRID 2
/*
 * Class: ProductSelection Instance Encoding
 */
#define BOOKSTORE_PRODUCTSELECTION_INSTCOUNT 40
/*
 * Class: ShoppingCart Attribute Encoding
 */
#define BOOKSTORE_SHOPPINGCART_CLASSID 23
#define BOOKSTORE_SHOPPINGCART_ATTRCOUNT 2
#define BOOKSTORE_SHOPPINGCART_CARTID_ATTRID 0
#define BOOKSTORE_SHOPPINGCART_TOTALVALUE_ATTRID 1
/*
 * Class: ShoppingCart Instance Encoding
 */
#define BOOKSTORE_SHOPPINGCART_INSTCOUNT 20
/*
 * Class: CreditCardCharge Attribute Encoding
 */
#define BOOKSTORE_CREDITCARDCHARGE_CLASSID 24
#define BOOKSTORE_CREDITCARDCHARGE_ATTRCOUNT 8
#define BOOKSTORE_CREDITCARDCHARGE_ACCOUNTNUMBER_ATTRID 0
#define BOOKSTORE_CREDITCARDCHARGE_APPROVALCODE_ATTRID 1
#define BOOKSTORE_CREDITCARDCHARGE_BILLINGADDRESS_ATTRID 2
#define BOOKSTORE_CREDITCARDCHARGE_CARDEXPIRATIONDATE_ATTRID 3
#define BOOKSTORE_CREDITCARDCHARGE_CARDHOLDERNAME_ATTRID 4
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEAMOUNT_ATTRID 5
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEID_ATTRID 6
#define BOOKSTORE_CREDITCARDCHARGE_DATECHARGEMADE_ATTRID 7
/*
 * Class: CreditCardCharge Instance Encoding
 */
#define BOOKSTORE_CREDITCARDCHARGE_INSTCOUNT 40
/*
 * Class: OrderPayment Attribute Encoding
 */
#define BOOKSTORE_ORDERPAYMENT_CLASSID 25
#define BOOKSTORE_ORDERPAYMENT_ATTRCOUNT 0
/*
 * Class: OrderPayment Instance Encoding
 */
#define BOOKSTORE_ORDERPAYMENT_INSTCOUNT 40
/*
 * Class: Shipment Attribute Encoding
 */
#define BOOKSTORE_SHIPMENT_CLASSID 26
#define BOOKSTORE_SHIPMENT_ATTRCOUNT 9
#define BOOKSTORE_SHIPMENT_CONTACTPHONE_ATTRID 0
#define BOOKSTORE_SHIPMENT_DELIVERYADDRESS_ATTRID 1
#define BOOKSTORE_SHIPMENT_RECIPIENT_ATTRID 2
#define BOOKSTORE_SHIPMENT_SHIPMENTID_ATTRID 3
#define BOOKSTORE_SHIPMENT_TIMEDELIVERED_ATTRID 4
#define BOOKSTORE_SHIPMENT_TIMEPICKEDUP_ATTRID 5
#define BOOKSTORE_SHIPMENT_TIMEPREPARED_ATTRID 6
#define BOOKSTORE_SHIPMENT_TRACKINGNUMBER_ATTRID 7
#define BOOKSTORE_SHIPMENT_WAITINGTOBEPACKED_ATTRID 8
/*
 * Class: Shipment Instance Encoding
 */
#define BOOKSTORE_SHIPMENT_INSTCOUNT 20
/*
 * Class: Delivery Attribute Encoding
 */
#define BOOKSTORE_DELIVERY_CLASSID 27
#define BOOKSTORE_DELIVERY_ATTRCOUNT 0
/*
 * Class: Delivery Instance Encoding
 */
#define BOOKSTORE_DELIVERY_INSTCOUNT 20
/*
 * Class: PastPacking Attribute Encoding
 */
#define BOOKSTORE_PASTPACKING_CLASSID 28
#define BOOKSTORE_PASTPACKING_ATTRCOUNT 0
/*
 * Class: PastPacking Instance Encoding
 */
#define BOOKSTORE_PASTPACKING_INSTCOUNT 20
/*
 * Class: Packing Attribute Encoding
 */
#define BOOKSTORE_PACKING_CLASSID 29
#define BOOKSTORE_PACKING_ATTRCOUNT 0
/*
 * Class: Packing Instance Encoding
 */
#define BOOKSTORE_PACKING_INSTCOUNT 20
/*
 * Class: ShippingCompany Attribute Encoding
 */
#define BOOKSTORE_SHIPPINGCOMPANY_CLASSID 30
#define BOOKSTORE_SHIPPINGCOMPANY_ATTRCOUNT 6
#define BOOKSTORE_SHIPPINGCOMPANY_COMPANYNAME_ATTRID 0
#define BOOKSTORE_SHIPPINGCOMPANY_CUSTOMERSERVICEPHONE_ATTRID 1
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALCONTACT_ATTRID 2
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALDISPATCHPHONE_ATTRID 3
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALOFFICE_ATTRID 4
#define BOOKSTORE_SHIPPINGCOMPANY_TRACKINGWEBSITE_ATTRID 5
/*
 * Class: ShippingCompany Instance Encoding
 */
#define BOOKSTORE_SHIPPINGCOMPANY_INSTCOUNT 2
#define BOOKSTORE_SHIPPINGCOMPANY_FEDEX_INSTID 0
#define BOOKSTORE_SHIPPINGCOMPANY_UPS_INSTID 1
/*
 * Class: WarehouseClerk Attribute Encoding
 */
#define BOOKSTORE_WAREHOUSECLERK_CLASSID 31
#define BOOKSTORE_WAREHOUSECLERK_ATTRCOUNT 3
#define BOOKSTORE_WAREHOUSECLERK_CLERKID_ATTRID 0
#define BOOKSTORE_WAREHOUSECLERK_CLERKNAME_ATTRID 1
#define BOOKSTORE_WAREHOUSECLERK_GOOFFDUTYATENDOFJOB_ATTRID 2
/*
 * Class: WarehouseClerk Instance Encoding
 */
#define BOOKSTORE_WAREHOUSECLERK_INSTCOUNT 3
#define BOOKSTORE_WAREHOUSECLERK_FS_INSTID 0
#define BOOKSTORE_WAREHOUSECLERK_JI_INSTID 1
#define BOOKSTORE_WAREHOUSECLERK_GS_INSTID 2
/*
 * Class: Warehouse Attribute Encoding
 */
#define BOOKSTORE_WAREHOUSE_CLASSID 32
#define BOOKSTORE_WAREHOUSE_ATTRCOUNT 2
#define BOOKSTORE_WAREHOUSE_WAREHOUSELOCATION_ATTRID 0
#define BOOKSTORE_WAREHOUSE_WAREHOUSENAME_ATTRID 1
/*
 * Class: Warehouse Instance Encoding
 */
#define BOOKSTORE_WAREHOUSE_INSTCOUNT 2
#define BOOKSTORE_WAREHOUSE_ACME_INSTID 0
#define BOOKSTORE_WAREHOUSE_MF_INSTID 1
/*
 * Class: ShippingClerk Attribute Encoding
 */
#define BOOKSTORE_SHIPPINGCLERK_CLASSID 33
#define BOOKSTORE_SHIPPINGCLERK_ATTRCOUNT 1
#define BOOKSTORE_SHIPPINGCLERK_AWAITINGASSIGNMENT_ATTRID 0
/*
 * Class: ShippingClerk Instance Encoding
 */
#define BOOKSTORE_SHIPPINGCLERK_INSTCOUNT 1
#define BOOKSTORE_SHIPPINGCLERK_FS_INSTID 0
/*
 * Class: StockClerk Attribute Encoding
 */
#define BOOKSTORE_STOCKCLERK_CLASSID 34
#define BOOKSTORE_STOCKCLERK_ATTRCOUNT 1
#define BOOKSTORE_STOCKCLERK_IDLE_ATTRID 0
/*
 * Class: StockClerk Instance Encoding
 */
#define BOOKSTORE_STOCKCLERK_INSTCOUNT 1
#define BOOKSTORE_STOCKCLERK_JI_INSTID 0
/*
 * Class: OffDutyClerk Attribute Encoding
 */
#define BOOKSTORE_OFFDUTYCLERK_CLASSID 35
#define BOOKSTORE_OFFDUTYCLERK_ATTRCOUNT 0
/*
 * Class: OffDutyClerk Instance Encoding
 */
#define BOOKSTORE_OFFDUTYCLERK_INSTCOUNT 1
#define BOOKSTORE_OFFDUTYCLERK_GS_INSTID 0
/*
 * Class: ShipmentItem Attribute Encoding
 */
#define BOOKSTORE_SHIPMENTITEM_CLASSID 36
#define BOOKSTORE_SHIPMENTITEM_ATTRCOUNT 1
#define BOOKSTORE_SHIPMENTITEM_QUANTITYSHIPPED_ATTRID 0
/*
 * Class: ShipmentItem Instance Encoding
 */
#define BOOKSTORE_SHIPMENTITEM_INSTCOUNT 40
/*
 * Class: CreditCardCharge Event Encoding
 */
#define BOOKSTORE_CREDITCARDCHARGE_EVENTCOUNT 3
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEPROCESSED_EVENT 0
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEPROCESSINGNOTCOMPLETED_EVENT 1
#define BOOKSTORE_CREDITCARDCHARGE_MAKECHARGE_EVENT 2
/*
 * Class: Order Event Encoding
 */
#define BOOKSTORE_ORDER_EVENTCOUNT 6
#define BOOKSTORE_ORDER_CHECKOUT_EVENT 0
#define BOOKSTORE_ORDER_ORDERDELIVERED_EVENT 1
#define BOOKSTORE_ORDER_PAYMENTAPPROVED_EVENT 2
#define BOOKSTORE_ORDER_PAYMENTDECLINED_EVENT 3
#define BOOKSTORE_ORDER_SUBCHARGE_EVENT 4
#define BOOKSTORE_ORDER_SUBMITCHARGE_EVENT 5
/*
 * Class: ProductSelection Event Encoding
 */
#define BOOKSTORE_PRODUCTSELECTION_EVENTCOUNT 3
#define BOOKSTORE_PRODUCTSELECTION_ADDSELECTION_EVENT 0
#define BOOKSTORE_PRODUCTSELECTION_CHANGEQUANTITY_EVENT 1
#define BOOKSTORE_PRODUCTSELECTION_REMOVESELECTION_EVENT 2
/*
 * Class: Shipment Event Encoding
 */
#define BOOKSTORE_SHIPMENT_EVENTCOUNT 5
#define BOOKSTORE_SHIPMENT_DELIVERYCONFIRMED_EVENT 0
#define BOOKSTORE_SHIPMENT_PACKED_EVENT 1
#define BOOKSTORE_SHIPMENT_PICKEDUP_EVENT 2
#define BOOKSTORE_SHIPMENT_REQUESTSHIPMENT_EVENT 3
#define BOOKSTORE_SHIPMENT_TRACKINGNUMBERASSIGNED_EVENT 4
/*
 * Class: ShippingClerk Event Encoding
 */
#define BOOKSTORE_SHIPPINGCLERK_EVENTCOUNT 8
#define BOOKSTORE_SHIPPINGCLERK_BOOKSSELECTED_EVENT 0
#define BOOKSTORE_SHIPPINGCLERK_BOXATLOADINGDOC_EVENT 1
#define BOOKSTORE_SHIPPINGCLERK_BOXPACKED_EVENT 2
#define BOOKSTORE_SHIPPINGCLERK_BOXSEALED_EVENT 3
#define BOOKSTORE_SHIPPINGCLERK_CLERKASSIGNED_EVENT 4
#define BOOKSTORE_SHIPPINGCLERK_OFFDUTY_EVENT 5
#define BOOKSTORE_SHIPPINGCLERK_SHIPPINGLABELATTACHED_EVENT 6
#define BOOKSTORE_SHIPPINGCLERK_STARTSHIPPING_EVENT 7
/*
 * Class: ShoppingCart Event Encoding
 */
#define BOOKSTORE_SHOPPINGCART_EVENTCOUNT 4
#define BOOKSTORE_SHOPPINGCART_ADDSELECTION_EVENT 0
#define BOOKSTORE_SHOPPINGCART_CANCEL_EVENT 1
#define BOOKSTORE_SHOPPINGCART_CHECKOUT_EVENT 2
#define BOOKSTORE_SHOPPINGCART_STARTCART_EVENT 3
/*
 * Class: Warehouse Event Encoding
 */
#define BOOKSTORE_WAREHOUSE_EVENTCOUNT 3
#define BOOKSTORE_WAREHOUSE_CLERKASSIGNEDTOSHIPMENT_EVENT 0
#define BOOKSTORE_WAREHOUSE_CLERKFREE_EVENT 1
#define BOOKSTORE_WAREHOUSE_SHIPMENTREADYTOPACK_EVENT 2
/*
 * Class: CreditCardCharge State Encoding
 */
#define BOOKSTORE_CREDITCARDCHARGE_STATECOUNT 3
#define BOOKSTORE_CREDITCARDCHARGE_DECLINEFORTIMEOUT_STATE 3
#define BOOKSTORE_CREDITCARDCHARGE_PROCESSINGCOMPLETED_STATE 2
#define BOOKSTORE_CREDITCARDCHARGE_REQUESTINGCHARGEAPPROVAL_STATE 1
/*
 * Class: Order State Encoding
 */
#define BOOKSTORE_ORDER_STATECOUNT 5
#define BOOKSTORE_ORDER_BEINGPACKEDANDSHIPPED_STATE 4
#define BOOKSTORE_ORDER_DELIVEREDTOCUSTOMER_STATE 5
#define BOOKSTORE_ORDER_ESTABLISHINGCUSTOMERANDVERIFYINGPAYMENT_STATE 1
#define BOOKSTORE_ORDER_PAYMENTNOTAPPROVED_STATE 3
#define BOOKSTORE_ORDER_SUBMITTINGCHARGE_STATE 2
/*
 * Class: ProductSelection State Encoding
 */
#define BOOKSTORE_PRODUCTSELECTION_STATECOUNT 3
#define BOOKSTORE_PRODUCTSELECTION_CHANGINGQUANTITY_STATE 2
#define BOOKSTORE_PRODUCTSELECTION_NEWSELECTION_STATE 1
#define BOOKSTORE_PRODUCTSELECTION_REMOVINGSELECTION_STATE 3
/*
 * Class: Shipment State Encoding
 */
#define BOOKSTORE_SHIPMENT_STATECOUNT 7
#define BOOKSTORE_SHIPMENT_DELIVERED_STATE 7
#define BOOKSTORE_SHIPMENT_INTRANSITTOCUSTOMER_STATE 6
#define BOOKSTORE_SHIPMENT_NUMBERASSIGNED_STATE 4
#define BOOKSTORE_SHIPMENT_NUMBERASSIGNEDANDWAITINGTOBEPACKED_STATE 3
#define BOOKSTORE_SHIPMENT_PACKED_STATE 5
#define BOOKSTORE_SHIPMENT_PACKEDANDAWAITINGTRACKINGNUMBER_STATE 2
#define BOOKSTORE_SHIPMENT_PREPARINGSHIPMENT_STATE 1
/*
 * Class: ShippingClerk State Encoding
 */
#define BOOKSTORE_SHIPPINGCLERK_STATECOUNT 8
#define BOOKSTORE_SHIPPINGCLERK_ATTACHINGSHIPPINGLABEL_STATE 5
#define BOOKSTORE_SHIPPINGCLERK_COMPLETINGJOB_STATE 7
#define BOOKSTORE_SHIPPINGCLERK_DELIVERINGBOXTOLOADINGDOCK_STATE 6
#define BOOKSTORE_SHIPPINGCLERK_OFFDUTY_STATE 8
#define BOOKSTORE_SHIPPINGCLERK_PACKINGBOX_STATE 3
#define BOOKSTORE_SHIPPINGCLERK_SEALINGBOX_STATE 4
#define BOOKSTORE_SHIPPINGCLERK_SELECTINGBOOKS_STATE 2
#define BOOKSTORE_SHIPPINGCLERK_WAITINGFORAJOB_STATE 1
/*
 * Class: ShoppingCart State Encoding
 */
#define BOOKSTORE_SHOPPINGCART_STATECOUNT 4
#define BOOKSTORE_SHOPPINGCART_ADDINGSELECTIONTOORDER_STATE 2
#define BOOKSTORE_SHOPPINGCART_CANCELINGENTIREORDER_STATE 3
#define BOOKSTORE_SHOPPINGCART_ESTABLISHINGCUSTOMERANDVERIFYINGPAYMENT_STATE 4
#define BOOKSTORE_SHOPPINGCART_NEWORDER_STATE 1
/*
 * Class: Warehouse State Encoding
 */
#define BOOKSTORE_WAREHOUSE_STATECOUNT 3
#define BOOKSTORE_WAREHOUSE_ASSIGNINGCLERKTOSHIPMENT_STATE 2
#define BOOKSTORE_WAREHOUSE_WAITINGFORAFREECLERK_STATE 1
#define BOOKSTORE_WAREHOUSE_WAITINGFORASHIPMENT_STATE 0

/*
 * Domain Portal Declaration
 */
extern MRT_DomainPortal const bookstore__PORTAL ;

#endif /* BOOKSTORE_H_ */

