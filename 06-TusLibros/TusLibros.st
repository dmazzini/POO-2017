!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart aProduct'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 11:26:56'!
test01ANewCartShouldBeEmpty
	
	aCart _ Cart new.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:11:27'!
test02WhenAProductIsAddedTheCartShouldNotBeEmpty
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.

	aCart add: aProduct.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:12:21'!
test03ACartIncludesAnAddedProduct
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.

	aCart add: aProduct.
	self assert: (aCart includes: aProduct).
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 11:28:40'!
test04ACartDoesNotIncludeAProductThatHasntBeenAdded
	
	aCart _ Cart new.
	
	self deny: (aCart includes: aProduct).
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:12:51'!
test05TheAmountOfAProductAfterAddingItTwiceIsTwo
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.
	aCart add: aProduct.
	aCart add: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 2.
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:13:26'!
test06TheAmountOfAProductAfterAddingThreeOfItIsThree
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.
	
	aCart add: 3 of: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 3.
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:22:42'!
test07AddingANegativeAmountOfAProductShouldRaiseError
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.	

	self should: [aCart add: -1 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeOrZeroAmountErrorMessage.
						self assert: aCart isEmpty .]
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:14:03'!
test08ACartWithProductsPrintsThem

	|aCatalog aString|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.
	aCart add: 3 of: aProduct.	
	
	aString _ String streamContents: [:aStream |
				aCart printOn: aStream.	].
	
	self assert: aString equals: '''aProduct'' ''aProduct'' ''aProduct'''.
					
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:23:13'!
test09AddingANonWholeNumberAmountOfAProductShouldRaiseError
	|aCatalog|
	
	aCatalog _ Set new.
	
	aCatalog add: aProduct.

	aCart _ Cart with: aCatalog.
	self should: [aCart add: 5/3 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart nonWholeNumberErrorMessage.
						self assert: aCart isEmpty .]
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:05:31'!
test10AddingAProductThatNotBelongToCatalogShouldRaiseError
	|aCatalog|

	aCatalog _ Set new.
		
	aCart _ Cart with: aCatalog.	

	self should: [aCart add: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotFoundErrorMessage.
						self assert: aCart isEmpty .]
	
! !

!CartTest methodsFor: 'tests' stamp: 'dim 6/14/2017 19:16:11'!
test11AddingMoreThanOneProductThatNotBelongToCatalogShouldRaiseError
	|aCatalog|

	aCatalog _ Set new.
		
	aCart _ Cart with: aCatalog.	

	self should: [aCart add: 3 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotFoundErrorMessage.
						self assert: aCart isEmpty .]
	
! !


!CartTest methodsFor: 'set up' stamp: 'ad 6/12/2017 11:27:29'!
setUp

	aProduct _ 'aProduct'! !


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

!Cart methodsFor: 'adding' stamp: 'dim 6/14/2017 19:20:27'!
add: anAmount of: aProduct
	(catalog includes: aProduct) ifFalse: [ self error:  self class productNotFoundErrorMessage ].
		
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

!Cart class methodsFor: 'error messages' stamp: 'ad 6/12/2017 12:14:17'!
productNotFoundErrorMessage
	
	^ 'Product not found'! !


!Cart class methodsFor: 'class initialization' stamp: 'dim 6/14/2017 18:56:09'!
with: aCatalog
 
	^self new initializeWith: aCatalog ! !
