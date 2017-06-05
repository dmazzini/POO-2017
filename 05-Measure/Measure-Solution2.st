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


!Measure methodsFor: 'converting' stamp: 'ad 6/5/2017 15:04:00'!
convertTo: aUnit

	(self category = aUnit category) ifFalse: [self error: self class canNotConvertErrorMessage].
		
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


!Measure methodsFor: 'interval' stamp: 'ad 6/5/2017 13:54:48'!
to: aMeasure 

	^ MeasureInterval 
		from: self 
		to: aMeasure.! !

!Measure methodsFor: 'interval' stamp: 'ad 6/5/2017 13:55:00'!
to: aMeasure by: stepMeasure
	 
	^ MeasureInterval 
		from: self 
		to: aMeasure 
		by: stepMeasure! !

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

!Measure methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:19:53'!
isFromSameCategoryThan: aMeasure
	
	^ self unit isFromSameCategoryThan: aMeasure unit.! !

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

!MeasureUnit methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:49:57'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^false].
	
	^ self category = aUnit category.! !


!MeasureUnit methodsFor: 'printing' stamp: 'ad 6/3/2017 16:24:32'!
printString
	
	^ name asString ! !


!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/5/2017 14:49:14'!
* aMeasureUnit 

	| aUnitDictionary |
	
	aUnitDictionary _ Dictionary new.
	
	aUnitDictionary at: self put: 1; at: aMeasureUnit put: 1.	

	^ CompoundUnit from: aUnitDictionary.! !

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
	instanceVariableNames: 'oneKilogram twoKilograms oneThousandGrams oneMiligram oneThousandMililiters oneLiter zeroMeters zeroLiters oneMeter threeKilograms aMeasureInterval'
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

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:36:52'!
test25OneKilogramPlusOneLitersAndOneThousandMilitersPlusOneThousandGramsHaveTheSameHash

	self assert: (oneKilogram + oneLiter) hash = (oneThousandMililiters + oneThousandGrams) hash! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:48:20'!
test26AnIntervalOfMeasuresFromOneKilogramToThreeKilogramsHasTwoKilogramsAtSecondPosition

	| anIntervalOfMeasures |
	
	anIntervalOfMeasures _ oneKilogram to: threeKilograms.
	
	self assert:  (anIntervalOfMeasures at: 2) = twoKilograms.! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:46:54'!
test27TheElementsOfAMeasureIntervalFromOneKilogramToKilogramsByHalfKilogramSumTenKilograms

	| sumOfIntervalMeasures |
	
	sumOfIntervalMeasures _ 0 * kilogram.
	
	oneKilogram to: threeKilograms by: ((1/2)*kilogram) do: [:aDistance | 
		sumOfIntervalMeasures _ aDistance + sumOfIntervalMeasures ].	
	
	self assert:  sumOfIntervalMeasures = (10*kilogram).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:17:22'!
test28CreatingAnIntervalWithMeasuresFromDifferentCategoriesShouldRaiseError
	
	self should: [oneKilogram to: oneThousandMililiters]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anError | 
					self assert: anError messageText equals: 
											MeasureInterval measuresFromDifferentCategoryErrorMessage ]! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:17:41'!
test29CreatingAnIncreasingMeasureIntervalWithNegativeStepShouldRaiseError

	self 
		should: [ oneMiligram to: oneKilogram by: (-1 * gram)] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: MeasureInterval wrongCreationParametersErrorMessage]! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:24:35'!
test30AnIntervalFromOneMetroToDiezKilometrosByCincoCentimetrosContainsTwoMetrosAtPosition21
	
	aMeasureInterval _ (oneMeter ) to: (10*kilometer ) by: (5*centimeter).
	
	self assert:  (aMeasureInterval at: 21) = (2*meter).! !

!MeasureUnitTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:45:19'!
test31

	self assert: 1 * (meter*meter) = (1 * (meter*meter)).! !


!MeasureUnitTest methodsFor: 'set up' stamp: 'ad 6/4/2017 18:58:00'!
setUp

	oneKilogram _ 1 * kilogram.
	twoKilograms _ 2 * kilogram.
	threeKilograms _ 3 * kilogram.
	
	oneThousandGrams _ 1000 * gram.
	
	oneMiligram _ 1 * miligram.
	
	zeroLiters _ 0 * liter. 
	oneLiter _ 1 * liter. 
	oneThousandMililiters _ 1000 * mililiter. 
	
	zeroMeters _ 0 * meter. 
	oneMeter _ 1 * meter. 

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

!CompoundMeasure methodsFor: 'comparing' stamp: 'ad 6/5/2017 13:34:44'!
hash

	| sumOfAllMeasuresHashes |
	
	sumOfAllMeasuresHashes _ 0.
	
	self measuresDo: [:aMeasure |
					sumOfAllMeasuresHashes _ sumOfAllMeasuresHashes + aMeasure hash].	

	^ sumOfAllMeasuresHashes hash! !


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


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
Object subclass: #CompoundUnit
	instanceVariableNames: 'units'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'private' stamp: 'ad 6/5/2017 14:50:44'!
from: aUnitDictionary 
	
	units _ aUnitDictionary ! !


!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/5/2017 14:56:50'!
adaptToNumber: aNumber andSend: aSymbol

	^ Measure withAmount: aNumber andUnit: self! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/5/2017 15:43:30'!
singleUnitFromCategory: aCategory ifAbsent: absentBlock 
	
	self unitsDo: [:aSingleUnit | 
						aSingleUnit category = aCategory ifTrue: [^ aSingleUnit]].
					
	^ absentBlock value.

	! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/5/2017 15:29:24'!
units

	^ units! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/5/2017 15:41:40'!
unitsDo: aBlockClosure 

	self units size = 0 ifTrue: [^self].
	
	self units associationsDo: [ :assoc |
										aBlockClosure value: assoc key].! !


!CompoundUnit methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:45:03'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^ false].
	
	(self units size = aUnit units size) ifFalse: [^false].
	
	self unitsDo: [:aSingleUnitFromSelf |   | aSingleUnitFromOther |
							aSingleUnitFromOther _ aUnit singleUnitFromCategory: aSingleUnitFromSelf category ifAbsent: [^ false].
							((self units at: aSingleUnitFromSelf) = (aUnit units at: aSingleUnitFromOther )) ifFalse: [^ false]].
						
	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'initialization' stamp: 'ad 6/5/2017 14:50:05'!
from: aUnitDictionary

	^ self new from: aUnitDictionary! !


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

!MeasureFactory class methodsFor: 'initialize' stamp: 'ad 6/5/2017 14:26:23'!
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
	MeasureUnit withName: #centimeter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: (1/100).
	
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

!MeasureInterval class methodsFor: 'initialization' stamp: 'ad 6/5/2017 13:57:24'!
from: aMeasure to: anotherMeasure

	^ self from: aMeasure to: anotherMeasure by: (Measure withAmount: 1 andUnit: aMeasure unit).! !

!MeasureInterval class methodsFor: 'initialization' stamp: 'ad 6/5/2017 14:27:52'!
from: initialMeasure to: stopMeasure by: stepMeasure
			
	self isValidIntervalFrom: initialMeasure to: stopMeasure by: stepMeasure.

	^ self new from: initialMeasure to: (stopMeasure convertTo: initialMeasure unit) by: (stepMeasure convertTo: initialMeasure unit).! !


!MeasureInterval class methodsFor: 'validation' stamp: 'ad 6/5/2017 14:16:15'!
isValidIntervalFrom: initialMeasure to: stopMeasure by: step

	( (initialMeasure isFromSameCategoryThan: stopMeasure)
		and:
	  [stopMeasure isFromSameCategoryThan: step] )
			ifFalse: [self error: MeasureInterval measuresFromDifferentCategoryErrorMessage].

 	( (initialMeasure > stopMeasure and: [step amount >= 0] ) 
		or: 
	  (initialMeasure < stopMeasure and: [step amount <= 0] ) ) 
			ifTrue: [self error: MeasureInterval wrongCreationParametersErrorMessage].! !


!MeasureInterval class methodsFor: 'error messages' stamp: 'ad 6/5/2017 14:05:01'!
measuresFromDifferentCategoryErrorMessage

	^ 'Can not create interval with measures from different categoris'! !

!MeasureInterval class methodsFor: 'error messages' stamp: 'ad 6/5/2017 14:05:53'!
wrongCreationParametersErrorMessage

	^'The parameters provided do not induce an interval'.! !

MeasureFactory initialize!