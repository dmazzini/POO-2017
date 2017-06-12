!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'dim 6/9/2017 19:03:58'!
test01ANewCartShuoldBeEmpty

	|aCart|
	
	aCart _ Cart new.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:31:46'!
test02WhenAnElementIsAddedShouldNotBeEmpty
	
	|aCart anElement |
	
	aCart _ Cart new.
	anElement _ 'anElement'.
	
	aCart addElement: anElement.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:32:00'!
test03aCartIncludesAnAddedElement

	|aCart anElement |
	
	aCart _ Cart new.
	anElement _ 'anElement'.
	
	aCart addElement: anElement.
	
	self assert: (aCart includes: anElement).
	
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:32:10'!
test04DoesNotIncludesNotAddedElement

	|aCart anElement |
	
	aCart _ Cart new.
	anElement _ 'anElement'.
	
	self deny: (aCart includes: anElement).
	
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 22:46:49'!
test05

	|aCart anElement |
	
	aCart _ Cart new.
	anElement _ 'anElement'.
	
	aCart addElement: anElement.
	aCart addElement: anElement.
	
	self assert: (aCart quantityOf: anElement) = 2.
	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:18:46'!
addElement: anElement

	elements add: anElement.
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:22:55'!
includes: anElement

	^ elements includes: anElement.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:21:57'!
initialize

	elements _ Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 21:22:19'!
isEmpty

	^ elements isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'dim 6/11/2017 22:45:40'!
quantityOf: anElement

	^ elements occurrencesOf: anElement.! !
