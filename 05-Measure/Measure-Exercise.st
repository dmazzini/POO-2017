!classDefinition: #MeasureTest category: #'Measure-Exercise'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Exercise'!

!MeasureTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/25/2011 16:05'!
test01ObjectsRepresentingSameMeasureShouldBeEqual

	self assert: self oneMeter = self oneMeter.
	self assert: self oneSecond = self oneSecond.
	self assert: self oneCelsius = self oneCelsius.
	

! !

!MeasureTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/25/2011 16:06'!
test02DifferentMeasuresShouldNotBeEqual

	self deny: self oneMeter = self twoMeters.
	self deny: self oneSecond = self sixtySeconds.
	self deny: self oneCelsius = self zeroCelsius.
! !

!MeasureTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/25/2011 16:07'!
test03SameMeasureExpressWithDifferentUnitsShouldBeEqual

	self assert: self oneMeter = self oneHundredCentimeters.
	self assert: self twoMeters = self twoHundredCentimeters.
	self assert: self oneMinute = self sixtySeconds.
	self assert: self zeroCelsius = self thirtyTwoFahrenheits.
! !

!MeasureTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/25/2011 16:08'!
test03aMeasuresOfDifferentDomainShouldNotBeEqual

	self deny: self oneMeter = self oneSecond.
	self deny: self oneMeter = self oneCelsius.
	self deny: self oneCelsius = self oneSecond
! !

!MeasureTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/25/2011 16:09'!
test04EqualsShouldBeCommutative

	self assert: (self oneMeter = self oneHundredCentimeters and: [ self oneHundredCentimeters = self oneMeter ]).
	self assert: (self twoMeters = self twoHundredCentimeters and:  [ self twoHundredCentimeters = self twoMeters ]).
	self assert: (self oneMinute = self sixtySeconds and: [self sixtySeconds = self oneMinute]).
	self assert: (self zeroCelsius = self thirtyTwoFahrenheits and: [ self thirtyTwoFahrenheits = self zeroCelsius]).
! !


!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:11'!
test05UnitStringRepresentationShouldBeHumanReadable

	self assert: self meter printString = 'meter'.
	self assert: self centimeter printString = 'centimeter'.
	self assert: self decimeter printString = 'decimeter'.
	self assert: self millimeter printString = 'milimeter'.
	self assert: self decameter printString = 'decameter'.
	self assert: self hectometer printString = 'hectometer'.
	self assert: self kilometer printString = 'kilometer'.	
	
	self assert: self celsius printString = 'celsius'.	
	self assert: self fahrenheit printString = 'fahrenheit'.	

	self assert: self day printString = 'day'.	
	self assert: self hour printString = 'hour'.	
	self assert: self minute printString = 'minute'.	
	self assert: self second printString = 'second'.	

! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:13'!
test06MeasureStringRepresentationShouldBeHumanReadable

	self assert: self oneMeter printString = '1 meter'.
	self assert: self twoMeters printString = '2 meters'.
	self assert: self oneHundredCentimeters printString = '100 centimeters'.
	
	self assert: self oneMinute printString = '1 minute'.
	self assert: self sixtySeconds printString = '60 seconds'.
	
	self assert: self zeroCelsius printString = '0 celcius'.
	self assert: self thirtyTwoFahrenheits printString = '32 fahrenheits'.
	
	
! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:14'!
test07aMeasureAmountShouldBeTheExpectedAmount

	self assert: self oneMeter amount = 1.
	self assert: self twoMeters amount = 2.
	self assert: self oneHundredCentimeters amount = 100.
	self assert: self twoHundredCentimeters amount = 200.

	self assert: self oneMinute amount = 1.
	self assert: self sixtySeconds amount = 60.
	
	self assert: self zeroCelsius amount = 0.
	self assert: self thirtyTwoFahrenheits amount = 32.
! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:15'!
test07bMeasureUnitShouldBeTheExpectedUnit

	self assert: self oneMeter unit = self meter.
	self assert: self twoMeters unit = self meter.
	self assert: self oneHundredCentimeters unit = self centimeter.
	self assert: self twoHundredCentimeters unit = self centimeter.
	
	self assert: self oneMinute unit = self minute.
	self assert: self sixtySeconds unit = self second.
	
	self assert: self zeroCelsius unit = self celsius.
	self assert: self thirtyTwoFahrenheits unit = self fahrenheit
! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HAW 4/19/2017 17:00:00'!
test07cDifferentMeasureUnitsShouldBeDifferent

	| units unitsSet |
	
	units := self distanceUnits.
	unitsSet := units asSet.
	
	self assert: units size equals: unitsSet size.
	self assert: (unitsSet includesAll: units).! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:03'!
test07dDistancesCanBeConvertedToDifferentUnits

	"A partir de los test de igualdad, se deben haber dado cuenta que debemos poder
	convertir distancias a distintas unidades... y que ademas dos distancias de distintas unidades
	pueden ser iguales... Por lo tanto ¿por qué no hacer esta caracteristica de las distancias explicita?
	Veran que luego se torna muy util
	
	Respecto de como esta escrito el test, para no tener que escribir los assert para oneMeter y oneHundredCentimeters 
	creo un array y lo recorro... ¿Se podria escribir menos aun en este test?
	
	Y por qué se asserta sobre el amount y luego la unidad y no directametne sobre la distancia completa. ej:
	self assert: (aDistance converTo: self meter) = self oneMeter
	"
	
	(Array with: self oneMeter with: self oneHundredCentimeters) do: [ :aDistance |
		self assert: (aDistance convertTo: self meter) amount = 1.
		self assert: (aDistance convertTo: self meter) unit = self meter.
		
		self assert: (aDistance convertTo: self decimeter) amount = 10.
		self assert: (aDistance convertTo: self decimeter) unit = self decimeter.
		
		self assert: (aDistance convertTo: self centimeter) amount = 100.
		self assert: (aDistance convertTo: self centimeter) unit = self centimeter.
		
		self assert: (aDistance convertTo: self millimeter) amount = 1000.
		self assert: (aDistance convertTo: self millimeter) unit = self millimeter.
	
		self assert: (aDistance convertTo: self decameter) amount = (1/10).
		self assert: (aDistance convertTo: self decameter) unit = self decameter.
		
		self assert: (aDistance convertTo: self hectometer) amount = (1/100).
		self assert: (aDistance convertTo: self hectometer) unit = self hectometer.
	
		self assert: (aDistance convertTo: self kilometer) amount = (1/1000).
		self assert: (aDistance convertTo: self kilometer) unit = self kilometer ]! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:17'!
test07eTimeMeasuresCanBeConvertedToDifferentUnits

	self assert: (self oneMinute convertTo: self second) = self sixtySeconds.
	self assert: (self sixtySeconds convertTo: self minute) = self oneMinute.

	self assert: (self oneHour convertTo: self minute) = self sixtyMinutes.
	self assert: (self sixtyMinutes convertTo: self hour) = self oneHour.

	self assert: (self oneDay convertTo: self hour) = self twentyFourHours.
	self assert: (self twentyFourHours convertTo: self day) = self oneDay.

! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:17'!
test07fTemperatureMeasuresCanBeConvertedToDifferentUnits

	self assert: (self zeroCelsius convertTo: self fahrenheit) = self thirtyTwoFahrenheits.
	self assert: (self thirtyTwoFahrenheits convertTo: self celsius) = self zeroCelsius.

! !

!MeasureTest methodsFor: '2 - Converting/accessing/printing' stamp: 'HernanWilkinson 4/25/2011 16:19'!
test07gMeasuresCanNotBeConvertedToUnitsOfDifferentDomain

	self should: [ self oneMeter convertTo: self second ] raise: self canNotConvertMeasurementException.
	self should: [ self oneSecond convertTo: self celsius ] raise: self canNotConvertMeasurementException.
	self should: [ self oneCelsius convertTo: self centimeter ] raise: self canNotConvertMeasurementException.


! !


!MeasureTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/25/2011 16:20'!
test08aComparingMeasuresWithOtherObjectsShouldReturnFalse

	"El igual no debe generar ningun tipo de error por mas que se comparen objetos
	de distintos tipos
	Fijense como se crea una instancia de Object sin ningun tipo de problema... ¿qué representa?"

	self deny: self oneMeter = Object new.
	self deny: Object new = self oneMeter! !

!MeasureTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/25/2011 16:21'!
test08bMeasuresThatAreEqualShouldReturnTheSameHash

	"Debido a como funcionan los diccionarios, cuando dos objetos son iguales deben
	tener es mismo hash. La inversa no es verdad"
	
	self assert: self oneMeter hash=self oneMeter hash.
	self assert: self oneMeter hash=self oneHundredCentimeters hash.
	self assert: self oneMinute hash = self sixtySeconds hash.
	self assert: self zeroCelsius hash = self thirtyTwoFahrenheits hash.
	
	
! !

!MeasureTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/25/2011 16:21'!
test08cCopiesOfTheSameMeasureShouldBeEqual

	"Dos objetos que ocupan distintas posiciones de memoria pero representan
	la misma entidad de la realidad, deben devolver true cuando se los compara por igual, puesto
	que representan la misma entidad de la realidad.
	Por lo tanto, el mensaje #= significa '¿representan el mismo ente de la realidad?'
	mientras que el mensaje #== significa ¿ocupan la misma posicion de memoria?"

	| originalOneMeter copiedOneMeter |

	"Al objeto oneMeter lo copio para asegurarme de tener uno oneMeter en otra posicion de memoria"

	originalOneMeter := self oneMeter.
	copiedOneMeter := originalOneMeter copy.

	"Me aseguro que ocupen distinta posicion de memoria"
	self deny: originalOneMeter == copiedOneMeter.

	"Ahora me aseguro que sean iguales"
	self assert: originalOneMeter = copiedOneMeter! !


!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:31'!
test09AddingMeasuresOfSameUnitShouldReturnAMeasureRepresentingTheAddingMeasures

	self assert: (self oneMeter + self oneMeter) = self twoMeters.
	self assert: (self oneSecond + self oneSecond) = self twoSeconds.
	self assert: (self oneCelsius + self oneCelsius) = self twoCelsius.
	

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:32'!
test10AddingMeasuresOfDifferentUnitShouldReturnAMeasureRepresentingTheAddingMeasures

	self assert: (self oneMeter + self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneMeter + self oneHundredCentimeters) = self twoHundredCentimeters.
	self assert: (self oneSecond + self oneMinute) = self sixtyOneSeconds.

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:48'!
test10aCanNotAddMeasuresOfDifferentDomain

	self should: [ self oneMeter + self oneSecond ] raise: self canNotConvertMeasurementException 

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:32'!
test11AddingMeasuresIsCommutative

	self assert: (self oneMeter + self twoMeters)=(self twoMeters + self oneMeter).
	self assert: (self oneSecond + self twoSeconds)=(self twoSeconds + self oneSecond).
	self assert: (self oneCelsius + self twoCelsius)=(self twoCelsius + self oneCelsius)
	


! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:33'!
test12AddingMeasuresIsAssociative

	self assert: 
		((self oneMeter + self oneMeter) + self twoMeters) = 
		(self oneMeter + (self oneMeter + self twoMeters)).

	self assert: 
		((self oneSecond + self oneSecond) + self twoSeconds) = 
		(self oneSecond + (self oneSecond + self twoSeconds)).

	self assert: 
		((self oneCelsius + self oneCelsius) + self twoCelsius) = 
		(self oneCelsius + (self oneCelsius + self twoCelsius)).

		

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:35'!
test12aAddingMeasuresKeepsMeasureImmutability

	| oneMeter oneSecond oneCelsius |
	
	oneMeter := self oneMeter.
	oneMeter + oneMeter.
	
	self assert: oneMeter = self oneMeter.
	
	oneSecond := self oneSecond.
	oneSecond + oneSecond.
	
	self assert: oneSecond = self oneSecond.
	
	oneCelsius := self oneCelsius.
	oneCelsius + oneCelsius.
	
	self assert: oneCelsius = self oneCelsius 



! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:36'!
test13aNegatingAMeasureNegatesItsAmount

	(Array with: self oneMeter with: self twoSeconds with: self thirtyTwoFahrenheits) do: [:aMeasure |
		self assert: aMeasure negated amount=aMeasure amount negated ]
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:36'!
test13bNegatingAMeasureIsReflective

	(Array with: self oneMeter with: self twoSeconds with: self thirtyTwoFahrenheits) do: [:aMeasure |
		self assert: aMeasure negated negated=aMeasure ].
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:37'!
test14SubtractingMeasuresOfSameUnitShouldReturnAMeasureRepresentingTheSubtractedMeasures

	self assert: (self twoMeters - self oneMeter) = self oneMeter.
	self assert: (self oneMeter - self oneMeter) = self zeroMeters.
	self assert: (self oneMeter - self twoMeters) = self oneMeter negated.
	
	self assert: (self twoSeconds - self oneSecond) = self oneSecond.
	self assert: (self oneSecond - self oneSecond) = self zeroSeconds.
	self assert: (self oneSecond - self twoSeconds) = self oneSecond negated.
	
	self assert: (self twoCelsius - self oneCelsius) = self oneCelsius.
	self assert: (self oneCelsius - self oneCelsius) = self zeroCelsius.
	self assert: (self oneCelsius - self twoCelsius) = self oneCelsius negated.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:38'!
test15SubtractingMeasuresOfDifferentUnitShouldReturnAMeasureRepresentingTheSubtractedMeasures

	self assert: (self twoMeters - self oneHundredCentimeters) = self oneMeter.
	self assert: (self oneMeter - self oneHundredCentimeters) = self zeroMeters.
	self assert: (self oneHundredCentimeters - self twoMeters) = self oneMeter negated.
	
	self assert: (self sixtyOneSeconds - self oneMinute) = self oneSecond.
	

	! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:48'!
test15aCanNotSubtractMeasuresOfDifferentDomain

	self should: [ self oneMeter - self oneSecond ] raise: self canNotConvertMeasurementException 

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:38'!
test16SubtractingMeasuresIsAssociative

	self assert: 
		((self twoMeters - self oneMeter) - self oneMeter) = 
		(self twoMeters - (self oneMeter + self oneMeter)).

	self assert: 
		((self twoSeconds - self oneSecond) - self oneSecond) = 
		(self twoSeconds - (self oneSecond + self oneSecond)).	

	

	! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:39'!
test16aSubtractingMeasuresKeepsMeasuresImmutability

	| oneMeter oneSecond oneCelsius |
	
	oneMeter := self oneMeter.
	oneMeter - oneMeter.
	
	self assert: oneMeter = self oneMeter.
	
	oneSecond := self oneSecond.
	oneSecond - oneSecond.
	
	self assert: oneSecond = self oneSecond.
	
	oneCelsius := self oneCelsius.
	oneCelsius - oneCelsius.
	
	self assert: oneCelsius = self oneCelsius 


! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:40'!
test17aMeasuresCanBeMultiplyByAnInteger

	self assert: self oneMeter * 1 = self oneMeter.
	self assert: self oneMeter * 2 = self twoMeters.
	self assert: self oneMeter * 0 = self zeroMeters.

	self assert: self oneSecond * 1 = self oneSecond.
	self assert: self oneSecond * 2 = self twoSeconds.
	self assert: self oneSecond * 0 = self zeroSeconds.

	self assert: self oneCelsius * 1 = self oneCelsius.
	self assert: self oneCelsius * 2 = self twoCelsius.
	self assert: self oneCelsius * 0 = self zeroCelsius.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:40'!
test17bMeasuresCanBeMultiplyByAFraction

	self assert: (self oneMeter * (2/3)) amount = (2/3).
	self assert: (self twoMeters * (2/3)) amount = (2 * (2/3)).

	self assert: (self oneSecond * (2/3)) amount = (2/3).
	self assert: (self twoSeconds * (2/3)) amount = (2 * (2/3)).

	self assert: (self oneCelsius * (2/3)) amount = (2/3).
	self assert: (self twoCelsius * (2/3)) amount = (2 * (2/3)).
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:41'!
test17cMeasuresCanBeMultiplyByAFloat

	self assert: (self oneMeter * 2.5) amount = 2.5.
	self assert: (self twoMeters * 2.5) amount = (2 * 2.5).

	self assert: (self oneSecond * 2.5) amount = 2.5.
	self assert: (self twoSeconds * 2.5) amount = (2 * 2.5).

	self assert: (self oneCelsius * 2.5) amount = 2.5.
	self assert: (self twoCelsius * 2.5) amount = (2 * 2.5).
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:45'!
test17dMeasuresCanBeMultiplyByAMeasureOfSameDomain

	self assert: (self oneMeter * self oneMeter) = self oneSquaredMeter.
	self assert: (self twoMeters * self twoMeters) = self fourSquaredMeters.
	self assert: (self twoMeters * self twoMeters * self twoMeters) = self eightCubicMeters.

	self assert: (self oneSecond * self oneSecond) = self oneSquaredSecond.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:53'!
test17eMeasuresCanBeMultiplyByAMeasureOfDifferentDomain

	self assert: (self oneMeter * self twoSeconds) = self twoMetersTimesSecond.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:42'!
test18MultiplicationKeepsMeasureImmutability

	| oneMeter oneSecond oneCelsius |
	
	oneMeter := self oneMeter.
	oneMeter * 2.
	
	self assert: oneMeter = self oneMeter.
	
	oneSecond := self oneSecond.
	oneSecond * 2.
	
	self assert: oneSecond = self oneSecond.
	
	oneCelsius := self oneCelsius.
	oneCelsius * 2.
	
	self assert: oneCelsius = self oneCelsius 




! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:49'!
test19aMeasuresCanBeDividedByAnInteger

	self assert: (self oneMeter / 1) = self oneMeter.
	self assert: (self twoMeters / 2) = self oneMeter.

	self assert: (self oneSecond / 1) = self oneSecond.
	self assert: (self twoSeconds / 2) = self oneSecond.

	self assert: (self oneCelsius / 1) = self oneCelsius.
	self assert: (self twoCelsius / 2) = self oneCelsius.

! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:50'!
test19bMeasuresCanBeDividedByAFraction

	self assert: (self twoMeters / (1/3)) amount = 6.
	self assert: (self twoSeconds / (1/3)) amount = 6.
	self assert: (self twoCelsius / (1/3)) amount = 6.




! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:50'!
test19cMeasuresCanBeDividedByAFloat

	self assert: (self twoMeters / 2.5) amount = (2/2.5).
	self assert: (self twoSeconds / 2.5) amount = (2/2.5).
	self assert: (self twoCelsius / 2.5) amount = (2/2.5).




! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:52'!
test19dMeasuresCanBeDividedByAMeasureOfSameDomain

	self assert: (self oneMeter / self oneMeter) = 1.
	self assert: (self twoMeters / self oneMeter) = 2.
		
	self assert: (self oneSecond / self oneSecond) = 1.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:52'!
test19eMeasuresCanBeDividedByAMeasureOfDifferentDomain

	self assert: (self oneMeter / self twoSeconds) = self twoMetersBySecond.
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 16:54'!
test20DivisionKeepsMeasureImmutability

	| oneMeter oneSecond oneCelsius |
	
	oneMeter := self oneMeter.
	oneMeter / 2.
	
	self assert: oneMeter = self oneMeter.
	
	oneSecond := self oneSecond.
	oneSecond / 2.
	
	self assert: oneSecond = self oneSecond.
	
	oneCelsius := self oneCelsius.
	oneCelsius / 2.
	
	self assert: oneCelsius = self oneCelsius 


! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'efo 5/2/2011 20:56'!
test20aFinalSpeedCanBeRepresentedWithMeasures

	self assert: 
		(self finalSpeedStartingAt: self oneMeterPerSecond accelerating: self twoMetersPerSquaredSecond during: self sixtySeconds) = 
		(self oneMeterPerSecond + (self twoMetersPerSquaredSecond * self sixtySeconds)).
		
	self assert: (self finalSpeedStartingAt: self oneMeterPerSecond accelerating: self twoMetersPerSquaredSecond during: self sixtySeconds) = self oneHundredTwentyOneMetersPerSecond 
	
! !

!MeasureTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/25/2011 17:00'!
test20bMultiplyingANumberByAUnitReturnsAMeasure

	self assert: (1*self meter) = self oneMeter.
	self assert: (2*self second) = self twoSeconds.
! !


!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:02'!
test21MeasuresProvideATotalOrder

	self assert: (self measureExamples allSatisfy: [ :aMeasure | aMeasure < (aMeasure + (1* aMeasure unit))])

! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:03'!
test22MeasuresCanBeComparedWithGreaterThan

	self assert: (self measureExamples allSatisfy: [ :aMeasure | (aMeasure + (1 * aMeasure unit)) > aMeasure ])
! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:04'!
test23MeasuresCanBeComparedWithLessThanOrEqual

	self assert: (self measureExamples allSatisfy: [ :aMeasure | aMeasure <= aMeasure and: [aMeasure <= (aMeasure + (1 * aMeasure unit))]])

	
! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:05'!
test24MeasuresCanBeComparedWithGreaterThanOrEqual

	self assert: (self measureExamples allSatisfy: [ :aMeasure | aMeasure >= aMeasure and: [(aMeasure + (1 * aMeasure unit)) >= aMeasure]])! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:05'!
test25MaxReturnsTheMaximumBetweenTwoMeasures

	self assert: (self twoMeters max: self oneMeter) = self twoMeters.
	self assert: (self oneMeter max: self twoMeters) = self twoMeters.

	self assert: (self twoMeters max: self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneHundredCentimeters max: self twoMeters) = self twoMeters.

	
! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:05'!
test26MinReturnsTheMinimumBetweenTwoMeasures

	self assert: (self twoMeters min: self oneMeter) = self oneMeter.
	self assert: (self oneMeter min: self twoMeters) = self oneMeter.

	self assert: (self twoMeters min: self oneHundredCentimeters) = self oneHundredCentimeters.
	self assert: (self oneHundredCentimeters min: self twoMeters) = self oneHundredCentimeters.

	
! !

!MeasureTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/25/2011 17:05'!
test27BetweenAndReturnsTrueIfAMeasureIsBetweenOtherTwoMeasures

	self assert: (self oneMeter between: self zeroMeters and: self twoMeters).
	self assert: (self oneHundredCentimeters between: self zeroMeters and: self twoMeters).
	
	self deny: (self twoMeters between: self zeroMeters and: self oneMeter).
	self deny: (self twoHundredCentimeters between: self zeroMeters and: self oneMeter).

! !


!MeasureTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/25/2011 17:09'!
test28IntervalOfMeasuresCanBeCreatedBecauseTheyDefineATotalOrder

	self assert: (self oneMeter to: self twoMeters) first=self oneMeter.
	self assert: (self oneMeter to: self twoMeters) last=self twoMeters.
	self assert: (self oneMeter to: self twoMeters) increment =self oneMeter.	

	self assert: (self oneHundredCentimeters to: self twoMeters) first=self oneMeter.
	self assert: (self oneHundredCentimeters to: self twoMeters) last=self twoMeters.
	self assert: (self oneHundredCentimeters to: self twoMeters) increment=self oneCentimeter.	
	! !

!MeasureTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/25/2011 17:16'!
test29MeasureIntervalStepCanBeAnyMeasure

	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) first=self zeroMeters.
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) last=(self twoMeters * 2).
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) increment=self twoMeters.

	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) first=(self twoMeters * 2).
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) last=self zeroMeters.
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) increment=self twoMeters negated

	! !

!MeasureTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/25/2011 17:17'!
test30MeasureIntervalSizeReturnsTheNumberOfMeasuresOfTheInterval

	self assert: (self zeroMeters to: (self twoMeters * 2) ) size =5.
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self oneMeter negated) size =5.
! !

!MeasureTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/25/2011 17:17'!
test31MeasureIntervalCanBeEnumeratedUsingDo

	| value |
	
	value := 1.
	(self oneMeter to: (self oneMeter * 10)) do: [ :aMeasure |
		self assert: aMeasure amount = value.
		value := value + 1 ].
	
	self assert: value = 11
! !

!MeasureTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/25/2011 17:18'!
test32MeasureIntervalCanBeEnumeratedWithSpecificStep

	| value initialDistance byDistance finalDistance |
	
	initialDistance := self oneMeter.
	byDistance := self twoMeters.
	finalDistance := initialDistance * 9.
	value := initialDistance amount.
		
	(initialDistance to: finalDistance by:  byDistance) do: [ :aMeasure |
		self assert: aMeasure amount = value.
		value := value + byDistance amount ].
	
	self assert:  value = (finalDistance amount + byDistance amount)
! !


!MeasureTest methodsFor: '7 - Polymorphic zero' stamp: 'HernanWilkinson 4/25/2011 17:20'!
test33NothingOnAnyDomainAreEquals

	self assert: self zeroMeters = self zeroSeconds.
	self assert: self zeroSeconds = self zeroKelvin.
	self assert: self zeroKelvin = self zeroMeters! !

!MeasureTest methodsFor: '7 - Polymorphic zero' stamp: 'HernanWilkinson 4/25/2011 17:42'!
test34ZeroCelsiusIsNotNothingOnTemperature

	self deny: self zeroCelsius = self zeroKelvin.
	self deny: self zeroSeconds = self zeroCelsius.
! !


!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
centimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia centimetro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
decameter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia decametro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
decimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia decimetro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 17:27'!
distanceUnits 

	^self objectsInCategoryOf: thisContext method selector.
	
! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
hectometer
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia hectometro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
kilometer
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia kilometro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
meter

	self error: 'Este metodo debe devolver el objeto que la unidad de distancia metro'! !

!MeasureTest methodsFor: 'distance units' stamp: 'HernanWilkinson 4/25/2011 16:03'!
millimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia millimetro'! !


!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 17:27'!
distanceExamples 

	^self objectsInCategoryOf: thisContext method selector.
	
! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
minusOneMeter 
	
	self error: 'Este metodo debe devolver un objeto que represente un metro'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
oneCentimeter
	
	self error: 'Este metodo debe devolver un objeto que represente un centimetro'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
oneHundredCentimeters
	
	self error: 'Este metodo debe devolver un objeto que represente cien centimetros'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
oneMeter
	
	self error: 'Este metodo debe devolver un objeto que represente un metro'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
twoHundredCentimeters
	
	self error: 'Este metodo debe devolver un objeto que represente doscientos centimetros'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
twoMeters
	
	self error: 'Este metodo debe devolver un objeto que represente dos metros'! !

!MeasureTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/25/2011 16:03'!
zeroMeters

	self error: 'Este metodo debe devolver un objeto que represente cero metros'! !


!MeasureTest methodsFor: 'temperature units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
celsius
	
	self error: 'Este metodo debe devolver un objeto que la unidad de temperatura Celsius'! !

!MeasureTest methodsFor: 'temperature units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
fahrenheit
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad de temperatura Fahrenheit'! !

!MeasureTest methodsFor: 'temperature units' stamp: 'HernanWilkinson 4/25/2011 17:29'!
kelvin
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad de temperatura Kelvin'! !

!MeasureTest methodsFor: 'temperature units' stamp: 'HernanWilkinson 4/25/2011 17:28'!
temperatureUnits

	^self objectsInCategoryOf: thisContext method selector.
	
! !


!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
oneCelsius
	
	self error: 'Este metodo debe devolver un objeto que represente un grado centigrado'! !

!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:28'!
temperatureExamples

	^self objectsInCategoryOf: thisContext method selector.
	
! !

!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
thirtyTwoFahrenheits
	
	self error: 'Este metodo debe devolver un objeto que represente 32 fahrenhetis, o sea
	0 grados centigrados'! !

!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
twoCelsius
	
	self error: 'Este metodo debe devolver un objeto que represente dos grados centigrados'! !

!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
zeroCelsius
	
	self error: 'Este metodo debe devolver un objeto que represente cero grados centrigrados'! !

!MeasureTest methodsFor: 'temperature measures' stamp: 'HernanWilkinson 4/25/2011 17:31'!
zeroKelvin
	
	self error: 'Este metodo debe devolver un objeto que represente cero kelvin'! !


!MeasureTest methodsFor: 'time units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
day
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad dia'! !

!MeasureTest methodsFor: 'time units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
hour
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad hora'! !

!MeasureTest methodsFor: 'time units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
minute
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad minuto'! !

!MeasureTest methodsFor: 'time units' stamp: 'HernanWilkinson 4/25/2011 17:22'!
second
	
	self error: 'Este metodo debe devolver un objeto que represente la unidad segundo'! !

!MeasureTest methodsFor: 'time units' stamp: 'HernanWilkinson 4/29/2011 17:10'!
timeUnits

	^self objectsInCategoryOf: thisContext method selector.
	
 ! !


!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
oneDay
	
	self error: 'Este metodo debe devolver un objeto que represente un dia'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
oneHour
	
	self error: 'Este metodo debe devolver un objeto que represente una hora'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
oneMinute
	
	self error: 'Este metodo debe devolver un objeto que represente un minuto'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
oneSecond

	self error: 'Este metodo debe devolver un objeto que represente un segundo'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
sixtyMinutes
	
	self error: 'Este metodo debe devolver un objeto que represente sesenta minutos'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
sixtyOneSeconds
	
	self error: 'Este metodo debe devolver un objeto que represente sesenta y un segundos'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
sixtySeconds
	
	self error: 'Este metodo debe devolver un objeto que represente sesenta segundos'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:29'!
timeExamples

	^self objectsInCategoryOf: thisContext method selector.
	
! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
twentyFourHours
	
	self error: 'Este metodo debe devolver un objeto que represente veinticuatros horas'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
twoSeconds
	
	self error: 'Este metodo debe devolver un objeto que represente dos segundos'! !

!MeasureTest methodsFor: 'time measures' stamp: 'HernanWilkinson 4/25/2011 17:22'!
zeroSeconds
	
	self error: 'Este metodo debe devolver un objeto que represente cero segundos'! !


!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:35'!
eightCubicMeters

	^self error: 'este metodo debe devolver la medida 8 metros cubicos'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:40'!
finalSpeedStartingAt: initialSpeed accelerating: anAcceleration during: aTimePeriod

	^self error: 'Implementar la formula de velocidad final: vf = vi + a * t'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:35'!
fourSquaredMeters

	^self error: 'este metodo debe devolver la medida 4 metros cuadrados'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'efo 5/2/2011 20:56'!
oneHundredTwentyOneMetersPerSecond

	^self error: 'este metodo debe devolver la medida 121 metro/segundo'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:36'!
oneMeterPerSecond

	^self error: 'este metodo debe devolver la medida 1 metro/segundo'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:37'!
oneSquaredMeter

	^self error: 'este metodo debe devolver la medida 1 metro cuadrado'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:36'!
oneSquaredSecond

	^self error: 'este metodo debe devolver la medida 1 segundo cuadrado'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:35'!
twoMetersBySecond

	^self error: 'este metodo debe devolver la medida 2 metros/segundo'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:33'!
twoMetersPerSquaredSecond

	^self error: 'este metodo debe devolver la medida 2 metros/segundoAlCuadrado'! !

!MeasureTest methodsFor: 'compound measures' stamp: 'HernanWilkinson 4/25/2011 17:33'!
twoMetersTimesSecond

	^self error: 'este metodo debe devolver la medida 2 metros*segundo'! !


!MeasureTest methodsFor: 'objects in category' stamp: 'HernanWilkinson 4/25/2011 17:30'!
measureExamples 

	^ OrderedCollection new
		addAll: self distanceExamples;
		addAll: self temperatureExamples;
		addAll: self timeExamples;
		yourself ! !

!MeasureTest methodsFor: 'objects in category' stamp: 'HernanWilkinson 4/25/2011 17:27'!
objectsInCategoryOf: aSelector

	| category messageNames |
	
	category := self class organization categoryOfElement: aSelector.
	messageNames := (self class organization listAtCategoryNamed:  category) reject: [ :aMessageName | aMessageName = aSelector ].
	
	 ^ messageNames collect: [ :aMessageName | self perform: aMessageName ]
	

	
! !

!MeasureTest methodsFor: 'objects in category' stamp: 'HernanWilkinson 4/25/2011 17:34'!
units 

	^ OrderedCollection new
		addAll: self distanceUnits;
		addAll: self temperatureUnits;
		addAll: self timeUnits;
		yourself ! !


!MeasureTest methodsFor: 'errors' stamp: 'HernanWilkinson 4/25/2011 17:22'!
canNotConvertMeasurementException
	
	self error: 'Este metodo debe devolver el objeto que representa que no se pudo
		convertir una medida a la unidad pedida'! !
