!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros cienMilCentimetros unMilimetro tresCentimetros cincoMilimetros'
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


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 5/26/2017 16:43:14'!
setUp

	ceroMetros := Metros quantity: 0.
	medioMetro := Metros quantity: 1/2.
	unMetro := Metros quantity: 1.
	unMetroYMedio := Metros quantity: 3/2.
	dosMetros := Metros quantity: 2.
	tresMetros := Metros quantity: 3.
	cuatroMetros := Metros quantity: 4.
	cincoMetros := Metros quantity: 5.
	milMetros := Metros quantity: 1000.
	
	unCentimetro := Centimetros quantity: 1.
	tresCentimetros := Centimetros quantity: 3.
	cienCentimetros := Centimetros quantity: 100.
	doscientosCentimetros := Centimetros quantity: 200.	
	cienMilCentimetros := Centimetros quantity: 100000.
	
	unKilometro := Kilometros quantity: 1.
	dosKilometros := Kilometros quantity: 2.

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


!Distancia methodsFor: 'converting' stamp: 'dim 5/26/2017 00:02:42'!
convertTo: aDistanceClass

	^aDistanceClass quantity:((self quantity * (self class factorDeConversionAMetros)) / aDistanceClass factorDeConversionAMetros).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Distance-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 13:00:08'!
factorDeConversionAMetros

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

!Centimetros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:57:54'!
factorDeConversionAMetros

	^ 1/100.
	
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

!Decimetros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:58:24'!
factorDeConversionAMetros 

	^ 1/10.
	

	
	
	! !


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

!Hectometros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:58:48'!
factorDeConversionAMetros 

	^ 100.
	! !


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

!Kilometros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:59:04'!
factorDeConversionAMetros 

	^ 1000.
	! !


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

!Metros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:59:27'!
factorDeConversionAMetros 

	^ 1.! !


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

!Milimetros class methodsFor: 'convertion' stamp: 'DIM 5/26/2017 12:59:42'!
factorDeConversionAMetros 

	^ 1/1000.
	! !
