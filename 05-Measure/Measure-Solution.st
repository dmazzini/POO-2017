!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:28'!
* aNumber

	^ self performArithmeticOperation: #* withNumber: aNumber

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:05:41'!
+ aDistance

	^ self performArithmeticOperation: #+ with: aDistance
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:07:42'!
- aDistance

	^ self performArithmeticOperation: #- with: aDistance
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:48'!
/  aNumber

	^ self performArithmeticOperation: #/ withNumber: aNumber

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:58'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber

	! !

!Measure methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:20:54'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/3/2017 16:41:21'!
performArithmeticOperation: aSelector with: aMeasure

	^ self class withAmount: (self amount perform: aSelector with: (aMeasure convertTo: self unit) amount) 
					andUnit: unit. 
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/3/2017 12:13:37'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ self class withAmount: (self amount perform: aSelector with: aNumber) 
					andUnit: unit. 

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/3/2017 16:41:28'!
performComparisonOperation: aSelector with: aMeasure

	^ self amount perform: aSelector with: (aMeasure convertTo: self unit) amount
	

	! !


!Measure methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:42'!
amount
	
	^ amount

	! !

!Measure methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:49'!
unit

	^ unit.! !


!Measure methodsFor: 'converting' stamp: 'ad 6/3/2017 20:54:56'!
convertTo: aUnit

	(self unit category = aUnit category) ifFalse: [self error: self class canNotConvertErrorMessage].

	"^ Measure 
		withAmount: (self amount * self unit convertionFactor / aUnit convertionFactor ) 
		andUnit: aUnit."
		
		^ Measure 
		withAmount: ( aUnit inverseConvertionFormula value: (self unit convertionFormula value: self amount ) ) 
		andUnit: aUnit.! !


!Measure methodsFor: 'printing' stamp: 'ad 6/1/2017 23:49:15'!
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


!Measure methodsFor: 'interval' stamp: 'ad 6/2/2017 00:04:53'!
to: aDistance 

	^ DistanceInterval 
		from: self 
		to: (aDistance convertTo: self unit).! !

!Measure methodsFor: 'interval' stamp: 'ad 6/2/2017 00:04:45'!
to: aDistance by: stepDistance
	 
	^ DistanceInterval 
		from: self 
		to: (aDistance convertTo: self unit) 
		by: (stepDistance convertTo: self unit)! !

!Measure methodsFor: 'interval' stamp: 'ad 5/30/2017 17:16:57'!
to: aDistance by: stepDistance do: aBlockClosure
	
	(self to: aDistance by: stepDistance )
			do: aBlockClosure .! !

!Measure methodsFor: 'interval' stamp: 'ad 5/30/2017 17:17:01'!
to: aDistance do: aBlockClosure

	 (self to: aDistance )
			do: aBlockClosure .! !


!Measure methodsFor: 'comparing' stamp: 'ad 5/26/2017 16:16:18'!
< aDistance

	^ self performComparisonOperation: #< with: aDistance 

	! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 19:12:21'!
= aMeasure

	(aMeasure isKindOf: self class) ifFalse:[^ false].
	
	(self areEmptyMeasuresFromDifferentCategoriesWith: aMeasure) ifTrue: [^ true].
	
	(self isSameCategoryThan: aMeasure) ifFalse: [^false].

	^ self performComparisonOperation: #= with: aMeasure 
	
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 19:12:03'!
areEmptyMeasuresFromDifferentCategoriesWith: aMeasure.
	
	^ ((self isSameCategoryThan: aMeasure) not) and: [self amount = 0 and: [aMeasure amount = 0]]! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 22:00:01'!
hash
	
	^ (self unit convertionFormula value: self amount) hash
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 19:07:54'!
isSameCategoryThan: aMeasure
	
	^ self unit category = (aMeasure unit category)! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 12:13:50'!
negated

	 ^ self class withAmount: (self amount * -1) andUnit: unit.! !


!Measure methodsFor: 'private' stamp: 'AD 6/1/2017 20:41:08'!
initializeWithAmount: anAmount andUnit: aDistanceUnit

	amount _ anAmount.
	
	unit _ aDistanceUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'initialization' stamp: 'AD 6/1/2017 20:40:21'!
withAmount: anAmount andUnit: aDistanceUnit

	^ self new initializeWithAmount: anAmount andUnit: aDistanceUnit.! !


!Measure class methodsFor: 'error messages' stamp: 'ad 6/3/2017 17:01:44'!
canNotConvertErrorMessage

	^ 'A unit can only be converted into units from the same categoty'! !


!classDefinition: #MeasureUnit category: #'Measure-Solution'!
Magnitude subclass: #MeasureUnit
	instanceVariableNames: 'name category convertionFactor convertionFormula inverseFormula'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/3/2017 12:34:34'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

	name _ aUnitNameSymbol.
	
	category _ aCategoryNameSymbol.
	
	convertionFactor _ aConvertionFactor.
	
	Smalltalk at: aUnitNameSymbol put: self.! !

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/3/2017 20:04:07'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock

	name _ aUnitNameSymbol.
	
	category _ aCategoryNameSymbol.
	
	convertionFormula _ aConvertionFormulaBlock.
	
	Smalltalk at: aUnitNameSymbol put: self.! !

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/3/2017 20:53:37'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	name _ aUnitNameSymbol.
	
	category _ aCategoryNameSymbol.
	
	convertionFormula _ aConvertionFormulaBlock.
	
	inverseFormula _ inverseFormulaBlock .
	
	Smalltalk at: aUnitNameSymbol put: self.! !


!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:31:49'!
category

	^ category ! !

!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:32:31'!
convertionFactor

	^ convertionFactor ! !

!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:04:36'!
convertionFormula

	^ convertionFormula ! !

!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:55:11'!
inverseConvertionFormula
	
	^ inverseFormula ! !

!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:31:58'!
name

	^ name ! !


!MeasureUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:31'!
= aUnit 

	(aUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aUnit name! !

!MeasureUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:43'!
hash

	^ self name asString size.! !


!MeasureUnit methodsFor: 'printing' stamp: 'ad 6/3/2017 16:24:32'!
printString
	
	^ name asString ! !


!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/3/2017 17:42:32'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ Measure withAmount: aNumber andUnit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureUnit class' category: #'Measure-Solution'!
MeasureUnit class
	instanceVariableNames: ''!

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 12:30:21'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

 ^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor! !

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 20:03:38'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock

 ^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock! !

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 20:52:44'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

! !


!classDefinition: #MeasureUnitTest category: #'Measure-Solution'!
TestCase subclass: #MeasureUnitTest
	instanceVariableNames: 'oneKilogram twoKilograms oneThousandGrams oneMiligram oneThousandMililiters oneLiter zeroMeters zeroLiters oneMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:35:35'!
test01OneKilogramEqualsOneKilogram
	
	| anotherOneKilogram |
	
	anotherOneKilogram _ Measure withAmount: 1 andUnit: kilogram. 
	
	self assert: oneKilogram = anotherOneKilogram.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:04'!
test02OneKilogramDoesNotEqualTwoKilograms
	
	self deny: oneKilogram = twoKilograms.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:21'!
test03OneKilogramEqualsOneThousandGrams
	
	self assert: oneKilogram = oneThousandGrams.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:32'!
test04OneKilogramIsGreaterThanOneMiligram
	
	self assert: oneKilogram > oneMiligram.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:55'!
test05OneKilogramMultipliedByTwoEqualsTwoKilograms
	
	self assert: oneKilogram * 2 = twoKilograms.
	self assert: 2 * oneKilogram = twoKilograms.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:17'!
test06OneKilogramPlusOneThousandGramsEqualsTwoKilograms
	
	self assert: oneKilogram + oneThousandGrams = twoKilograms.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:43'!
test07TwoKilogramsMinusOneKilogramEqualsOneThousandGrams
	
	self assert: twoKilograms - oneKilogram = oneThousandGrams.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:59'!
test08OneLiterEqualsOneThousandMililiters
	
	self assert: oneLiter = oneThousandMililiters.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:42:21'!
test09OneLiterDoesNotEqualOneKilogram
	
	self deny: oneLiter = oneKilogram.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:56:20'!
test10OneKilogramConvertedToGramsEqualsOneThousandGrams
	
	self assert: ( (oneKilogram convertTo: gram) = oneThousandGrams)! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 17:03:56'!
test11ConvertingAUnitToAnotherFromADifferentCategoryShouldRaiseError
	
	self should: [oneKilogram convertTo: liter]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anError | 
					self assert: anError messageText equals: Measure canNotConvertErrorMessage ]! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 18:01:01'!
test12OneKilogramAndOneThousandGramsHaveTheSameHash

	self assert: oneKilogram hash = oneThousandGrams hash! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 18:00:21'!
test13OneMultipliedByKilogramEqualsOneKilogram

	self assert: 1 * kilogram = oneKilogram ! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 19:04:46'!
test14ZeroMetersEqualsZeroLiters
	
	self assert: zeroMeters = zeroLiters.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:55:16'!
test15ZeroKelvinDoesNotEqualZeroCelsius										
	
	self deny: 0 * kelvin = (0 * celsius).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:59:45'!
test16ThreeHundredAndSomeMoreKelvinEqualsOneHundredCelsius
	
	self assert: (7463/20) * kelvin = (100 * celsius).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:58:26'!
test17ZeroKelvinIsLesserThanZeroCelsius
	
	self assert: 0 * kelvin < (0 * celsius).! !


!MeasureUnitTest methodsFor: 'set up' stamp: 'ad 6/3/2017 20:38:26'!
setUp

	oneKilogram _ Measure withAmount: 1 andUnit: kilogram.
	twoKilograms _ Measure withAmount: 2 andUnit: kilogram.
	
	oneThousandGrams _ Measure withAmount: 1000 andUnit: gram.
	
	oneMiligram _ Measure withAmount: 1 andUnit: miligram.
	
	zeroLiters _ Measure withAmount: 0 andUnit: liter. 
	oneLiter _ Measure withAmount: 1 andUnit: liter. 
	oneThousandMililiters _ Measure withAmount: 1000 andUnit: mililiter. 
	
	zeroMeters _ Measure withAmount: 0 andUnit: meter. 
	oneMeter _ Measure withAmount: 1 andUnit: meter. 

! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'ad 6/3/2017 11:07:01'!
finalSpeedStartingAt: aStartingSpeed accelerating: anAcceleration during: anAmountOfTime

 ^ aStartingSpeed + anAcceleration * anAmountOfTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'initialize' stamp: 'ad 6/3/2017 21:45:56'!
initialize
	
	"Unidades de peso"
	MeasureUnit withName: #gram inCategory: #weight 
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInGrams |
																	aMeasureInGrams]
		andInverseFormula: [:aMeasureInGrams |
																	aMeasureInGrams].
	MeasureUnit withName: #kilogram inCategory: #weight 
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInKilograms |
																	aMeasureInKilograms * 1000]
		andInverseFormula: [:aMeasureInGrams |
																	aMeasureInGrams / 1000].
	MeasureUnit withName: #miligram inCategory: #weight  
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInMiligrams |
																	aMeasureInMiligrams / 1000]
		andInverseFormula: [:aMeasureInGrams |
																	aMeasureInGrams * 1000].
	
	"Unidades de volumen"
	MeasureUnit withName: #liter inCategory: #volume   
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInLiters |
																	aMeasureInLiters]
		andInverseFormula: [:aMeasureInLiters |
																	aMeasureInLiters].
	MeasureUnit withName: #mililiter inCategory: #volume   
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInMililiters |
																	aMeasureInMililiters / 1000]
		andInverseFormula: [:aMeasureInLiters |
																	aMeasureInLiters * 1000].
	
	"Unidades de distancia"
	
	MeasureUnit withName: #meter inCategory: #distance
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInMeters |
																	aMeasureInMeters]
		andInverseFormula: [:aMeasureInMeters |
																	aMeasureInMeters].
	MeasureUnit withName: #kilometer inCategory: #distance
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInKilometers |
																	aMeasureInKilometers * 1000]
		andInverseFormula: [:aMeasureInMeters |
																	aMeasureInMeters / 1000].
	
	"Unidades de tiempo"
	MeasureUnit withName: #second inCategory: #time
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInSeconds |
																	aMeasureInSeconds]
		andInverseFormula: [:aMeasureInSeconds |
																	aMeasureInSeconds].
	MeasureUnit withName: #minute inCategory: #time
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInMinutes |
																	aMeasureInMinutes * 60]
		andInverseFormula: [:aMeasureInSeconds |
																	aMeasureInSeconds / 60].
	MeasureUnit withName: #hour inCategory: #time
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInHours |
																	aMeasureInHours * 3600]
		andInverseFormula: [:aMeasureInSeconds |
																	aMeasureInSeconds / 3600].
	
	
	"Unidades de temperatura"
	MeasureUnit withName: #kelvin inCategory: #temperature
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInKelvin |
																	aMeasureInKelvin]
		andInverseFormula: [:aMeasureInKelvin |
																	aMeasureInKelvin].	
	MeasureUnit withName: #celsius inCategory: #temperature
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInCelsius |
																	aMeasureInCelsius + (5463/20)]
		andInverseFormula: [:aMeasureInKelvin |
																	aMeasureInKelvin  - (5463/20)].! !

MeasureFactory initialize!