!classDefinition: #Distance category: #'Distance-Solution'!
Magnitude subclass: #Distance
	instanceVariableNames: 'quantity amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:28'!
* aNumber

	^ self performArithmeticOperation: #* withNumber: aNumber

	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:05:41'!
+ aDistance

	^ self performArithmeticOperation: #+ with: aDistance
	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:07:42'!
- aDistance

	^ self performArithmeticOperation: #- with: aDistance
	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:48'!
/  aNumber

	^ self performArithmeticOperation: #/ withNumber: aNumber

	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:58'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber

	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:18'!
< aDistance

	^ self performComparisonOperation: #< with: aDistance 

	! !

!Distance methodsFor: 'arithmetic' stamp: 'DIM 6/1/2017 10:07:44'!
= aDistance

	(aDistance isKindOf: self class superclass) ifFalse:[^ false].

	^ self performComparisonOperation: #= with: aDistance 
	
! !

!Distance methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:20:54'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 6/1/2017 23:22:59'!
negated

	 ^ Distance withAmount: (self amount * -1) andUnit: unit.! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 6/1/2017 23:23:09'!
performArithmeticOperation: aSelector with: aDistance

	^ Distance withAmount: (self amount perform: aSelector with: (aDistance convertTo: self unit) amount) 
					andUnit: unit. 
	! !

!Distance methodsFor: 'arithmetic' stamp: 'ad 6/1/2017 23:23:13'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ Distance withAmount: (self amount perform: aSelector with: aNumber) 
					andUnit: unit. 

	! !

!Distance methodsFor: 'arithmetic' stamp: 'AD 6/1/2017 20:58:36'!
performComparisonOperation: aSelector with: aDistance

	^ self amount perform: aSelector with: (aDistance convertTo: self unit) amount
	

	! !


!Distance methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:42'!
amount
	
	^ amount

	! !

!Distance methodsFor: 'accessing' stamp: 'dim 5/26/2017 00:24:15'!
quantity
	
	^ quantity

	! !

!Distance methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:49'!
unit

	^ unit.! !


!Distance methodsFor: 'converting' stamp: 'ad 6/2/2017 00:13:30'!
convertTo: aDistanceUnit

	^ Distance 
		withAmount: (self amount * self unit convertionFactorToMeter / aDistanceUnit convertionFactorToMeter ) 
		andUnit: aDistanceUnit.! !


!Distance methodsFor: 'printing' stamp: 'ad 6/1/2017 23:49:15'!
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


!Distance methodsFor: 'interval' stamp: 'ad 6/2/2017 00:04:53'!
to: aDistance 

	^ DistanceInterval 
		from: self 
		to: (aDistance convertTo: self unit).! !

!Distance methodsFor: 'interval' stamp: 'ad 6/2/2017 00:04:45'!
to: aDistance by: stepDistance
	 
	^ DistanceInterval 
		from: self 
		to: (aDistance convertTo: self unit) 
		by: (stepDistance convertTo: self unit)! !

!Distance methodsFor: 'interval' stamp: 'ad 5/30/2017 17:16:57'!
to: aDistance by: stepDistance do: aBlockClosure
	
	(self to: aDistance by: stepDistance )
			do: aBlockClosure .! !

!Distance methodsFor: 'interval' stamp: 'ad 5/30/2017 17:17:01'!
to: aDistance do: aBlockClosure

	 (self to: aDistance )
			do: aBlockClosure .! !


!Distance methodsFor: 'binding' stamp: 'ad 6/2/2017 00:11:23'!
hash

	^ (self convertTo: meter) amount hash.  
! !


!Distance methodsFor: 'private' stamp: 'AD 6/1/2017 20:41:08'!
initializeWithAmount: anAmount andUnit: aDistanceUnit

	amount _ anAmount.
	
	unit _ aDistanceUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'initialization' stamp: 'AD 6/1/2017 20:40:21'!
withAmount: anAmount andUnit: aDistanceUnit

	^ self new initializeWithAmount: anAmount andUnit: aDistanceUnit.! !


!classDefinition: #DistanceUnit category: #'Distance-Solution'!
Magnitude subclass: #DistanceUnit
	instanceVariableNames: 'name convertionFactorToMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnit methodsFor: 'private' stamp: 'AD 6/1/2017 20:32:29'!
initializeWithName: aNameSymbol andConvertionFactorToMeter: aConvertionNumber

	name _ aNameSymbol.
	
	convertionFactorToMeter _ aConvertionNumber.
	
	Smalltalk at: aNameSymbol put: self.! !


!DistanceUnit methodsFor: 'accessing' stamp: 'ad 6/2/2017 00:13:12'!
convertionFactorToMeter
	
	^ convertionFactorToMeter ! !

!DistanceUnit methodsFor: 'accessing' stamp: 'ad 6/1/2017 23:50:56'!
name
	
	^ name ! !

!DistanceUnit methodsFor: 'accessing' stamp: 'ad 6/2/2017 00:01:56'!
printString
	
	^ name asString ! !


!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/1/2017 23:55:56'!
= aDistanceUnit 

	(aDistanceUnit isKindOf: self class) ifFalse:[^ false].
	
	^ self name = aDistanceUnit name! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'ad 6/2/2017 00:00:38'!
hash

	^ self name asString size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'AD 6/1/2017 20:18:49'!
withName: aName andConvertionFactorToMeter: aConvertionNumber

	^ self new initializeWithName: aName andConvertionFactorToMeter: aConvertionNumber.! !


!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros cienMilCentimetros unMilimetro tresCentimetros cincoMilimetros diezKilometros cincoCentimetros anIntervalOfDistances seisMetros unMetroNegativo diezMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaTest methodsFor: 'tests' stamp: 'DIM 5/26/2017 11:11:03'!
test01UnMetroEqualsUnMetro

	self assert: unMetro = unMetro.
! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:13:21'!
test02UnMetroIsNotTheSameThanDosMetros

	self deny: unMetro = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:14:05'!
test04UnMetroPlusUnMetroEqualsDosMetros
	
	self assert: unMetro + unMetro = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:43:01'!
test05UnMetroPlusDosMetrosEqualsTresMetros
	
	self assert: unMetro + dosMetros = tresMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:52:20'!
test06UnMetroMultipliedByTwoEqualsDosMetros
	
	self assert: unMetro * 2 = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:52:32'!
test07UnMetroMultipliedByThreeEqualsTresMetros
	
	self assert: unMetro * 3 = tresMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:57:17'!
test09DosMetrosMinusUnMetroEqualsUnMetro
	
	self assert: dosMetros - unMetro = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:53:15'!
test10UnMetroMinusUnMetroEqualsCeroMetros
	
	self assert: unMetro - unMetro = ceroMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:26:19'!
test11ThreeMultipliedByUnMetroEqualsTresMetros
	
	self assert: 3 * unMetro = tresMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:29:39'!
test12OneMultipliedByUnMetroEqualsUnMetro
	
	self assert: 1 * unMetro = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:38:54'!
test13UnMetroDividedByTwoEqualsMedioMetro
	
	self assert: unMetro / 2 = medioMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:39:27'!
test14TresMetrosDividedByTwoEqualsUnMetroYMedio
	
	self assert: tresMetros / 2 = unMetroYMedio.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:49:23'!
test15TresMetrosIsLesserThanCuatroMetros
	
	self assert: tresMetros < cuatroMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:49:11'!
test16TresMetrosIsNotLesserThanDosMetros
	
	self deny: tresMetros < dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:50:44'!
test17TresMetrosIsLesserOrEqualThanCuatroMetros
	
	self assert: tresMetros <= cuatroMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:52:23'!
test18TresMetrosIsNotLesserOrEqualThanDosMetros
	
	self deny: tresMetros <= dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:53:23'!
test19TresMetrosIsGreaterThanUnMetro
	
	self assert: tresMetros > unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:54:14'!
test20TresMetrosIsNotGreaterThanCuatroMetros
	
	self deny: tresMetros > cuatroMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:57:16'!
test21TresMetrosIsGreaterOrEqualThanUnMetro
	
	self assert: tresMetros >= unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 19:57:47'!
test22TresMetrosIsNotGreaterThanCuatroMetros
	
	self deny: tresMetros >= cuatroMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 21:55:01'!
test23UnMetroEqualsCienCentimetros

	self assert: unMetro = cienCentimetros.
	self assert: cienCentimetros = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:43:22'!
test24UnMetroIsNotEqualThanDoscientosCentimetros

	self deny: unMetro = doscientosCentimetros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 21:58:29'!
test25MilMetrosEqualsUnKilometro

	self assert: milMetros = unKilometro.
	self assert: unKilometro = milMetros! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:49:23'!
test26MilMetrosIsNotEqualThanDosKilometros

	self deny: milMetros = dosKilometros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:10:31'!
test27UnMetroEqualsMilMilimetros

	self assert: unMetro = milMilimetros.
	self assert: milMilimetros = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:58:21'!
test28UnMetroIsNotEqualThanDosMilMilimetros

	self deny: unMetro = dosMilMilimetros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:10:59'!
test29UnCentimetroEqualsDiezMilimetros

	self assert: unCentimetro = diezMilimetros.
	self assert: diezMilimetros = unCentimetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:11:47'!
test30UnKilometroEqualsUnMillonDeMilimetros

	self assert: unKilometro = unMillonDeMilimetros.
	self assert:  unMillonDeMilimetros =  unKilometro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 15:56:40'!
test31UnKilometroEqualsCienMilCentimetros

	self assert: unKilometro = cienMilCentimetros.
	self assert: cienMilCentimetros = unKilometro! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 15:56:46'!
test32UnKilometroEqualsUnKilometro

	self assert: unKilometro = unKilometro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 15:56:49'!
test33UnMilimetroEqualsUnMilimetro

	self assert: unMilimetro = unMilimetro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 15:56:52'!
test34UnCentimetroEqualsUnCentimetro

	self assert: unCentimetro = unCentimetro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 16:33:21'!
test35UnKilometroMultipliedByTwoEqualsDosKilometros
	
	self assert: unKilometro * 2 = dosKilometros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 16:34:34'!
test36ThreeMultipliedByUnCentimetroEqualsTresCentimetros
	
	self assert: 3 * unCentimetro = tresCentimetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 16:38:41'!
test37UnMilimetroIsLesserOrEqualThanUnKilometro
	
	self assert: unMilimetro <= unKilometro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 16:39:47'!
test38UnMilimetroIsNotGreaterThanUnKilometro
	
	self deny: unMilimetro > unKilometro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/26/2017 16:42:53'!
test39UnCentimetroDividedByTwoEqualsCincoMilimetros
	
	self assert: unCentimetro / 2 = cincoMilimetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/29/2017 10:07:17'!
test40AnIntervalFromOneMetroToThreeMetrosContainsTwoMetrosAtSecondPosition
	
	anIntervalOfDistances _ unMetro to: tresMetros.
	
	self assert:  (anIntervalOfDistances at: 2) = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/29/2017 10:07:24'!
test41AnIntervalFromOneMetroToDiezKilometrosByCincoCentimetrosContainsTwoMetrosAtPosition21
	
	anIntervalOfDistances _ unMetro to: diezKilometros by: cincoCentimetros.
	
	self assert:  (anIntervalOfDistances at: 21) = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 6/1/2017 23:40:56'!
test42TheElementsOfAnIntervaloDeDistanciaFromUnMetroToTresMetrosSumSeisMetros

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ Distance withAmount: 0 andUnit: meter.
	
	(unMetro to: tresMetros) do: [:aDistance | 
		sumOfIntervalDistances _ aDistance + sumOfIntervalDistances ].	
	
	self assert:  sumOfIntervalDistances = seisMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:53:54'!
test43AnIntervaloDeDistanciasFromUnMetroToSeisMetrosHasThreeElementsOverTresMetros

	| amountOfElementsOverTresMetrosInInterval |
	
	amountOfElementsOverTresMetrosInInterval _ 0.
	
	(unMetro to: seisMetros) do: [:aDistance | 
		aDistance > tresMetros 
			ifTrue: [amountOfElementsOverTresMetrosInInterval _ amountOfElementsOverTresMetrosInInterval + 1] ].	
	
	self assert:  amountOfElementsOverTresMetrosInInterval = 3.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 6/1/2017 23:43:20'!
test44TheElementsOfAnIntervaloDeDistanciaFromUnMetroToTresMetrosByMedioMetroSumDiezMetros

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ ceroMetros.
	
	unMetro to: tresMetros by: medioMetro do: [:aDistance | 
		sumOfIntervalDistances _ aDistance + sumOfIntervalDistances ].	
	
	self assert:  sumOfIntervalDistances = diezMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 6/2/2017 00:05:00'!
test45CreatingAnIntervaloDeDistanciaWithAStepOfZeroMetrosShouldRaiseError

	self 
		should: [ unMetro to: tresMetros by: ceroMetros] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: DistanceInterval wrongCreationParametersErrorText]
		
! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 6/2/2017 00:05:03'!
test46CreatingAnIncreasingIntervaloDeDistanciaWithNegativeStepShouldRaiseError

	self 
		should: [ unMetro to: unKilometro by: unMetroNegativo] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: DistanceInterval wrongCreationParametersErrorText]
		
! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 6/2/2017 00:04:57'!
test47CreatingADecreasingIntervaloDeDistanciaWithPositiveStepShouldRaiseError

	self 
		should: [ tresMetros to: unMetro by: cincoMilimetros ] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: DistanceInterval wrongCreationParametersErrorText]
		
! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 6/1/2017 23:43:55'!
setUp

	DistanceUnit withName: #meter andConvertionFactorToMeter: 1.
	DistanceUnit withName: #centimeter andConvertionFactorToMeter: 1/100.
	DistanceUnit withName: #milimeter andConvertionFactorToMeter: 1/1000.
	DistanceUnit withName: #kilometer andConvertionFactorToMeter: 1000.

	unMetroNegativo := Distance withAmount: -1 andUnit: meter.
	ceroMetros := Distance withAmount: 0 andUnit: meter.
	medioMetro := Distance withAmount: 1/2 andUnit: meter.
	unMetro := Distance withAmount: 1 andUnit: meter.
	unMetroYMedio := Distance withAmount: 3/2 andUnit: meter.
	dosMetros := Distance withAmount: 2 andUnit: meter.
	tresMetros := Distance withAmount: 3 andUnit: meter.
	cuatroMetros := Distance withAmount: 4 andUnit: meter.
	cincoMetros := Distance withAmount: 5 andUnit: meter.
	seisMetros := Distance withAmount: 6 andUnit: meter.
	diezMetros := Distance withAmount: 10 andUnit: meter.
	milMetros := Distance withAmount: 1000 andUnit: meter.
	
	unCentimetro := Distance withAmount: 1 andUnit: centimeter.
	tresCentimetros := Distance withAmount: 3 andUnit: centimeter.
	cincoCentimetros := Distance withAmount: 5 andUnit: centimeter.	
	cienCentimetros := Distance withAmount: 100 andUnit: centimeter.
	doscientosCentimetros := Distance withAmount: 200 andUnit: centimeter.
	cienMilCentimetros := Distance withAmount: 100000 andUnit: centimeter.
	
	unKilometro := Distance withAmount: 1 andUnit: kilometer.
	dosKilometros := Distance withAmount: 2 andUnit: kilometer.
	diezKilometros := Distance withAmount: 10 andUnit: kilometer.

	unMilimetro := Distance withAmount: 1 andUnit: milimeter.	
	cincoMilimetros := Distance withAmount: 5 andUnit: milimeter.	
	diezMilimetros := Distance withAmount: 10 andUnit: milimeter.	
	milMilimetros := Distance withAmount: 1000 andUnit: milimeter.	
	dosMilMilimetros := Distance withAmount: 2000 andUnit: milimeter.	
	unMillonDeMilimetros := Distance withAmount: 1000000 andUnit: milimeter.	! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:44:42'!
minusOneMeter
	
	^ Distance withAmount: -1 andUnit: meter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:44:52'!
oneCentimeter
	
	^ Distance withAmount: 1 andUnit: centimeter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:45:07'!
oneHundredCentimeters
	
	^ Distance withAmount: 100 andUnit: centimeter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:45:19'!
oneMeter
	
	^ Distance withAmount: 1 andUnit: meter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:45:43'!
twoHundredCentimeters
	
	^ Distance withAmount: 200 andUnit: centimeter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:45:53'!
twoMeters
	
	^ Distance withAmount: 2 andUnit: meter.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'ad 6/1/2017 23:46:02'!
zeroMeters
	
	^ Distance withAmount: 0 andUnit: meter.! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'interval distanceUnit from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'private' stamp: 'ad 6/1/2017 23:35:59'!
from: startDistance to: stopDistance

	from _ startDistance.
	to _ stopDistance.
	by _ Distance withAmount: 1 andUnit: startDistance unit.
	
	interval _ Interval from: startDistance amount to: stopDistance amount.
	
	distanceUnit _ startDistance unit.! !

!DistanceInterval methodsFor: 'private' stamp: 'ad 6/1/2017 23:38:46'!
from: startDistance to: stopDistance by: aStepDistance

	from _ startDistance.
	to _ stopDistance.
	by _ aStepDistance.
			
	interval := Interval from: startDistance amount to: stopDistance amount by: aStepDistance amount.
	
	distanceUnit := startDistance unit.
	
	! !


!DistanceInterval methodsFor: 'accessing' stamp: 'ad 6/1/2017 23:37:14'!
at: anIndex
	
	^ Distance withAmount: (interval at: anIndex) andUnit: distanceUnit ! !


!DistanceInterval methodsFor: 'enumerating' stamp: 'ad 6/1/2017 23:40:04'!
do: aBlockClosure

	1 to: (interval size) do: [ :i |
		aBlockClosure value: (Distance withAmount: (interval at: i) andUnit: distanceUnit ) ]
	
	! !


!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:16:38'!
by
	
	^ by! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:15:00'!
from
	
	^ from! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:19:44'!
size

	^ interval size
! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:16:25'!
to
	
	^ to! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'initialization' stamp: 'dim 5/28/2017 21:37:59'!
from: aDistance to: anotherDistance

	^ self new from: aDistance to: anotherDistance.! !

!DistanceInterval class methodsFor: 'initialization' stamp: 'ad 5/30/2017 17:25:13'!
from: initialDistance to: stopDistance by: aStepDistance
			
	self isValidIntervalFrom: initialDistance to: stopDistance by: aStepDistance.

	^ self new from: initialDistance to: stopDistance by: aStepDistance.! !

!DistanceInterval class methodsFor: 'initialization' stamp: 'ad 5/30/2017 16:26:52'!
wrongCreationParametersErrorText

	^'The parameters provided do not induce an interval'.! !


!DistanceInterval class methodsFor: 'validation' stamp: 'ad 6/2/2017 00:05:10'!
isValidIntervalFrom: initialDistance to: stopDistance by: step

 ^ 	( (initialDistance > stopDistance and: [step amount >= 0] ) 
		or: 
	  (initialDistance < stopDistance and: [step amount <= 0] ) ) 
			ifTrue: [self error: DistanceInterval wrongCreationParametersErrorText].! !
