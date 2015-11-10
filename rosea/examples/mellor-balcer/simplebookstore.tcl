# DO NOT EDIT THIS FILE!
# THIS FILE IS AUTOMATICALLY GENERATED FROM A LITERATE PROGRAM SOURCE FILE.
#
# This software is copyrighted 2015 by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.

package require Tcl 8.6
package require rosea 1.4
package require uuid

domain bookstore {
    class Product {
        attribute productID string -id 1
        attribute productName string
        attribute copyright string -check {$copyright > 0}
        attribute unitPrice int -check {$unitPrice > 0}
        attribute description string
        attribute website string
        attribute currentlyAvailable boolean
    
        attribute categoryID string ; # <1>
        reference R15 ProductCategory -link categoryID
    
        attribute groupCode string ; # <2>
        attribute publisherCode string
        reference R1 Publisher -link groupCode -link publisherCode
    
    }
    generalization R12 Product SpecialOrderProduct StockedProduct
    generalization R11 Product BookProduct RecordingProduct SoftwareProduct
    association R15 Product 0..*--1 ProductCategory
    association R1 Product 0..*--1 Publisher
    class Publisher {
        attribute groupCode string -id 1 ; # <1>
        attribute publisherCode string -id 1
        attribute name string
        attribute address string
        attribute website string
    }
    class Author {
        attribute name string -id 1 ; # <1>
        attribute website string
        attribute email string
    }
    class Authorship {
        attribute preCredit string -default {}
        attribute postCredit string -default {}
    
        attribute name string -id 1 ; # <1>
        reference R2 Author -link name
        attribute productID string -id 1
        reference R2 BookProduct -link productID
    
        attribute previousName string ; # <2>
        attribute previousProductID string
        reference R3 Authorship\
            -link {previousName name}\
            -link {previousProductID productID} ; # <3>
    }
    association R2 BookProduct 1..*--0..* Author -associator Authorship
    association R3 Authorship 0..1--0..1 Authorship\
        -path {name previousName productID previousProductID} ; # <1>
    class BookProduct {
        attribute bookNumber string
        attribute titleCode string
        attribute title string
        attribute subtitle string
    
        attribute productID string -id 1 ; # <1>
        reference R11 Product -link productID
    }
    class RecordingProduct {
        attribute runningTime string
    
        attribute productID string -id 1 ; # <1>
        reference R11 Product -link productID
    
        attribute recordingID string -id 2 ; # <2>
        attribute formatID string -id 2
        reference R16 Recording -link recordingID
        reference R16 RecordingFormat -link formatID
    }
    association R16 Recording 1..*--1..* RecordingFormat -associator RecordingProduct
    class SoftwareProduct {
        attribute productVersion string
    
        attribute productID string -id 1
        reference R11 Product -link productID
    
        attribute softwareID string
        reference R20 ComputerSoftware -link softwareID
    
        attribute platformID string
        reference R19 Platform -link platformID
    }
    association R19 SoftwareProduct 1..*--1 Platform
    association R20 SoftwareProduct 1..*--1 ComputerSoftware
    class SpecialOrderProduct {
        attribute specialOrderInstructions string
        attribute daysToDeliver int
    
        attribute productID string -id 1
        reference R12 Product -link productID
    }
    class StockedProduct {
        attribute quantityOnHand int
        attribute reorderThreshold int
        attribute reorderIncrement int
        attribute reorderInstructions string
    
        attribute productID string -id 1
        reference R12 Product -link productID
    }
    class ProductCategory {
        attribute categoryID string -id 1
        attribute categoryName string
    
        attribute parentCategoryID string
        reference R14 ProductCategory -link {parentCategoryID categoryID}
    }
    association R14 ProductCategory 0..*--0..1 ProductCategory
    class Recording {
        attribute recordingID string -id 1 ; # <1>
        attribute title string
    }
    class Artist {
        attribute artistID string -id 1
        attribute artistName string
    }
    class PerformanceCredit {
        attribute role string -default {}
    
        attribute recordingID string -id 1
        attribute artistID string -id 1
        reference R17 Recording -link recordingID
        reference R17 Artist -link artistID
    
        attribute prevRecordingID string
        attribute prevArtistID string
        reference R18 PerformanceCredit\
            -link {prevRecordingID recordingID}\
            -link {prevArtistID artistID}
    }
    association R17 Recording 1..*--1..* Artist -associator PerformanceCredit
    association R18 PerformanceCredit 0..1--0..1 PerformanceCredit\
        -path {recordingID prevRecordingID artistID prevArtistID}
    class RecordingFormat {
        attribute formatID string -id 1
        attribute formatName string
    }
    class Platform {
        attribute platformID string -id 1
        attribute platformName string
    }
    class ComputerSoftware {
        attribute softwareID string -id 1
        attribute title string
    }
    class Customer {
        attribute email string -id 1
        attribute name string
        attribute shippingAddress string
        attribute phone string
        attribute purchasesMade int -default 0 ; # <1>
    }
    class Order {
        attribute orderID string -id 1
        attribute dateOrderPlaced string -default {}
        attribute totalValue int
        attribute recipient string
        attribute deliveryAddress string
        attribute contactPhone string
    
        attribute cartID string -default {} ; # <1>
        reference R10 ShoppingCart -link cartID
    
        attribute email string -default {} ; # <2>
        reference R5 Customer -link email
    
        statemodel {
            transition @ - checkOut -> EstablishingCustomerandVerifyingPayment ; # <1>
            state EstablishingCustomerandVerifyingPayment {
                    cart accountNumber billingAddress cardExpirationDate
                    cardholderName customerEmail} {
                R10 link $self $cart
            
                set customer [Customer findById email $customerEmail]
                assignAttribute $self recipient deliveryAddress contactPhone
                if {[isEmptyRef $customer]} {
                    set customer [Customer create\
                        email $customerEmail\
                        name $recipient\
                        shippingAddress $deliveryAddress\
                        phone $contactPhone
                    ]
                } else {
                    updateAttribute $customer\
                        name $recipient\
                        shippingAddress $deliveryAddress\
                        phone $contactPhone
                }
            
                R5 link $self $customer
            
                updateAttribute $self dateOrderPlaced [clock format [clock seconds]]
            
                signal $self submitCharge $accountNumber $billingAddress\
                    $cardExpirationDate $cardholderName
            }
            
            transition EstablishingCustomerandVerifyingPayment - submitCharge ->\
                SubmittingCharge
            state SubmittingCharge {accountNumber billingAddress cardExpirationDate
                    cardholderName} {
                CreditCardCharge createasync makeCharge [list $self]\
                    chargeID [uuid::uuid generate]\
                    accountNumber $accountNumber\
                    cardholderName $cardholderName\
                    billingAddress $billingAddress\
                    cardExpirationDate $cardExpirationDate\
                    chargeAmount [readAttribute $self totalValue] ; # <1>
            }
            
            transition SubmittingCharge - paymentApproved -> BeingPackedandShipped
            transition SubmittingCharge - paymentDeclined -> PaymentNotApproved
            state PaymentNotApproved {} {
                set customer [findRelated $self R5]
                # generate chargeDeclined(customerEmail: customer.email)
                #       to EE_OnlineCustomer
                EE_OnLineCustomer::chargeDeclined [readAttribute $customer email] ; # <1>
            }
            
            transition PaymentNotApproved - subCharge -> SubmittingCharge
            state BeingPackedandShipped {} {
                set customer [findRelated $self R5]
                EE_OnLineCustomer::chargeApproved [readAttribute $customer email]
            
                assignAttribute $self recipient deliveryAddress contactPhone
                Shipment createasync requestShipment [list $self]\
                    shipmentID [uuid::uuid generate]\
                    recipient $recipient\
                    deliveryAddress $deliveryAddress\
                    contactPhone $contactPhone
            }
            transition BeingPackedandShipped - orderDelivered -> DeliveredtoCustomer
            
            state DeliveredtoCustomer {} {
                set customer [findRelated $self R5] ; # <1>
                EE_OnLineCustomer::orderReportedDelivered [readAttribute $customer email]
            }
        }
    }
    association R10 Order 0..1--1 ShoppingCart
    association R5 Order 1..*--0..1 Customer ; # <1>
    class ProductSelection {
        attribute quantity int -default 0
        attribute unitPriceOfSelection int -default 0
        attribute selectionValue int -default 0
    
        attribute productID string -id 1 -default {} ; # <1>
        attribute cartID string -id 1 -default {}
        reference R4 Product -link productID
        reference R4 ShoppingCart -link cartID
    
        statemodel {
            initialstate NewSelection ; # <1>
            transition @ - addSelection -> NewSelection
            
            state NewSelection {cartID productID quantity} {
                set product [Product findById productID $productID]
                updateAttribute $self\
                    productID $productID\
                    cartID $cartID\
                    unitPriceOfSelection [readAttribute $product unitPrice] ; # <1>
            
                signal $self changeQuantity $quantity
            }
            transition NewSelection - changeQuantity -> ChangingQuantity
            state ChangingQuantity {quantityOfSelection} {
                withAttribute $self quantity unitPriceOfSelection selectionValue {
                    set quantity $quantityOfSelection
                    set selectionValue [expr {$quantity * $unitPriceOfSelection}]
                }
                if {$quantity == 0} {
                    signal $self removeSelection
                } else {
                    set cart [findRelated $self ~R4]
                    instop $cart cartUpdated
                }
            }
            transition ChangingQuantity - removeSelection -> RemovingSelection
            
            state RemovingSelection {} {
                set cart [findRelated $self ~R4]
                R4 unlink $self
                set remainingProduct [findRelated $cart R4]
                if {[isEmptyRef $remainingProduct]} {
                    signal $cart cancel
                } else {
                    instop $cart cartUpdated
                }
            }
            terminal RemovingSelection
        }
    }
    association R4 ShoppingCart 0..*--1..* Product -associator ProductSelection
    class ShoppingCart {
        attribute cartID string -id 1
        attribute totalValue int
    
        statemodel {
            transition @ - startCart -> NewOrder
            
            state NewOrder {productID quantity} {
                signal $self addSelection $productID $quantity
            }
            transition NewOrder - addSelection -> AddingSelectiontoOrder
            
            state AddingSelectiontoOrder {productID quantity} {
                set product [Product findById productID $productID]
                set unitprice [readAttribute $product unitPrice]
                set selectionvalue [expr {$unitprice * $quantity}]
                set newSelection [R4 link $self $product\
                    quantity $quantity\
                    unitPriceOfSelection $unitprice\
                    selectionValue $selectionvalue\
                ] ; # <1>
                withAttribute $self totalValue {
                    incr totalValue $selectionvalue
                }
            }
            transition AddingSelectiontoOrder - addSelection -> AddingSelectiontoOrder
            transition AddingSelectiontoOrder - cancel -> CancelingEntireOrder
            transition AddingSelectiontoOrder - checkOut ->\
                    EstablishingCustomerandVerifyingPayment
            state CancelingEntireOrder {} {
                set selections [findRelated $self {R4 ProductSelection}]
                R4 unlink $selections
            }
            terminal CancelingEntireOrder ; # <1>
            state EstablishingCustomerandVerifyingPayment {
                    accountNumber billingAddress cardExpirationDate
                    cardholderName customerEmail customerName customerPhone
                    shippingAddress} {
                Order createasync checkOut [list $self $accountNumber\
                    $billingAddress $cardExpirationDate $cardholderName\
                    $customerEmail]\
                    orderID [uuid::uuid generate]\
                    totalValue [readAttribute $self totalValue]\
                    recipient $customerName\
                    deliveryAddress $shippingAddress\
                    contactPhone $customerPhone
            }
        }
    
        instop cartUpdated {} {
            updateAttribute $self totalValue [tcl::mathop::+ {*}[pipe {
                    findRelated $self {R4 ProductSelection} |
                    deRef ~ selectionValue |
                    relation list ~ selectionValue
                }]]
        } ; # <1>
    }
    class CreditCardCharge {
        attribute chargeID string -id 1
        attribute accountNumber string
        attribute cardholderName string
        attribute billingAddress string
        attribute cardExpirationDate string
        attribute dateChargeMade string -default {}
        attribute chargeAmount int
        attribute approvalCode string -default pending -check {$approvalCode in
                {approved overLimit noAccount connectionFailed
                accountDataMismatch expired pending}
            }
    
        attribute attemptOrderID string -default {}
        reference R7 Order -link {attemptOrderID orderID}
    
        attribute paidOrderID string -default {}
        reference R8 Order -link {paidOrderID orderID}
    
        statemodel {
            transition @ - makeCharge -> RequestingChargeApproval
            
            state RequestingChargeApproval {order} {
                R7 link $self $order ; # <1>
                updateAttribute $self dateChargeMade [clock format [clock seconds]]
            
                withAttribute $self accountNumber billingAddress cardholderName\
                        cardExpirationDate chargeAmount {
                    EE_CreditCardCompany::requestChargeApproval\
                        $accountNumber\
                        $billingAddress\
                        $cardholderName\
                        $cardExpirationDate\
                        [readAttribute $self chargeID]\
                        $chargeAmount
                }
            
                delaysignal 60000 $self chargeProcessingNotCompleted
            }
            transition RequestingChargeApproval - chargeProcessed -> ProcessingCompleted
            transition RequestingChargeApproval - chargeProcessingNotCompleted ->\
                DeclineForTimeout
            state ProcessingCompleted {resultCode} {
                set order [findRelated $self R7] ; # <1>
                canceldelayed $self $order chargeProcessingNotCompleted ; # <2>
            
                updateAttribute $self approvalCode $resultCode
                if {$resultCode eq "approved"} {
                    R8 link $self $order ; # <3>
                    signal $order paymentApproved
                } else {
                    signal $order paymentDeclined
                }
            }
            state DeclineForTimeout {} {
                updateAttribute $self approvalCode connectionFailed
                set order [findRelated $self R7] ; # <1>
                signal $order paymentDeclined
            }
        }
    }
    association R7 CreditCardCharge 0..*--1 Order
    association R8 CreditCardCharge 0..1--0..1 Order ; #<1>
    class Shipment {
        attribute shipmentID string -id 1
        attribute shippingCompany string -default {} ; # <1>
        reference R21 ShippingCompany -link {shippingCompany companyName}
        attribute trackingNumber string -default {}
    
        attribute recipient string
        attribute deliveryAddress string
        attribute contactPhone string
        attribute timePrepared string -default {}
        attribute timePickedUp string -default {}
        attribute timeDelivered string -default {}
        attribute waitingToBePacked boolean -default true
    
        attribute warehouseName string -default {}
        reference R24 Warehouse -link warehouseName
    
        attribute clerkID string -default {}
        reference R22 WarehouseClerk -link clerkID
    
        attribute orderID string -default {}
        reference R6 Order -link orderID
    
        statemodel {
            transition @ - requestShipment -> PreparingShipment
            
            state PreparingShipment {order} {
                R6 link $self $order
            
                set warehouse [Warehouse chooseWarehouse [readAttribute $order orderID]] ; # <1>
                R24 link $self $warehouse
            
                set items [findRelated $order R10 {R4 ProductSelection}] ; #<2>
                R9 link $items $self
            
                signal $warehouse shipmentReadyToPack ; #<3>
            }
            transition PreparingShipment - packed -> PackedandAwaitingTrackingNumber
            transition PreparingShipment - trackingNumberAssigned ->\
                NumberAssignedandWaitingtobePacked
            state PackedandAwaitingTrackingNumber {clerkID} {
                instop $self updatePackingInfo $clerkID
            }
            transition PackedandAwaitingTrackingNumber - trackingNumberAssigned ->\
                NumberAssigned
            
            state NumberAssignedandWaitingtobePacked {
                    shippingCompany trackingNumber} {
                instop $self updateTrackingInfo $shippingCompany $trackingNumber
            }
            transition NumberAssignedandWaitingtobePacked - packed -> Packed
            
            state NumberAssigned {shippingCompany trackingNumber} {
                instop $self updateTrackingInfo $shippingCompany $trackingNumber
            }
            transition NumberAssigned - pickedUp -> InTransittoCustomer
            
            state Packed {clerkID} {
                instop $self updatePackingInfo $clerkID
            }
            transition Packed - pickedUp -> InTransittoCustomer
            state InTransittoCustomer {} {
                updateAttribute $self timePickedUp [clock format [clock seconds]]
            }
            transition InTransittoCustomer - deliveryConfirmed -> Delivered
            
            state Delivered {timeDelivered} {
                updateAttribute $self timeDelivered $timeDelivered
                set order [findRelated $self R6]
                signal $order orderDelivered
            }
        }
    
        instop updateTrackingInfo {shippingCompany trackingNumber} {
            updateAttribute $self trackingNumber $trackingNumber
            set company [ShippingCompany findById companyName $shippingCompany]
            R21 link $self $company
        }
        
        instop updatePackingInfo {clerkID} {
            updateAttribute $self timePrepared [clock format [clock seconds]]
        
            set clerk [WarehouseClerk findById clerkID $clerkID]
            R22 link $self $clerk
        
            EE_ShippingCompany::shipmentReadyForPickup\
                [readAttribute $self shipmentID]
        }
    }
    association R21 Shipment 0..*--0..1 ShippingCompany ; #<1>
    association R24 Shipment 0..*--1 Warehouse
    association R22 Shipment 0..*--0..1 WarehouseClerk
    association R6 Shipment 0..1--1 Order
    class ShippingCompany {
        attribute companyName string -id 1
        attribute trackingWebsite string
        attribute customerServicePhone string
        attribute localDispatchPhone string
        attribute localOffice string
        attribute localContact string
    }
    class WarehouseClerk {
        attribute clerkID string -id 1
        attribute clerkName string
        attribute goOffDutyAtEndOfJob boolean -default false ; # <1>
    
        attribute warehouseName string
        reference R25 Warehouse -link warehouseName
    }
    generalization R27 WarehouseClerk OffDutyClerk StockClerk ShippingClerk
    association R25 WarehouseClerk 1..*--1 Warehouse
    class Warehouse {
        attribute warehouseName string -id 1
        attribute warehouseLocation string
    
        statemodel {
            initialstate WaitingforaShipment ; # <1>
            defaulttrans IG ; # <2>
            state WaitingforaShipment {} {
                set readyShipment [findRelatedWhere $self ~R24 {$waitingToBePacked}]
                if {[isNotEmptyRef $readyShipment]} {
                    signal $self shipmentReadyToPack
                }
            }
            transition WaitingforaShipment - shipmentReadyToPack -> WaitingforaFreeClerk
            
            state WaitingforaFreeClerk {} {
                set freeClerk [findRelatedWhere $self {~R25 {~R27 ShippingClerk}}\
                    {$awaitingAssignment eq "true"}]
                puts $freeClerk
                if {[isNotEmptyRef $freeClerk]} {
                    signal $self clerkFree
                }
            }
            transition WaitingforaFreeClerk - clerkFree -> AssigningClerktoShipment
            
            state AssigningClerktoShipment {} {
                set readyShipment [findRelatedWhere $self ~R24 {$waitingToBePacked}]
                set readyShipment [limitRef $readyShipment]
            
                set freeClerk [findRelatedWhere $self {~R25 {~R27 ShippingClerk}}\
                    {$awaitingAssignment}]
                set freeClerk [limitRef $freeClerk]
            
                R23 link $readyShipment $freeClerk
                updateAttribute $readyShipment waitingToBePacked false
                updateAttribute $freeClerk awaitingAssignment false
            
                signal $freeClerk clerkAssigned
                signal $self clerkAssignedToShipment
            }
            transition AssigningClerktoShipment - clerkAssignedToShipment ->\
                    WaitingforaShipment
        }
    
        classop chooseWarehouse {orderID} {
            return [limitRef [Warehouse findAll]]
        }
    }
    class ShippingClerk {
        attribute clerkID string -id 1
        reference R27 WarehouseClerk -link clerkID
    
        attribute awaitingAssignment boolean -default true
    
        attribute shipmentID string -default {}
        reference R23 Shipment -link shipmentID
    
        statemodel {
            transition @ - startShipping -> WaitingforaJob
            
            state WaitingforaJob {} {
                updateAttribute $self awaitingAssignment true
                set warehouse [findRelated R27 R25]
                signal $warehouse clerkFree
            }
            transition WaitingforaJob - clerkAssigned -> SelectingBooks
            transition WaitingforaJob - offDuty -> OffDuty
            
            state SelectingBooks {} {
                EE_ShippingClerk::shipmentReadyToPack\
                    [readAttribute $self shipmentID]
            
                randomdelaysignal $self booksSelected
            }
            transition SelectingBooks - booksSelected -> PackingBox
            
            state PackingBox {} {
                randomdelaysignal $self boxPacked
            }
            transition PackingBox - boxPacked -> SealingBox
            state SealingBox {} {
                set allSelections [deRef [ProductSelection findAll] quantity] ; # <1>
            
                ShipmentItem update [pipe {
                    findRelated $self R23 {R9 ShipmentItem} |
                    deRef ~ |
                    relation join ~ $allSelections |
                    relation project ~ shipmentID productID cartID quantity |
                    relation rename ~ quantity quantityShipped
                }] ; # <2>
            
                randomdelaysignal $self boxSealed
            }
            transition SealingBox - boxSealed -> AttachingShippingLabel
            state AttachingShippingLabel {} {
                randomdelaysignal $self shippingLabelAttached
            }
            transition AttachingShippingLabel - shippingLabelAttached ->\
                DeliveringBoxtoLoadingDock
            
            state DeliveringBoxtoLoadingDock {} {
                randomdelaysignal $self boxAtLoadingDoc
            }
            transition DeliveringBoxtoLoadingDock - boxAtLoadingDoc -> CompletingJob
            
            state CompletingJob {} {
                set currentShipment [findRelated $self R23]
                signal $currentShipment packed [readAttribute $self clerkID]
                R23 unlink $currentShipment
                set wc [findRelated $self R27]
                if {[readAttribute $wc goOffDutyAtEndOfJob]} {
                    signal $self offDuty
                } else {
                    updateAttribute $self awaitingAssignment true
                    set myWarehouse [findRelated $wc R25]
                    signal $myWarehouse clerkFree
                }
            }
            transition CompletingJob - clerkAssigned -> SelectingBooks
            transition CompletingJob - offDuty -> OffDuty
            
            state OffDuty {} {
                R27 migrate $self OffDutyClerk
            } ; # <1>
        }
    }
    association R23 ShippingClerk 0..1--0..1 Shipment
    class StockClerk {
        attribute clerkID string -id 1
        reference R27 WarehouseClerk -link clerkID
        attribute idle boolean -default true
    }
    class OffDutyClerk {
        attribute clerkID string -id 1
        reference R27 WarehouseClerk -link clerkID
    }
    class ShipmentItem {
        attribute quantityShipped int -default 0
    
        attribute shipmentID string -id 1
        reference R9 Shipment -link shipmentID
    
        attribute productID string -id 1
        attribute cartID string -id 1
        reference R9 ProductSelection -link productID -link cartID
    }
    association R9 Shipment 0..*--1..* ProductSelection -associator ShipmentItem
}
