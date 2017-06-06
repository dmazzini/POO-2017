!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:35:40'!
* aMultiplier

	(aMultiplier isKindOf: MeasureUnit) ifTrue: [^ Measure withAmount: self amount andUnit: (aMultiplier * self unit)].
	
	(aMultiplier isKindOf: Number) ifTrue: [^ aMultiplier * self].
	
	"case where aMultiplier is Measure"
	^ self class withAmount: (self amount * aMultiplier amount) andUnit: (self unit * aMultiplier unit). 

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 11:37:45'!
+ aMeasure

	^ self performArithmeticOperation: #+ with: aMeasure
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 13:23:47'!
- aMeasure

	^ self + aMeasure negated
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 15:36:46'!
/  aNumber

	^ (1/ aNumber) * self

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:58'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 15:13:38'!
adaptToNumber: aNumber andSend: aSymbol 

	^ self performArithmeticOperation: #* withNumber: aNumber! !

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

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:29:35'!
performComparisonOperation: aSelector with: aMeasure

	^ self amount perform: aSelector with: ((aMeasure convertTo: self unit) amount)
	

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


!Measure methodsFor: 'converting' stamp: 'ad 6/5/2017 22:34:00'!
convertTo: aUnit

	(aUnit isFromSameCategoryThan: self unit) ifFalse: [self error: self class canNotConvertErrorMessage].
		
		
		(self unit isKindOf: SingleUnit) 
			ifTrue: [
					^ Measure 
					withAmount: ( aUnit inverseConvertionFormula value: (self unit convertionFormula value: self amount ) ) 
					andUnit: aUnit.]
				
			ifFalse: [ | newAmount |
				newAmount _ self amount.
				self unit unitsDo: [ :aSingleUnitFromSelf |  | aSingleUnitFromOther unitRepetitions |
								aSingleUnitFromOther _ aUnit singleUnitFromCategory: aSingleUnitFromSelf category ifAbsent: [self error: self class canNotConvertErrorMessage].
								unitRepetitions _ self unit units at: aSingleUnitFromSelf.
								(unitRepetitions > 0) 
									ifTrue: [ unitRepetitions timesRepeat: 
												[newAmount _ aSingleUnitFromOther inverseConvertionFormula value: (aSingleUnitFromSelf convertionFormula value: newAmount )]]
									ifFalse: [ (-1 * unitRepetitions) timesRepeat: 
												[ newAmount _ aSingleUnitFromOther convertionFormula value: (aSingleUnitFromSelf inverseConvertionFormula value: newAmount ) ] ] ].
						^ Measure withAmount: newAmount andUnit: aUnit  ].
		! !


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


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'oneKilogram twoKilograms oneThousandGrams oneMiligram oneThousandMililiters oneLiter zeroMeters zeroLiters oneMeter threeKilograms aMeasureInterval'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:35:35'!
test01OneKilogramEqualsOneKilogram
	
	| anotherOneKilogram |
	
	anotherOneKilogram _ Measure withAmount: 1 andUnit: kilogram. 
	
	self assert: oneKilogram = anotherOneKilogram.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:04'!
test02OneKilogramDoesNotEqualTwoKilograms
	
	self deny: oneKilogram = twoKilograms.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:21'!
test03OneKilogramEqualsOneThousandGrams
	
	self assert: oneKilogram = oneThousandGrams.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:32'!
test04OneKilogramIsGreaterThanOneMiligram
	
	self assert: oneKilogram > oneMiligram.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:36:55'!
test05OneKilogramMultipliedByTwoEqualsTwoKilograms
	
	self assert: oneKilogram * 2 = twoKilograms.
	self assert: 2 * oneKilogram = twoKilograms.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:17'!
test06OneKilogramPlusOneThousandGramsEqualsTwoKilograms
	
	self assert: oneKilogram + oneThousandGrams = twoKilograms.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:43'!
test07TwoKilogramsMinusOneKilogramEqualsOneThousandGrams
	
	self assert: twoKilograms - oneKilogram = oneThousandGrams.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:37:59'!
test08OneLiterEqualsOneThousandMililiters
	
	self assert: oneLiter = oneThousandMililiters.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:42:21'!
test09OneLiterDoesNotEqualOneKilogram
	
	self deny: oneLiter = oneKilogram.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 16:56:20'!
test10OneKilogramConvertedToGramsEqualsOneThousandGrams
	
	self assert: ( (oneKilogram convertTo: gram) = oneThousandGrams)! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 17:03:56'!
test11ConvertingAUnitToAnotherFromADifferentCategoryShouldRaiseError
	
	self should: [oneKilogram convertTo: liter]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anError | 
					self assert: anError messageText equals: Measure canNotConvertErrorMessage ]! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 18:01:01'!
test12OneKilogramAndOneThousandGramsHaveTheSameHash

	self assert: oneKilogram hash = oneThousandGrams hash! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 18:00:21'!
test13OneMultipliedByKilogramEqualsOneKilogram

	self assert: 1 * kilogram = oneKilogram ! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 19:04:46'!
test14ZeroMetersEqualsZeroLiters
	
	self assert: zeroMeters = zeroLiters.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:55:16'!
test15ZeroKelvinDoesNotEqualZeroCelsius										
	
	self deny: 0 * kelvin = (0 * celsius).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:59:45'!
test16ThreeHundredAndSomeMoreKelvinEqualsOneHundredCelsius
	
	self assert: (7463/20) * kelvin = (100 * celsius).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/3/2017 21:58:26'!
test17ZeroKelvinIsLesserThanZeroCelsius
	
	self assert: 0 * kelvin < (0 * celsius).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 11:57:34'!
test18OneLiterPlusOneKilogramEqualsOneLiterPlusOneKilogram
	
	self assert: oneLiter + oneKilogram = (oneLiter + oneKilogram ).
	self assert: oneLiter + oneKilogram = (oneKilogram + oneLiter ).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 12:08:58'!
test19OneLiterPlusOneKilogramPlusOneMeterEqualsOneLiterPlusOneKilogramPlusOneMeter
	
	self assert: oneLiter + oneKilogram + oneMeter = (oneLiter + oneKilogram + oneMeter ).
	self assert: oneLiter + oneKilogram + oneMeter = (oneKilogram + oneMeter + oneLiter ).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 12:12:51'!
test20OneLiterPlusOneKilogramPlusOneKilogramEqualsOneLiterPlusTwoKilograms
	
	self assert: oneLiter + oneKilogram + oneKilogram = (oneLiter + twoKilograms).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 14:27:10'!
test21OneLiterPlusOneKilogramMinusOneKilogramEqualsOneLiter
	
	self assert: oneLiter + oneKilogram - oneKilogram = oneLiter.
	self assert: oneLiter - oneKilogram + oneKilogram = oneLiter.
	self assert: oneKilogram + oneLiter - oneKilogram = oneLiter.
	self assert: oneKilogram - oneKilogram + oneLiter = oneLiter.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 14:54:52'!
test22ZeroMetersPlusZeroLitersEqualsZeroLiters
	
	self assert: zeroMeters + zeroLiters = zeroLiters.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 15:05:40'!
test23OneLiterPlusOneKilogramEqualsOneLiterPlusOneThousandGrams
	
	self assert: oneLiter + oneKilogram = (oneLiter + oneThousandGrams).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/4/2017 16:18:12'!
test24OneLiterPlusOneKilogramPlusOneThousandGramsEqualsOneLiterPlusTwoKilograms
	
	self assert: oneLiter + oneKilogram + oneThousandGrams = (oneLiter + twoKilograms).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:36:52'!
test25OneKilogramPlusOneLitersAndOneThousandMilitersPlusOneThousandGramsHaveTheSameHash

	self assert: (oneKilogram + oneLiter) hash = (oneThousandMililiters + oneThousandGrams) hash! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:48:20'!
test26AnIntervalOfMeasuresFromOneKilogramToThreeKilogramsHasTwoKilogramsAtSecondPosition

	| anIntervalOfMeasures |
	
	anIntervalOfMeasures _ oneKilogram to: threeKilograms.
	
	self assert:  (anIntervalOfMeasures at: 2) = twoKilograms.! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 13:46:54'!
test27TheElementsOfAMeasureIntervalFromOneKilogramToKilogramsByHalfKilogramSumTenKilograms

	| sumOfIntervalMeasures |
	
	sumOfIntervalMeasures _ 0 * kilogram.
	
	oneKilogram to: threeKilograms by: ((1/2)*kilogram) do: [:aDistance | 
		sumOfIntervalMeasures _ aDistance + sumOfIntervalMeasures ].	
	
	self assert:  sumOfIntervalMeasures = (10*kilogram).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:17:22'!
test28CreatingAnIntervalWithMeasuresFromDifferentCategoriesShouldRaiseError
	
	self should: [oneKilogram to: oneThousandMililiters]
			raise: Error - MessageNotUnderstood
			withExceptionDo: [ :anError | 
					self assert: anError messageText equals: 
											MeasureInterval measuresFromDifferentCategoryErrorMessage ]! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 14:17:41'!
test29CreatingAnIncreasingMeasureIntervalWithNegativeStepShouldRaiseError

	self 
		should: [ oneMiligram to: oneKilogram by: (-1 * gram)] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: MeasureInterval wrongCreationParametersErrorMessage]! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 20:30:18'!
test30AnIntervalFromOneMeterToTenKilometersByFiveCentimetersContainsTwoMetersAtPosition21
	
	aMeasureInterval _ (oneMeter ) to: (10*kilometer ) by: (5*centimeter).
	
	self assert:  (aMeasureInterval at: 21) = (2*meter).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 21:28:41'!
test31OneSquareMeterEqualsOneSquareMeter

	self assert: 1 * (meter*meter) = (1 * (meter*meter)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 21:30:10'!
test32OneMeterPerSecondEqualsOneMeterPerSecond

	self assert: 1 * (meter/second) = (1 * (meter/second)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 21:49:05'!
test33ZeroMetersPerSecondEqualsZeroMetersPerSecond

	self assert: 0 * (meter/second) = (0 * (meter/gram)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 22:17:59'!
test34OneMeterPerSecondEqualsTheSameSpeedInKilometersPerHour

	self assert: 1 * (meter/second) = ((3600/1000) * (kilometer/hour)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 22:27:17'!
test35OneMeterPerSecondPlusOneMeterPerSecondEqualsTwoMetersPerSecond

	self assert: 1 * (meter/second) + (1 * (meter/second)) = (2 * (meter/second)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 22:30:28'!
test36OneMeterPerSecondPlusSameSpeedInKilometersPerHourEqualsTwoMetersPerSecond

	self assert: 1 * (meter/second) + ((3600/1000) * (kilometer/hour)) = (2 * (meter/second)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 22:32:09'!
test37OneCubicMeterEqualsOneCubicMeter

	self assert: 1 * (meter*meter*meter) = (1 * (meter*meter*meter)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 16:50:39'!
test38OneCubicMeterEqualsOneCubicMeter

	self assert: 1 * (meter*meter*meter) = ((1 * (meter*meter)) *meter).
	self assert: 1 * (meter*meter*meter) = ((1 * meter) * (meter *meter)).
	self assert: 1 * (meter*meter*meter) = ((meter*meter*meter) * 1).
	self assert: 1 * (meter*meter*meter) = ((meter*meter) * (meter * 1)).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 14:59:19'!
test39OneMultipliedByMeterEqualsMeterMultipliedByOne

	self assert: 1 * meter = (meter*1).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 15:37:18'!
test40OneMeterPerSecondEqualsOneMeterPerSecond

	self assert: 1 * (meter/second) = ((1 * meter) / second).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 17:52:12'!
test41TwoEqualCompoundUnitsHaveTheSameHash

	self assert: (meter * meter /second) hash = (meter / second * meter) hash! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 17:57:14'!
test42TwoEqualCompoundUnitsHaveTheSameHash

	"self assert: (meter * meter /second) hash = (meter / second * meter) hash"! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/6/2017 17:58:58'!
test4MeterMultipliedByMeterAndDividedBySecondEqualsTheSameUnitCreatedDifferently

	self assert: meter * meter /second = (meter / second * meter)! !


!MeasureTest methodsFor: 'set up' stamp: 'ad 6/4/2017 18:58:00'!
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

!MeasureFactory class methodsFor: 'initialize' stamp: 'ad 6/5/2017 22:34:34'!
initialize
	
	"Unidades de peso"
	SingleUnit withName: #gram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: 1.
	SingleUnit withName: #kilogram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: 1000.
	SingleUnit withName: #miligram inCategory: #weight
		andConvertionFactorToCategoryReferenceUnit: (1/1000).
	
	"Unidades de volumen"
	SingleUnit withName: #liter inCategory: #volume
		andConvertionFactorToCategoryReferenceUnit: 1.
	SingleUnit withName: #mililiter inCategory: #volume
		andConvertionFactorToCategoryReferenceUnit: (1/1000).
	
	"Unidades de distancia"
	
	SingleUnit withName: #meter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 1.
	SingleUnit withName: #kilometer inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 1000.
	SingleUnit withName: #centimeter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: (1/100).
	
	"Unidades de tiempo"
	SingleUnit withName: #second inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 1.
	SingleUnit withName: #minute inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 60.
	SingleUnit withName: #hour inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 3600.
	
	
	"Unidades de temperatura"
	SingleUnit withName: #kelvin inCategory: #temperature
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInKelvin |
																	aMeasureInKelvin]
		andInverseFormula: [:aMeasureInKelvin |
																	aMeasureInKelvin].	
	SingleUnit withName: #celsius inCategory: #temperature
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


!classDefinition: #MeasureUnit category: #'Measure-Solution'!
Object subclass: #MeasureUnit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:18:45'!
* aMultiplier

	self subclassResponsibility 

	! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:18:38'!
/ aDivisor

	self subclassResponsibility 

	! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:55:29'!
adaptToNumber: aNumber andSend: aSelector

	(aSelector = #* ) ifTrue: [ ^ Measure withAmount: aNumber andUnit: self ].
	
	"case aSelector is #/"
	^ Measure withAmount: aNumber andUnit: (self inverse)! !


!MeasureUnit methodsFor: 'comparing' stamp: 'ad 6/6/2017 16:19:20'!
isFromSameCategoryThan: aUnit

	self subclassResponsibility! !


!MeasureUnit methodsFor: 'private' stamp: 'ad 6/6/2017 17:10:41'!
inverse

	self subclassResponsibility ! !


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
MeasureUnit subclass: #CompoundUnit
	instanceVariableNames: 'units'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'private' stamp: 'ad 6/5/2017 23:04:41'!
convertToSingleUnitClassIfAmountOfUnitsIsOne

	(units size = 1) ifTrue: [
		| assoc |
		assoc _ units associations last.
		(assoc value = 1) ifTrue: [^ assoc key] ].
	
	(units size = 0) ifTrue: [
		^ 1 ].
	
	^ self! !

!CompoundUnit methodsFor: 'private' stamp: 'ad 6/6/2017 17:08:05'!
from: aUnitDictionary 
	
	units _ aUnitDictionary.
	
	^ self convertToSingleUnitClassIfAmountOfUnitsIsOne.
	
	! !

!CompoundUnit methodsFor: 'private' stamp: 'ad 6/6/2017 17:00:38'!
inverse

	| aDictionaryOfUnits |
	
	aDictionaryOfUnits _ Dictionary newFrom: self units.
	
	aDictionaryOfUnits associationsDo: [:assoc |
				aDictionaryOfUnits at: assoc key put: (assoc value * -1)].
			
	^ self class from: aDictionaryOfUnits.! !


!CompoundUnit methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:45:03'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^ false].
	
	(self units size = aUnit units size) ifFalse: [^false].
	
	self unitsDo: [:aSingleUnitFromSelf |   | aSingleUnitFromOther |
							aSingleUnitFromOther _ aUnit singleUnitFromCategory: aSingleUnitFromSelf category ifAbsent: [^ false].
							((self units at: aSingleUnitFromSelf) = (aUnit units at: aSingleUnitFromOther )) ifFalse: [^ false]].
						
	^ true.! !


!CompoundUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:49:29'!
* aMultiplier

	(aMultiplier isKindOf: SingleUnit) ifTrue: [	| aDictionaryOfUnits |	
			aDictionaryOfUnits _ Dictionary newFrom: self units.
	
			self singleUnitFromCategory: aMultiplier category 
						ifAbsent: [ aDictionaryOfUnits at: aMultiplier put: 1]
						ifPresent: [ :aSingleUnitFromSelf |  | oldValue |
										oldValue _ self units at: aSingleUnitFromSelf.
										(oldValue = -1) ifTrue: [aDictionaryOfUnits removeKey: aSingleUnitFromSelf]
										                       ifFalse: [aDictionaryOfUnits at: aSingleUnitFromSelf 
																						 put: (oldValue + 1) ]].										
			^ (self class from: aDictionaryOfUnits) convertToSingleUnitClassIfAmountOfUnitsIsOne.].
		
	(aMultiplier isKindOf: Number) ifTrue: [	^ Measure withAmount: aMultiplier andUnit: self. ].
	
	"case where aMultiplier is Measure"
	^ aMultiplier * self

	! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 17:14:02'!
= aCompoundUnit

	(aCompoundUnit isKindOf: self class) ifFalse: [^false].
	
	^ self units = aCompoundUnit units.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 17:28:41'!
hash

	| sumOfSingleUnitHashes |
	
	sumOfSingleUnitHashes _ 0.
	
	self unitsDo: [ :aSingleUnit | | aMultiplier |
				aMultiplier _ self units at: aSingleUnit.
				sumOfSingleUnitHashes _ (aSingleUnit hash * aMultiplier)].
			
	^ sumOfSingleUnitHashes.! !


!CompoundUnit methodsFor: 'accessing' stamp: 'ad 6/5/2017 15:43:30'!
singleUnitFromCategory: aCategory ifAbsent: absentBlock 
	
	self unitsDo: [:aSingleUnit | 
						aSingleUnit category = aCategory ifTrue: [^ aSingleUnit]].
					
	^ absentBlock value.

	! !

!CompoundUnit methodsFor: 'accessing' stamp: 'ad 6/5/2017 22:38:50'!
singleUnitFromCategory: aCategory ifAbsent: absentBlock ifPresent: presentBlock
	
	self unitsDo: [:aSingleUnit | 
						aSingleUnit category = aCategory ifTrue: [^presentBlock value: aSingleUnit]].
					
	^ absentBlock value.

	! !

!CompoundUnit methodsFor: 'accessing' stamp: 'ad 6/5/2017 15:29:24'!
units

	^ units! !


!CompoundUnit methodsFor: 'enumerating' stamp: 'ad 6/5/2017 15:41:40'!
unitsDo: aBlockClosure 

	self units size = 0 ifTrue: [^self].
	
	self units associationsDo: [ :assoc |
										aBlockClosure value: assoc key].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'initialization' stamp: 'ad 6/5/2017 14:50:05'!
from: aUnitDictionary

	^ self new from: aUnitDictionary! !


!classDefinition: #SingleUnit category: #'Measure-Solution'!
MeasureUnit subclass: #SingleUnit
	instanceVariableNames: 'name category convertionFormula inverseFormula'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SingleUnit methodsFor: 'private' stamp: 'ad 6/3/2017 20:53:37'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	name _ aUnitNameSymbol.
	
	category _ aCategoryNameSymbol.
	
	convertionFormula _ aConvertionFormulaBlock.
	
	inverseFormula _ inverseFormulaBlock .
	
	Smalltalk at: aUnitNameSymbol put: self.! !

!SingleUnit methodsFor: 'private' stamp: 'ad 6/6/2017 16:57:30'!
inverse

	| aDictionaryOfUnits |
	
	aDictionaryOfUnits _ Dictionary new.
	
	aDictionaryOfUnits at: self put: -1.
	
	^ CompoundUnit from: aDictionaryOfUnits.! !


!SingleUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:31:49'!
category

	^ category ! !

!SingleUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:04:36'!
convertionFormula

	^ convertionFormula ! !

!SingleUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:55:11'!
inverseConvertionFormula
	
	^ inverseFormula ! !

!SingleUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:31:58'!
name

	^ name ! !


!SingleUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:31'!
= aUnit 

	(aUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aUnit name! !

!SingleUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:43'!
hash

	^ self name asString size.! !

!SingleUnit methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:49:57'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^false].
	
	^ self category = aUnit category.! !


!SingleUnit methodsFor: 'printing' stamp: 'ad 6/3/2017 16:24:32'!
printString
	
	^ name asString ! !


!SingleUnit methodsFor: 'arithmetic' stamp: 'ad 6/6/2017 16:39:49'!
* aMultiplier

	| aUnitDictionary |

	(aMultiplier isKindOf: Number) ifTrue: [^ aMultiplier * self].
	
	(aMultiplier isKindOf: Measure) ifTrue: [^ Measure withAmount: aMultiplier amount andUnit: (aMultiplier unit * self)].		
	
	(aMultiplier isKindOf: SingleUnit ) 
			ifTrue: [
					aUnitDictionary _ Dictionary new.	
					(aMultiplier isFromSameCategoryThan: self) 
									ifFalse: [ aUnitDictionary at: self put: 1; at: aMultiplier put: 1]
									ifTrue: [ aUnitDictionary at: self put: 2].
					^ CompoundUnit from: aUnitDictionary ].
				
	"case aMultiplier is CompoundUnit"		
	^ aMultiplier * self! !

!SingleUnit methodsFor: 'arithmetic' stamp: 'ad 6/5/2017 21:35:50'!
/ aSingleUnit

	| aUnitDictionary |
	
	aUnitDictionary _ Dictionary new.
	
	(aSingleUnit isFromSameCategoryThan: self)
					ifTrue: [ self error: 'No me dividas por algo en la misma categoria. HACER REFACTORING ACA']
					ifFalse: [ aUnitDictionary at: self put: 1; at: aSingleUnit put: -1].
					
	^ CompoundUnit from: aUnitDictionary.
	! !


!SingleUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/6/2017 15:50:58'!
isZero
	
	^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SingleUnit class' category: #'Measure-Solution'!
SingleUnit class
	instanceVariableNames: ''!

!SingleUnit class methodsFor: 'initialization' stamp: 'ad 6/4/2017 11:25:12'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

 ^ self withName: aUnitNameSymbol 
			   inCategory: aCategoryNameSymbol 
			   andFormulaToConvertIntoCategoryReferenceUnit: [:thisUnit |
																			thisUnit * aConvertionFactor ]
			   andInverseFormula: [ :referenceUnit |
												referenceUnit / aConvertionFactor ].! !

!SingleUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 20:52:44'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

! !

MeasureFactory initialize!