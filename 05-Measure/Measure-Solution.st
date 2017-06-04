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

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 11:37:45'!
+ aMeasure

	^ self performArithmeticOperation: #+ with: aMeasure
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 13:23:47'!
- aMeasure

	^ self + aMeasure negated
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

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 16:53:24'!
performArithmeticOperation: aSelector with: aMeasure

	(self isFromSameCategoryThan: aMeasure) ifFalse: [
					^ CompoundMeasure from: (OrderedCollection with: self with: aMeasure) ]. 

	^ self class withAmount: (self amount perform: aSelector with: (aMeasure convertTo: self unit) amount) 
					andUnit: unit.! !

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

!Measure methodsFor: 'accessing' stamp: 'ad 6/4/2017 15:50:05'!
category

	^ unit category! !

!Measure methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:49'!
unit

	^ unit.! !


!Measure methodsFor: 'converting' stamp: 'ad 6/4/2017 11:38:09'!
convertTo: aUnit

	(self unit category = aUnit category) ifFalse: [self error: self class canNotConvertErrorMessage].
		
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


!Measure methodsFor: 'interval' stamp: 'ad 6/4/2017 17:01:01'!
to: aMeasure 

	^ MeasureInterval 
		from: self 
		to: (aMeasure convertTo: self unit).! !

!Measure methodsFor: 'interval' stamp: 'ad 6/4/2017 17:00:56'!
to: aMeasure by: stepMeasure
	 
	^ MeasureInterval 
		from: self 
		to: (aMeasure convertTo: self unit) 
		by: (stepMeasure convertTo: self unit)! !

!Measure methodsFor: 'interval' stamp: 'ad 6/4/2017 11:40:31'!
to: aMeasure by: stepMeasure do: aBlockClosure
	
	(self to: aMeasure by: stepMeasure )
			do: aBlockClosure .! !

!Measure methodsFor: 'interval' stamp: 'ad 6/4/2017 11:40:36'!
to: aMeasure do: aBlockClosure

	 (self to: aMeasure )
			do: aBlockClosure .! !


!Measure methodsFor: 'comparing' stamp: 'ad 6/4/2017 11:38:57'!
< aMeasure

	^ self performComparisonOperation: #< with: aMeasure 

	! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/4/2017 16:53:11'!
= aMeasure

	(aMeasure isKindOf: self class) ifFalse:[^ false].
	
	(self areEmptyMeasuresFromDifferentCategoriesWith: aMeasure) ifTrue: [^ true].
	
	(self isFromSameCategoryThan: aMeasure) ifFalse: [^false].

	^ self performComparisonOperation: #= with: aMeasure 
	
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/4/2017 16:53:19'!
areEmptyMeasuresFromDifferentCategoriesWith: aMeasure.
	
	^ ((self isFromSameCategoryThan: aMeasure) not) and: [self amount = 0 and: [aMeasure amount = 0]]! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 22:00:01'!
hash
	
	^ (self unit convertionFormula value: self amount) hash
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/4/2017 16:52:58'!
isFromSameCategoryThan: aMeasure
	
	^ self unit category = (aMeasure unit category)! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 12:13:50'!
negated

	 ^ self class withAmount: (self amount * -1) andUnit: unit.! !


!Measure methodsFor: 'private' stamp: 'ad 6/4/2017 11:39:32'!
initializeWithAmount: anAmount andUnit: aMeasureUnit

	amount _ anAmount.
	
	unit _ aMeasureUnit.! !

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
	instanceVariableNames: 'name category convertionFormula inverseFormula'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/4/2017 11:25:12'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

 ^ self withName: aUnitNameSymbol 
			   inCategory: aCategoryNameSymbol 
			   andFormulaToConvertIntoCategoryReferenceUnit: [:thisUnit |
																			thisUnit * aConvertionFactor ]
			   andInverseFormula: [ :referenceUnit |
												referenceUnit / aConvertionFactor ].! !

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 20:52:44'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

! !


!classDefinition: #MeasureUnitTest category: #'Measure-Solution'!
TestCase subclass: #MeasureUnitTest
	instanceVariableNames: 'oneKilogram twoKilograms oneThousandGrams oneMiligram oneThousandMililiters oneLiter zeroMeters zeroLiters oneMeter threeKilograms'
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

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 11:57:34'!
test18OneLiterPlusOneKilogramEqualsOneLiterPlusOneKilogram
	
	self assert: oneLiter + oneKilogram = (oneLiter + oneKilogram ).
	self assert: oneLiter + oneKilogram = (oneKilogram + oneLiter ).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 12:08:58'!
test19OneLiterPlusOneKilogramPlusOneMeterEqualsOneLiterPlusOneKilogramPlusOneMeter
	
	self assert: oneLiter + oneKilogram + oneMeter = (oneLiter + oneKilogram + oneMeter ).
	self assert: oneLiter + oneKilogram + oneMeter = (oneKilogram + oneMeter + oneLiter ).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 12:12:51'!
test20OneLiterPlusOneKilogramPlusOneKilogramEqualsOneLiterPlusTwoKilograms
	
	self assert: oneLiter + oneKilogram + oneKilogram = (oneLiter + twoKilograms).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 14:27:10'!
test21OneLiterPlusOneKilogramMinusOneKilogramEqualsOneLiter
	
	self assert: oneLiter + oneKilogram - oneKilogram = oneLiter.
	self assert: oneLiter - oneKilogram + oneKilogram = oneLiter.
	self assert: oneKilogram + oneLiter - oneKilogram = oneLiter.
	self assert: oneKilogram - oneKilogram + oneLiter = oneLiter.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 14:54:52'!
test22ZeroMetersPlusZeroLitersEqualsZeroLiters
	
	self assert: zeroMeters + zeroLiters = zeroLiters.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 15:05:40'!
test23OneLiterPlusOneKilogramEqualsOneLiterPlusOneThousandGrams
	
	self assert: oneLiter + oneKilogram = (oneLiter + oneThousandGrams).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 16:18:12'!
test24OneLiterPlusOneKilogramPlusOneThousandGramsEqualsOneLiterPlusTwoKilograms
	
	self assert: oneLiter + oneKilogram + oneThousandGrams = (oneLiter + twoKilograms).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/4/2017 16:59:02'!
test25

	| anIntervalOfMeasures |
	
	anIntervalOfMeasures _ oneKilogram to: threeKilograms.
	
	self assert:  (anIntervalOfMeasures at: 2) = twoKilograms.! !


!MeasureUnitTest methodsFor: 'set up' stamp: 'ad 6/4/2017 16:58:38'!
setUp

	oneKilogram _ Measure withAmount: 1 andUnit: kilogram.
	twoKilograms _ Measure withAmount: 2 andUnit: kilogram.
	threeKilograms _ Measure withAmount: 3 andUnit: kilogram.
	
	oneThousandGrams _ Measure withAmount: 1000 andUnit: gram.
	
	oneMiligram _ Measure withAmount: 1 andUnit: miligram.
	
	zeroLiters _ Measure withAmount: 0 andUnit: liter. 
	oneLiter _ Measure withAmount: 1 andUnit: liter. 
	oneThousandMililiters _ Measure withAmount: 1000 andUnit: mililiter. 
	
	zeroMeters _ Measure withAmount: 0 andUnit: meter. 
	oneMeter _ Measure withAmount: 1 andUnit: meter. 

! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'measures'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'private' stamp: 'ad 6/4/2017 16:16:11'!
errorMeasureNotFound

	self error: 'Measure not found'! !

!CompoundMeasure methodsFor: 'private' stamp: 'ad 6/4/2017 16:18:27'!
initializeWith: aDictionaryOfMeasures

	measures _ aDictionaryOfMeasures.
	
	^ self removeEmptyMeasuresAndConvertToMeasureClassIfAmountOfMeasuresIsOne .! !

!CompoundMeasure methodsFor: 'private' stamp: 'ad 6/4/2017 17:22:09'!
removeEmptyMeasuresAndConvertToMeasureClassIfAmountOfMeasuresIsOne

     | backUpUnit |

	self measuresDo: [:aMeasure |
							(aMeasure amount = 0) ifTrue: [
														backUpUnit _ aMeasure unit.
														measures removeKey: aMeasure unit]].

	(measures size = 1) ifTrue: [
		| assoc |
		assoc _ measures associations last.
		^ Measure withAmount: assoc value andUnit: assoc key ].
	(measures size = 0) ifTrue: [
		^ Measure withAmount: 0 andUnit: backUpUnit ].
	
	^ self! !


!CompoundMeasure methodsFor: 'comparing' stamp: 'ad 6/4/2017 17:14:59'!
= aCompoundMeasure

	self == aCompoundMeasure ifTrue: [^ true].	"Any object is equal to itself"
	(aCompoundMeasure isKindOf: self class) ifFalse: [^false].
	(self measures size = aCompoundMeasure measures size) ifFalse: [^false].
	self measuresDo: [:aMeasureFromSelf | | aMeasureFromOther |
		aMeasureFromOther _ aCompoundMeasure measureFromCategory: aMeasureFromSelf category 																					ifAbsent:[^false].
		(aMeasureFromSelf = aMeasureFromOther) ifFalse: [^false]].
	^true! !

!CompoundMeasure methodsFor: 'comparing' stamp: 'ad 6/4/2017 12:06:36'!
hash

	^ measures hash! !


!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 16:04:04'!
measureFromCategory: aCategoryName
	
	^ self measureFromCategory: aCategoryName ifAbsent: [self errorMeasureNotFound]! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 17:17:17'!
measureFromCategory: aCategoryName ifAbsent: absentBlock 
	
	self measuresDo: [:aMeasure | 
						aMeasure category = aCategoryName ifTrue: [^ aMeasure]].
					
	^ absentBlock value.! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 16:25:16'!
measureFromCategory: aCategoryName ifAbsent: absentBlock ifPresent: presentBlock 
	
	self measuresDo: [:aMeasure | 
						aMeasure category = aCategoryName ifTrue: [^ presentBlock value: aMeasure ]].
					
	^ absentBlock value.! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 16:24:56'!
measureFromCategory: aCategoryName ifPresent: presentBlock ifAbsent: absentBlock
	
	self measuresDo: [:aMeasure | 
						aMeasure category = aCategoryName ifTrue: [^ presentBlock value: aMeasure ]].
					
	^ absentBlock value.! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 12:05:09'!
measures

	^ measures! !


!CompoundMeasure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 16:32:30'!
+ aMeasure
									
	self measureFromCategory: aMeasure category 
					ifPresent: [:aMeasureFromCategory |  | newMeasure |
								newMeasure _ aMeasureFromCategory + aMeasure.
								measures removeKey: aMeasureFromCategory unit.
								measures at: newMeasure unit put: newMeasure amount]
					ifAbsent: [measures at: aMeasure unit put: aMeasure amount].
	
	^ self removeEmptyMeasuresAndConvertToMeasureClassIfAmountOfMeasuresIsOne.! !

!CompoundMeasure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 12:48:04'!
- aMeasure 
	
	^ self + (aMeasure negated)! !


!CompoundMeasure methodsFor: 'enumerating' stamp: 'ad 6/4/2017 15:54:10'!
measuresDo: aBlockClosure 

		self measures size = 0 ifTrue: [^self].
		
		self measures associationsDo: [ :assoc |  | aMeasure |
						aMeasure _ Measure withAmount: assoc value andUnit: assoc key.
						aBlockClosure value: aMeasure]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Measure-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'initialization' stamp: 'ad 6/4/2017 16:42:08'!
from: aCollectionOfMeasures

	| aDictionaryOfMeasures |
	
	aDictionaryOfMeasures _ Dictionary new.
	
	aCollectionOfMeasures do: [:aMeasure |
					aDictionaryOfMeasures at: aMeasure unit put: aMeasure amount].

	^ self new initializeWith: aDictionaryOfMeasures ! !

!CompoundMeasure class methodsFor: 'initialization' stamp: 'ad 6/4/2017 16:49:43'!
with: aDictionaryOfMeasures

	^ self new initializeWith: aDictionaryOfMeasures ! !


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

!MeasureFactory class methodsFor: 'initialize' stamp: 'ad 6/4/2017 11:28:19'!
initialize
	
	"Unidades de peso"
	MeasureUnit withName: #gram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: 1.
	MeasureUnit withName: #kilogram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: 1000.
	MeasureUnit withName: #miligram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: (1/1000).
	
	"Unidades de volumen"
	MeasureUnit withName: #liter inCategory: #volume
		andConvertionFactorToCategoryReferenceUnit: 1.
	MeasureUnit withName: #mililiter inCategory: #volume
		andConvertionFactorToCategoryReferenceUnit: (1/1000).
	
	"Unidades de distancia"
	
	MeasureUnit withName: #meter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 1.
	MeasureUnit withName: #kilometer inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 1000.
	
	"Unidades de tiempo"
	MeasureUnit withName: #second inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 1.
	MeasureUnit withName: #minute inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 60.
	MeasureUnit withName: #hour inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 3600.
	
	
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


!classDefinition: #MeasureInterval category: #'Measure-Solution'!
Object subclass: #MeasureInterval
	instanceVariableNames: 'interval unit from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureInterval methodsFor: 'private' stamp: 'ad 6/4/2017 17:03:28'!
from: startMeasure to: stopMeasure

	from _ startMeasure.
	to _ stopMeasure.
	by _ Measure withAmount: 1 andUnit: startMeasure unit.
	
	interval _ Interval from: startMeasure amount to: stopMeasure amount.
	
	unit _ startMeasure unit.! !

!MeasureInterval methodsFor: 'private' stamp: 'ad 6/4/2017 17:04:10'!
from: startMeasure to: stopMeasure by: aStepMeasure

	from _ startMeasure.
	to _ stopMeasure.
	by _ aStepMeasure.
			
	interval _ Interval from: startMeasure amount to: stopMeasure amount by: aStepMeasure amount.
	
	unit _ startMeasure unit.
	
	! !


!MeasureInterval methodsFor: 'enumerating' stamp: 'ad 6/4/2017 17:02:45'!
do: aBlockClosure

	1 to: (interval size) do: [ :i |
		aBlockClosure value: (Measure withAmount: (interval at: i) andUnit: unit ) ]
	
	! !


!MeasureInterval methodsFor: 'accessing' stamp: 'ad 6/4/2017 17:02:39'!
at: anIndex
	
	^ Measure withAmount: (interval at: anIndex) andUnit: unit ! !

!MeasureInterval methodsFor: 'accessing' stamp: 'DIM 6/1/2017 10:16:38'!
by
	
	^ by! !

!MeasureInterval methodsFor: 'accessing' stamp: 'DIM 6/1/2017 10:15:00'!
from
	
	^ from! !

!MeasureInterval methodsFor: 'accessing' stamp: 'DIM 6/1/2017 10:19:44'!
size

	^ interval size
! !

!MeasureInterval methodsFor: 'accessing' stamp: 'DIM 6/1/2017 10:16:25'!
to
	
	^ to! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'initialization' stamp: 'dim 5/28/2017 21:37:59'!
from: aDistance to: anotherDistance

	^ self new from: aDistance to: anotherDistance.! !

!MeasureInterval class methodsFor: 'initialization' stamp: 'ad 5/30/2017 17:25:13'!
from: initialDistance to: stopDistance by: aStepDistance
			
	self isValidIntervalFrom: initialDistance to: stopDistance by: aStepDistance.

	^ self new from: initialDistance to: stopDistance by: aStepDistance.! !

!MeasureInterval class methodsFor: 'initialization' stamp: 'ad 5/30/2017 16:26:52'!
wrongCreationParametersErrorText

	^'The parameters provided do not induce an interval'.! !


!MeasureInterval class methodsFor: 'validation' stamp: 'ad 6/4/2017 17:01:50'!
isValidIntervalFrom: initialMeasure to: stopMeasure by: step

 ^ 	( (initialMeasure > stopMeasure and: [step amount >= 0] ) 
		or: 
	  (initialMeasure < stopMeasure and: [step amount <= 0] ) ) 
			ifTrue: [self error: MeasureInterval wrongCreationParametersErrorText].! !

MeasureFactory initialize!