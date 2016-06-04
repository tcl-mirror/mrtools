
/*
 * ----------------------------------------------------------------------
 * THIS FILE IS AUTOMATICALLY GENERATED. DO NOT EDIT.
 * Created by: /home/andrewm/working/mrtools/micca/code/starpack/x86_64-linux-tcl8.6/micca/lib/application/micca_main.tcl simplebookstore.micca sbs_population.micca
 * Created on: Fri Jun 03 14:20:58 PDT 2016
 * This is micca version 0.1
 * ----------------------------------------------------------------------
 */

#ifndef BOOKSTORE_H_
#define BOOKSTORE_H_
#include "micca_rt.h"
/*
 * Domain Interface Contents
 */
#include <time.h>
/*
 * Type Aliases
 */
typedef enum {AP_approved, AP_overlimit, AP_noAccount, AP_connectionFailed, AP_accountDataMismatch, AP_expired, AP_pending} AP_Code ;
typedef time_t DateType ;

/*
 * Domain Operations External Declarations
 */
extern void bookstore_changeSelectionQuantity(MRT_InstId, MRT_InstId, unsigned) ;

/*
 * External Operations Declarations
 */
extern void bookstore_OnlineCustomer_orderReportedDelivered__EOP(MRT_InstId, char const *) ;
extern void bookstore_ShippingCompany_shipmentReadyForPickup__EOP(MRT_InstId) ;
extern void bookstore_CreditCardCompany_requestChargeApproval__EOP(MRT_InstId, char const *, char const *, char const *, DateType, unsigned, unsigned) ;
extern void bookstore_ShippingClerk_shipmentReadyToPack__EOP(MRT_InstId, unsigned) ;
extern void bookstore_OnlineCustomer_chargeApproved__EOP(MRT_InstId, char const *) ;
extern void bookstore_OnlineCustomer_chargeDeclined__EOP(MRT_InstId, char const *) ;

/*
 * Event Parameter Structure Declarations
 */
struct bookstore_CreditCardCharge_makeCharge__EPARAMS {
    struct Order * order ;
} ;
static_assert(sizeof(struct bookstore_CreditCardCharge_makeCharge__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, CreditCardCharge, event, makeCharge, are too large") ;
struct bookstore_CreditCardCharge_chargeProcessed__EPARAMS {
    AP_Code resultCode ;
} ;
static_assert(sizeof(struct bookstore_CreditCardCharge_chargeProcessed__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, CreditCardCharge, event, chargeProcessed, are too large") ;
struct bookstore_Order_subCharge__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType cardExpirationDate ;
    char const * cardholderName ;
} ;
static_assert(sizeof(struct bookstore_Order_subCharge__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, subCharge, are too large") ;
struct bookstore_Order_submitCharge__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType cardExpirationDate ;
    char const * cardholderName ;
} ;
static_assert(sizeof(struct bookstore_Order_submitCharge__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, submitCharge, are too large") ;
struct bookstore_Order_checkOut__EPARAMS {
    struct ShoppingCart * cart ;
    char const * accountNumber ;
    char const * billingAddress ;
    DateType cardExpirationDate ;
    char const * cardholderName ;
    char const * customerEmail ;
} ;
static_assert(sizeof(struct bookstore_Order_checkOut__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Order, event, checkOut, are too large") ;
struct bookstore_ProductSelection_changeQuantity__EPARAMS {
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ProductSelection_changeQuantity__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ProductSelection, event, changeQuantity, are too large") ;
struct bookstore_ProductSelection_addSelection__EPARAMS {
    unsigned cartID ;
    char const * productID ;
    unsigned quantity ;
} ;
static_assert(sizeof(struct bookstore_ProductSelection_addSelection__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, ProductSelection, event, addSelection, are too large") ;
struct bookstore_Shipment_requestShipment__EPARAMS {
    struct Order * order ;
} ;
static_assert(sizeof(struct bookstore_Shipment_requestShipment__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Shipment, event, requestShipment, are too large") ;
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
    DateType timeDelivered ;
} ;
static_assert(sizeof(struct bookstore_Shipment_deliveryConfirmed__EPARAMS) <= sizeof(MRT_EventParams), "Parameters for class or assigner, Shipment, event, deliveryConfirmed, are too large") ;
struct bookstore_ShoppingCart_checkOut__EPARAMS {
    char const * accountNumber ;
    char const * billingAddress ;
    DateType cardExpirationDate ;
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
#define BOOKSTORE_CLASSCOUNT 29
/*
 * Class: Product
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
#define BOOKSTORE_PRODUCT_INSTCOUNT 3
#define BOOKSTORE_PRODUCT_MBXUML_INSTID 0
#define BOOKSTORE_PRODUCT_CMC_INSTID 1
#define BOOKSTORE_PRODUCT_MACWD_INSTID 2
/*
 * Class: Publisher
 */
#define BOOKSTORE_PUBLISHER_CLASSID 1
#define BOOKSTORE_PUBLISHER_ATTRCOUNT 5
#define BOOKSTORE_PUBLISHER_ADDRESS_ATTRID 0
#define BOOKSTORE_PUBLISHER_GROUPCODE_ATTRID 1
#define BOOKSTORE_PUBLISHER_NAME_ATTRID 2
#define BOOKSTORE_PUBLISHER_PUBLISHERCODE_ATTRID 3
#define BOOKSTORE_PUBLISHER_WEBSITE_ATTRID 4
#define BOOKSTORE_PUBLISHER_INSTCOUNT 3
#define BOOKSTORE_PUBLISHER_MS_INSTID 2
#define BOOKSTORE_PUBLISHER_OTM_INSTID 1
#define BOOKSTORE_PUBLISHER_AW_INSTID 0
/*
 * Class: Author
 */
#define BOOKSTORE_AUTHOR_CLASSID 2
#define BOOKSTORE_AUTHOR_ATTRCOUNT 3
#define BOOKSTORE_AUTHOR_EMAIL_ATTRID 0
#define BOOKSTORE_AUTHOR_NAME_ATTRID 1
#define BOOKSTORE_AUTHOR_WEBSITE_ATTRID 2
#define BOOKSTORE_AUTHOR_INSTCOUNT 2
#define BOOKSTORE_AUTHOR_SJM_INSTID 0
#define BOOKSTORE_AUTHOR_MJB_INSTID 1
/*
 * Class: Authorship
 */
#define BOOKSTORE_AUTHORSHIP_CLASSID 3
#define BOOKSTORE_AUTHORSHIP_ATTRCOUNT 2
#define BOOKSTORE_AUTHORSHIP_POSTCREDIT_ATTRID 0
#define BOOKSTORE_AUTHORSHIP_PRECREDIT_ATTRID 1
#define BOOKSTORE_AUTHORSHIP_INSTCOUNT 2
#define BOOKSTORE_AUTHORSHIP_SJM_INSTID 0
#define BOOKSTORE_AUTHORSHIP_MJB_INSTID 1
/*
 * Class: BookProduct
 */
#define BOOKSTORE_BOOKPRODUCT_CLASSID 4
#define BOOKSTORE_BOOKPRODUCT_ATTRCOUNT 4
#define BOOKSTORE_BOOKPRODUCT_BOOKNUMBER_ATTRID 0
#define BOOKSTORE_BOOKPRODUCT_SUBTITLE_ATTRID 1
#define BOOKSTORE_BOOKPRODUCT_TITLE_ATTRID 2
#define BOOKSTORE_BOOKPRODUCT_TITLECODE_ATTRID 3
#define BOOKSTORE_BOOKPRODUCT_INSTCOUNT 1
#define BOOKSTORE_BOOKPRODUCT_MBXUML_INSTID 0
/*
 * Class: RecordingProduct
 */
#define BOOKSTORE_RECORDINGPRODUCT_CLASSID 5
#define BOOKSTORE_RECORDINGPRODUCT_ATTRCOUNT 1
#define BOOKSTORE_RECORDINGPRODUCT_RUNNINGTIME_ATTRID 0
#define BOOKSTORE_RECORDINGPRODUCT_INSTCOUNT 1
#define BOOKSTORE_RECORDINGPRODUCT_CMC_INSTID 0
/*
 * Class: SoftwareProduct
 */
#define BOOKSTORE_SOFTWAREPRODUCT_CLASSID 6
#define BOOKSTORE_SOFTWAREPRODUCT_ATTRCOUNT 1
#define BOOKSTORE_SOFTWAREPRODUCT_PRODUCTVERSION_ATTRID 0
#define BOOKSTORE_SOFTWAREPRODUCT_INSTCOUNT 1
#define BOOKSTORE_SOFTWAREPRODUCT_MACWD_INSTID 0
/*
 * Class: SpecialOrderProduct
 */
#define BOOKSTORE_SPECIALORDERPRODUCT_CLASSID 7
#define BOOKSTORE_SPECIALORDERPRODUCT_ATTRCOUNT 2
#define BOOKSTORE_SPECIALORDERPRODUCT_DAYSTODELIVER_ATTRID 0
#define BOOKSTORE_SPECIALORDERPRODUCT_SPECIALORDERINSTRUCTIONS_ATTRID 1
#define BOOKSTORE_SPECIALORDERPRODUCT_INSTCOUNT 1
#define BOOKSTORE_SPECIALORDERPRODUCT_CMC_INSTID 0
/*
 * Class: StockedProduct
 */
#define BOOKSTORE_STOCKEDPRODUCT_CLASSID 8
#define BOOKSTORE_STOCKEDPRODUCT_ATTRCOUNT 4
#define BOOKSTORE_STOCKEDPRODUCT_QUANTITYONHAND_ATTRID 0
#define BOOKSTORE_STOCKEDPRODUCT_REORDERINCREMENT_ATTRID 1
#define BOOKSTORE_STOCKEDPRODUCT_REORDERINSTRUCTIONS_ATTRID 2
#define BOOKSTORE_STOCKEDPRODUCT_REORDERTHRESHOLD_ATTRID 3
#define BOOKSTORE_STOCKEDPRODUCT_INSTCOUNT 2
#define BOOKSTORE_STOCKEDPRODUCT_MBXUML_INSTID 0
#define BOOKSTORE_STOCKEDPRODUCT_MACWD_INSTID 1
/*
 * Class: ProductCategory
 */
#define BOOKSTORE_PRODUCTCATEGORY_CLASSID 9
#define BOOKSTORE_PRODUCTCATEGORY_ATTRCOUNT 1
#define BOOKSTORE_PRODUCTCATEGORY_CATEGORYNAME_ATTRID 0
#define BOOKSTORE_PRODUCTCATEGORY_INSTCOUNT 5
#define BOOKSTORE_PRODUCTCATEGORY_SOFTWARE_INSTID 4
#define BOOKSTORE_PRODUCTCATEGORY_MUSIC_INSTID 3
#define BOOKSTORE_PRODUCTCATEGORY_NON_FICTION_INSTID 2
#define BOOKSTORE_PRODUCTCATEGORY_BOOK_INSTID 0
#define BOOKSTORE_PRODUCTCATEGORY_FICTION_INSTID 1
/*
 * Class: Recording
 */
#define BOOKSTORE_RECORDING_CLASSID 10
#define BOOKSTORE_RECORDING_ATTRCOUNT 1
#define BOOKSTORE_RECORDING_TITLE_ATTRID 0
#define BOOKSTORE_RECORDING_INSTCOUNT 1
#define BOOKSTORE_RECORDING_CMC_INSTID 0
/*
 * Class: Artist
 */
#define BOOKSTORE_ARTIST_CLASSID 11
#define BOOKSTORE_ARTIST_ATTRCOUNT 1
#define BOOKSTORE_ARTIST_ARTISTNAME_ATTRID 0
#define BOOKSTORE_ARTIST_INSTCOUNT 2
#define BOOKSTORE_ARTIST_MJ_INSTID 0
#define BOOKSTORE_ARTIST_FS_INSTID 1
/*
 * Class: PerformanceCredit
 */
#define BOOKSTORE_PERFORMANCECREDIT_CLASSID 12
#define BOOKSTORE_PERFORMANCECREDIT_ATTRCOUNT 1
#define BOOKSTORE_PERFORMANCECREDIT_ROLE_ATTRID 0
#define BOOKSTORE_PERFORMANCECREDIT_INSTCOUNT 2
#define BOOKSTORE_PERFORMANCECREDIT_MJ_INSTID 0
#define BOOKSTORE_PERFORMANCECREDIT_FS_INSTID 1
/*
 * Class: RecordingFormat
 */
#define BOOKSTORE_RECORDINGFORMAT_CLASSID 13
#define BOOKSTORE_RECORDINGFORMAT_ATTRCOUNT 1
#define BOOKSTORE_RECORDINGFORMAT_FORMATNAME_ATTRID 0
#define BOOKSTORE_RECORDINGFORMAT_INSTCOUNT 1
#define BOOKSTORE_RECORDINGFORMAT_CD_INSTID 0
/*
 * Class: Platform
 */
#define BOOKSTORE_PLATFORM_CLASSID 14
#define BOOKSTORE_PLATFORM_ATTRCOUNT 1
#define BOOKSTORE_PLATFORM_PLATFORMNAME_ATTRID 0
#define BOOKSTORE_PLATFORM_INSTCOUNT 1
#define BOOKSTORE_PLATFORM_MACOSX_INSTID 0
/*
 * Class: ComputerSoftware
 */
#define BOOKSTORE_COMPUTERSOFTWARE_CLASSID 15
#define BOOKSTORE_COMPUTERSOFTWARE_ATTRCOUNT 1
#define BOOKSTORE_COMPUTERSOFTWARE_TITLE_ATTRID 0
#define BOOKSTORE_COMPUTERSOFTWARE_INSTCOUNT 1
#define BOOKSTORE_COMPUTERSOFTWARE_MACWD_INSTID 0
/*
 * Class: Customer
 */
#define BOOKSTORE_CUSTOMER_CLASSID 16
#define BOOKSTORE_CUSTOMER_ATTRCOUNT 5
#define BOOKSTORE_CUSTOMER_EMAIL_ATTRID 0
#define BOOKSTORE_CUSTOMER_NAME_ATTRID 1
#define BOOKSTORE_CUSTOMER_PHONE_ATTRID 2
#define BOOKSTORE_CUSTOMER_PURCHASESMADE_ATTRID 3
#define BOOKSTORE_CUSTOMER_SHIPPINGADDRESS_ATTRID 4
#define BOOKSTORE_CUSTOMER_INSTCOUNT 20
/*
 * Class: Order
 */
#define BOOKSTORE_ORDER_CLASSID 17
#define BOOKSTORE_ORDER_ATTRCOUNT 6
#define BOOKSTORE_ORDER_CONTACTPHONE_ATTRID 0
#define BOOKSTORE_ORDER_DATEORDERPLACED_ATTRID 1
#define BOOKSTORE_ORDER_DELIVERYADDRESS_ATTRID 2
#define BOOKSTORE_ORDER_ORDERID_ATTRID 3
#define BOOKSTORE_ORDER_RECIPIENT_ATTRID 4
#define BOOKSTORE_ORDER_TOTALVALUE_ATTRID 5
#define BOOKSTORE_ORDER_INSTCOUNT 20
/*
 * Class: ProductSelection
 */
#define BOOKSTORE_PRODUCTSELECTION_CLASSID 18
#define BOOKSTORE_PRODUCTSELECTION_ATTRCOUNT 3
#define BOOKSTORE_PRODUCTSELECTION_QUANTITY_ATTRID 0
#define BOOKSTORE_PRODUCTSELECTION_SELECTIONVALUE_ATTRID 1
#define BOOKSTORE_PRODUCTSELECTION_UNITPRICEOFSELECTION_ATTRID 2
#define BOOKSTORE_PRODUCTSELECTION_INSTCOUNT 40
/*
 * Class: ShoppingCart
 */
#define BOOKSTORE_SHOPPINGCART_CLASSID 19
#define BOOKSTORE_SHOPPINGCART_ATTRCOUNT 2
#define BOOKSTORE_SHOPPINGCART_CARTID_ATTRID 0
#define BOOKSTORE_SHOPPINGCART_TOTALVALUE_ATTRID 1
#define BOOKSTORE_SHOPPINGCART_INSTCOUNT 20
/*
 * Class: CreditCardCharge
 */
#define BOOKSTORE_CREDITCARDCHARGE_CLASSID 20
#define BOOKSTORE_CREDITCARDCHARGE_ATTRCOUNT 8
#define BOOKSTORE_CREDITCARDCHARGE_ACCOUNTNUMBER_ATTRID 0
#define BOOKSTORE_CREDITCARDCHARGE_APPROVALCODE_ATTRID 1
#define BOOKSTORE_CREDITCARDCHARGE_BILLINGADDRESS_ATTRID 2
#define BOOKSTORE_CREDITCARDCHARGE_CARDEXPIRATIONDATE_ATTRID 3
#define BOOKSTORE_CREDITCARDCHARGE_CARDHOLDERNAME_ATTRID 4
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEAMOUNT_ATTRID 5
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEID_ATTRID 6
#define BOOKSTORE_CREDITCARDCHARGE_DATECHARGEMADE_ATTRID 7
#define BOOKSTORE_CREDITCARDCHARGE_INSTCOUNT 40
/*
 * Class: Shipment
 */
#define BOOKSTORE_SHIPMENT_CLASSID 21
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
#define BOOKSTORE_SHIPMENT_INSTCOUNT 20
/*
 * Class: ShippingCompany
 */
#define BOOKSTORE_SHIPPINGCOMPANY_CLASSID 22
#define BOOKSTORE_SHIPPINGCOMPANY_ATTRCOUNT 6
#define BOOKSTORE_SHIPPINGCOMPANY_COMPANYNAME_ATTRID 0
#define BOOKSTORE_SHIPPINGCOMPANY_CUSTOMERSERVICEPHONE_ATTRID 1
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALCONTACT_ATTRID 2
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALDISPATCHPHONE_ATTRID 3
#define BOOKSTORE_SHIPPINGCOMPANY_LOCALOFFICE_ATTRID 4
#define BOOKSTORE_SHIPPINGCOMPANY_TRACKINGWEBSITE_ATTRID 5
#define BOOKSTORE_SHIPPINGCOMPANY_INSTCOUNT 2
#define BOOKSTORE_SHIPPINGCOMPANY_FEDEX_INSTID 0
#define BOOKSTORE_SHIPPINGCOMPANY_UPS_INSTID 1
/*
 * Class: WarehouseClerk
 */
#define BOOKSTORE_WAREHOUSECLERK_CLASSID 23
#define BOOKSTORE_WAREHOUSECLERK_ATTRCOUNT 3
#define BOOKSTORE_WAREHOUSECLERK_CLERKID_ATTRID 0
#define BOOKSTORE_WAREHOUSECLERK_CLERKNAME_ATTRID 1
#define BOOKSTORE_WAREHOUSECLERK_GOOFFDUTYATENDOFJOB_ATTRID 2
#define BOOKSTORE_WAREHOUSECLERK_INSTCOUNT 3
#define BOOKSTORE_WAREHOUSECLERK_FS_INSTID 0
#define BOOKSTORE_WAREHOUSECLERK_JI_INSTID 1
#define BOOKSTORE_WAREHOUSECLERK_GS_INSTID 2
/*
 * Class: Warehouse
 */
#define BOOKSTORE_WAREHOUSE_CLASSID 24
#define BOOKSTORE_WAREHOUSE_ATTRCOUNT 2
#define BOOKSTORE_WAREHOUSE_WAREHOUSELOCATION_ATTRID 0
#define BOOKSTORE_WAREHOUSE_WAREHOUSENAME_ATTRID 1
#define BOOKSTORE_WAREHOUSE_INSTCOUNT 2
#define BOOKSTORE_WAREHOUSE_ACME_INSTID 0
#define BOOKSTORE_WAREHOUSE_MF_INSTID 1
/*
 * Class: ShippingClerk
 */
#define BOOKSTORE_SHIPPINGCLERK_CLASSID 25
#define BOOKSTORE_SHIPPINGCLERK_ATTRCOUNT 1
#define BOOKSTORE_SHIPPINGCLERK_AWAITINGASSIGNMENT_ATTRID 0
#define BOOKSTORE_SHIPPINGCLERK_INSTCOUNT 1
#define BOOKSTORE_SHIPPINGCLERK_FS_INSTID 0
/*
 * Class: StockClerk
 */
#define BOOKSTORE_STOCKCLERK_CLASSID 26
#define BOOKSTORE_STOCKCLERK_ATTRCOUNT 1
#define BOOKSTORE_STOCKCLERK_IDLE_ATTRID 0
#define BOOKSTORE_STOCKCLERK_INSTCOUNT 1
#define BOOKSTORE_STOCKCLERK_JI_INSTID 0
/*
 * Class: OffDutyClerk
 */
#define BOOKSTORE_OFFDUTYCLERK_CLASSID 27
#define BOOKSTORE_OFFDUTYCLERK_ATTRCOUNT 0
#define BOOKSTORE_OFFDUTYCLERK_INSTCOUNT 1
#define BOOKSTORE_OFFDUTYCLERK_GS_INSTID 0
/*
 * Class: ShipmentItem
 */
#define BOOKSTORE_SHIPMENTITEM_CLASSID 28
#define BOOKSTORE_SHIPMENTITEM_ATTRCOUNT 1
#define BOOKSTORE_SHIPMENTITEM_QUANTITYSHIPPED_ATTRID 0
#define BOOKSTORE_SHIPMENTITEM_INSTCOUNT 40
/*
 * Numeric encoding of event numbers used by the portal functions
 */
/*
 * Class: CreditCardCharge
 */
#define BOOKSTORE_CREDITCARDCHARGE_EVENTCOUNT 3
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEPROCESSED_EVENT 0
#define BOOKSTORE_CREDITCARDCHARGE_CHARGEPROCESSINGNOTCOMPLETED_EVENT 1
#define BOOKSTORE_CREDITCARDCHARGE_MAKECHARGE_EVENT 2
/*
 * Class: Order
 */
#define BOOKSTORE_ORDER_EVENTCOUNT 6
#define BOOKSTORE_ORDER_CHECKOUT_EVENT 0
#define BOOKSTORE_ORDER_ORDERDELIVERED_EVENT 1
#define BOOKSTORE_ORDER_PAYMENTAPPROVED_EVENT 2
#define BOOKSTORE_ORDER_PAYMENTDECLINED_EVENT 3
#define BOOKSTORE_ORDER_SUBCHARGE_EVENT 4
#define BOOKSTORE_ORDER_SUBMITCHARGE_EVENT 5
/*
 * Class: ProductSelection
 */
#define BOOKSTORE_PRODUCTSELECTION_EVENTCOUNT 3
#define BOOKSTORE_PRODUCTSELECTION_ADDSELECTION_EVENT 0
#define BOOKSTORE_PRODUCTSELECTION_CHANGEQUANTITY_EVENT 1
#define BOOKSTORE_PRODUCTSELECTION_REMOVESELECTION_EVENT 2
/*
 * Class: Shipment
 */
#define BOOKSTORE_SHIPMENT_EVENTCOUNT 5
#define BOOKSTORE_SHIPMENT_DELIVERYCONFIRMED_EVENT 0
#define BOOKSTORE_SHIPMENT_PACKED_EVENT 1
#define BOOKSTORE_SHIPMENT_PICKEDUP_EVENT 2
#define BOOKSTORE_SHIPMENT_REQUESTSHIPMENT_EVENT 3
#define BOOKSTORE_SHIPMENT_TRACKINGNUMBERASSIGNED_EVENT 4
/*
 * Class: ShippingClerk
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
 * Class: ShoppingCart
 */
#define BOOKSTORE_SHOPPINGCART_EVENTCOUNT 4
#define BOOKSTORE_SHOPPINGCART_ADDSELECTION_EVENT 0
#define BOOKSTORE_SHOPPINGCART_CANCEL_EVENT 1
#define BOOKSTORE_SHOPPINGCART_CHECKOUT_EVENT 2
#define BOOKSTORE_SHOPPINGCART_STARTCART_EVENT 3
/*
 * Class: Warehouse
 */
#define BOOKSTORE_WAREHOUSE_EVENTCOUNT 3
#define BOOKSTORE_WAREHOUSE_CLERKASSIGNEDTOSHIPMENT_EVENT 0
#define BOOKSTORE_WAREHOUSE_CLERKFREE_EVENT 1
#define BOOKSTORE_WAREHOUSE_SHIPMENTREADYTOPACK_EVENT 2

/*
 * Domain Portal Declaration
 */
extern MRT_DomainPortal bookstore__PORTAL ;

#endif /* BOOKSTORE_H_ */

