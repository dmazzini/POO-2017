!classDefinition: #Weight category: #'Measure-Solution'!
Magnitude subclass: #Weight
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:45:03'!
- aWeight

	^ self performArithmeticOperation: #- with: aWeight
	! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:45:39'!
/  aNumber

	^ self performArithmeticOperation: #/ withNumber: aNumber
! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:45:52'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:46:43'!
< aWeight

	^ self performComparisonOperation: #< with: aWeight 
! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:46:54'!
= aWeight

	(aWeight isKindOf: self class superclass) ifFalse:[^ false].

	^ self performComparisonOperation: #= with: aWeight 
	
! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:47:09'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:47:28'!
amount
	
	^ amount! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:48:21'!
convertTo: aWeightUnit

	^ Weight 
		withAmount: (self amount * self unit convertionFactorToGram / aWeightUnit convertionFactorToGram ) 
		andUnit: aWeightUnit.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:48:44'!
hash

	^ (self convertTo: gram) amount hash.  ! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:40:51'!
initializeWithAmount: anAmount andUnit: aUnit

	amount _ anAmount.
	
	unit _ aUnit.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:49:12'!
negated

	 ^ Weight withAmount: (self amount * -1) andUnit: unit.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:49:48'!
performArithmeticOperation: aSelector with: aWeight

	^ Weight withAmount: (self amount perform: aSelector with: (aWeight convertTo: self unit) amount) 
					andUnit: unit. 
! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:50:48'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ Weight withAmount: (self amount perform: aSelector with: aNumber) 
					andUnit: unit. 

	! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:51:15'!
performComparisonOperation: aSelector with: aWeight

	^ self amount perform: aSelector with: (aWeight convertTo: self unit) amount
	
	! !

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:51:37'!
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

!Weight methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:51:59'!
unit

	^ unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Weight class' category: #'Measure-Solution'!
Weight class
	instanceVariableNames: ''!

!Weight class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:39:58'!
withAmount: anAmount andUnit: aUnit

	^ self new initializeWithAmount: anAmount andUnit: aUnit.! !


!classDefinition: #WeightUnit category: #'Measure-Solution'!
Magnitude subclass: #WeightUnit
	instanceVariableNames: 'name convertionFactorToGram'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:56:03'!
= aUnit 

	(aUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aUnit name! !

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:56:35'!
convertionFactorToGram
	
	^ convertionFactorToGram! !

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:56:56'!
hash

	^ self name asString size.! !

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:58:52'!
initializeWithName: aNameSymbol andConvertionFactorToGram: aConvertionNumber

	name _ aNameSymbol.
	
	convertionFactorToGram _ aConvertionNumber.
	
	Smalltalk at: aNameSymbol put: self.! !

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:57:44'!
name
	
	^ name ! !

!WeightUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:57:56'!
printString
	
	^ name asString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WeightUnit class' category: #'Measure-Solution'!
WeightUnit class
	instanceVariableNames: ''!

!WeightUnit class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:58:35'!
withName: aName andConvertionFactorToGram: aConvertionNumber

	^ self new initializeWithName: aName andConvertionFactorToGram: aConvertionNumber.! !


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

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:42:26'!
oneHundredGrams

	^ Weight withAmount: 100 andUnit: gram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 14:42:42'!
oneKilogram

	^ Weight withAmount: 1 andUnit: kilogram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:10:11'!
oneThousandGrams

	^ Weight withAmount: 1000 andUnit: gram.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIM 6/3/2017 15:05:08'!
initialize
	|meter centimeter decimeter decameter hectometer millimeter kilometer
	gram kilogram
	|	
	
	meter _ DistanceUnit withName: #meter andConvertionFactorToMeter: 1.
	centimeter _ DistanceUnit withName: #centimeter andConvertionFactorToMeter: 1/100.
	decimeter  _ DistanceUnit withName: #decimeter andConvertionFactorToMeter: 1/10.
	decameter  _ DistanceUnit withName: #decameter andConvertionFactorToMeter: 10.
	hectometer _ DistanceUnit withName: #hectometer andConvertionFactorToMeter: 100.
	millimeter _ DistanceUnit withName: #millimeter andConvertionFactorToMeter: 1/1000.
	kilometer _ DistanceUnit withName: #kilometer andConvertionFactorToMeter: 1000.
	gram _ WeightUnit withName: #gram andConvertionFactorToGram: 1.
	kilogram _ WeightUnit withName: #kilogram andConvertionFactorToGram: 1000.

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