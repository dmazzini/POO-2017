!classDefinition: #DistanciaTest category: #Distancia!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros medioMetro unMetroYMedio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancia'!

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:13:26'!
test01UnMetroEqualsUnMetro

	self assert: unMetro = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:13:21'!
test02UnMetroIsNotTheSameThanDosMetros

	self deny: unMetro = dosMetros.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 21:51:34'!
test03AMetroWithNegativeQuantityShouldRaiseAnError

	self should: [Metros quantity: -1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Metros negativeDistanceErrorText]! !

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

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:41:49'!
test08UnMetroMultipliedByANegativeNumberRaisesError

	self should: [unMetro * -1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Metros negativeMultiplicationOrDivisionErrorText]! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:57:17'!
test09DosMetrosMinusUnMetroEqualsUnMetro
	
	self assert: dosMetros - unMetro = unMetro.! !

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/22/2017 15:53:15'!
test10UnMetroMinusUnMetroEqualsCeroMetros
	
	self assert: unMetro - unMetro = ceroMetros.! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 5/22/2017 15:55:00'!
setUp

	ceroMetros := Metros quantity: 0.
	medioMetro := Metros quantity: 1/2.
	unMetro := Metros quantity: 1.
	unMetroYMedio := Metros quantity: 3/2.
	dosMetros := Metros quantity: 2.
	tresMetros := Metros quantity: 3.
	cuatroMetros := Metros quantity: 4.
	cincoMetros := Metros quantity: 5.! !


!classDefinition: #Metros category: #Distancia!
Object subclass: #Metros
	instanceVariableNames: 'quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancia'!

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

!Metros methodsFor: 'arithmetic' stamp: 'ad 5/20/2017 21:32:45'!
= otraDistanciaEnMetros

	^ self quantity = otraDistanciaEnMetros quantity.


	! !


!Metros methodsFor: 'private' stamp: 'ad 5/20/2017 21:34:36'!
quantity: aQuantityOfMetros

	quantity := aQuantityOfMetros! !


!Metros methodsFor: 'accessing' stamp: 'ad 5/20/2017 21:32:32'!
quantity
	
	^ quantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metros class' category: #Distancia!
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
