!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart aProduct anEmptyCatalog aCatalogWithAProduct anExpiredCard today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 14:59:42'!
test01ANewCartShouldBeEmpty

	aCart _ Cart new.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:00:56'!
test02WhenAProductIsAddedTheCartShouldNotBeEmpty

	aCart _ Cart with: aCatalogWithAProduct.

	aCart add: aProduct.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:01:16'!
test03ACartIncludesAnAddedProduct

	aCart _ Cart with: aCatalogWithAProduct.

	aCart add: aProduct.
	
	self assert: (aCart includes: aProduct).! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:01:33'!
test04ACartDoesNotIncludeAProductThatHasntBeenAdded

	aCart _ Cart new.
	
	self deny: (aCart includes: aProduct).
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 16:37:26'!
test05TheAmountOfAProductAfterAddingItTwiceIsTwo

	aCart _ Cart with: aCatalogWithAProduct.
	
	aCart add: aProduct; add: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 2.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:02:40'!
test06TheAmountOfAProductAfterAddingThreeOfItIsThree

	aCart _ Cart with: aCatalogWithAProduct.
	
	aCart add: 3 of: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 3.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:03:06'!
test07AddingANegativeAmountOfAProductShouldRaiseError

	aCart _ Cart with: aCatalogWithAProduct.
	
	self should: [aCart add: -1 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeOrZeroAmountErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:03:56'!
test08ACartWithProductsPrintsThem

	| aString |

	aCart _ Cart with: aCatalogWithAProduct.
	
	aCart add: 3 of: aProduct.
	
	aString _ String streamContents: [:aStream |
				aCart printOn: aStream.	].
			
	self assert: aString equals: '''aProduct'' ''aProduct'' ''aProduct'''.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:04:17'!
test09AddingANonWholeNumberAmountOfAProductShouldRaiseError

	aCart _ Cart with: aCatalogWithAProduct.
	
	self should: [aCart add: 5/3 of: aProduct.]	
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart nonWholeNumberErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 15:09:21'!
test10AddingAProductThatDoesntBelongToTheCatalogShouldRaiseError
		
	aCart _ Cart with: anEmptyCatalog.	
	
	self should: [aCart add: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotOnCatalogErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 16:11:49'!
test11CanNotCreateACachierWithAnEmptyCart

	| aCard |
		
	aCart _ Cart with: anEmptyCatalog.
	
	aCard _ Card new.
	
	self should: [Cashier with: aCart payingWith: aCard on: today.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier emptyCartErrorMessage] ! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 16:11:35'!
test12CanNotCreateACachierWithAnExpiredCard
		
	aCart _ Cart with: aCatalogWithAProduct.
	
	aCart add: 'aProduct'.
	
	self should: [Cashier with: aCart payingWith: anExpiredCard on: today.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier expiredCardErrorMessage.] ! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/16/2017 16:38:09'!
test13CreatingACardWithANumberWithMoreThanSixteenDigitsShouldRaiseEror
	
	self should: [Card number: 12345678901234567 forOwner: 'Jaime'  thatExpiresOn: 'december' of: 2017.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Card invalidNumberErrorMessage.] ! !


!CartTest methodsFor: 'set up' stamp: 'ad 6/16/2017 16:12:01'!
setUp

	aProduct _ 'aProduct'.
	
	anEmptyCatalog _ Set new.
	
	aCatalogWithAProduct _ Set with: 'aProduct'.	
	
	anExpiredCard _ Card number: 0000000000000000 forOwner: 'Owner' thatExpiresOn: 'march' of: 2017.
	
	today _ Date today.! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'number owner expMonth expYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'private' stamp: 'ad 6/16/2017 16:03:57'!
initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthNameOrIndex of: aYear

	number _ aCardNumber.
	
	owner _ aName.
	
	
	expMonth _ aMonthNameOrIndex isInteger 
				ifTrue: [aMonthNameOrIndex]
				ifFalse: [Month indexOfMonth: aMonthNameOrIndex].
	
	expYear _ aYear.! !


!Card methodsFor: 'testing' stamp: 'ad 6/16/2017 16:09:49'!
isExpiredOn: aDate

	^ (expYear <= aDate yearNumber) and: (expMonth < aDate monthIndex). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'ad 6/16/2017 16:23:49'!
number: aCardNumber forOwner: aName thatExpiresOn: aMonthNameOrIndex of: aYear.

	(self isValidCardNumber: aCardNumber) ifFalse: [self error: self invalidNumberErrorMessage].

	^ self new initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthNameOrIndex of: aYear.
	
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

!Cart methodsFor: 'initialization' stamp: 'ad 6/12/2017 11:24:42'!
initialize

	products _ Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'dim 6/14/2017 18:57:33'!
initializeWith: aCatalog

	catalog _ aCatalog.
	products  _ Bag new.! !


!Cart methodsFor: 'adding' stamp: 'dim 6/14/2017 19:20:45'!
add: aProduct

	self add: 1 of: aProduct.! !

!Cart methodsFor: 'adding' stamp: 'ad 6/16/2017 15:09:18'!
add: anAmount of: aProduct
	(catalog includes: aProduct) ifFalse: [ self error:  self class productNotOnCatalogErrorMessage ].
		
	(anAmount isKindOf: Integer) ifFalse: [self error: self class nonWholeNumberErrorMessage ].
	(anAmount > 0) ifFalse: [self error: self class negativeOrZeroAmountErrorMessage ].
			products add: aProduct withOccurrences: anAmount.! !


!Cart methodsFor: 'testing' stamp: 'ad 6/12/2017 11:24:30'!
includes: aProduct

	^ products includes: aProduct.! !

!Cart methodsFor: 'testing' stamp: 'ad 6/12/2017 11:24:48'!
isEmpty

	^ products isEmpty.! !


!Cart methodsFor: 'accessing' stamp: 'ad 6/12/2017 11:25:11'!
amountOf: aProduct

	^ products occurrencesOf: aProduct.! !

!Cart methodsFor: 'accessing' stamp: 'AD 6/13/2017 21:06:01'!
products

	^ products copy.! !


!Cart methodsFor: 'printing' stamp: 'AD 6/13/2017 19:44:46'!
printOn: aStream

	| iter |
	
	iter _ 1.

	self productsDo: [:aProduct | 
			aProduct printOn: aStream.
			(iter = products size) ifFalse: [ 
					aStream nextPutAll: ' '.].
			iter _ iter + 1.]! !


!Cart methodsFor: 'enumerating' stamp: 'AD 6/13/2017 19:18:27'!
productsDo: aBlock

	products do: [:aProduct |
				aBlock value: aProduct ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'AD 6/13/2017 21:21:44'!
negativeOrZeroAmountErrorMessage
	
	^ 'Can not add a negative or zero amount'! !

!Cart class methodsFor: 'error messages' stamp: 'AD 6/13/2017 21:20:24'!
nonWholeNumberErrorMessage
	
	^ 'Can not add a non whole number amount.'! !

!Cart class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:09:08'!
productNotOnCatalogErrorMessage

	^ 'Product not listed on catalog'! !


!Cart class methodsFor: 'class initialization' stamp: 'dim 6/14/2017 18:56:09'!
with: aCatalog
 
	^self new initializeWith: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'ad 6/16/2017 15:48:00'!
with: aCart payingWith: aCard on: aDate

	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	(aCard isExpiredOn: aDate ) ifTrue: [self error: self expiredCardErrorMessage].! !


!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:30:23'!
emptyCartErrorMessage

	^ 'Can not create a cashier with an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:45:04'!
expiredCardErrorMessage

	^ 'Can not create a cashier with an expired card.'! !
