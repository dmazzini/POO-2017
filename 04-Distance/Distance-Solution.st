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


!classDefinition: #Distancia category: #'Distance-Solution'!
Object subclass: #Distancia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:54:31'!
* aNumber

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:53:07'!
+ aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:53:14'!
- aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:54:35'!
/ aNumber

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:56:00'!
// aNumber

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:06'!
< aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:09'!
<= aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:01'!
= aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:14'!
> aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:12'!
>= aDistance

	^ self subclassResponsibility 

	! !

!Distancia methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 20:55:53'!
adaptToNumber: aNumber andSend: aSymbol 

	^ self subclassResponsibility ! !


!Distancia methodsFor: 'private' stamp: 'dim 5/25/2017 20:52:35'!
quantity: aDistance

	^ self subclassResponsibility 

	! !


!Distancia methodsFor: 'accessing' stamp: 'dim 5/25/2017 20:52:46'!
quantity

	^ self subclassResponsibility 

	! !


!classDefinition: #Centimetros category: #'Distance-Solution'!
Distancia subclass: #Centimetros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimetros methodsFor: 'private' stamp: 'dim 5/25/2017 22:14:04'!
= aDistance
	
	^ aDistance equalsCentimetros: self.! !

!Centimetros methodsFor: 'private' stamp: 'dim 5/25/2017 22:15:57'!
equalsMetros: aDistanceInMetros
	
		^ self quantity = (aDistanceInMetros quantity *100).
! !

!Centimetros methodsFor: 'private' stamp: 'AD 5/23/2017 20:33:02'!
quantity: aQuantityOfCentimetros

	quantity := aQuantityOfCentimetros ! !


!Centimetros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:33:28'!
quantity
	
	^ quantity! !


!Centimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:19:55'!
equalsCentimetros: aCentimetros 
	
	^ quantity = aCentimetros quantity ! !

!Centimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:12:58'!
equalsKilometros: aKilometros

	^ self quantity = (aKilometros quantity * 100000)! !

!Centimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:14:07'!
equalsMilimetros: aMilimetros 
	
	^ aMilimetros equalsCentimetros: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimetros class' category: #'Distance-Solution'!
Centimetros class
	instanceVariableNames: ''!

!Centimetros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:32:18'!
quantity: aQuantityOfCentimetros

	^ self new quantity: aQuantityOfCentimetros ! !


!classDefinition: #Kilometros category: #'Distance-Solution'!
Distancia subclass: #Kilometros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Kilometros methodsFor: 'private' stamp: 'dim 5/25/2017 22:13:06'!
= aDistance
	
	^ aDistance equalsKilometros: self.! !

!Kilometros methodsFor: 'private' stamp: 'dim 5/25/2017 22:15:19'!
equalsMetros: aDistanceInMetros
	
		^ self quantity *1000 = aDistanceInMetros quantity.! !

!Kilometros methodsFor: 'private' stamp: 'AD 5/23/2017 20:47:31'!
quantity: aQuantityOfKilometros

	quantity := aQuantityOfKilometros ! !


!Kilometros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:47:47'!
quantity
	
	^ quantity ! !


!Kilometros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:16:55'!
equalsCentimetros: aCentimetros 
	
	^ aCentimetros equalsKilometros: self.! !

!Kilometros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:17:50'!
equalsKilometros: aKilometros 
	
	^ quantity = aKilometros quantity .! !

!Kilometros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:12:22'!
equalsMilimetros: aMilimetros 
	
	^ aMilimetros equalsKilometros: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Kilometros class' category: #'Distance-Solution'!
Kilometros class
	instanceVariableNames: ''!

!Kilometros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:47:04'!
quantity: aQuantityOfKilometros

	^ self new quantity: aQuantityOfKilometros .! !


!classDefinition: #Metros category: #'Distance-Solution'!
Distancia subclass: #Metros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:44:08'!
* aNumber
	^ self performArithmeticOperator: #* withNumber: aNumber .! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:26:52'!
+ aDistanceInMetros 
	
	^ self performArithmeticOperator: #+ with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:45:55'!
- aDistanceInMetros
	
	^ self performArithmeticOperator: #- with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:44:47'!
/ aNumber 

	^ self performArithmeticOperator: #/ withNumber: aNumber .! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:45:04'!
// aNumber

	^ self performArithmeticOperator: #// withNumber: aNumber .! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:34:30'!
< aDistanceInMetros 
		^ self performComparisonOperator: #< with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:23:50'!
<= aDistanceInMetros
	
	^ self performComparisonOperator: #<= with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:15:01'!
= aDistance
	
	^ aDistance equalsMetros: self.



	! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:24:21'!
> aDistanceInMetros
	
	^ self performComparisonOperator: #> with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:24:30'!
>= aDistanceInMetros
	
	^ self performComparisonOperator: #>= with: aDistanceInMetros.! !

!Metros methodsFor: 'arithmetic' stamp: 'AD 5/23/2017 19:30:36'!
adaptToNumber: aNumber andSend: aSymbol 
	
	^ self * aNumber.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:15:04'!
equalsCentimetros: aCentimetros 
	
	^ aCentimetros equalsMetros: self.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:15:08'!
equalsKilometros: aKilometros 
	
	^ aKilometros equalsMetros: self.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:23:19'!
equalsMilimetros: aMilimetros 
	
	^ aMilimetros equalsMetros: self.! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:22:18'!
performArithmeticOperator: aSelector with: aDistanceInMetros
	
	^ self class quantity: ( self quantity perform: aSelector with: aDistanceInMetros quantity ).! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:43:13'!
performArithmeticOperator: aSelector withNumber: aNumber
	
	^ self class quantity: ( self quantity perform: aSelector with: aNumber ).! !

!Metros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 21:21:51'!
performComparisonOperator: aSelector with: aDistanceInMetros
	
	^ self quantity perform: aSelector with: aDistanceInMetros quantity .! !


!Metros methodsFor: 'private' stamp: 'dim 5/25/2017 22:14:52'!
equalsMetros: aDistanceInMetros
	
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

!Metros class methodsFor: 'initialization' stamp: 'dim 5/25/2017 20:47:28'!
quantity: aQuantityOfMetros
	^ self new quantity: aQuantityOfMetros! !


!classDefinition: #Milimetros category: #'Distance-Solution'!
Distancia subclass: #Milimetros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Milimetros methodsFor: 'private' stamp: 'dim 5/25/2017 22:15:40'!
equalsCentimetros: aDistanceInCentimetros 
	^ self quantity = (aDistanceInCentimetros quantity *10)! !

!Milimetros methodsFor: 'private' stamp: 'dim 5/25/2017 22:15:34'!
equalsMetros: aDistanceInMetros
	
		^ self quantity = (aDistanceInMetros quantity *1000).! !

!Milimetros methodsFor: 'private' stamp: 'AD 5/23/2017 20:56:15'!
quantity: aQuantityOfMilimetros

	quantity := aQuantityOfMilimetros ! !


!Milimetros methodsFor: 'accessing' stamp: 'AD 5/23/2017 20:56:34'!
quantity
	
	^ quantity ! !


!Milimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:09:51'!
= aDistance 

	^aDistance equalsMilimetros: self.! !

!Milimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:14:34'!
equalsKilometros: aDistanceInKilometros 

	^ self quantity = (aDistanceInKilometros quantity * 1000000)! !

!Milimetros methodsFor: 'arithmetic' stamp: 'dim 5/25/2017 22:19:07'!
equalsMilimetros: aMilimetros 
	
	^ quantity = aMilimetros quantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Milimetros class' category: #'Distance-Solution'!
Milimetros class
	instanceVariableNames: ''!

!Milimetros class methodsFor: 'initialization' stamp: 'AD 5/23/2017 20:55:51'!
quantity: aQuantityOfMilimetros

	^ self new quantity: aQuantityOfMilimetros ! !
