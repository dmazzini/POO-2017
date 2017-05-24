!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio cienCentimetros doscientosCentimetros milMetros unKilometro dosKilometros milMilimetros dosMilMilimetros unCentimetro diezMilimetros unMillonDeMilimetros'
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

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:41:23'!
test23UnMetroEqualsCienCentimetros

	self assert: unMetro = cienCentimetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:43:22'!
test24UnMetroIsNotEqualThanDoscientosCentimetros

	self deny: unMetro = doscientosCentimetros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:46:07'!
test25MilMetrosEqualsUnKilometro

	self assert: milMetros = unKilometro! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:49:23'!
test26MilMetrosIsNotEqualThanDosKilometros

	self deny: milMetros = dosKilometros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:54:30'!
test27UnMetroEqualsMilMilimetros

	self assert: unMetro = milMilimetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 20:58:21'!
test28UnMetroIsNotEqualThanDosMilMilimetros

	self deny: unMetro = dosMilMilimetros .! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 21:31:25'!
test29UnCentimetroEqualsDiezMilimetros

	self assert: unCentimetro = diezMilimetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'AD 5/23/2017 21:38:13'!
test29UnKilometroEqualsUnMillonDeMilimetros

	self assert: unKilometro = unMillonDeMilimetros.! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'AD 5/23/2017 21:38:51'!
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
	
	unKilometro := Kilometros quantity: 1.
	dosKilometros := Kilometros quantity: 2.

	diezMilimetros := Milimetros quantity: 10.	
	milMilimetros := Milimetros quantity: 1000.
	dosMilMilimetros := Milimetros quantity: 2000.
	unMillonDeMilimetros := Milimetros quantity: 1000000.	! !


!classDefinition: #Centimetros category: #'Distance-Solution'!
Object subclass: #Centimetros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimetros methodsFor: 'private' stamp: 'AD 5/23/2017 21:33:54'!
= aDistance
	
	^ aDistance equalsCentimetro: self.! !

!Centimetros methodsFor: 'private' stamp: 'AD 5/23/2017 21:19:42'!
equalsMetro: aDistanceInMetros
	
		^ self quantity = (aDistanceInMetros quantity *100).
! !

!Centimetros methodsFor: 'private' stamp: 'AD 5/23/2017 20:33:02'!
quantity: aQuantityOfCentimetros

	quantity := aQuantityOfCentimetros ! !


!Centimetros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:33:28'!
quantity
	
	^ quantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimetros class' category: #'Distance-Solution'!
Centimetros class
	instanceVariableNames: ''!

!Centimetros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:32:18'!
quantity: aQuantityOfCentimetros

	^ self new quantity: aQuantityOfCentimetros ! !


!classDefinition: #Kilometros category: #'Distance-Solution'!
Object subclass: #Kilometros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Kilometros methodsFor: 'private' stamp: 'DIM 5/24/2017 09:49:32'!
= aDistance
	
	^ aDistance equalsKilometro: self.! !

!Kilometros methodsFor: 'private' stamp: 'AD 5/23/2017 21:20:59'!
equalsMetro: aDistanceInMetros
	
		^ self quantity *1000 = aDistanceInMetros quantity.! !

!Kilometros methodsFor: 'private' stamp: 'AD 5/23/2017 20:47:31'!
quantity: aQuantityOfKilometros

	quantity := aQuantityOfKilometros ! !


!Kilometros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:47:47'!
quantity
	
	^ quantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Kilometros class' category: #'Distance-Solution'!
Kilometros class
	instanceVariableNames: ''!

!Kilometros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:47:04'!
quantity: aQuantityOfKilometros

	^ self new quantity: aQuantityOfKilometros .! !


!classDefinition: #Metros category: #'Distance-Solution'!
Object subclass: #Metros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Metros methodsFor: 'arithmetic' stamp: 'ad 5/22/2017 15:39:24'!
* aNumber

	(aNumber >= 0) ifFalse: [self error: self class negativeMultiplicationOrDivisionErrorText ].

	^ Metros quantity: quantity * aNumber ! !

!Metros methodsFor: 'arithmetic' stamp: 'ad 5/20/2017 22:08:46'!
+ aDistanceInMetros 

	^ Metros quantity: self quantity + aDistanceInMetros quantity! !

!Metros methodsFor: 'arithmetic' stamp: 'ad 5/22/2017 15:47:27'!
- aDistanceInMetros

	^ Metros quantity: quantity - aDistanceInMetros quantity .! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:38:25'!
/ aNumber 
	
	^ Metros quantity: quantity / aNumber.! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 20:14:50'!
// aNumber
	
	^ Metros quantity: quantity // aNumber.! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:47:44'!
< aDistanceInMetros 
	
	^ quantity < aDistanceInMetros quantity .! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:52:16'!
<= aDistanceInMetros

	^ quantity <= aDistanceInMetros quantity .! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 21:25:27'!
= aDistance
	
	^ aDistance equalsMetro: self.



	! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:54:36'!
> aDistanceInMetros

	^ quantity > aDistanceInMetros quantity .! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:58:09'!
>= aDistanceInMetros

	^ quantity >= aDistanceInMetros quantity.! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:30:36'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !


!Metros methodsFor: 'private' stamp: 'AD 5/23/2017 21:15:22'!
equalsMetro: aDistanceInMetros
	
		^ self quantity = aDistanceInMetros quantity.! !

!Metros methodsFor: 'private' stamp: 'ad 5/20/2017 21:34:36'!
quantity: aQuantityOfMetros

	quantity := aQuantityOfMetros! !


!Metros methodsFor: 'accessing' stamp: 'ad 5/20/2017 21:32:32'!
quantity
	
	^ quantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metros class' category: #'Distance-Solution'!
Metros class
	instanceVariableNames: ''!

!Metros class methodsFor: 'initialization' stamp: 'ad 5/20/2017 22:04:48'!
quantity: aQuantityOfMetros

	aQuantityOfMetros >= 0 ifFalse: [self error: self negativeDistanceErrorText].

	^ self new quantity: aQuantityOfMetros! !


!Metros class methodsFor: 'error messages' stamp: 'ad 5/20/2017 21:42:57'!
negativeDistanceErrorText

	^ 'No existen distancias negativas'! !

!Metros class methodsFor: 'error messages' stamp: 'ad 5/22/2017 15:33:25'!
negativeMultiplicationOrDivisionErrorText
	
	^ 'No se puede multiplicar o dividir una distancia en metros por un valor negativo.'! !


!classDefinition: #Milimetros category: #'Distance-Solution'!
Object subclass: #Milimetros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Milimetros methodsFor: 'private' stamp: 'AD 5/23/2017 21:36:25'!
equalsCentimetro: aDistanceInCentimetros 
	^ self quantity = (aDistanceInCentimetros quantity *10)! !

!Milimetros methodsFor: 'private' stamp: 'DIM 5/24/2017 09:52:28'!
equalsKilometro: aDistanceInKilometros 
	^ self quantity = (aDistanceInKilometros quantity * 1000000)! !

!Milimetros methodsFor: 'private' stamp: 'AD 5/23/2017 21:21:40'!
equalsMetro: aDistanceInMetros
	
		^ self quantity = (aDistanceInMetros quantity *1000).! !

!Milimetros methodsFor: 'private' stamp: 'AD 5/23/2017 20:56:15'!
quantity: aQuantityOfMilimetros

	quantity := aQuantityOfMilimetros ! !


!Milimetros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:56:34'!
quantity
	
	^ quantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Milimetros class' category: #'Distance-Solution'!
Milimetros class
	instanceVariableNames: ''!

!Milimetros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:55:51'!
quantity: aQuantityOfMilimetros

	^ self new quantity: aQuantityOfMilimetros ! !
