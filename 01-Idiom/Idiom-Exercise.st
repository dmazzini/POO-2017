!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'ad 4/22/2017 19:21:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assert: [customerBook addCustomerNamed: 'John Lennon'.] durationToRun < (Duration milliSeconds: 50). ! !

!IdiomTest methodsFor: 'testing' stamp: 'ad 4/22/2017 19:21:24'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: [customerBook removeCustomerNamed: paulMcCartney.] durationToRun < (Duration milliSeconds: 100). 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'DIM 4/23/2017 19:33:26'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self failBlock: [ customerBook addCustomerNamed: ''.] 
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]

! !

!IdiomTest methodsFor: 'testing' stamp: 'DIM 4/23/2017 19:34:07'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self failBlock: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!IdiomTest methodsFor: 'as yet unclassified' stamp: 'ad 4/22/2017 19:12:18'!
assertBlock: aBlock shouldNotTakeMoreThanMilliseconds: milliseconds 
		
	
	^ (aBlock durationToRun) < (Duration milliSeconds: milliseconds).
	
	
	"millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue."! !

!IdiomTest methodsFor: 'as yet unclassified' stamp: 'DIM 4/23/2017 19:32:49'!
failBlock: aBlock on: anError do: otherBlock

	[ aBlock value.
		self fail ] on: anError do: otherBlock.
		! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
