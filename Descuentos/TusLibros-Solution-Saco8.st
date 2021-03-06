!classDefinition: #DescuentosTest category: #'TusLibros-Solution'!
TestCase subclass: #DescuentosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:37:17'!
atest06
	
	| aCartID aSale aClientID aCreditCard aPassword aRestToObjectTransator anItem aCatalog aDiscountCatalog |

	aClientID _ 1.
	aPassword _ 123123.
	anItem _ Object new.
	aCatalog _ Dictionary new.

	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForDay of: 1/10 on: Date today dayOfWeek).
		
	aRestToObjectTransator _ RestToObjectTranslator withCatalog: aCatalog withWebServer: WebServer new withDiscountApplier: (DiscountApplier with: aDiscountCatalog).
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aCreditCard _ CreditCard withNumber: 123123123123 withExpirationDate: Date tomorrow withOwnerName: 'Javier'.
	aSale _ aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard.

	self assert: ((aRestToObjectTransator listDiscountsForClientWithID: aClientID) equals: 1).	

	
	
	
	! !

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:40:24'!
test01TheNetPriceOfAShoppingCartStaysTheSameWhenNoDiscountApplies

	| aCatalog aShoppingCart anItem aDiscountCatalog aDiscountApplier anotherItem |

	anItem _ Object new.
	anotherItem _ Object new.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForPack of: [ :aPrice | aPrice * 1/10] withMinimum: 5).
	aDiscountCatalog add: (DiscountForItem of: [ :aPrice | aPrice * 1/10] forItem: anotherItem).
	aDiscountCatalog add: (DiscountForDay of: [ :aPrice | aPrice - 50] on: Date tomorrow dayOfWeek).
	aDiscountApplier _ DiscountApplier with: aDiscountCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: aDiscountApplier.
	aShoppingCart add: anItem withOccurrences: 2.
	
	self assert: aShoppingCart netPrice equals: 200.
	
	
	! !

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:40:32'!
test02TheNetPriceOfAShoppingCartLowersWhenIncludesItemsWithPackDiscount

	| aCatalog aShoppingCart anItem aDiscountCatalog aDiscountApplier |

	anItem _ Object new.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForPack of: [ :aPrice | aPrice * 1/10] withMinimum: 2).
	aDiscountApplier _ DiscountApplier with: aDiscountCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: aDiscountApplier.
	aShoppingCart add: anItem withOccurrences: 2.
	
	self assert: aShoppingCart netPrice equals: 180.
	
	
	! !

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:40:43'!
test03TheNetPriceOfAShoppingCartLowersEvenMoreWhenIncludesItemsWithGreaterPackDiscount

	| aCatalog aShoppingCart anItem aDiscountCatalog aDiscountApplier |

	anItem _ Object new.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForPack of: [ :aPrice | aPrice * 1/10] withMinimum: 2).
	aDiscountCatalog add: (DiscountForPack of: [ :aPrice | aPrice * 2/10] withMinimum: 5).
	aDiscountApplier _ DiscountApplier with: aDiscountCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: aDiscountApplier.
	aShoppingCart add: anItem withOccurrences: 5.
	
	self assert: aShoppingCart netPrice equals: 400.
	
	
	! !

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:41:17'!
test04TheNetPriceOfAShoppingCartLowersWhenIncludesItemsWithIndividualDiscount

	| aCatalog aShoppingCart anItem aDiscountCatalog aDiscountApplier |

	anItem _ Object new.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForItem of: [ :aPrice | aPrice * 1/10] forItem: anItem).
	aDiscountApplier _ DiscountApplier with: aDiscountCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: aDiscountApplier.
	aShoppingCart add: anItem.
	
	self assert: aShoppingCart netPrice equals: 90.
	
	
	! !

!DescuentosTest methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 21:41:54'!
test05TheNetPriceOfAShoppingCartLowersWhenIncludesDayDiscount

	| aCatalog aShoppingCart anItem aDiscountCatalog aDiscountApplier |

	anItem _ Object new.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aDiscountCatalog _ Set new.
	aDiscountCatalog add: (DiscountForDay of: [ :aPrice | aPrice - 50] on: Date today dayOfWeek).
	aDiscountApplier _ DiscountApplier with: aDiscountCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: aDiscountApplier.
	aShoppingCart add: anItem.
	
	self assert: aShoppingCart netPrice equals: 50.
	
	
	! !


!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aCashier aCatalog anEmptyCatalog aShoppingCartWithEmptyCatalog aShoppingCart anItem anotherItem aCreditCard anExpiredCreditCard aShoppingCartWithAnItem today aRestToObjectTransator aClientID aPassword aCreditCardNumber aCreditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:23:19'!
test01AShoppingCartRaisesAnErrorIfTryingToAddAnItemNotIncludedInTheCatalog
		
	self 
		should: [aShoppingCartWithEmptyCatalog add: 'Harry Potter and the Chamber of Secrets' ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart catalogDoesNotIncludeItemErrorDescription.
			] ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:23:42'!
test02AShoppingCartIncludesItemsAddedThatAreOnTheCatalog
	
	aShoppingCart add: anItem.
	
	self assert: (aShoppingCart includes: anItem) ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:24:43'!
test03AShoppingCartRaisesExceptionWhenTryingToAddAnUnevenAmountOfItems
	
	self 
		should: [aShoppingCart add: anItem withOccurrences: 1.5 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:24:59'!
test04AShoppingCartRaisesExceptionWhenTryingToAddANegativeAmountOfItems
	
	self 
		should: [aShoppingCart add: anItem withOccurrences: -1 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !


!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:24'!
test01ACashierWontCheckoutAnEmptyShoppingCart
	
	self 
		should: [ aCashier checkout: aShoppingCart payingWith: aCreditCard on: today] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier emptyShoppingCartErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/25/2017 22:51:44'!
test02ACashierReturnsASaleWithCreditCardAmountAndDateAfterCheckingOutShoppingCart

	| aSale |

	aShoppingCart add: anItem withOccurrences: 3.
	aShoppingCart add: anotherItem.
		
	aSale _ aCashier checkout: aShoppingCart payingWith: aCreditCard on: today.

	self assert: aSale creditCard equals: aCreditCard.
	self assert: aSale amount equals: 500.
	self assert: aSale date equals: today.
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:34'!
test03ACashierRaisesAnExceptionWhenTryingToPayWithExpiredCreditCard

	self 
		should: [ aCashier checkout: aShoppingCartWithAnItem payingWith: anExpiredCreditCard on: today ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier expiredCreditCardErrorDescription.
			]
		 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:41'!
test04ACashierLogsOrderAndRaisesAnExceptionWhenMerchantProcessorIsUnavailable

	| aCashierWithUnavailableMerchantProcessor |

	aCashierWithUnavailableMerchantProcessor _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: UnavailableMerchantProcessor new.

	self 
		should: [ aCashierWithUnavailableMerchantProcessor checkout: aShoppingCartWithAnItem payingWith: aCreditCard on: today ] 
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantProcessor unavailableErrorDescription.
			self assert: aCashierWithUnavailableMerchantProcessor salesBook isEmpty.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders size equals: 1.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne shoppingCart equals: aShoppingCartWithAnItem.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne creditCard equals: aCreditCard .
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne date equals: today.
			]
				
! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:15:11'!
test05ACashierRaisesAnExceptionWhenCreditCardIsRejected

	| aCashierWithCreditCardRejecterMerchantProcessor |

	aCashierWithCreditCardRejecterMerchantProcessor _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: CreditCardRejecterMerchantProcessor new.

	self 
		should: [ aCashierWithCreditCardRejecterMerchantProcessor checkout: aShoppingCartWithAnItem payingWith: aCreditCard on: today ] 
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantProcessor invalidCreditCardErrorDescription.
			self assert: aCashierWithCreditCardRejecterMerchantProcessor salesBook isEmpty.
			self assert: aCashierWithCreditCardRejecterMerchantProcessor delayedOrders isEmpty
			]
				
! !


!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/24/2017 00:18:12'!
test01ARecentlyCreatedCartCanBeListedAndItIsEmpty

	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	
	self assert: (aRestToObjectTransator listCartWithID: aCartID) isEmpty
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:04'!
test02AddedItemsToACartCanBeListedWithTheirAssociatedCounts

	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	
	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aRestToObjectTransator add: anotherItem toCartWithID: aCartID withOccurrences: 2.
	
	self assert: ((aRestToObjectTransator listCartWithID: aCartID) includes: (Association key: 1 value: anItem)).
	self assert: ((aRestToObjectTransator listCartWithID: aCartID) includes: (Association key: 2 value: anotherItem)).! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:16'!
test03TryingToListANonExistantCartRaisesAnError

	self 
		should: [ aRestToObjectTransator listCartWithID: 123 ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:25'!
test04TryingToAddAnItemToANonExistantCartRaisesAnError

	self 
		should: [ aRestToObjectTransator add: anItem toCartWithID: 123 ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:32'!
test05TryingToCheckOutANonExistantCartRaisesAnError

	self 
		should: [ aRestToObjectTransator checkoutCartWithID: 123 payingWith: aCreditCard ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:46'!
test06TryingToListAnExpiredCartRaisesAnError

	| aCartID thirtyMinutesAgo |
	
	thirtyMinutesAgo _ DateAndTime now - 30 minutes.
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: thirtyMinutesAgo.

	self 
		should: [ aRestToObjectTransator listCartWithID: aCartID ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartIsExpiredErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:20:53'!
test07TryingToAddAnItemToAnExpiredCartRaisesAnError

	| aCartID thirtyMinutesAgo |
	
	thirtyMinutesAgo _ DateAndTime now - 30 minutes.
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: thirtyMinutesAgo.

	self 
		should: [ aRestToObjectTransator add: anItem toCartWithID: aCartID  ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartIsExpiredErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:21:05'!
test08TryingToCheckoutAnExpiredCartRaisesAnError

	| aCartID thirtyMinutesAgo |
	
	thirtyMinutesAgo _ DateAndTime now - 30 minutes.
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: thirtyMinutesAgo.

	self 
		should: [ aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard  ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartIsExpiredErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:21:25'!
test09TryingToListACheckedOutCartRaisesAnError
	
	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.

	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard.
	
	self 
		should: [ aRestToObjectTransator listCartWithID: aCartID. ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:23:04'!
test10TryingToAddAnItemToACheckedOutCartRaisesAnError
	
	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	
	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard.

	self 
		should: [ aRestToObjectTransator add: anotherItem toCartWithID: aCartID ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 21:23:10'!
test11TryingToCheckOutACheckedOutCartRaisesAnError
	
	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	
	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard.

	self 
		should: [ aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard. ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription ]
		
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 23:30:47'!
test12AClientWhoDidntCheckoutAnyCartHasNoPurchases
	
	| aCartID |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	aRestToObjectTransator add: anItem toCartWithID: aCartID.

	self assert: ((aRestToObjectTransator listPurchasesOfClientWithID: aClientID) isEmpty).	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/25/2017 23:30:36'!
test13AClientPurchasesIncludesSaleGivenByCartCheckOut
	
	| aCartID aSale |
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword on: DateAndTime now.
	aRestToObjectTransator add: anItem toCartWithID: aCartID.
	aSale _ aRestToObjectTransator checkoutCartWithID: aCartID payingWith: aCreditCard.

	self assert: ((aRestToObjectTransator listPurchasesOfClientWithID: aClientID) includes: aSale).	

	! !


!TusLibrosTest methodsFor: 'set up' stamp: 'JG 7/4/2017 21:31:36'!
setUp

	today _ Date today.

	anEmptyCatalog _ Dictionary new.
	aShoppingCartWithEmptyCatalog _ ShoppingCart withCatalog: anEmptyCatalog withDiscountApplier: (DiscountApplier with: Set new).
	
	anItem _ 'Harry Potter and the Chamber of Secrets'.
	anotherItem _ 'The Bible'.	
	
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aCatalog at: anotherItem put: 200.
	
	aShoppingCart _ ShoppingCart withCatalog: aCatalog withDiscountApplier: (DiscountApplier with: Set new).

	aShoppingCartWithAnItem _ ShoppingCart withCatalog: aCatalog withDiscountApplier: (DiscountApplier with: Set new).
	aShoppingCartWithAnItem add: anItem.
	
	aCreditCardNumber _ 1231231231231231.
	aCreditCardOwner _ 'John Doe'.
	
	aCreditCard _ CreditCard withNumber: aCreditCardNumber withExpirationDate: Date tomorrow withOwnerName: aCreditCardOwner.
	anExpiredCreditCard _ CreditCard withNumber: aCreditCardNumber withExpirationDate: Month current previous withOwnerName: aCreditCardOwner.
	
	aCashier _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: MerchantProcessor new.

	aRestToObjectTransator _ RestToObjectTranslator withCatalog: aCatalog withWebServer: WebServer new withDiscountApplier: (DiscountApplier with: Set new).
	
	aClientID _ 1.
	aPassword _ 'password'.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesBook merchantProcessor delayedOrders discounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'initializing' stamp: 'JG 6/21/2017 19:20:25'!
initialize

	delayedOrders _ Bag new.
	
	^ self! !

!Cashier methodsFor: 'initializing' stamp: 'JG 6/20/2017 01:54:57'!
initializeWithCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	catalog _ aCatalog.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.
	
	^ self ! !


!Cashier methodsFor: 'accessing' stamp: 'JG 6/21/2017 19:21:48'!
delayedOrders

	^ delayedOrders! !

!Cashier methodsFor: 'accessing' stamp: 'JG 6/15/2017 22:45:26'!
salesBook
	
	^ salesBook! !


!Cashier methodsFor: 'working' stamp: 'JG 7/4/2017 21:19:40'!
checkout: aShoppingCart payingWith: aCreditCard on: aDate
	
	aShoppingCart isEmpty
		ifTrue: [ self error: Cashier emptyShoppingCartErrorDescription ]
		ifFalse: [ (aCreditCard isExpiredOn: aDate)
			ifTrue: [ self error: Cashier expiredCreditCardErrorDescription ]
			ifFalse: [ .
				[ merchantProcessor debit: aShoppingCart netPrice from: aCreditCard ] 
					on: Error 
					do: [ :anError | 
							(anError messageText = MerchantProcessor unavailableErrorDescription) 
								ifTrue: [ self logOrderOf: aShoppingCart payingWith: aCreditCard on: aDate ].
							self error: anError messageText.
						].
				^ salesBook add: (Sale withCreditCard: aCreditCard withAmount: aShoppingCart price on: aDate). 
			] 
		].! !

!Cashier methodsFor: 'working' stamp: 'JG 6/21/2017 21:03:52'!
logOrderOf: aShoppingCart payingWith: aCreditCard on: aDate

	"Generate batch file"
	^ delayedOrders add: (Order with: aShoppingCart payingWith: aCreditCard on: aDate).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'JG 6/14/2017 11:43:38'!
emptyShoppingCartErrorDescription

	^ 'The shopping cart is empty' ! !

!Cashier class methodsFor: 'error description' stamp: 'JG 6/15/2017 19:31:38'!
expiredCreditCardErrorDescription
	
	^ 'The credit card is expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'JG 6/20/2017 01:55:25'!
withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	^ self new initializeWithCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	 ! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/15/2017 20:07:14'!
expirationMonthIndex

	^ expirationDate monthIndex! !

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/15/2017 20:07:21'!
expirationYearNumber

	^ expirationDate yearNumber! !

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/27/2017 12:51:35'!
initializeWithNumber: aNumber withExpirationDate: aDate withOwnerName: aName

	number _ aNumber.
	expirationDate _ aDate.
	ownerName _ aName.
	
	^ self! !


!CreditCard methodsFor: 'accessing' stamp: 'JG 6/15/2017 22:49:54'!
isExpiredOn: aDate

	^ (aDate yearNumber <= self expirationYearNumber and: aDate monthIndex <= self expirationMonthIndex) not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JG 6/27/2017 12:51:59'!
withNumber: aNumber withExpirationDate: aDate withOwnerName: aName
	
	^ self new initializeWithNumber: aNumber withExpirationDate: aDate withOwnerName: aName! !


!classDefinition: #Discount category: #'TusLibros-Solution'!
Object subclass: #Discount
	instanceVariableNames: 'discount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Discount methodsFor: 'testing' stamp: 'JG 7/4/2017 20:43:51'!
appliesTo: anItem onCart: aShoppingCart

	self subclassResponsibility ! !


!Discount methodsFor: 'accesing' stamp: 'JG 7/4/2017 21:00:33'!
applyToPrice: aPrice

	^ aPrice - (self discountForPrice: aPrice)! !

!Discount methodsFor: 'accesing' stamp: 'JG 7/4/2017 21:41:38'!
discountForPrice: aPrice

	^ discount value: aPrice! !


!classDefinition: #DiscountForDay category: #'TusLibros-Solution'!
Discount subclass: #DiscountForDay
	instanceVariableNames: 'dayOfWeek'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!DiscountForDay methodsFor: 'initialization' stamp: 'JG 7/4/2017 21:14:42'!
initializeWithDiscountOf: aFraction onDay: aDay

	discount _ aFraction.
	dayOfWeek _ aDay.
	
	^ self! !


!DiscountForDay methodsFor: 'testing' stamp: 'JG 7/4/2017 21:14:21'!
appliesTo: anItem onCart: aShoppingCart

	'todo: Implementar clock'.
	^ Date today dayOfWeek = dayOfWeek! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DiscountForDay class' category: #'TusLibros-Solution'!
DiscountForDay class
	instanceVariableNames: ''!

!DiscountForDay class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 21:09:26'!
of: aFraction on: aDay

	^ self new initializeWithDiscountOf: aFraction onDay: aDay
	! !


!classDefinition: #DiscountForItem category: #'TusLibros-Solution'!
Discount subclass: #DiscountForItem
	instanceVariableNames: 'item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!DiscountForItem methodsFor: 'initialization' stamp: 'JG 7/4/2017 21:01:39'!
initializeWithDiscountOf: aFraction withItem: anItem

	discount _ aFraction.
	item _ anItem.
	
	^ self! !


!DiscountForItem methodsFor: 'testing' stamp: 'JG 7/4/2017 21:00:17'!
appliesTo: anItem onCart: aShoppingCart

	^ item = anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DiscountForItem class' category: #'TusLibros-Solution'!
DiscountForItem class
	instanceVariableNames: ''!

!DiscountForItem class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 21:01:46'!
of: aFraction forItem: anItem

	^ self new initializeWithDiscountOf: aFraction withItem: anItem! !


!classDefinition: #DiscountForPack category: #'TusLibros-Solution'!
Discount subclass: #DiscountForPack
	instanceVariableNames: 'packMinimum'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!DiscountForPack methodsFor: 'initialization' stamp: 'JG 7/4/2017 20:54:32'!
initializeWithDiscountOf: aFraction withMinimum: anAmount

	discount _ aFraction.
	packMinimum _ anAmount.
	
	^ self
	! !



!DiscountForPack methodsFor: 'testing' stamp: 'JG 7/4/2017 20:53:45'!
appliesTo: anItem onCart: aShoppingCart

	^ (aShoppingCart countOf: anItem) >= packMinimum! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DiscountForPack class' category: #'TusLibros-Solution'!
DiscountForPack class
	instanceVariableNames: ''!

!DiscountForPack class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 20:55:27'!
of: aFraction withMinimum: anAmount

	^ self new initializeWithDiscountOf: aFraction withMinimum: anAmount
	! !


!classDefinition: #NullDiscount category: #'TusLibros-Solution'!
Discount subclass: #NullDiscount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!NullDiscount methodsFor: 'accesing' stamp: 'JG 7/4/2017 20:29:33'!
applyToPrice: aPrice

	^ aPrice! !

!NullDiscount methodsFor: 'accesing' stamp: 'JG 7/4/2017 20:39:26'!
discountForPrice: aPrice

	^ 0! !


!NullDiscount methodsFor: 'testing' stamp: 'JG 7/4/2017 20:29:16'!
appliesTo: anItem onCart: aShoppingCart

	^ true! !


!classDefinition: #DiscountApplier category: #'TusLibros-Solution'!
Object subclass: #DiscountApplier
	instanceVariableNames: 'discounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!DiscountApplier methodsFor: 'initialization' stamp: 'JG 7/4/2017 20:30:55'!
initializeWith: aDiscountCatalog

	discounts _ aDiscountCatalog.
	discounts add: (NullDiscount new).
	
	^ self! !


!DiscountApplier methodsFor: 'as yet unclassified' stamp: 'JG 7/4/2017 20:38:27'!
applyTo: anItem ofPrice: itemPrice onCart: aShoppingCart

	| itemDiscounts bestDiscount |

	itemDiscounts _ discounts select: [ :aDiscount | aDiscount appliesTo: anItem onCart: aShoppingCart ].
	bestDiscount _ itemDiscounts detectMax: [ :aDiscount | aDiscount discountForPrice: itemPrice ].

	^ bestDiscount applyToPrice: itemPrice
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DiscountApplier class' category: #'TusLibros-Solution'!
DiscountApplier class
	instanceVariableNames: ''!

!DiscountApplier class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 20:30:25'!
with: aDiscountCatalog

	^ self new initializeWith: aDiscountCatalog! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'working' stamp: 'JG 6/20/2017 01:49:56'!
debit: anAmount from: aCreditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error description' stamp: 'JG 6/21/2017 21:13:03'!
invalidCreditCardErrorDescription
	
	^ 'The credit card is invalid'! !

!MerchantProcessor class methodsFor: 'error description' stamp: 'JG 6/20/2017 01:48:48'!
unavailableErrorDescription

	^ 'The Merchant Processor is unavailable at the moment'
	! !


!classDefinition: #CreditCardRejecterMerchantProcessor category: #'TusLibros-Solution'!
MerchantProcessor subclass: #CreditCardRejecterMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCardRejecterMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 21:14:35'!
debit: anAmount from: aCreditCard

	self error: MerchantProcessor invalidCreditCardErrorDescription ! !


!classDefinition: #UnavailableMerchantProcessor category: #'TusLibros-Solution'!
MerchantProcessor subclass: #UnavailableMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!UnavailableMerchantProcessor methodsFor: 'working' stamp: 'JG 6/20/2017 01:54:30'!
debit: anAmount from: aCreditCard

	self error: MerchantProcessor unavailableErrorDescription ! !


!classDefinition: #Order category: #'TusLibros-Solution'!
Object subclass: #Order
	instanceVariableNames: 'shoppingCart creditCard date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Order methodsFor: 'initialization' stamp: 'JG 6/21/2017 19:28:31'!
initializeWith: aShoppingCart payingWith: aCreditCard on: aDate

	shoppingCart _ aShoppingCart.
	creditCard _ aCreditCard.
	date _ aDate.
	
	^ self! !


!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:31:57'!
creditCard

	 ^ creditCard! !

!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:32:01'!
date

	 ^ date! !

!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:31:51'!
shoppingCart

	 ^ shoppingCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Order class' category: #'TusLibros-Solution'!
Order class
	instanceVariableNames: ''!

!Order class methodsFor: 'instance creation' stamp: 'JG 6/21/2017 19:28:02'!
with: aShoppingCart payingWith: aCreditCard on: aDate

	^ self new initializeWith: aShoppingCart payingWith: aCreditCard on: aDate! !


!classDefinition: #RestToObjectTranslator category: #'TusLibros-Solution'!
Object subclass: #RestToObjectTranslator
	instanceVariableNames: 'carts catalog webServer cartsLastUse cashier cartClientID clientPurchases discountApplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!RestToObjectTranslator methodsFor: 'initializing' stamp: 'JG 6/25/2017 23:01:33'!
initialize

	carts _ Dictionary new.
	cartsLastUse _ Dictionary new.
	cartClientID _ Dictionary new.
	clientPurchases _ Dictionary new.
	cashier _ Cashier withCatalog: catalog withSalesBook: Bag new withMerchantProcessor: MerchantProcessor new.
	
	^ self! !

!RestToObjectTranslator methodsFor: 'initializing' stamp: 'JG 7/4/2017 21:26:07'!
initializeWithCatalog: aCatalog withWebServer: aWebServer withDiscountApplier: aDiscountApplier

	catalog _ aCatalog.
	webServer _ aWebServer.
	discountApplier _ aDiscountApplier.
	
	^ self! !


!RestToObjectTranslator methodsFor: 'creating' stamp: 'JG 7/4/2017 21:26:27'!
createCartForClientWithID: anID andPassword: aPassword on: aDateAndTime

	| cartID |

	cartID _ webServer generateCartID.
	carts at: cartID put: (ShoppingCart withCatalog: catalog withDiscountApplier: discountApplier).
	cartClientID at: cartID put: anID.
	self cartWithID: cartID usedOn: aDateAndTime.
	(clientPurchases includesKey: anID)
		ifFalse: [ clientPurchases at: anID put: Bag new ].
		
	^ cartID
	
	

	! !


!RestToObjectTranslator methodsFor: 'accessing' stamp: 'JG 6/25/2017 23:31:07'!
checkoutCartWithID: anID payingWith: aCreditCard

	| aSale |

	self validateCartWithID: anID.
	aSale _ cashier checkout: (carts at: anID) payingWith: aCreditCard on: Date today.
	(clientPurchases at: (cartClientID at: anID)) add: aSale.
	self removeCartWithID: anID.
	
	^ aSale
	
! !

!RestToObjectTranslator methodsFor: 'accessing' stamp: 'JG 6/24/2017 00:37:49'!
isExpiredCartWithID: anID

	^ (cartsLastUse includesKey: anID) not or: [ (cartsLastUse at: anID) < (DateAndTime now - 30 minutes) ]! !

!RestToObjectTranslator methodsFor: 'accessing' stamp: 'JG 6/25/2017 16:30:40'!
listCartWithID: anID 

	self validateCartWithID: anID.
	
	^ (carts at: anID) sortedCounts
	! !

!RestToObjectTranslator methodsFor: 'accessing' stamp: 'JG 6/25/2017 23:28:12'!
listPurchasesOfClientWithID: anID

	^ clientPurchases at: anID! !


!RestToObjectTranslator methodsFor: 'adding' stamp: 'JG 6/25/2017 21:03:32'!
add: anItem toCartWithID: anID

	^ self add: anItem toCartWithID: anID withOccurrences: 1! !

!RestToObjectTranslator methodsFor: 'adding' stamp: 'JG 6/25/2017 21:03:15'!
add: anItem toCartWithID: anID withOccurrences: anAmount 
	
	self validateCartWithID: anID.
	
	^ (carts at: anID) add: anItem withOccurrences: anAmount
	! !


!RestToObjectTranslator methodsFor: 'private' stamp: 'JG 6/24/2017 00:17:36'!
cartWithID: cartID usedOn: aDateAndTime

	cartsLastUse at: cartID put: aDateAndTime.
	
	^ self! !

!RestToObjectTranslator methodsFor: 'private' stamp: 'JG 6/25/2017 16:28:47'!
validateCartWithID: anID

	(carts includesKey: anID)
		ifTrue: [ 
			(self isExpiredCartWithID: anID)
				ifFalse: [ ^ true ]
				ifTrue: [ self error: RestToObjectTranslator cartIsExpiredErrorDescription]
			]
		ifFalse: [ self error: RestToObjectTranslator cartDoesntExistErrorDescription ]
	! !


!RestToObjectTranslator methodsFor: 'removing' stamp: 'JG 6/25/2017 22:55:23'!
removeCartWithID: anID

	carts removeKey: anID.
	cartsLastUse removeKey: anID.
	cartClientID removeKey: anID.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestToObjectTranslator class' category: #'TusLibros-Solution'!
RestToObjectTranslator class
	instanceVariableNames: ''!

!RestToObjectTranslator class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 21:25:11'!
withCatalog: aCatalog withWebServer: aWebServer withDiscountApplier: aDiscountApplier

	^ self new initializeWithCatalog: aCatalog withWebServer: aWebServer withDiscountApplier: aDiscountApplier! !


!RestToObjectTranslator class methodsFor: 'error description' stamp: 'JG 6/23/2017 19:10:20'!
cartDoesntExistErrorDescription

	^ 'The cart for the ID given does not exist'! !

!RestToObjectTranslator class methodsFor: 'error description' stamp: 'JG 6/24/2017 00:33:11'!
cartIsExpiredErrorDescription

	^ 'The cart for the ID given has expired'! !


!classDefinition: #Sale category: #'TusLibros-Solution'!
Object subclass: #Sale
	instanceVariableNames: 'creditCard amount date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Sale methodsFor: 'initialization' stamp: 'JG 6/15/2017 22:44:15'!
initializeWithCreditCard: aCreditCard withAmount: anAmount on: aDate

	creditCard _ aCreditCard.
	amount _ anAmount.
	date _ aDate.
	
	^ self! !


!Sale methodsFor: 'accesing' stamp: 'JG 6/25/2017 22:50:28'!
amount
	
	^ amount! !

!Sale methodsFor: 'accesing' stamp: 'JG 6/25/2017 22:50:39'!
creditCard
	
	^ creditCard! !

!Sale methodsFor: 'accesing' stamp: 'JG 6/25/2017 22:50:32'!
date
	
	^ date! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Solution'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'JG 6/15/2017 22:39:21'!
withCreditCard: aCreditCard withAmount: anAmount on: aDate

	^ self new initializeWithCreditCard: aCreditCard withAmount: anAmount on: aDate	! !


!classDefinition: #ShoppingCart category: #'TusLibros-Solution'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'contents catalog discountApplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/13/2017 21:51:31'!
add: newObject

	^ self add: newObject withOccurrences: 1
		! !

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/14/2017 11:42:38'!
add: newObject withOccurrences: anAmount

	(catalog includesKey: newObject) 
		ifTrue: [ (anAmount isInteger and: anAmount > 0)
			ifTrue: [ contents add: newObject withOccurrences: anAmount]
			ifFalse: [ self error: ShoppingCart invalidAmountOfItemsErrorDescription ] ]
		ifFalse: [ self error: ShoppingCart catalogDoesNotIncludeItemErrorDescription ].
		
	^ self ! !


!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/14/2017 11:42:48'!
countOf: anItem
	
	^ contents occurrencesOf: anItem ! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/13/2017 22:02:58'!
includes: anItem

	^ contents includes: anItem! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/13/2017 22:08:17'!
isEmpty

	^ contents isEmpty! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 7/4/2017 19:59:14'!
netPrice
	
	^ ( contents asSet collect: [ :anItem | (self countOf: anItem) * (self netPriceFor: anItem) ] ) sum! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 7/4/2017 20:35:29'!
netPriceFor: anItem

	^ discountApplier applyTo: anItem ofPrice: (self priceFor: anItem) onCart: self
! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 7/4/2017 19:58:53'!
price

	^ ( contents asSet collect: [ :anItem | (self countOf: anItem) * (self priceFor: anItem) ] ) sum! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 7/4/2017 19:58:38'!
priceFor: anItem

	^ catalog at: anItem
! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/23/2017 19:03:13'!
sortedCounts

	^ contents sortedCounts! !


!ShoppingCart methodsFor: 'initializing' stamp: 'JG 6/13/2017 22:02:19'!
initialize

	contents _ Bag new.
	
	^ self! !

!ShoppingCart methodsFor: 'initializing' stamp: 'JG 6/13/2017 20:40:03'!
initializeWith: aCatalog
	
	catalog _ aCatalog.
	
	^ self! !

!ShoppingCart methodsFor: 'initializing' stamp: 'JG 7/4/2017 20:25:13'!
initializeWith: aCatalog withDiscountApplier: aDiscountApplier
	
	catalog _ aCatalog.
	discountApplier _ aDiscountApplier.
	
	^ self! !

!ShoppingCart methodsFor: 'initializing' stamp: 'JG 7/4/2017 19:53:53'!
initializeWith: aCatalog withDiscounts: aDiscountCatalog
	
	catalog _ aCatalog.
	discounts _ aDiscountCatalog.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Solution'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 21:50:10'!
catalogDoesNotIncludeItemErrorDescription
	
	^ 'The item is not included in the catalog'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 22:20:33'!
invalidAmountOfItemsErrorDescription

	^ 'The amount of items is invalid'! !


!ShoppingCart class methodsFor: 'instance creation' stamp: 'JG 7/4/2017 20:24:51'!
withCatalog: aCatalog withDiscountApplier: aDiscountApplier

	^ self new initializeWith: aCatalog withDiscountApplier: aDiscountApplier! !


!classDefinition: #WebServer category: #'TusLibros-Solution'!
Object subclass: #WebServer
	instanceVariableNames: 'lastIDAssignedToACart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!WebServer methodsFor: 'generating' stamp: 'JG 6/24/2017 00:09:40'!
generateCartID

	lastIDAssignedToACart _ lastIDAssignedToACart + 1.

	^ lastIDAssignedToACart! !


!WebServer methodsFor: 'initializing' stamp: 'JG 6/24/2017 00:09:27'!
initialize

	lastIDAssignedToACart _ 0.
	
	^ self! !
