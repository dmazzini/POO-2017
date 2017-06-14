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

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:34:01'!
test02WhenAProductIsAddedTheCartShouldNotBeEmpty
	
	aCart _ Cart new.
	
	aCart add: aProduct.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:34:03'!
test03ACartIncludesAnAddedProduct
	
	aCart _ Cart new.
	
	aCart add: aProduct.
	
	self assert: (aCart includes: aProduct).
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 11:28:40'!
test04ACartDoesNotIncludeAProductThatHasntBeenAdded
	
	aCart _ Cart new.
	
	self deny: (aCart includes: aProduct).
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:34:10'!
test05TheAmountOfAProductAfterAddingItTwiceIsTwo
	
	aCart _ Cart new.
	
	aCart add: aProduct.
	aCart add: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 2.
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:39:44'!
test06TheAmountOfAProductAfterAddingThreeOfItIsThree
	
	aCart _ Cart new.
	
	aCart add: 3 of: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 3.
	
! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/13/2017 21:21:58'!
test07AddingANegativeAmountOfAProductShouldRaiseError
	
	aCart _ Cart new.	
	
	self should: [aCart add: -1 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeOrZeroAmountErrorMessage.
						self assert: aCart isEmpty .]
	
! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/13/2017 21:12:51'!
test08ACartWithProductsPrintsThem

	| aString |
	
	aCart _ Cart new.
	
	aCart add: 3 of: aProduct.	
	
	aString _ String streamContents: [:aStream |
				aCart printOn: aStream.	].
	
	self assert: aString equals: '''aProduct'' ''aProduct'' ''aProduct'''.
					
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/13/2017 21:16:10'!
test09AddingANonWholeNumberAmountOfAProductShouldRaiseError
	
	aCart _ Cart new.	
	
	self should: [aCart add: 5/3 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart nonWholeNumberErrorMessage.
						self assert: aCart isEmpty .]
	
! !


!CartTest methodsFor: 'set up' stamp: 'ad 6/12/2017 11:27:29'!
setUp

	aProduct _ 'aProduct'! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'ad 6/12/2017 11:24:42'!
initialize

	products _ Bag new.! !


!Cart methodsFor: 'adding' stamp: 'ad 6/12/2017 12:33:48'!
add: aProduct

	products add: aProduct.! !

!Cart methodsFor: 'adding' stamp: 'AD 6/13/2017 21:21:53'!
add: anAmount of: aProduct

	(anAmount isKindOf: Integer) ifFalse: [self error: self class nonWholeNumberErrorMessage ].
	(anAmount > 0) ifFalse: [self error: self class negativeOrZeroAmountErrorMessage ].
		
	anAmount timesRepeat: [self add: aProduct ]! !


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
