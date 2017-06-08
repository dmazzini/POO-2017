!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'DIM 6/8/2017 09:45:56'!
* aMultiplier

	(aMultiplier isKindOf: Number) ifTrue: [^ aMultiplier * self].
	
	^ aMultiplier multiplyMeasure: self.
"
	(aMultiplier isKindOf: MeasureUnit) ifTrue: [^ Measure withAmount: self amount andUnit: (aMultiplier * self unit)].
	

	
	(aMultiplier isKindOf: Measure) ifTrue: [
	^ self class withAmount: (self amount * aMultiplier amount) andUnit: (self unit * aMultiplier unit) ]. 

	self error: 'Should implement'
"
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/8/2017 03:54:55'!
+ aMeasure

	(self isFromSameCategoryThan: aMeasure) ifFalse: [
					^ CompoundMeasure from: (OrderedCollection with: self with: aMeasure) ]. 

	^ self class withAmount: (self amount +  (aMeasure convertTo: self unit) amount) 
					andUnit: unit.
	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/4/2017 13:23:47'!
- aMeasure

	^ self + aMeasure negated
	! !

!Measure methodsFor: 'arithmetic' stamp: 'DIM 6/6/2017 21:00:38'!
/  aDivisor

	^ (1/ aDivisor) * self

	! !

!Measure methodsFor: 'arithmetic' stamp: 'ad 6/8/2017 04:20:58'!
adaptToNumber: aNumber andSend: aSymbol 

	(aSymbol = #*) ifTrue: [ ^ self class withAmount: (self amount * aNumber) 
												andUnit: unit. ].

	(aSymbol = #/) ifTrue: [ ^ self class withAmount: (aNumber / self amount) 
												andUnit: unit inverse. ].! !


!Measure methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:42'!
amount
	
	^ amount

	! !

!Measure methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:49'!
unit

	^ unit.! !

!Measure methodsFor: 'accessing' stamp: 'ad 6/8/2017 00:06:26'!
unitsDo: aBlockClosure

	^ self unit unitsDo: aBlockClosure.! !


!Measure methodsFor: 'converting' stamp: 'ad 6/8/2017 03:26:52'!
convertTo: aUnit

	| newAmount |

	(aUnit isFromSameCategoryThan: self unit) ifFalse: [self error: self class canNotConvertErrorMessage].
		
	newAmount _ self amount.
	self unitsDo: [ :aMetaUnitFromSelf |  | aMetaUnitFromOther unitRepetitions |
				aMetaUnitFromOther _ aUnit metaUnitFromSameCategoryThan: aMetaUnitFromSelf 												ifAbsent: [self error: self class canNotConvertErrorMessage].
				unitRepetitions _ self unit units at: aMetaUnitFromSelf.
				(unitRepetitions > 0) 
						ifTrue: [ unitRepetitions timesRepeat: 												
									[newAmount _ aMetaUnitFromSelf convert: newAmount 
																	toEquivalentIn: aMetaUnitFromOther ]]
						ifFalse: [ (-1 * unitRepetitions) timesRepeat: 
									[ newAmount _ aMetaUnitFromOther convert: newAmount 
																	toEquivalentIn: aMetaUnitFromSelf ] ] ].
	^ Measure withAmount: newAmount andUnit: aUnit.
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


!Measure methodsFor: 'comparing' stamp: 'ad 6/8/2017 04:00:15'!
< aMeasure

	^ self amount < (aMeasure convertTo: self unit) amount! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/8/2017 04:00:04'!
= aMeasure

	(aMeasure isKindOf: self class) ifFalse:[^ false].
	
	(self areEmptyMeasuresFromDifferentCategoriesWith: aMeasure) ifTrue: [^ true].
	
	(self isFromSameCategoryThan: aMeasure) ifFalse: [^false].

	^ self amount = (aMeasure convertTo: self unit) amount
	
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/8/2017 04:12:17'!
areEmptyMeasuresFromDifferentCategoriesWith: aMeasure.
	
	^ ((self isFromSameCategoryThan: aMeasure) not) 
				and: 
		[self amountInStandardUnits = 0 and: [aMeasure amountInStandardUnits = 0]]! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/8/2017 01:48:22'!
hash
			
	^ self amountInStandardUnits hash.
! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:19:53'!
isFromSameCategoryThan: aMeasure
	
	^ self unit isFromSameCategoryThan: aMeasure unit.! !

!Measure methodsFor: 'comparing' stamp: 'ad 6/3/2017 12:13:50'!
negated

	 ^ self class withAmount: (self amount * -1) andUnit: unit.! !


!Measure methodsFor: 'private' stamp: 'ad 6/8/2017 00:09:02'!
amountInStandardUnits

	| newAmount | 
	
	newAmount _ self amount.
	
	self unitsDo: [ :aMetaUnit | | aMultiplier |
				aMultiplier _ self unit units at: aMetaUnit.
				(aMultiplier > 0) ifTrue: [ 
										aMultiplier timesRepeat: 
												[newAmount _ aMetaUnit convertionFormula value: newAmount] ]
								   ifFalse: [
										-1 * aMultiplier timesRepeat:
												[newAmount _ aMetaUnit inverseConvertionFormula value: newAmount]]].
			
	^ newAmount.! !

!Measure methodsFor: 'private' stamp: 'ad 6/8/2017 03:06:44'!
combineMetaUnitsFromSameCategory

	| aDicOfUnits newAmount |
	
	aDicOfUnits _ self unit units copy.
	newAmount _ self amount.

	aDicOfUnits keysDo: [:aMetaUnit | 
			aDicOfUnits keysDo: [:anotherMetaUnit | 
					((anotherMetaUnit = aMetaUnit) not
						and:
					(anotherMetaUnit isFromSameCategoryThan: aMetaUnit) )
						ifTrue: [   | aMultiplier oldValue |
							aMultiplier _ aDicOfUnits at: anotherMetaUnit.
							(aMultiplier > 0)
								ifTrue: [ 
										aMultiplier timesRepeat: 
												[newAmount _ anotherMetaUnit convert: newAmount 
																					toEquivalentIn: aMetaUnit ] ]
								ifFalse: [
										-1 * aMultiplier timesRepeat:
												[newAmount _ aMetaUnit convert: newAmount 
																			toEquivalentIn: anotherMetaUnit ]].
											oldValue _ aDicOfUnits at: aMetaUnit.
											(oldValue + aMultiplier = 0)
												ifTrue: [aDicOfUnits removeKey: aMetaUnit ]
												ifFalse: [aDicOfUnits at: aMetaUnit put: (oldValue + aMultiplier)].
											aDicOfUnits removeKey: anotherMetaUnit .]
					
					]].
			
	(aDicOfUnits size = 0) ifTrue: [^ newAmount].
	amount _ newAmount .
	unit _ MeasureUnit from: aDicOfUnits.! !

!Measure methodsFor: 'private' stamp: 'ad 6/8/2017 02:51:20'!
initializeWithAmount: anAmount andUnit: aMeasureUnit

	amount _ anAmount.
	
	unit _ aMeasureUnit.
	
	^ self combineMetaUnitsFromSameCategory.! !

!Measure methodsFor: 'private' stamp: 'ad 6/8/2017 04:17:18'!
isZero
	
	^ self amountInStandardUnits = 0.! !


!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/8/2017 09:48:21'!
multiplyMeasure: aMeasure
 
	^ self class withAmount: (self amount * aMeasure amount) andUnit: (self unit * aMeasure unit)! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIM 6/8/2017 10:03:27'!
multiplyMeasureUnit: aMeasureUnit 

	^ self * aMeasureUnit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'initialization' stamp: 'ad 6/8/2017 01:16:48'!
withAmount: anAmount andUnit: aMeasureUnit

	(aMeasureUnit = 1) ifTrue: [^ anAmount].

	^ self new initializeWithAmount: anAmount andUnit: aMeasureUnit.! !


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

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:07:17'!
test10OneKilogramConvertedToGramsEqualsOneThousandGrams
	
	self assert: (oneKilogram convertTo: gram) = oneThousandGrams! !

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

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:07:58'!
test16ThreeHundredAndSomeMoreKelvinEqualsOneHundredCelsius
	
	self assert: 7463/20 * kelvin = (100 * celsius).! !

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

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:08:36'!
test25OneKilogramPlusOneLitersAndOneThousandMilitersPlusOneThousandGramsHaveTheSameHash

	self assert: (oneKilogram + oneLiter) hash = (oneThousandMililiters + oneThousandGrams) hash! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:08:57'!
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

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:09:57'!
test30AnIntervalFromOneMeterToTenKilometersByFiveCentimetersContainsTwoMetersAtPosition21
	
	aMeasureInterval _ oneMeter to: 10*kilometer by: 5*centimeter.
	
	self assert:  (aMeasureInterval at: 21) = (2*meter).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/5/2017 21:28:41'!
test31OneSquareMeterEqualsOneSquareMeter

	self assert: 1 * (meter*meter) = (1 * (meter*meter)).! !

!MeasureTest methodsFor: 'tests' stamp: 'DIM 6/7/2017 21:50:56'!
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

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:11:46'!
test40OneMeterPerSecondEqualsOneMeterPerSecond

	self assert: 1 * (meter/second) = (1 * meter / second).! !

!MeasureTest methodsFor: 'tests' stamp: 'DIM 6/6/2017 19:25:42'!
test41MeterMultipliedByMeterAndDividedBySecondEqualsTheSameUnitCreatedDifferently

	self assert: meter * meter /second = (meter / second * meter)! !

!MeasureTest methodsFor: 'tests' stamp: 'DIM 6/6/2017 19:48:08'!
test42TwoEqualCompoundUnitsHaveTheSameHash

	self assert: (meter * meter /second) hash = (meter / second * meter) hash! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/7/2017 23:12:51'!
test43OneMeterQuarticEqualsOneMeterQuartic

	|aSquareMeter anotherSquareMeter |
	
	aSquareMeter  _ meter * meter.
	anotherSquareMeter  _ meter * meter.
	
	self assert: meter*meter*meter*meter = (aSquareMeter *anotherSquareMeter).

! !

!MeasureTest methodsFor: 'tests' stamp: 'DIM 6/6/2017 20:42:52'!
test44TwoEqualCompoundMeasuresWithCompoundUnitsCreatedDifferentlyAreEqual

	self assert: 1 * meter / second + (5 * liter / kelvin * kilogram) = (5 * liter / kelvin * kilogram + (1 * meter / second))! !

!MeasureTest methodsFor: 'tests' stamp: 'DIM 6/6/2017 20:00:34'!
test45OneMeterMultipliedByMeterAndDividedBySecondEqualsTheSameMeasureCreatedDifferently

	self assert: 1 * meter * meter /second = (meter / second * meter * 1).
	self assert: meter * meter * (1/second) = (meter / second * meter * 1).! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/8/2017 00:10:56'!
test46FinalSpeedIsTheExpectedOne

	|initialSpeed expectedFinalSpeed acceleration time measureFactory|
	
	measureFactory _ MeasureFactory new.
	initialSpeed _ 1 * kilometer/hour.
	acceleration _ 5 * kilometer /hour/hour.
	time _ 5 * hour.
	expectedFinalSpeed  _ 26 * kilometer/hour.
	
	self assert: expectedFinalSpeed = (measureFactory finalSpeedStartingAt: initialSpeed 
															     accelerating: acceleration 
															     during:time). ! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/8/2017 04:22:53'!
test47OneMeterPerSecondPlusZeroCelsiusDoesNotEqualOneMeterPerSecond

	self deny: 1 * meter / second + (0 * celsius) = (1 * meter / second) ! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/8/2017 04:22:57'!
test48ZeroMetersIsNoEqualThanZeroCelsius

	self deny: 0 * meter = (0 * celsius)! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/8/2017 04:23:02'!
test49OneThousandMetersOverMeterEqualsOneKilometerOverMeter

	self assert: 1000 * meter / meter = (1 * kilometer / meter)! !

!MeasureTest methodsFor: 'tests' stamp: 'ad 6/8/2017 04:24:01'!
test50TenMetersPerSecondDividedByFiveMetersPerSecondEqualsTwo

	self assert: 10 * meter / second / (5 * meter / second) = 2.! !


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

!CompoundMeasure methodsFor: 'private' stamp: 'ad 6/8/2017 00:24:43'!
initializeWith: aDictionaryOfMeasures

	measures _ aDictionaryOfMeasures copy.
	
	^ self removeEmptyMeasuresAndConvertToMeasureClassIfAmountOfMeasuresIsOne .! !

!CompoundMeasure methodsFor: 'private' stamp: 'ad 6/8/2017 00:03:06'!
removeEmptyMeasuresAndConvertToMeasureClassIfAmountOfMeasuresIsOne

     | backUpUnit |

	self measuresDo: [:aMeasure |
							(aMeasure amountInStandardUnits = 0) ifTrue: [
														backUpUnit _ aMeasure unit.
														measures removeKey: aMeasure unit]].

	(measures size = 1) ifTrue: [
		| assoc |
		assoc _ measures associations last.
		^ Measure withAmount: assoc value andUnit: assoc key ].
	(measures size = 0) ifTrue: [
		^ Measure withAmount: 0 andUnit: backUpUnit ].
	
	^ self! !


!CompoundMeasure methodsFor: 'comparing' stamp: 'ad 6/8/2017 03:37:28'!
= aCompoundMeasure

	self == aCompoundMeasure ifTrue: [^ true].	"Any object is equal to itself"
	
	(aCompoundMeasure isKindOf: self class) ifFalse: [^false].
	
	(self measures size = aCompoundMeasure measures size) ifFalse: [^false].
	
	self measuresDo: [:aMeasureFromSelf | | aMeasureFromOther |
		aMeasureFromOther _ aCompoundMeasure measureFromSameCategoryThan: aMeasureFromSelf
										ifAbsent:[^false].
		(aMeasureFromSelf = aMeasureFromOther) ifFalse: [^false]].
	^true! !

!CompoundMeasure methodsFor: 'comparing' stamp: 'ad 6/5/2017 13:34:44'!
hash

	| sumOfAllMeasuresHashes |
	
	sumOfAllMeasuresHashes _ 0.
	
	self measuresDo: [:aMeasure |
					sumOfAllMeasuresHashes _ sumOfAllMeasuresHashes + aMeasure hash].	

	^ sumOfAllMeasuresHashes hash! !


!CompoundMeasure methodsFor: 'accessing' stamp: 'DIM 6/6/2017 20:23:39'!
measureFromSameCategoryThan: aMeasure ifAbsent: absentBlock 
	
	self measuresDo: [:aMeasureFromSelf | 
						(aMeasureFromSelf isFromSameCategoryThan: aMeasure) ifTrue: [^ aMeasureFromSelf ]].
					
	^ absentBlock value.! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/8/2017 03:46:15'!
measureFromSameCategoryThan: aMeasure ifPresent: presentBlock ifAbsent: absentBlock 
	
	self measuresDo: [:aMeasureFromSelf | 
						(aMeasureFromSelf isFromSameCategoryThan: aMeasure) 
											ifTrue: [^ presentBlock value: aMeasureFromSelf ]].
					
	^ absentBlock value.! !

!CompoundMeasure methodsFor: 'accessing' stamp: 'ad 6/4/2017 12:05:09'!
measures

	^ measures! !


!CompoundMeasure methodsFor: 'arithmetic' stamp: 'ad 6/8/2017 03:44:18'!
+ aMeasure

	| aDicOfMeasures |
	
	aDicOfMeasures _ self measures copy.
									
	self measureFromSameCategoryThan: aMeasure 
					ifPresent: [:aMeasureFromCategory |  | newMeasure |
								newMeasure _ aMeasureFromCategory + aMeasure.
								aDicOfMeasures removeKey: aMeasureFromCategory unit.
								aDicOfMeasures at: newMeasure unit put: newMeasure amount]
					ifAbsent: [aDicOfMeasures at: aMeasure unit put: aMeasure amount].
	
	^ CompoundMeasure with: aDicOfMeasures.! !

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

!CompoundMeasure class methodsFor: 'initialization' stamp: 'ad 6/8/2017 03:40:23'!
from: aCollectionOfMeasures

	| aDictionaryOfMeasures |
	
	aDictionaryOfMeasures _ Dictionary new.
	
	aCollectionOfMeasures do: [:aMeasure |
					aDictionaryOfMeasures at: aMeasure unit put: aMeasure amount].

	^ self with: aDictionaryOfMeasures ! !

!CompoundMeasure class methodsFor: 'initialization' stamp: 'ad 6/4/2017 16:49:43'!
with: aDictionaryOfMeasures

	^ self new initializeWith: aDictionaryOfMeasures ! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'formulas' stamp: 'DIM 6/6/2017 20:51:05'!
finalSpeedStartingAt: aStartingSpeed accelerating: anAcceleration during: anAmountOfTime

 ^ aStartingSpeed + (anAcceleration * anAmountOfTime) ! !


!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:57:16'!
celsius

	^ celsius! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'ad 6/7/2017 15:05:49'!
centimeter

	^ centimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:02:33'!
day

	^ day! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:55:24'!
decameter

	^ decameter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:55:37'!
decimeter

	^ decimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:27:26'!
eightCubicMeters

	^ 8 * meter * meter * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:13:23'!
fahrenheit

	^ fahrenheit! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:27:38'!
fourSquaredMeters

	^ 4 * meter * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:55:50'!
hectometer

	^ hectometer! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:58:46'!
hour

	^ hour! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:58:20'!
kelvin

	^ kelvin! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:56:01'!
kilometer

	^ kilometer! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:56:08'!
meter

	^ meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:56:15'!
millimeter

	^ millimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:19:56'!
minusOneMeter

	^ -1 * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:58:53'!
minute

	^ minute! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:23:24'!
oneCelsius

	^ 1 * celsius! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:21:30'!
oneCentimeter

	^ 1 * centimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:25:08'!
oneDay

	^ 1 * day! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:25:18'!
oneHour

	^ 1 * hour! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:21:51'!
oneHundredCentimeters

	^ 100 * centimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:28:06'!
oneHundredTwentyOneMetersPerSecond

	^ 121 * meter/second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:22:04'!
oneMeter

	^ 1 * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:28:45'!
oneMeterPerSecond

	^ 1 * meter/second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:25:31'!
oneMinute

	^ 1 * minute! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:25:41'!
oneSecond

	^ 1 * second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:28:59'!
oneSquaredMeter

	^ 1 * meter * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:29:13'!
oneSquaredSecond

	^ 1 * second * second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 21:58:59'!
second

	^ second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:25:53'!
sixtyMinutes

	^ 60 * minute ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:26:05'!
sixtyOneSeconds

	^ 61 * second ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:26:17'!
sixtySeconds

	^ 60 * second ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:24:22'!
thirtyTwoFahrenheits

	^ 32 * fahrenheit ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:26:33'!
twentyFourHours

	^ 24 * hour! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:24:36'!
twoCelsius

	^ 2 * celsius ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:22:36'!
twoHundredCentimeters

	^ 200 * centimeter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:22:53'!
twoMeters

	^ 2 * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:29:37'!
twoMetersBySecond

	^ 2 * meter / second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:30:45'!
twoMetersPerSquaredSecond

	^ 2 * meter / second / second ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'ad 6/8/2017 00:20:59'!
twoMetersTimesSecond

	^ 2 * meter * second  ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:26:44'!
twoSeconds

	^ 2 * second! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:24:47'!
zeroCelsius

	^ 0 * celsius ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:24:55'!
zeroKelvin

	^ 0 * kelvin ! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:23:03'!
zeroMeters

	^ 0 * meter! !

!MeasureFactory methodsFor: 'measure instances' stamp: 'DIM 6/7/2017 22:26:51'!
zeroSeconds

	^ 0 * second! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'initialize' stamp: 'ad 6/8/2017 00:23:31'!
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
	MeasureUnit withName: #hectometer inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 100.
	MeasureUnit withName: #decameter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: 10.
	MeasureUnit withName: #decimeter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: (1/10).
	MeasureUnit withName: #centimeter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: (1/100).
	MeasureUnit withName: #millimeter inCategory: #distance
		andConvertionFactorToCategoryReferenceUnit: (1/1000).
	
	"Unidades de tiempo"
	MeasureUnit withName: #second inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 1.
	MeasureUnit withName: #minute inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 60.
	MeasureUnit withName: #hour inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 3600.
	MeasureUnit withName: #day inCategory: #time
		andConvertionFactorToCategoryReferenceUnit: 86400.
	
	"Unidades de temperatura"
	MeasureUnit withName: #kelvin inCategory: #temperature
		andConvertionFactorToCategoryReferenceUnit: 1.	
	MeasureUnit withName: #celsius inCategory: #temperature
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInCelsius |
																	aMeasureInCelsius + (5463/20)]
		andInverseFormula: [:aMeasureInKelvin |
																	aMeasureInKelvin  - (5463/20)].
																
	MeasureUnit withName: #fahrenheit inCategory: #temperature
		andFormulaToConvertIntoCategoryReferenceUnit: [:aMeasureInFahrenheit |
																	aMeasureInFahrenheit + (45967/100) * 5/9]
		andInverseFormula: [:aMeasureInKelvin |
																	aMeasureInKelvin *9/5  - (45967/100)].																! !


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


!MeasureInterval methodsFor: 'enumerating' stamp: 'ad 6/8/2017 03:35:22'!
do: aBlockClosure

	1 to: interval size do: [ :i |
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
	instanceVariableNames: 'units'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/7/2017 23:23:42'!
from: aUnitDictionary 
	
	units _ aUnitDictionary copy.
	

	
	! !

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/8/2017 03:16:58'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	| aMetaUnit aDictionaryOfUnits |
	
	aMetaUnit _ MetaUnit withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock.
	
	aDictionaryOfUnits _ Dictionary new.
	
	aDictionaryOfUnits at: aMetaUnit put: 1.
	
	units _ aDictionaryOfUnits.
	
	Smalltalk at: aUnitNameSymbol put: self.! !

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/7/2017 23:21:03'!
inverse

	| aDictionaryOfUnits |
	
	aDictionaryOfUnits _ self units copy.
	aDictionaryOfUnits associationsDo: [:assoc |
				aDictionaryOfUnits at: assoc key put: (assoc value * -1)].
			
	^ self class from: aDictionaryOfUnits.! !

!MeasureUnit methodsFor: 'private' stamp: 'ad 6/7/2017 16:44:56'!
isZero
	
	^false! !


!MeasureUnit methodsFor: 'comparing' stamp: 'ad 6/8/2017 03:32:00'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^ false].
	
	(self units size = aUnit units size) ifFalse: [^false].
	
	self unitsDo: [:aMetaUnitFromSelf |
							aUnit metaUnitFromSameCategoryThan: aMetaUnitFromSelf
																	ifAbsent: [^ false]].
						
	^ true.! !


!MeasureUnit methodsFor: 'arithmetic' stamp: 'DIM 6/8/2017 09:49:28'!
* aMultiplier
		
	(aMultiplier isKindOf: Number) ifTrue: [	^ Measure withAmount: aMultiplier andUnit: self. ].
	
	^ aMultiplier multiplyMeasureUnit: self.
	"
	(aMultiplier isKindOf: Measure) ifTrue: [	^ aMultiplier * self].	
	
	(aMultiplier isKindOf: self class) ifTrue: [	| aDictionaryOfUnits |	
			aDictionaryOfUnits _ self units copy.
	
			aMultiplier unitsDo: [ :aMetaUnitFromOther |
					self units at: aMetaUnitFromOther 
							ifPresent: [ :valueAtMetaUnit |  | newValue |
										newValue _ valueAtMetaUnit + aMultiplier units at: aMetaUnitFromOther .
										(newValue = 0) ifTrue: [aDictionaryOfUnits removeKey: aMetaUnitFromOther]
										                       ifFalse: [aDictionaryOfUnits at: aMetaUnitFromOther 
																						 put: newValue ]]
							ifAbsent: [ aDictionaryOfUnits at: aMetaUnitFromOther 
															   put: ( aMultiplier units at: aMetaUnitFromOther )]													
			].
			^ self class from: aDictionaryOfUnits.
		].
	
	self error: 'Should implement'.	
"	



	! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/7/2017 15:32:10'!
/ aUnit

	^ self * aUnit inverse! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/8/2017 03:11:24'!
= aMeasureUnit

	(aMeasureUnit isKindOf: self class) ifFalse: [^false].
	
	^ self units = aMeasureUnit units.! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/7/2017 15:34:07'!
adaptToNumber: aNumber andSend: aSelector

	(aSelector = #* ) ifTrue: [ ^ Measure withAmount: aNumber andUnit: self ].
	
	(aSelector = #/ ) ifTrue: [ ^ Measure withAmount: aNumber andUnit: (self inverse)].

	self error: 'should implement'! !

!MeasureUnit methodsFor: 'arithmetic' stamp: 'ad 6/8/2017 01:46:54'!
hash

	| sumOfMetaUnitHashes |
	
	sumOfMetaUnitHashes _ 0.
	
	self unitsDo: [ :aMetaUnit | | aMultiplier |
				aMultiplier _ self units at: aMetaUnit.
				sumOfMetaUnitHashes _ (aMetaUnit hash * aMultiplier)].
			
	^ sumOfMetaUnitHashes.! !


!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/8/2017 03:26:08'!
metaUnitFromSameCategoryThan: anotherMetaUnit ifAbsent: absentBlock 
	
	self unitsDo: [:aMetaUnit | 
						(aMetaUnit isFromSameCategoryThan: anotherMetaUnit) ifTrue: [^ aMetaUnit]].
					
	^ absentBlock value.

	! !

!MeasureUnit methodsFor: 'accessing' stamp: 'ad 6/5/2017 15:29:24'!
units

	^ units! !


!MeasureUnit methodsFor: 'enumerating' stamp: 'ad 6/5/2017 15:41:40'!
unitsDo: aBlockClosure 

	self units size = 0 ifTrue: [^self].
	
	self units associationsDo: [ :assoc |
										aBlockClosure value: assoc key].! !


!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/8/2017 09:47:19'!
multiplyMeasure: aMeasure

	^ Measure withAmount: aMeasure amount andUnit: (self * aMeasure unit) 
! !

!MeasureUnit methodsFor: 'as yet unclassified' stamp: 'DIM 6/8/2017 09:51:30'!
multiplyMeasureUnit: aMeasureUnit 

	| aDictionaryOfUnits |	
			aDictionaryOfUnits _ self units copy.
	
			aMeasureUnit unitsDo: [ :aMetaUnitFromOther |
					self units at: aMetaUnitFromOther 
							ifPresent: [ :valueAtMetaUnit |  | newValue |
										newValue _ valueAtMetaUnit + aMeasureUnit units at: aMetaUnitFromOther .
										(newValue = 0) ifTrue: [aDictionaryOfUnits removeKey: aMetaUnitFromOther]
										                       ifFalse: [aDictionaryOfUnits at: aMetaUnitFromOther 
																						 put: newValue ]]
							ifAbsent: [ aDictionaryOfUnits at: aMetaUnitFromOther 
															   put: ( aMeasureUnit units at: aMetaUnitFromOther )]													
			].
			^ self class from: aDictionaryOfUnits.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureUnit class' category: #'Measure-Solution'!
MeasureUnit class
	instanceVariableNames: ''!

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/8/2017 00:52:31'!
from: aUnitDictionary

	(aUnitDictionary size = 0) ifTrue: [
		^ 1 ].

	^ (self new from: aUnitDictionary).! !

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/7/2017 15:36:54'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

 ^ self withName: aUnitNameSymbol 
			   inCategory: aCategoryNameSymbol 
			   andFormulaToConvertIntoCategoryReferenceUnit: [:thisUnit |
																			thisUnit * aConvertionFactor ]
			   andInverseFormula: [ :referenceUnit |
												referenceUnit / aConvertionFactor ].! !

!MeasureUnit class methodsFor: 'initialization' stamp: 'ad 6/7/2017 15:36:37'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock! !


!classDefinition: #MetaUnit category: #'Measure-Solution'!
Object subclass: #MetaUnit
	instanceVariableNames: 'name category convertionFormula inverseFormula'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MetaUnit methodsFor: 'private' stamp: 'ad 6/3/2017 12:31:49'!
category

	^ category ! !

!MetaUnit methodsFor: 'private' stamp: 'ad 6/3/2017 20:53:37'!
initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	name _ aUnitNameSymbol.
	
	category _ aCategoryNameSymbol.
	
	convertionFormula _ aConvertionFormulaBlock.
	
	inverseFormula _ inverseFormulaBlock .
	
	Smalltalk at: aUnitNameSymbol put: self.! !

!MetaUnit methodsFor: 'private' stamp: 'ad 6/7/2017 15:30:07'!
inverse

	| aDictionaryOfUnits |
	
	aDictionaryOfUnits _ Dictionary new.
	
	aDictionaryOfUnits at: self put: -1.
	
	^ MeasureUnit from: aDictionaryOfUnits.! !

!MetaUnit methodsFor: 'private' stamp: 'ad 6/6/2017 15:50:58'!
isZero
	
	^ false.! !


!MetaUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:04:36'!
convertionFormula

	^ convertionFormula ! !

!MetaUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 20:55:11'!
inverseConvertionFormula
	
	^ inverseFormula ! !

!MetaUnit methodsFor: 'accessing' stamp: 'ad 6/3/2017 12:31:58'!
name

	^ name ! !


!MetaUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:31'!
= aUnit 

	(aUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aUnit name! !

!MetaUnit methodsFor: 'comparing' stamp: 'ad 6/3/2017 16:23:43'!
hash

	^ self name asString size.! !

!MetaUnit methodsFor: 'comparing' stamp: 'ad 6/5/2017 15:49:57'!
isFromSameCategoryThan: aUnit

	(aUnit isKindOf: self class) ifFalse: [^false].
	
	^ self category = aUnit category.! !


!MetaUnit methodsFor: 'printing' stamp: 'ad 6/3/2017 16:24:32'!
printString
	
	^ name asString ! !


!MetaUnit methodsFor: 'converting' stamp: 'ad 6/7/2017 16:22:50'!
convert: aNumber toEquivalentIn: aMetaUnit

	^ aMetaUnit inverseConvertionFormula value: (self convertionFormula value: aNumber).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MetaUnit class' category: #'Measure-Solution'!
MetaUnit class
	instanceVariableNames: ''!

!MetaUnit class methodsFor: 'initialization' stamp: 'ad 6/4/2017 11:25:12'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andConvertionFactorToCategoryReferenceUnit: aConvertionFactor

 ^ self withName: aUnitNameSymbol 
			   inCategory: aCategoryNameSymbol 
			   andFormulaToConvertIntoCategoryReferenceUnit: [:thisUnit |
																			thisUnit * aConvertionFactor ]
			   andInverseFormula: [ :referenceUnit |
												referenceUnit / aConvertionFactor ].! !

!MetaUnit class methodsFor: 'initialization' stamp: 'ad 6/3/2017 20:52:44'!
withName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

	^ self new initializeWithName: aUnitNameSymbol inCategory: aCategoryNameSymbol andFormulaToConvertIntoCategoryReferenceUnit: aConvertionFormulaBlock andInverseFormula: inverseFormulaBlock

! !

MeasureFactory initialize!