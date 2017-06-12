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

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:39:48'!
test07AddingANegativeAmountOfAProductShouldRaiseError
	
	aCart _ Cart new.	
	
	self should: [aCart add: -1 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeAmountErrorMessage]
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:37:13'!
test08ACartShouldBeEmptyAfterAddingAndRemovingAProduct
	
	aCart _ Cart new.	
	
	aCart add: aProduct.
	aCart remove: aProduct.
	
	self assert: aCart isEmpty.
					
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:37:16'!
test09RemovingAProductThatIsNotInTheCartShouldRaiseError
	
	aCart _ Cart new.	
	
	self should: [aCart remove: aProduct]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotFoundErrorMessage]
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:39:53'!
test10WhenAddingThreeAndRemovingTwoOfAProductThereShouldBeOnlyOneLeft
	
	aCart _ Cart new.	
	
	aCart add: 3 of: aProduct.
	aCart remove: 2 of: aProduct.
	
	self assert: (aCart amountOf: aProduct) = 1.
					
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:39:28'!
test11RemovingANegativeAmountOfAProductShouldRaiseError
	
	aCart _ Cart new.	
	
	self should: [aCart remove: -1 of: aProduct.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeAmountErrorMessage]
	
! !

!CartTest methodsFor: 'tests' stamp: 'ad 6/12/2017 12:39:57'!
test12ACartShouldBeEmptyAfterAddingAndRemovingAllOfAProduct
	
	aCart _ Cart new.	
	
	aCart add: 7 of: aProduct.
	aCart removeAll: aProduct.
	
	self assert: aCart isEmpty.
					
	
	
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

!Cart methodsFor: 'adding' stamp: 'ad 6/12/2017 12:39:36'!
add: anAmount of: aProduct

	(anAmount < 0) ifTrue: [self error: self class negativeAmountErrorMessage ].
		
	anAmount timesRepeat: [self add: aProduct ]! !


!Cart methodsFor: 'removing' stamp: 'ad 6/12/2017 12:42:17'!
remove: aProduct

	self remove: aProduct ifAbsent: [self error: self class productNotFoundErrorMessage ]! !

!Cart methodsFor: 'removing' stamp: 'ad 6/12/2017 12:42:48'!
remove: aProduct ifAbsent: absentBlock

	products remove: aProduct ifAbsent: absentBlock.! !

!Cart methodsFor: 'removing' stamp: 'ad 6/12/2017 12:38:04'!
remove: anAmount of: aProduct

	(anAmount < 0) ifTrue: [self error: self class negativeAmountErrorMessage ].

	anAmount timesRepeat: [self remove: aProduct]! !

!Cart methodsFor: 'removing' stamp: 'ad 6/12/2017 12:38:42'!
removeAll: aProduct 
	
	self remove: (self amountOf: aProduct) of: aProduct  ! !


!Cart methodsFor: 'testing' stamp: 'ad 6/12/2017 11:24:30'!
includes: aProduct

	^ products includes: aProduct.! !

!Cart methodsFor: 'testing' stamp: 'ad 6/12/2017 11:24:48'!
isEmpty

	^ products isEmpty.! !


!Cart methodsFor: 'accessing' stamp: 'ad 6/12/2017 11:25:11'!
amountOf: aProduct

	^ products occurrencesOf: aProduct.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'ad 6/12/2017 12:26:13'!
negativeAmountErrorMessage
	
	^ 'Can not add or remove a negative amount of a product'! !

!Cart class methodsFor: 'error messages' stamp: 'ad 6/12/2017 12:14:17'!
productNotFoundErrorMessage
	
	^ 'Product not found'! !
