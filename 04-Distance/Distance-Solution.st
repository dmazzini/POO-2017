!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros cienMilCentimetros unMilimetro tresCentimetros cincoMilimetros diezKilometros cincoCentimetros anIntervalOfDistances seisMetros'
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

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 23:55:51'!
test35UnMetroConvertToCienCentimetros

	self assert: (unMetro convertTo:Centimetros) = cienCentimetros.! !

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

!DistanciaTest methodsFor: 'tests' stamp: 'DIM 5/30/2017 14:09:09'!
test42

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ Metros quantity: 0.
	
	(unMetro to: tresMetros) do: [:aDistance | 
		sumOfIntervalDistances _ aDistance + sumOfIntervalDistances ].	
	
	self assert:  sumOfIntervalDistances = seisMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/29/2017 11:44:35'!
test43

	| amountOfElementsOverTresMetrosInInterval |
	
	amountOfElementsOverTresMetrosInInterval _ 0.
	
	(unMetro to: seisMetros) do: [:aDistance | 
		aDistance > tresMetros 
			ifTrue: [amountOfElementsOverTresMetrosInInterval _ amountOfElementsOverTresMetrosInInterval + 1] ].	
	
	self assert:  amountOfElementsOverTresMetrosInInterval = 3.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/29/2017 13:34:35'!
test44

	| sumOfIntervalDistances |
	
	sumOfIntervalDistances _ Metros quantity: 0.
	
	unMetro to: tresMetros by: medioMetro do: [:aDistance | 
		sumOfIntervalDistances _ aDistance + sumOfIntervalDistances ].	
	
	self assert:  sumOfIntervalDistances = (Metros quantity: 10).! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 5/29/2017 10:11:10'!
setUp

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

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:37:52'!
minusOneMeter
	
	^ Metros quantity: -1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:39:29'!
oneCentimeter
	
	^ Centimetros quantity: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:39:42'!
oneHundredCentimeters
	
	^ Centimetros quantity: 100.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:40:00'!
oneMeter
	
	^ Metros quantity: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:40:21'!
twoHundredCentimeters
	
	^ Centimetros quantity: 200.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:40:36'!
twoMeters
	
	^ Metros quantity: 2.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIM 5/26/2017 10:40:46'!
zeroMeters
	
	^ Metros quantity: 0.! !


!classDefinition: #Distancia category: #'Distance-Solution'!
Object subclass: #Distancia
	instanceVariableNames: 'quantity'
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

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:32'!
<= aDistance

	^ self performComparisonOperation: #<= with: aDistance 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:40'!
= aDistance

	^ self performComparisonOperation: #= with: aDistance 
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:49'!
> aDistance

	^ self performComparisonOperation: #> with: aDistance 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:16:59'!
>= aDistance

	^ self performComparisonOperation: #>= with: aDistance  
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:20:54'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:14:10'!
performArithmeticOperation: aSelector with: aDistance

	^ self class quantity: (self quantity perform: aSelector with: (aDistance convertTo: self class) quantity).  
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:01:36'!
performArithmeticOperation: aSelector withNumber: aNumber

	^ self class quantity: (self quantity perform: aSelector with: aNumber )

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'ad 5/26/2017 16:24:43'!
performComparisonOperation: aSelector with: aDistance

	^ self quantity perform: aSelector with: (aDistance convertTo: self class) quantity.  
	

	! !


!Distancia methodsFor: 'private' stamp: 'dim 5/26/2017 00:24:43'!
quantity: aQuantity

	quantity := aQuantity 

	! !


!Distancia methodsFor: 'accessing' stamp: 'dim 5/26/2017 00:24:15'!
quantity
	
	^ quantity

	! !


!Distancia methodsFor: 'converting' stamp: 'DIM 5/30/2017 14:08:42'!
convertTo: aDistanceClass

	^aDistanceClass quantity:((self quantity * (self class convertionFactorToMetres)) / aDistanceClass convertionFactorToMetres).! !


!Distancia methodsFor: 'as yet unclassified' stamp: 'ad 5/29/2017 11:03:08'!
to: aDistance 

	^ IntervaloDeDistancia 
		from: self 
		to: (aDistance convertTo: self class).! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'ad 5/29/2017 11:04:37'!
to: aDistance by: stepDistance
	
	^ IntervaloDeDistancia 
		from: self 
		to: (aDistance convertTo: self class) 
		by: (stepDistance convertTo: self class)! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'ad 5/29/2017 13:37:17'!
to: aDistance by: stepDistance do: aBlockClosure

	Transcript show: 'Distancia >> to:by:do:'; newLine.
	
	(self to: aDistance by: stepDistance )
			do: aBlockClosure .! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'ad 5/29/2017 13:37:37'!
to: aDistance do: aBlockClosure

	Transcript show: 'Distancia >> to:do:'; newLine.

	 (self to: aDistance )
			do: aBlockClosure .! !


!Distancia methodsFor: 'printing' stamp: 'ad 5/29/2017 12:52:57'!
printString
	
	^String streamContents: 
        [:stream | 
            stream 
                 nextPutAll: (quantity printString); 
                 nextPutAll: ' '; 
                 nextPutAll: (self class printString) ]. ! !

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


!Centimetros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:54:15'!
printString

	^ 'centimetros'! !


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


!Decimetros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:54:09'!
printString

	^ 'decimetros'! !


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


!Hectometros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:54:00'!
printString

	^ 'hectometros'! !


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


!Kilometros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:53:49'!
printString

	^ 'kilometros'! !


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


!Metros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:37:32'!
printString

	^ 'metros'! !


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


!Milimetros class methodsFor: 'printing' stamp: 'ad 5/29/2017 12:53:38'!
printString

	^ 'milimetros'! !


!classDefinition: #IntervaloDeDistancia category: #'Distance-Solution'!
Object subclass: #IntervaloDeDistancia
	instanceVariableNames: 'interval distanceUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!IntervaloDeDistancia methodsFor: 'private' stamp: 'ad 5/29/2017 11:45:51'!
from: startDistance to: stopDistance
	
	interval _ Interval from: startDistance quantity to: stopDistance quantity.
	
	distanceUnit _ startDistance class.! !

!IntervaloDeDistancia methodsFor: 'private' stamp: 'ad 5/29/2017 11:45:56'!
from: startDistance to: stopDistance by: aStepDistance
	
	interval := Interval from: startDistance quantity to: stopDistance quantity by: aStepDistance quantity.
	
	distanceUnit := startDistance class.
	
	! !


!IntervaloDeDistancia methodsFor: 'accessing' stamp: 'ad 5/29/2017 11:45:23'!
at: anIndex
	
	^ distanceUnit quantity: (interval at: anIndex)! !


!IntervaloDeDistancia methodsFor: 'enumerating' stamp: 'ad 5/29/2017 13:37:46'!
do: aBlockClosure

	Transcript show: 'IntrevaloDeDistancias  >> do:'; newLine.

	1 to: (interval size) do: [ :i |
		aBlockClosure value: (distanceUnit quantity: (interval at: i)) ]	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntervaloDeDistancia class' category: #'Distance-Solution'!
IntervaloDeDistancia class
	instanceVariableNames: ''!

!IntervaloDeDistancia class methodsFor: 'initialization' stamp: 'dim 5/28/2017 21:37:59'!
from: aDistance to: anotherDistance

	^ self new from: aDistance to: anotherDistance.! !

!IntervaloDeDistancia class methodsFor: 'initialization' stamp: 'dim 5/28/2017 21:37:46'!
from: aDistance to: anotherDistance by: aStepDistance 

	^ self new from: aDistance to: anotherDistance by: aStepDistance.! !
