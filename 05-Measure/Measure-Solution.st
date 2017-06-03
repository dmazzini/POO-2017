!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:36:44'!
- aMeasure

	^ self performArithmeticOperation: #- with: aMeasure
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
/  aNumber

	^ self performArithmeticOperation: #/ withNumber: aNumber
! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:36:58'!
< aMeasure

	^ self performComparisonOperation: #< with: aMeasure
! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:05:32'!
= aMeasure

	^ self performComparisonOperation: #= with: aMeasure
	
! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
amount
	
	^ amount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:07:16'!
convertTo: aMeasureUnit

	^ Measure 
		withAmount: (self amount * self unit convertionFactorToStandard / aMeasureUnit convertionFactorToStandard ) 
		andUnit: aMeasureUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
hash

	^ (self convertTo: gram) amount hash.  ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
initializeWithAmount: anAmount andUnit: aUnit

	amount _ anAmount.
	
	unit _ aUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:40:30'!
negated

	 ^ Measure withAmount: (self amount * -1) andUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:38:49'!
performArithmeticOperation: aSelector with: aMeasure

	^ Measure withAmount: (self amount perform: aSelector with: (aMeasure convertTo: self unit) amount) 
					andUnit: unit. 
! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:39:05'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ Measure withAmount: (self amount perform: aSelector with: aNumber) 
					andUnit: unit. 

	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:39:17'!
performComparisonOperation: aSelector with: aMeasure

	^ self amount perform: aSelector with: (aMeasure convertTo: self unit) amount
	
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
printString
	
	^String streamContents: 
        [:stream | 
            stream 
                 nextPutAll: (amount printString); 
                 nextPutAll: ' '; 
			 nextPutAll: self unit name asString.
			 (amount > 1) ifTrue: [ stream nextPutAll: 's'] 
	  ].
			 ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
unit

	^ unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:34:00'!
withAmount: anAmount andUnit: aUnit

	^ self new initializeWithAmount: anAmount andUnit: aUnit.! !


!classDefinition: #MeasureUnit category: #'Measure-Solution'!
Magnitude subclass: #MeasureUnit
	instanceVariableNames: 'name convertionFactorToStandard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:42:05'!
= aUnit 

	(aUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aUnit name! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:44:18'!
convertionFactorToStandard
	
	^ convertionFactorToStandard! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:42:05'!
hash

	^ self name asString size.! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:43:39'!
initializeWithName: aNameSymbol andConvertionFactorToStandard: aConvertionNumber

	name _ aNameSymbol.
	
	convertionFactorToStandard _ aConvertionNumber.
	
	Smalltalk at: aNameSymbol put: self.! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:42:05'!
name
	
	^ name ! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:42:05'!
printString
	
	^ name asString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureUnit class' category: #'Measure-Solution'!
MeasureUnit class
	instanceVariableNames: ''!

!MeasureUnit class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:43:02'!
withName: aName andConvertionFactorToStandard: aConvertionNumber

	^ self new initializeWithName: aName andConvertionFactorToStandard: aConvertionNumber.! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:41:53'!
oneHundredGrams

	^ factory oneHundredGrams.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:35:58'!
oneKilogram

	^ factory oneKilogram.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:09:29'!
oneThousandGrams

	^ factory oneThousandGrams! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:34:03'!
setUp

	| factoryClass |
	
	factoryClass := Smalltalk classNamed: #MeasureFactory.
	
	factory := factoryClass new.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:08:59'!
test01ObjectsRepresentingSameMeasureShouldBeEqual

	self assert: self oneKilogram = self oneThousandGrams.
	
	
! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:03:38'!
oneHundredGrams

	^ Measure withAmount: 100 andUnit: gram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:03:44'!
oneKilogram

	^ Measure withAmount: 1 andUnit: kilogram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:03:49'!
oneThousandGrams

	^ Measure withAmount: 1000 andUnit: gram.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 16:02:35'!
initialize
	|meter centimeter decimeter decameter hectometer millimeter kilometer
	gram kilogram
	|	
	
	meter _ MeasureUnit withName: #meter andConvertionFactorToStandard: 1.
	centimeter _ MeasureUnit withName: #centimeter andConvertionFactorToStandard: 1/100.
	decimeter  _ MeasureUnit withName: #decimeter andConvertionFactorToStandard: 1/10.
	decameter  _ MeasureUnit withName: #decameter andConvertionFactorToStandard: 10.
	hectometer _ MeasureUnit withName: #hectometer andConvertionFactorToStandard: 100.
	millimeter _ MeasureUnit withName: #millimeter andConvertionFactorToStandard: 1/1000.
	kilometer _ MeasureUnit withName: #kilometer andConvertionFactorToStandard: 1000.
	gram _ MeasureUnit withName: #gram andConvertionFactorToStandard: 1.
	kilogram _ MeasureUnit withName: #kilogram andConvertionFactorToStandard: 1000.

	Smalltalk at: #meter put: meter.
	Smalltalk at: #centimeter put: centimeter.
	Smalltalk at: #millimeter put: millimeter.
	Smalltalk at: #kilometer put: kilometer.
	Smalltalk at: #decimeter put: decimeter.
	Smalltalk at: #decameter put: decameter.
	Smalltalk at: #hectometer put: hectometer.
	Smalltalk at: #gram put: gram.
	Smalltalk at: #kilogram put: kilogram.! !

MeasureFactory initialize!