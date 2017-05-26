!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros cienMilCentimetros unMilimetro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:13:26'!
test01UnMetroEqualsUnMetro

	self assert: unMetro = unMetro.! !

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

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:16:32'!
test31UnKilometroEqualsCienMilCentimetros
	self assert: unKilometro = cienMilCentimetros.
	self assert: cienMilCentimetros = unKilometro! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:17:25'!
test32UnKilometroEqualsUnKilometro
	self assert: unKilometro = unKilometro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:18:23'!
test33UnMilimetroEqualsUnMilimetro
	self assert: unMilimetro = unMilimetro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 22:19:39'!
test34UnCentimetroEqualsUnCentimetro
	self assert: unCentimetro = unCentimetro .! !

!DistanciaTest methodsFor: 'tests' stamp: 'dim 5/25/2017 23:55:51'!
test35UnMetroConvertToCienCentimetros

	self assert: (unMetro convertTo:Centimetros) = cienCentimetros.! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'dim 5/25/2017 22:18:42'!
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
	cienCentimetros := Centimetros quantity: 100.
	doscientosCentimetros := Centimetros quantity: 200.
	
	cienMilCentimetros := Centimetros quantity: 100000.
	
	unKilometro := Kilometros quantity: 1.
	dosKilometros := Kilometros quantity: 2.

	unMilimetro := Milimetros quantity: 1.	
	
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

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:16:23'!
* aNumber

	^ self class quantity: (self quantity * aNumber)

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:44:21'!
+ aDistance

	^ self class new quantity: (self quantity + (aDistance convertTo: self class) quantity).  
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:45:04'!
- aDistance

	^ self class new quantity: (self quantity - (aDistance convertTo: self class) quantity).  
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:17:22'!
/  aNumber

	^ self class quantity: (self quantity / aNumber) 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:45:26'!
< aDistance

	^ self quantity < (aDistance convertTo: self class) quantity.  
	

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:45:36'!
<= aDistance

	^ self quantity <= (aDistance convertTo: self class) quantity.  

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:45:46'!
= aDistance

	^ self quantity = (aDistance convertTo: self class) quantity.
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:43:43'!
> aDistance

	^ self quantity > (aDistance convertTo: self class) quantity.  

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:45:58'!
>= aDistance

	^ self quantity >= (aDistance convertTo: self class) quantity.  
	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/26/2017 00:20:54'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !


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


!classDefinition: #Centimetros category: #'Distance-Solution'!
Distancia subclass: #Centimetros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimetros class' category: #'Distance-Solution'!
Centimetros class
	instanceVariableNames: 'factorDeConversionAMetros'!

!Centimetros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:54'!
factorDeConversionAMetros

	^factorDeConversionAMetros.! !

!Centimetros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:47'!
quantity: aQuantityOfCentimetros

	factorDeConversionAMetros _ 1/100.
	
	^ self new quantity: aQuantityOfCentimetros ! !


!classDefinition: #Kilometros category: #'Distance-Solution'!
Distancia subclass: #Kilometros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Kilometros class' category: #'Distance-Solution'!
Kilometros class
	instanceVariableNames: 'factorDeConversionAMetros'!

!Kilometros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:32'!
factorDeConversionAMetros
	
	^factorDeConversionAMetros! !

!Kilometros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:36'!
quantity: aQuantityOfKilometros

	factorDeConversionAMetros _ 1000.
	
	^ self new quantity: aQuantityOfKilometros .! !


!classDefinition: #Metros category: #'Distance-Solution'!
Distancia subclass: #Metros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metros class' category: #'Distance-Solution'!
Metros class
	instanceVariableNames: 'factorDeConversionAMetros'!

!Metros class methodsFor: 'initialization' stamp: 'dim 5/25/2017 23:51:42'!
factorDeConversionAMetros

	^ factorDeConversionAMetros! !

!Metros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:21'!
quantity: aQuantityOfMetros

	factorDeConversionAMetros _ 1.
	
	^ self new quantity: aQuantityOfMetros! !


!classDefinition: #Milimetros category: #'Distance-Solution'!
Distancia subclass: #Milimetros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Milimetros class' category: #'Distance-Solution'!
Milimetros class
	instanceVariableNames: 'factorDeConversionAMetros'!

!Milimetros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:02'!
factorDeConversionAMetros

	^ factorDeConversionAMetros! !

!Milimetros class methodsFor: 'initialization' stamp: 'dim 5/26/2017 00:29:09'!
quantity: aQuantityOfMilimetros

	factorDeConversionAMetros _ 1/1000.
	
	^ self new quantity: aQuantityOfMilimetros ! !
