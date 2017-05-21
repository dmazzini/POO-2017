'From Cuis 5.0 of 7 November 2016 [latest update: #3076] on 17 May 2017 at 11:25:57 am'!
'Description Please enter a description for this package'!
!provides: 'RomanNumbers' 1 0!
!classDefinition: #RomanNumberTest category: #RomanNumbers!
TestCase subclass: #RomanNumberTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RomanNumbers'!
!classDefinition: 'RomanNumberTest class' category: #RomanNumbers!
RomanNumberTest class
	instanceVariableNames: ''!

!classDefinition: #DigitToRomanStringConverter category: #RomanNumbers!
Object subclass: #DigitToRomanStringConverter
	instanceVariableNames: 'divisor one five ten'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RomanNumbers'!
!classDefinition: 'DigitToRomanStringConverter class' category: #RomanNumbers!
DigitToRomanStringConverter class
	instanceVariableNames: ''!

!classDefinition: #IntegerToRomanStringConverter category: #RomanNumbers!
Object subclass: #IntegerToRomanStringConverter
	instanceVariableNames: 'numberToConvert'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RomanNumbers'!
!classDefinition: 'IntegerToRomanStringConverter class' category: #RomanNumbers!
IntegerToRomanStringConverter class
	instanceVariableNames: 'digitConverters'!


!Integer methodsFor: '*RomanNumbers' stamp: 'HAW 5/17/2017 11:02:46'!
asRomanString
	
	^IntegerToRomanStringConverter valueFor: self
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:02:52'!
test01OneAsARomanNumberIsI

	self assert: 1 asRomanString equals: 'I'! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:06:12'!
test02TwoAsRomanNumberIsII

	self assert: 2 asRomanString equals: 'II'! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 19:31:58'!
test03

	self assert: 3 asRomanString equals: 'III'! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 19:46:54'!
test04

	self assert: 4 asRomanString equals: 'IV'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 19:53:44'!
test05

	self assert: 5 asRomanString equals: 'V'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 19:56:59'!
test06

	self assert: 6 asRomanString equals: 'VI'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 19:59:36'!
test07

	self assert: 7 asRomanString equals: 'VII'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:08:02'!
test08

	self assert: 8 asRomanString equals: 'VIII'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:37:12'!
test09

	self assert: 9 asRomanString equals: 'IX'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:39:39'!
test10

	self assert: 10 asRomanString equals: 'X'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 20:53:15'!
test11

	self assert: 11 asRomanString equals: 'XI'.
	self assert: 12 asRomanString equals: 'XII'.
	self assert: 13 asRomanString equals: 'XIII'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:04:24'!
test12

	self assert: 14 asRomanString equals: 'XIV'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:07:45'!
test13

	self assert: 15 asRomanString equals: 'XV'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:11:39'!
test14From16to18ConvertsToRomanCorrectly

	self assert: 16 asRomanString equals: 'XVI'.
	self assert: 17 asRomanString equals: 'XVII'.
	self assert: 18 asRomanString equals: 'XVIII'.! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:37:16'!
test15
	self assert: 19 asRomanString equals: 'XIX'.
		! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:39:46'!
test16
	self assert: 20 asRomanString equals: 'XX'.
	self assert: 21 asRomanString equals: 'XXI'.
	self assert: 24 asRomanString equals: 'XXIV'.
	self assert: 29 asRomanString equals: 'XXIX'.
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:41:11'!
test17
	self assert: 30 asRomanString equals: 'XXX'.
	self assert: 31 asRomanString equals: 'XXXI'.
	self assert: 34 asRomanString equals: 'XXXIV'.
	self assert: 39 asRomanString equals: 'XXXIX'.
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:44:14'!
test18
	self assert: 40 asRomanString equals: 'XL'.
	self assert: 41 asRomanString equals: 'XLI'.
	self assert: 44 asRomanString equals: 'XLIV'.
	self assert: 49 asRomanString equals: 'XLIX'.
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:46:24'!
test19
	self assert: 50 asRomanString equals: 'L'.
	self assert: 61 asRomanString equals: 'LXI'.
	self assert: 74 asRomanString equals: 'LXXIV'.
	self assert: 89 asRomanString equals: 'LXXXIX'.
	self assert: 99 asRomanString equals: 'XCIX'.
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/16/2017 21:53:35'!
test20
	self assert: 100 asRomanString equals: 'C'.
	self assert: 344 asRomanString equals: 'CCCXLIV'.
	self assert: 455 asRomanString equals: 'CDLV'.
	self assert: 666 asRomanString equals: 'DCLXVI'.
	self assert: 999 asRomanString equals: 'CMXCIX'.
	! !

!RomanNumberTest methodsFor: 'testing' stamp: 'HAW 5/17/2017 11:23:09'!
test21CanNotConvertIntegersLessThanOne

	self
		should: [ 0 asRomanString ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: IntegerToRomanStringConverter canNotConvertNumberErrorMessage]! !

!DigitToRomanStringConverter methodsFor: 'evaluating - private' stamp: 'HAW 5/17/2017 11:18:43'!
convert4On: aStream
	
	aStream 
		nextPut: one; 
		nextPut: five! !

!DigitToRomanStringConverter methodsFor: 'evaluating - private' stamp: 'HAW 5/17/2017 11:16:26'!
convert9On: aStream
	
	aStream 
		nextPut: one; 
		nextPut: ten! !

!DigitToRomanStringConverter methodsFor: 'evaluating' stamp: 'HAW 5/17/2017 11:19:11'!
convert: aNumberToConver on: aStream

	| digit |
	
	digit := aNumberToConver // divisor \\ 10.
	
	digit = 9 ifTrue: [^self convert9On: aStream ].
	digit >= 5 ifTrue: [^self convertFrom5To8: digit on: aStream ].
	digit = 4 ifTrue: [^self convert4On: aStream ].
	self convertFrom1To3: digit on: aStream
	! !

!DigitToRomanStringConverter methodsFor: 'evaluating - private' stamp: 'HAW 5/17/2017 11:19:33'!
convertFrom1To3: digit on: aStream
	
	self putOnes: digit on: aStream ! !

!DigitToRomanStringConverter methodsFor: 'evaluating - private' stamp: 'HAW 5/17/2017 11:20:46'!
convertFrom5To8: digit on: aStream
	
	aStream nextPut: five.
	self putOnes: digit - 5 on: aStream ! !

!DigitToRomanStringConverter methodsFor: 'initialization' stamp: 'HAW 5/17/2017 11:11:37'!
initializeDividingBy: aDivisor oneAs: oneChar fiveAs: fiveChar tenAs: tenChar

	divisor := aDivisor.
	one := oneChar.
	five := fiveChar.
	ten := tenChar! !

!DigitToRomanStringConverter methodsFor: 'evaluating - private' stamp: 'HAW 5/17/2017 11:18:15'!
putOnes: times on: aStream 

	times timesRepeat: [ aStream nextPut: one ]! !

!DigitToRomanStringConverter class methodsFor: 'instance creation' stamp: 'HAW 5/17/2017 11:10:50'!
dividingBy: aDivisor oneAs: one fiveAs: five tenAs: ten 
	
	^self new initializeDividingBy: aDivisor oneAs: one fiveAs: five tenAs: ten 
! !

!IntegerToRomanStringConverter methodsFor: 'digit converters' stamp: 'HAW 5/17/2017 11:06:40'!
digitConverters
	
	^self class digitConverters! !

!IntegerToRomanStringConverter methodsFor: 'initialization' stamp: 'HAW 5/17/2017 11:04:30'!
initializeFor: aNumberToConvert

	numberToConvert := aNumberToConvert ! !

!IntegerToRomanStringConverter methodsFor: 'evaluating' stamp: 'HAW 5/17/2017 11:06:19'!
value 
	
	^String streamContents: [ :stream | self digitConverters do: [:aDigitConverter | aDigitConverter convert: numberToConvert on: stream ]]! !

!IntegerToRomanStringConverter class methodsFor: 'assertions' stamp: 'HAW 5/17/2017 11:24:43'!
assertCanConvert: aNumberToConvert

	aNumberToConvert < 1 ifTrue: [ self error: self canNotConvertNumberErrorMessage ]! !

!IntegerToRomanStringConverter class methodsFor: 'assertions' stamp: 'HAW 5/17/2017 11:25:05'!
canNotConvertNumberErrorMessage
	
	^'Can not convert number to roman string'! !

!IntegerToRomanStringConverter class methodsFor: 'digit converters' stamp: 'HAW 5/17/2017 11:07:04'!
digitConverters
	
	^digitConverters! !

!IntegerToRomanStringConverter class methodsFor: 'instance creation' stamp: 'HAW 5/17/2017 11:23:51'!
for: aNumberToConvert

	self assertCanConvert: aNumberToConvert.
	
	^self new initializeFor: aNumberToConvert ! !

!IntegerToRomanStringConverter class methodsFor: 'initialization' stamp: 'HAW 5/17/2017 11:10:06'!
initialize

	super initialize.
	self initializeDigitConverters ! !

!IntegerToRomanStringConverter class methodsFor: 'digit converters' stamp: 'HAW 5/17/2017 11:09:31'!
initializeDigitConverters

	digitConverters := Array
		with: (DigitToRomanStringConverter dividingBy: 100 oneAs: $C fiveAs: $D tenAs: $M)
		with: (DigitToRomanStringConverter dividingBy: 10 oneAs: $X fiveAs: $L tenAs: $C)
		with: (DigitToRomanStringConverter dividingBy: 1 oneAs: $I fiveAs: $V tenAs: $X)
! !

!IntegerToRomanStringConverter class methodsFor: 'evaluating' stamp: 'HAW 5/17/2017 11:03:36'!
valueFor: aNumberToConvert

	^(self for: aNumberToConvert) value! !
IntegerToRomanStringConverter initialize!
