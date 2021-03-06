Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:15'!
itemsAndQuantitiesDo: aBlock
	
	^ self content contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content
	
	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog
	
	^ catalog! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


Object subclass: #CartSession
	instanceVariableNames: 'owner cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:55'!
cart
	
	^ cart! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:58'!
owner
	
	^ owner! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 11:54'!
initializeOwnedBy: aClient with: aCart 

	owner := aClient.
	cart := aCart ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:54'!
ownedBy: aClient with: aCart 

	^self new initializeOwnedBy: aClient with: aCart ! !


TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |
	
	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity | 
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].
	
	ticket := Ticket of: lineItems 
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity 

	^(cart catalog at: anItem) * aQuantity  ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity 

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !


TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart
		ownedBy: testObjectsFactory customer 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				ownedBy: testObjectsFactory customer 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!LineItem methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal 

! !

!LineItem methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


Object subclass: #RestInterface
	instanceVariableNames: 'validUsersAndPasswords carts catalog lastId merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId
	
	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una 
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"
	
	lastId := lastId + 1.
	^lastId! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:06'!
listPurchasesOf: aUser authenticatingWith: aPassword

	| sales |
	
	sales := salesBook select: [ :aSale | aSale wasDoneBy: aUser ].
	"hmmm muy largo y feo ... me parece que deberia haber empezado con un test mas simple como cuando no hay ventas de un cliente.
	Ademas tengo que renombrar user por client y hay mucho por hacer... igual continuo para hacer pasar el test"
	^ sales
		inject: Dictionary new
		into: [ :salesOrderedByBook :aSale | 
			aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
				oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
				newTotal := oldTotal + aLineItem total.
				salesOrderedByBook at: aLineItem put: newTotal ].
			salesOrderedByBook ].
		
	
		! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:21'!
listCartIdentifiedAs: aCartId

	^ self withCartIdentifiedAs: aCartId do: [ :cart | cart content ]! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId
	
	self error: self invalidCartIdErrorDescription ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:57'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self 
		withCartSessionIdentifiedAs: aCartId 
		do: [ :cartSession | 
			(Cashier 
				toCheckout: cartSession cart 
				ownedBy: cartSession owner
				charging: (CreditCard expiringOn: anExpirationMonthOfYear) 
				throught: merchantProcessor 
				on: self today 
				registeringOn: salesBook) checkOut ]! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:56'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |
	
	cartSession := carts at: aCartId ifAbsent: [self signalInvalidCartId ].
	^ aBlock value: cartSession 
! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:17'!
today
	
	^DateAndTime now! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:07'!
is: aUser authenticatingWith: aPassword 

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"
	
	| storedPassword |
	
	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword
	
	self error: self invalidUserAndOrPasswordErrorDescription! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:58'!
withCartIdentifiedAs: aCartId do: aBlock

	^self withCartSessionIdentifiedAs: aCartId do: [ :aCartSession | aBlock value: aCartSession cart ]
! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription
	
	^'Invalid user and/or password'! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:53'!
createCartFor: aUser authenticatedWith: aPassword

	| cartId |
	
	(self is: aUser authenticatingWith: aPassword) ifFalse: [ self signalInvalidUserAndOrPassword ].
	
	cartId := self generateCartId.
	carts at: cartId put: (CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog)).
	
	^cartId ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^Cart invalidItemErrorMessage ! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:26'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartIdentifiedAs: aCartId do: [ :cart | cart add: anAmount of: aBook ]! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:48'!
initializeAuthenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook debitingThrought: aMerchantProcessor 

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	carts := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:48'!
authenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook debitingThrought: aMerchantProcessor 

	^self new initializeAuthenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook debitingThrought: aMerchantProcessor ! !


TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard 
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:26'!
test04CanAddItemsToACreatedCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		shouldnt: [interface add: 1 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:13'!
test12CanNotCheckoutAnEmptyCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface cartCanNotBeEmptyErrorMessage ]
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:06'!
test03CanNotCreateCartWithInvalidPassword

	| interface |

	interface := self createDefaultInterface.

	self
		should: [ interface createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidUserAndOrPasswordErrorDescription ]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor 

	^self! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 00:08'!
test08CanNotListCartOfInvalidCartId

	| interface |

	interface := self createDefaultInterface.

	self 
		should: [interface listCartIdentifiedAs: self invalidCartId] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 00:05'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (interface listCartIdentifiedAs: cartId) isEmpty 
	! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword
	
	^'invalidPassword'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:05'!
test01CanCreateCartWithValidUserAndPassword

	| interface |
	
	interface := self createDefaultInterface.

	self 
		shouldnt: [interface createCartFor: self validUser authenticatedWith: self validUserPassword]
		raise: Error - MessageNotUnderstood ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:10'!
test11CanNotCheckoutANotCreatedCart

	| interface |

	interface := self createDefaultInterface.

	self
		should: [interface 
			checkOutCartIdentifiedAs: self invalidCartId  
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:27'!
test06CanNotAddItemNotSellByTheStore

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [interface add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidItemErrorMessage ]
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser
	
	^'validUser'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:27'!
test05CanNotAddItemToNotCreatedCart

	| interface |

	interface := self createDefaultInterface.

	self
		should: [interface add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:03'!
test02CanNotCreateCartWithInvalidUser

	| interface |

	interface := self createDefaultInterface.

	self
		should: [ interface createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidUserAndOrPasswordErrorDescription ]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword
	
	^'validUserPassword'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:27'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface canNotChargeAnExpiredCreditCardErrorMessage ]
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:33'!
test14ListPurchasesIncludesBoughtItems

	| interface cartId purchases |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: 2 of: self validBook toCartIdentifiedAs: cartId.
	interface add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	interface 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: '1111222233334444' 
		ownedBy: 'Juan Perez' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	purchases := interface listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) = (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: (purchases at: self anotherValidBook) = testObjectsFactory anotherItemSellByTheStorePrice.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId
	
	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:47'!
createDefaultInterface
	
	^RestInterface 
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf: testObjectsFactory defaultCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook
	
	^testObjectsFactory anotherItemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook
	
	^testObjectsFactory itemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:27'!
test10CanCheckoutACart

	| interface cartId  |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		shouldnt: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook
	
	^OrderedCollection new! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/21/2013 23:43'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 11:27'!
test09ListCartReturnsTheRightNumberOfItems

	| interface cartId cartContent |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: 1 of: self validBook toCartIdentifiedAs: cartId.
	interface add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := interface listCartIdentifiedAs: cartId.
	
	self assert: (cartContent occurrencesOf: self validBook) = 1. 
	self assert: (cartContent occurrencesOf: self anotherValidBook) = 2
! !


Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total
	
	^ ticket total! !


!Sale methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket 

	customer := aCustomer.
	ticket := aTicket ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket 

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear 

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredMonthOfYear ! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer
	
	^'aCustomer'! !


Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems 

	lineItems := aCollectionOfLineItems ! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total
	
	^lineItems sum: [ :aLineItem | aLineItem total]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !
