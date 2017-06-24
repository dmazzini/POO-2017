!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'cartFactory aCart anExpiredCard today aNotExpiredCard aSalesBook dummyMerchantProcessor merchantProcessorWithoutDebitBehavior aProductA aProductB aProductC'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 19:11:13'!
test01ANewCartShouldBeEmpty

	self assert: cartFactory createCartWithCatalogWithOneProduct isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:07:28'!
test02WhenAProductIsAddedTheCartShouldNotBeEmpty

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:01'!
test03ACartIncludesAnAddedProduct

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA.
	
	self assert: (aCart includes: aProductA).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:07'!
test04ACartDoesNotIncludeAProductThatHasntBeenAdded

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	self deny: (aCart includes: aProductA).
! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:29'!
test05TheAmountOfAProductAfterAddingItTwiceIsTwo

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA; add: aProductA.
	
	self assert: (aCart amountOf: aProductA) = 2.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:55'!
test06TheAmountOfAProductAfterAddingThreeOfItIsThree

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: 3 of: aProductA.
	
	self assert: (aCart amountOf: aProductA) = 3.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:09'!
test07AddingANegativeAmountOfAProductShouldRaiseError

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	self should: [aCart add: -1 of: aProductA.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeOrZeroAmountErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:33'!
test08ACartWithProductsPrintsThem

	| aString |

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: 3 of: aProductA.
	
	aString _ String streamContents: [:aStream |
				aCart printOn: aStream.	].
			
	self assert: aString equals: '''aProductA'' ''aProductA'' ''aProductA'''.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:44'!
test09AddingANonWholeNumberAmountOfAProductShouldRaiseError

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	self should: [aCart add: 5/3 of: aProductA.]	
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart nonWholeNumberErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:49'!
test10AddingAProductThatDoesntBelongToTheCatalogShouldRaiseError
		
	aCart _ cartFactory createCartWithEmptyCatalog.
	
	self should: [aCart add: aProductA.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotOnCatalogErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:17:04'!
test11CanNotCreateACashierWithAnEmptyCart

	aCart _ cartFactory createCartWithEmptyCatalog.
	
	self should: [Cashier for: aCart payingWith: aNotExpiredCard to: dummyMerchantProcessor registeringIn: aSalesBook on: today.]
			raise: Error - MessageNotUnderstood 
 			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier emptyCartErrorMessage] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:10:09'!
test12CanNotCreateACashierWithAnExpiredCard
		
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: aProductA.
	
	self should: [Cashier for: aCart payingWith: anExpiredCard to: dummyMerchantProcessor registeringIn: aSalesBook on: today.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier expiredCardErrorMessage.] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/22/2017 11:00:25'!
test13CreatingACardWithANumberWithMoreThanSixteenDigitsShouldRaiseEror
	
	self should: [Card number: 12345678901234567 forOwner: 'Jaime'  thatExpiresOn:(Month month: today monthIndex year: today yearNumber + 1).]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Card invalidNumberErrorMessage.] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:10:50'!
test14CheckoutTotalForACartWithOneProductShouldBeEqualToThatProductPrice

	| aCashier |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: aProductA.
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn:aSalesBook on: today.
	
	self assert: aCashier checkout total = (aCart catalog at: aProductA).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:15:17'!
test15CheckoutTotalShouldBeEqualToTheSumOfAllCartsProductsPrices

	| aCashier |
	
	aCart _ cartFactory createCartWithCatalogWithThreeProducts.
	
	aCart add: 1 of: aProductA; add: 2 of: aProductB; add: 3 of: aProductC.	
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn: aSalesBook on: today.
	
	self assert: aCashier checkout total = ((aCart catalog at: aProductA) + ((aCart catalog at: aProductB) *2) + ((aCart catalog at: aProductC) *3) ).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:11:38'!
test16CashierCanNotCheckoutACartWithNotEnoughCredit

	| aCashier merchantProcessorSimulator |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | self error: Cashier cardDoesNotHaveEnoughCreditErrorMessage ].
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today .
	
	self 
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier cardDoesNotHaveEnoughCreditErrorMessage.
			].! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:11:46'!
test17CashierCanNotCheckoutACartWithAStolenCard

	| aCashier merchantProcessorSimulator |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | self error: Cashier cardStolenErrorMessage ].
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today .
	
	self 
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier cardStolenErrorMessage.
			].! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:14:18'!
test18CashierShouldNotInvokeMerchantProcessorIfTheCardIsExpired

	| merchantProcessorSimulator merchantProcessorDebits |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorDebits _ 0.
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | merchantProcessorDebits _ merchantProcessorDebits +1].
	
	self should: [Cashier for: aCart payingWith: anExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today .]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier expiredCardErrorMessage.
					self assert: merchantProcessorDebits = 0. 
			] 
	
	
		! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:11:59'!
test19SuccessfulCheckoutRegistersTheSale

	| aCashier aSale |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn: aSalesBook on: today.
	
	aSale _ aCashier checkout .
	
	self assert: aSalesBook first = aSale.! !


!CartTest methodsFor: 'set up' stamp: 'DIM 6/24/2017 20:07:07'!
setUp

	cartFactory _ CartFactory new.
	
	aProductA _ 'aProductA'.
	aProductB _ 'aProductB'.
	aProductC _ 'aProductC'.
	
	today _ Date today.
	
	aSalesBook _ OrderedCollection new.
		
	anExpiredCard _ Card number: 0000000000000000 forOwner: 'Owner' thatExpiresOn: (Month month: today monthIndex year: today yearNumber - 1).

	aNotExpiredCard _ Card number: 0000000000000000 forOwner: 'Owner' thatExpiresOn: (Month month: today monthIndex year: today yearNumber + 1).	

	dummyMerchantProcessor _ MerchantProcessorSimulator with: [].	

	merchantProcessorWithoutDebitBehavior _ MerchantProcessorSimulator with: [:anAmount :aCard | ].! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'number owner expireOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'private' stamp: 'dim 6/20/2017 18:51:46'!
initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthOfYear

	number _ aCardNumber.
	
	owner _ aName.
	
	expireOn _ aMonthOfYear.! !


!Card methodsFor: 'testing' stamp: 'dim 6/20/2017 19:12:19'!
isExpiredOn: aDate

	| aMonthOfaYear |
	
	aMonthOfaYear  _ Month month: aDate monthIndex year: aDate yearNumber.
	
	^ expireOn start < aMonthOfaYear start.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'dim 6/20/2017 18:52:47'!
number: aCardNumber forOwner: aName thatExpiresOn: aMonthOfaYear.

	(self isValidCardNumber: aCardNumber) ifFalse: [self error: self invalidNumberErrorMessage].

	^ self new initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthOfaYear.
	
	! !


!Card class methodsFor: 'error messages' stamp: 'ad 6/16/2017 16:22:11'!
invalidNumberErrorMessage

	^ 'Card number should contain 16 digits'! !


!Card class methodsFor: 'validation' stamp: 'ad 6/16/2017 16:28:44'!
isValidCardNumber: aCardNumber
	
	^ (aCardNumber isKindOf: Integer) and: [aCardNumber asString size <= 16].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'dim 6/14/2017 18:57:33'!
initializeWith: aCatalog

	catalog _ aCatalog.
	products  _ Bag new.! !


!Cart methodsFor: 'adding' stamp: 'dim 6/14/2017 19:20:45'!
add: aProduct

	self add: 1 of: aProduct.! !

!Cart methodsFor: 'adding' stamp: 'DIM 6/21/2017 10:54:09'!
add: anAmount of: aProduct

	(catalog includesKey: aProduct) ifFalse: [ self error:  self class productNotOnCatalogErrorMessage ].
		
	(anAmount isKindOf: Integer) ifFalse: [self error: self class nonWholeNumberErrorMessage ].
	
	(anAmount > 0) ifFalse: [self error: self class negativeOrZeroAmountErrorMessage ].
	
	products add: aProduct withOccurrences: anAmount.! !


!Cart methodsFor: 'testing' stamp: 'DIM 6/21/2017 10:54:23'!
includes: aProduct

	^ products includes: aProduct.! !

!Cart methodsFor: 'testing' stamp: 'DIM 6/21/2017 10:53:44'!
isEmpty

	^ products isEmpty.! !


!Cart methodsFor: 'accessing' stamp: 'DIM 6/21/2017 10:52:36'!
amountOf: aProduct

	^ products occurrencesOf: aProduct.! !

!Cart methodsFor: 'accessing' stamp: 'DIM 6/24/2017 19:39:17'!
catalog

	^ catalog.! !

!Cart methodsFor: 'accessing' stamp: 'DIM 6/21/2017 10:52:27'!
products

	^ products copy.! !

!Cart methodsFor: 'accessing' stamp: 'ad 6/22/2017 12:38:03'!
totalPrice

	| totalPrice |
	
	totalPrice _ 0.
	
	self productsDo: [:aProduct |
		
			totalPrice _ totalPrice  + catalog at:aProduct .
		].			
		
	^ totalPrice.
				
	! !


!Cart methodsFor: 'printing' stamp: 'DIM 6/21/2017 10:53:32'!
printOn: aStream

	| iter |	
	
	iter _ 1.
	
	self productsDo: [:aProduct |
		
			aProduct printOn: aStream.
			
			(iter = products size) ifFalse: [ 
				
					aStream nextPutAll: ' '.].
				
			iter _ iter + 1.]! !


!Cart methodsFor: 'enumerating' stamp: 'DIM 6/21/2017 10:54:48'!
productsDo: aBlock

	products do: [:aProduct |
		
				aBlock value: aProduct ].
			
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'DIM 6/21/2017 10:55:04'!
negativeOrZeroAmountErrorMessage

	^ 'Can not add a negative or zero amount'! !

!Cart class methodsFor: 'error messages' stamp: 'DIM 6/21/2017 11:01:18'!
nonWholeNumberErrorMessage

	^ 'Can not add a non whole number amount.'! !

!Cart class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:09:08'!
productNotOnCatalogErrorMessage

	^ 'Product not listed on catalog'! !


!Cart class methodsFor: 'initialization' stamp: 'dim 6/14/2017 18:56:09'!
with: aCatalog
 
	^self new initializeWith: aCatalog ! !


!classDefinition: #CartFactory category: #TusLibros!
Object subclass: #CartFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 20:07:45'!
createCartWithCatalogWithOneProduct
	
	| aCatalogWithOneProduct |	
	
	aCatalogWithOneProduct  _ Dictionary new.
	
	aCatalogWithOneProduct at:'aProductA' put:5.
	
	^ Cart with: aCatalogWithOneProduct.! !

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 19:35:01'!
createCartWithCatalogWithThreeProducts
	
	| aCatalogWithThreeProducts |	
	
	aCatalogWithThreeProducts  _ Dictionary new.
	
	aCatalogWithThreeProducts at:'aProductA' put:5; at:'aProductB' put:10; at:'aProductC' put:20.	.
	
	^ Cart with: aCatalogWithThreeProducts.! !

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 19:10:53'!
createCartWithEmptyCatalog
		
	^ Cart with: Dictionary new.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart card date merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'private' stamp: 'DIM 6/23/2017 19:11:24'!
initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate 

	cart _ aCart.
	card _ aCard.
	merchantProcessor _ aMerchantProcessor.
	date _ aDate.
	salesBook _ aSalesBook.! !


!Cashier methodsFor: 'checkout' stamp: 'DIM 6/24/2017 18:25:27'!
checkout
	| totalPrice aSale |
	
	totalPrice  _ cart totalPrice.
	merchantProcessor debit: totalPrice from: card.
	aSale _ Sale total: totalPrice.
	salesBook add: aSale.
	^ aSale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'DIM 6/23/2017 19:09:32'!
for: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate 

	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	(aCard isExpiredOn: aDate ) ifTrue: [self error: self expiredCardErrorMessage].
	
	^ self new initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate.
! !


!Cashier class methodsFor: 'error messages' stamp: 'DIM 6/23/2017 17:19:18'!
cardDoesNotHaveEnoughCreditErrorMessage
	
	^ 'Card does not have enough credit'.! !

!Cashier class methodsFor: 'error messages' stamp: 'DIM 6/23/2017 17:38:56'!
cardStolenErrorMessage

	^ 'The card was stolen' ! !

!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:30:23'!
emptyCartErrorMessage

	^ 'Can not create a cashier with an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:45:04'!
expiredCardErrorMessage

	^ 'Can not create a cashier with an expired card.'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'private' stamp: 'DIM 6/23/2017 17:10:57'!
initializeWith: aDebitBlock

	debitBlock _ aDebitBlock.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'DIM 6/23/2017 17:18:37'!
debit: anAmount from: aCard 

	debitBlock value: anAmount value: aCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'initialization' stamp: 'DIM 6/23/2017 17:10:16'!
with: aDebitBlock

	^ self new initializeWith: aDebitBlock.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'private' stamp: 'DIM 6/24/2017 18:23:58'!
initializeWithTotal: aTotal

	total _ aTotal.! !


!Sale methodsFor: 'accessing' stamp: 'DIM 6/24/2017 18:24:39'!
total

	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'initialization' stamp: 'DIM 6/24/2017 18:23:12'!
total: aTotal

	^ self new initializeWithTotal: aTotal.! !
