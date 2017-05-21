!classDefinition: #DistanciaTest category: #Distancia!
TestCase subclass: #DistanciaTest
	instanceVariableNames: 'ceroMetros unMetro dosMetros tresMetros cuatroMetros cincoMetros'
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

!DistanciaTest methodsFor: 'tests' stamp: 'ad 5/20/2017 22:14:20'!
test05UnMetrosPlusDosMetrosEqualsTresMetros
	
	self assert: unMetro + dosMetros = tresMetros.! !


!DistanciaTest methodsFor: 'Set Up' stamp: 'ad 5/20/2017 22:11:27'!
setUp

	ceroMetros := Metros quantity: 0.
	unMetro := Metros quantity: 1.
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

!Metros methodsFor: 'as yet unclassified' stamp: 'ad 5/20/2017 22:08:46'!
+ aDistanceInMetros 

	^ Metros quantity: self quantity + aDistanceInMetros quantity! !

!Metros methodsFor: 'as yet unclassified' stamp: 'ad 5/20/2017 21:32:45'!
= otraDistanciaEnMetros

	^ self quantity = otraDistanciaEnMetros quantity.


	! !

!Metros methodsFor: 'as yet unclassified' stamp: 'ad 5/20/2017 21:32:32'!
quantity
	
	^ quantity! !


!Metros methodsFor: 'private' stamp: 'ad 5/20/2017 21:34:36'!
quantity: aQuantityOfMetros

	quantity := aQuantityOfMetros! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Metros class' category: #Distancia!
Metros class
	instanceVariableNames: ''!

!Metros class methodsFor: 'private' stamp: 'ad 5/20/2017 22:04:48'!
quantity: aQuantityOfMetros

	aQuantityOfMetros >= 0 ifFalse: [self error: self negativeDistanceErrorText].

	^ self new quantity: aQuantityOfMetros! !


!Metros class methodsFor: 'error messages' stamp: 'ad 5/20/2017 21:42:57'!
negativeDistanceErrorText

	^ 'No existen distancias negativas'! !
