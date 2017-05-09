!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 22:44:45'!
emptyCheck	
	
	"self isEmpty ifTrue: [self emptyError]."
	
	[ collection emptyCheck ] on: Error do: [ self emptyError].
		
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 16:05:05'!
emptyError

	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:01:25'!
initialize

	| stackBottom |
	
	stackBottom := StackBottom new.
	
	collection := OrderedCollection new.
	
	collection add: stackBottom.
	
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:02:01'!
isEmpty
	
	^collection size = 1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'dim 5/9/2017 12:32:46'!
pop
	
	| stackItem |
	
	self top.
	stackItem := collection removeLast.
	
	 ^ stackItem item! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:04:26'!
push: anObject

	| stackItem |
	
	stackItem := StackNormalItem new with: anObject.

	collection addLast: stackItem.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:09:39'!
size
	
	 ^collection size - 1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:09:08'!
top
	
	| stackItem |
	
	stackItem := collection last.
	
	 ^ stackItem item
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'ad 5/8/2017 15:59:40'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackItem category: #'Stack-Exercise'!
Object subclass: #StackItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackItem methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 23:53:51'!
item

	self subclassResponsibility ! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 23:59:42'!
with: anObject

	self subclassResponsibility ! !


!classDefinition: #StackBottom category: #'Stack-Exercise'!
StackItem subclass: #StackBottom
	instanceVariableNames: 'item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBottom methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 23:57:22'!
item

	self error: OOStack stackEmptyErrorDescription! !

!StackBottom methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:00:16'!
with: anObject! !


!classDefinition: #StackNormalItem category: #'Stack-Exercise'!
StackItem subclass: #StackNormalItem
	instanceVariableNames: 'item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNormalItem methodsFor: 'as yet unclassified' stamp: 'ad 5/8/2017 23:58:20'!
item

	^ item! !

!StackNormalItem methodsFor: 'as yet unclassified' stamp: 'ad 5/9/2017 00:00:43'!
with: anObject

	item := anObject! !
