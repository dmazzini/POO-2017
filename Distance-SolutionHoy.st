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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'AD 6/1/2017 20:18:49'!
withName: aName andConvertionFactorToMeter: aConvertionNumber

	^ self new initializeWithName: aName andConvertionFactorToMeter: aConvertionNumber.! !


!classDefinition: #Distancia category: #'Distance-Solution'!
Magnitude subclass: #Distancia
	instanceVariableNames: 'quantity amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:28'!
* aNumber

	^ self performArithmeticOperation: #* withNumber: aNumber

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:05:41'!
+ aDistance

	^ self performArithmeticOperation: #+ with: aDistance
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:07:42'!
- aDistance

	^ self performArithmeticOperation: #- with: aDistance
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:48'!
/  aNumber

	^ self performArithmeticOperation: #/ withNumber: aNumber

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:02:58'!
//  aNumber

	^ self performArithmeticOperation: #// withNumber: aNumber

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:18'!
< aDistance

	^ self performComparisonOperation: #< with: aDistance 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'DIM 6/1/2017 10:07:44'!
= aDistance

	(aDistance isKindOf: self class superclass) ifFalse:[^ false].

	^ self performComparisonOperation: #= with: aDistance 
	
! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:20:54'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Distancia methodsFor: 'arithmetic' stamp: 'AD 6/1/2017 20:47:13'!
negated

	 ^ Distancia withAmount: (self amount * -1) andUnit: unit.! !

!Distancia methodsFor: 'arithmetic' stamp: 'AD 6/1/2017 20:58:06'!
performArithmeticOperation: aSelector with: aDistance

	^ Distancia withAmount: (self amount perform: aSelector with: (aDistance convertTo: self unit) amount) 
					andUnit: unit. 
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'AD 6/1/2017 20:56:17'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ Distancia withAmount: (self amount perform: aSelector with: aNumber) 
					andUnit: unit. 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'AD 6/1/2017 20:58:36'!
performComparisonOperation: aSelector with: aDistance

	^ self amount perform: aSelector with: (aDistance convertTo: self unit) amount
	

	! !


!Distancia methodsFor: 'private' stamp: 'dim 5/26/2017 00:24:43'!
quantity: aQuantity

	quantity := aQuantity 

	! !


!Distancia methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:42'!
amount
	
	^ amount

	! !

!Distancia methodsFor: 'accessing' stamp: 'dim 5/26/2017 00:24:15'!
quantity
	
	^ quantity

	! !

!Distancia methodsFor: 'accessing' stamp: 'AD 6/1/2017 20:41:49'!
unit

	^ unit.! !


!Distancia methodsFor: 'converting' stamp: 'AD 6/1/2017 20:44:53'!
convertTo: aDistanceUnit

	^ Distancia 
		withAmount: (self amount * self unit convertionFactorToMetres / aDistanceUnit convertionFactorToMetres ) 
		andUnit: aDistanceUnit.! !


!Distancia methodsFor: 'printing' stamp: 'AD 6/1/2017 21:01:01'!
printString
	
	^String streamContents: 
        [:stream | 
            stream 
                 nextPutAll: (quantity printString); 
                 nextPutAll: ' '; 
                 "nextPutAll: (self class printString)."
			 nextPut: self unit name.
			 (quantity > 1) ifTrue: [ stream nextPutAll: 's'] 
	  ].
			 ! !


!Distancia methodsFor: 'interval' stamp: 'AD 6/1/2017 21:03:44'!
to: aDistance 

	^ IntervaloDeDistancia 
		from: self 
		to: (aDistance convertTo: self unit).! !

!Distancia methodsFor: 'interval' stamp: 'AD 6/1/2017 21:04:06'!
to: aDistance by: stepDistance
	 
	^ IntervaloDeDistancia 
		from: self 
		to: (aDistance convertTo: self unit) 
		by: (stepDistance convertTo: self unit)! !

!Distancia methodsFor: 'interval' stamp: 'ad 5/30/2017 17:16:57'!
to: aDistance by: stepDistance do: aBlockClosure
	
	(self to: aDistance by: stepDistance )
			do: aBlockClosure .! !

!Distancia methodsFor: 'interval' stamp: 'ad 5/30/2017 17:17:01'!
to: aDistance do: aBlockClosure

	 (self to: aDistance )
			do: aBlockClosure .! !


!Distancia methodsFor: 'binding' stamp: 'AD 6/1/2017 20:08:48'!
hash

	^ (self convertTo: Metros) quantity hash.  
! !


!Distancia methodsFor: 'as yet unclassified' stamp: 'AD 6/1/2017 20:41:08'!
initializeWithAmount: anAmount andUnit: aDistanceUnit

	amount _ anAmount.
	
	unit _ aDistanceUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Distance-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:06:13'!
convertionFactorToMetres

	self subclassResponsibility.! !


!Distancia class methodsFor: 'initialization' stamp: 'DIM 5/26/2017 13:01:24'!
quantity: aQuantity

	^ self new quantity: aQuantity.! !

!Distancia class methodsFor: 'initialization' stamp: 'AD 6/1/2017 20:40:21'!
withAmount: anAmount andUnit: aDistanceUnit

	^ self new initializeWithAmount: anAmount andUnit: aDistanceUnit.! !


!classDefinition: #Centimetros category: #'Distance-Solution'!
Distancia subclass: #Centimetros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimetros class' category: #'Distance-Solution'!
Centimetros class
	instanceVariableNames: ''!

!Centimetros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:06:58'!
convertionFactorToMetres

	^ 1/100.
	
	! !


!Centimetros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:57:40'!
printString

	^ 'centimeter'! !


!classDefinition: #Decametros category: #'Distance-Solution'!
Distancia subclass: #Decametros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Decametros class' category: #'Distance-Solution'!
Decametros class
	instanceVariableNames: ''!

!Decametros class methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 09:40:14'!
convertionFactorToMetres 

	^ 10.
	

	! !

!Decametros class methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 09:59:14'!
printString

	^ 'decameter'	

	! !


!classDefinition: #Decimetros category: #'Distance-Solution'!
Distancia subclass: #Decimetros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Decimetros class' category: #'Distance-Solution'!
Decimetros class
	instanceVariableNames: ''!

!Decimetros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:07:30'!
convertionFactorToMetres 

	^ 1/10.
	

	
	
	! !


!Decimetros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:57:53'!
printString

	^ 'decimeter'! !


!classDefinition: #Hectometros category: #'Distance-Solution'!
Distancia subclass: #Hectometros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hectometros class' category: #'Distance-Solution'!
Hectometros class
	instanceVariableNames: ''!

!Hectometros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:07:44'!
convertionFactorToMetres 

	^ 100.
	! !


!Hectometros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:59:30'!
printString

	^ 'hectometer'! !


!classDefinition: #Kilometros category: #'Distance-Solution'!
Distancia subclass: #Kilometros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Kilometros class' category: #'Distance-Solution'!
Kilometros class
	instanceVariableNames: ''!

!Kilometros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:08:02'!
convertionFactorToMetres 

	^ 1000.
	! !


!Kilometros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:59:42'!
printString

	^ 'kilometer'! !


!classDefinition: #Metros category: #'Distance-Solution'!
Distancia subclass: #Metros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metros class' category: #'Distance-Solution'!
Metros class
	instanceVariableNames: ''!

!Metros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:08:11'!
convertionFactorToMetres 

	^ 1.! !


!Metros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:57:10'!
printString

	^ 'meter'! !


!classDefinition: #Milimetros category: #'Distance-Solution'!
Distancia subclass: #Milimetros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Milimetros class' category: #'Distance-Solution'!
Milimetros class
	instanceVariableNames: ''!

!Milimetros class methodsFor: 'convertion' stamp: 'DIM 5/30/2017 14:08:21'!
convertionFactorToMetres 

	^ 1/1000.
	! !


!Milimetros class methodsFor: 'printing' stamp: 'DIM 6/1/2017 09:58:07'!
printString

	^ 'milimeter'! !


!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros cienMilCentimetros unMilimetro tresCentimetros cincoMilimetros diezKilometros cincoCentimetros anIntervalOfDistances seisMetros unMetroNegativo'
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

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:14:38'!
test42TheElementsOfAnIntervaloDeDistanciaFromUnMetroToTresMetrosSumSeisMetros

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ Metros quantity: 0.
	
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

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:15:07'!
test44TheElementsOfAnIntervaloDeDistanciaFromUnMetroToTresMetrosByMedioMetroSumDiezMetros

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ Metros quantity: 0.
	
	unMetro to: tresMetros by: medioMetro do: [:aDistance | 
		sumOfIntervalDistances _ aDistance + sumOfIntervalDistances ].	
	
	self assert:  sumOfIntervalDistances = (Metros quantity: 10).! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:04:47'!
test45CreatingAnIntervaloDeDistanciaWithAStepOfZeroMetrosShouldRaiseError

	self 
		should: [ unMetro to: tresMetros by: ceroMetros] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: IntervaloDeDistancia wrongCreationParametersErrorText]
		
! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:16:06'!
test46CreatingAnIncreasingIntervaloDeDistanciaWithNegativeStepShouldRaiseError

	self 
		should: [ unMetro to: unKilometro by: unMetroNegativo] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: IntervaloDeDistancia wrongCreationParametersErrorText]
		
! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/30/2017 17:05:57'!
test47CreatingADecreasingIntervaloDeDistanciaWithPositiveStepShouldRaiseError

	self 
		should: [ tresMetros to: unMetro by: cincoMilimetros ] 
		raise:  Error		
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: IntervaloDeDistancia wrongCreationParametersErrorText]
		
! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 5/30/2017 16:53:55'!
setUp

	unMetroNegativo := Metros quantity: -1.
	ceroMetros := Metros quantity: 0.
	medioMetro := Metros quantity: 1/2.
	unMetro := Metros quantity: 1.
	unMetroYMedio := Metros quantity: 3/2.
	dosMetros := Metros quantity: 2.
	tresMetros := Metros quantity: 3.
	cuatroMetros := Metros quantity: 4.
	cincoMetros := Metros quantity: 5.
	seisMetros := Metros quantity: 6.
	milMetros := Metros quantity: 1000.
	
	unCentimetro := Centimetros quantity: 1.
	tresCentimetros := Centimetros quantity: 3.
	cincoCentimetros := Centimetros quantity: 5.
	
	cienCentimetros := Centimetros quantity: 100.
	doscientosCentimetros := Centimetros quantity: 200.	
	cienMilCentimetros := Centimetros quantity: 100000.
	
	unKilometro := Kilometros quantity: 1.
	dosKilometros := Kilometros quantity: 2.
	diezKilometros := Kilometros quantity: 10.

	unMilimetro := Milimetros quantity: 1.	
	cincoMilimetros := Milimetros quantity: 5.	
	diezMilimetros := Milimetros quantity: 10.	
	milMilimetros := Milimetros quantity: 1000.
	dosMilMilimetros := Milimetros quantity: 2000.
	unMillonDeMilimetros := Milimetros quantity: 1000000.	! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:37:52'!
minusOneMeter
	
	^ Metros quantity: -1.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:39:29'!
oneCentimeter
	
	^ Centimetros quantity: 1.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:39:42'!
oneHundredCentimeters
	
	^ Centimetros quantity: 100.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:40:00'!
oneMeter
	
	^ Metros quantity: 1.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:40:21'!
twoHundredCentimeters
	
	^ Centimetros quantity: 200.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:40:36'!
twoMeters
	
	^ Metros quantity: 2.! !

!DistanceFactory methodsFor: 'distance instances' stamp: 'DIM 5/26/2017 10:40:46'!
zeroMeters
	
	^ Metros quantity: 0.! !


!classDefinition: #IntervaloDeDistancia category: #'Distance-Solution'!
Object subclass: #IntervaloDeDistancia
	instanceVariableNames: 'interval distanceUnit from to by'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!IntervaloDeDistancia methodsFor: 'private' stamp: 'DIM 6/1/2017 10:22:49'!
from: startDistance to: stopDistance

	from _ startDistance.
	to _ stopDistance.
	by _ startDistance class quantity:1.
	
	interval _ Interval from: startDistance quantity to: stopDistance quantity.
	
	distanceUnit _ startDistance class.! !

!IntervaloDeDistancia methodsFor: 'private' stamp: 'DIM 6/1/2017 10:17:56'!
from: startDistance to: stopDistance by: aStepDistance

	from _ startDistance.
	to _ stopDistance.
	by _ aStepDistance.
			
	interval := Interval from: startDistance quantity to: stopDistance quantity by: aStepDistance quantity.
	
	distanceUnit := startDistance class.
	
	! !


!IntervaloDeDistancia methodsFor: 'accessing' stamp: 'ad 5/29/2017 11:45:23'!
at: anIndex
	
	^ distanceUnit quantity: (interval at: anIndex)! !


!IntervaloDeDistancia methodsFor: 'enumerating' stamp: 'ad 5/30/2017 17:17:26'!
do: aBlockClosure

	1 to: (interval size) do: [ :i |
		aBlockClosure value: (distanceUnit quantity: (interval at: i)) ]	
	
	! !


!IntervaloDeDistancia methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:16:38'!
by
	
	^ by! !

!IntervaloDeDistancia methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:15:00'!
from
	
	^ from! !

!IntervaloDeDistancia methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:19:44'!
size

	^ interval size
! !

!IntervaloDeDistancia methodsFor: 'as yet unclassified' stamp: 'DIM 6/1/2017 10:16:25'!
to
	
	^ to! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntervaloDeDistancia class' category: #'Distance-Solution'!
IntervaloDeDistancia class
	instanceVariableNames: ''!

!IntervaloDeDistancia class methodsFor: 'initialization' stamp: 'dim 5/28/2017 21:37:59'!
from: aDistance to: anotherDistance

	^ self new from: aDistance to: anotherDistance.! !

!IntervaloDeDistancia class methodsFor: 'initialization' stamp: 'ad 5/30/2017 17:25:13'!
from: initialDistance to: stopDistance by: aStepDistance
			
	self isValidIntervalFrom: initialDistance to: stopDistance by: aStepDistance.

	^ self new from: initialDistance to: stopDistance by: aStepDistance.! !

!IntervaloDeDistancia class methodsFor: 'initialization' stamp: 'ad 5/30/2017 16:26:52'!
wrongCreationParametersErrorText

	^'The parameters provided do not induce an interval'.! !


!IntervaloDeDistancia class methodsFor: 'validation' stamp: 'ad 5/30/2017 17:30:21'!
isValidIntervalFrom: initialDistance to: stopDistance by: step

 ^ 	( (initialDistance > stopDistance and: [step quantity >= 0] ) 
		or: 
	  (initialDistance < stopDistance and: [step quantity <= 0] ) ) 
			ifTrue: [self error: IntervaloDeDistancia wrongCreationParametersErrorText].! !
