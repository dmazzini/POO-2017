'From Cuis 5.0 of 7 November 2016 [latest update: #3076] on 6 May 2017 at 7:48:31 pm'!
'Description Please enter a description for this package'!
!provides: 'TDDExample' 1 0!
!classDefinition: #XXXTest category: #TDDExample!
TestCase subclass: #XXXTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'XXXTest class' category: #TDDExample!
XXXTest class
	instanceVariableNames: ''!

!classDefinition: #HolidayCalendar category: #TDDExample!
Object subclass: #HolidayCalendar
	instanceVariableNames: 'rules'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'HolidayCalendar class' category: #TDDExample!
HolidayCalendar class
	instanceVariableNames: ''!

!classDefinition: #HolidayRule category: #TDDExample!
Object subclass: #HolidayRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'HolidayRule class' category: #TDDExample!
HolidayRule class
	instanceVariableNames: ''!

!classDefinition: #CompoundHolidayRule category: #TDDExample!
HolidayRule subclass: #CompoundHolidayRule
	instanceVariableNames: 'holidayRule interval from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'CompoundHolidayRule class' category: #TDDExample!
CompoundHolidayRule class
	instanceVariableNames: ''!

!classDefinition: #DateHolidayRule category: #TDDExample!
HolidayRule subclass: #DateHolidayRule
	instanceVariableNames: 'date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'DateHolidayRule class' category: #TDDExample!
DateHolidayRule class
	instanceVariableNames: ''!

!classDefinition: #DayOfWeekHolidayRule category: #TDDExample!
HolidayRule subclass: #DayOfWeekHolidayRule
	instanceVariableNames: 'weekDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'DayOfWeekHolidayRule class' category: #TDDExample!
DayOfWeekHolidayRule class
	instanceVariableNames: ''!

!classDefinition: #MonthDayHolidayRule category: #TDDExample!
HolidayRule subclass: #MonthDayHolidayRule
	instanceVariableNames: 'monthDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'MonthDayHolidayRule class' category: #TDDExample!
MonthDayHolidayRule class
	instanceVariableNames: ''!

!classDefinition: #MonthDay category: #TDDExample!
Object subclass: #MonthDay
	instanceVariableNames: 'month day'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDExample'!
!classDefinition: 'MonthDay class' category: #TDDExample!
MonthDay class
	instanceVariableNames: ''!


!Object methodsFor: '*TDDExample' stamp: 'HAW 5/6/2017 19:46:05'!
toDo: aDescription! !

!Date methodsFor: '*TDDExample' stamp: 'HAW 5/4/2017 21:02:27'!
monthDay
	
	^MonthDay on: self monthName day: self dayOfMonth! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:43:53'!
test01OneDayOfWeekCanBeMarkAsHoliday

	| holidayCalendar aSunday |
	
	holidayCalendar := HolidayCalendar new.
	aSunday := Date year: 2017 month: 5 day: 7.
	holidayCalendar addHolidayRule: (DayOfWeekHolidayRule for: #Sunday).
	
	self assert: (holidayCalendar isHoliday: aSunday)! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 20:50:35'!
test02DayOfWeekCanNotBeHoliday

	| holidayCalendar aMonday |
	
	holidayCalendar := HolidayCalendar new.
	aMonday := Date year: 2017 month: 5 day: 8.
	
	self deny: (holidayCalendar isHoliday: aMonday)! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:44:10'!
test04MoreThanOneDayOfWeekCanBeMarkAsHoliday

	| holidayCalendar aSaturday aSunday|
	
	holidayCalendar := HolidayCalendar new.
	aSaturday := Date year: 2017 month: 5 day: 6.
	aSunday := Date year: 2017 month: 5 day: 7.
	holidayCalendar addHolidayRule: (DayOfWeekHolidayRule for: #Saturday).
	holidayCalendar addHolidayRule: (DayOfWeekHolidayRule for: #Sunday).
	
	self assert: (holidayCalendar isHoliday: aSaturday).
	self assert: (holidayCalendar isHoliday: aSunday).! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:44:31'!
test05

	| holidayCalendar aNavidad |
	
	holidayCalendar := HolidayCalendar new.
	aNavidad := MonthDay on:#December day: 25.
	holidayCalendar addHolidayRule: (MonthDayHolidayRule for: aNavidad).
	
	self assert: (holidayCalendar isHoliday: 
		(Date year: 2017 month: 12 day: 25)).
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:44:46'!
test06

	| holidayCalendar aNavidad aJanuaryFirst |
	
	holidayCalendar := HolidayCalendar new.
	aNavidad := MonthDay on:#December day: 25.
	aJanuaryFirst := MonthDay on:#January day: 1.
	holidayCalendar addHolidayRule: (MonthDayHolidayRule for: aNavidad).
	holidayCalendar addHolidayRule: (MonthDayHolidayRule for: aJanuaryFirst).
	
	self assert: (holidayCalendar isHoliday: 
		(Date year: 2017 month: 12 day: 25)).
	self assert: (holidayCalendar isHoliday: 
		(Date year: 2017 month: 1 day: 1)).
! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/5/2017 15:37:47'!
test07

	| holidayCalendar aDate |
	
	holidayCalendar := HolidayCalendar new.
	aDate := Date year: 2017 month: 12 day: 26.
	holidayCalendar addHolidayRule: (DateHolidayRule for: aDate).
	
	self assert: (holidayCalendar isHoliday: 
		(Date year: 2017 month: 12 day: 26)).
	! !

!XXXTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/5/2017 15:30:38'!
test08

	| holidayCalendar  |
	
	holidayCalendar := HolidayCalendar new.
	holidayCalendar addHolidayRule: (CompoundHolidayRule for: (DayOfWeekHolidayRule for: #Monday)  
		from: (Date year: 1990 month: 1 day: 1)
		to: (Date year: 1999 month: 12 day: 31)).
	
	self assert: (holidayCalendar isHoliday: (Date year: 1990 month: 1 day: 8)).
	! !

!HolidayCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:42:59'!
addHolidayRule: aRule
	
	rules add: aRule! !

!HolidayCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:42:03'!
initialize

	rules := OrderedCollection new.
	! !

!HolidayCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:42:14'!
isHoliday: aDate 
	
	^rules anySatisfy: [ :aRule | aRule isHoliday: aDate ]! !

!HolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:45:50'!
isHoliday: aDate

	self subclassResponsibility ! !

!CompoundHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/5/2017 15:33:56'!
initializeFor: aHolidayRule from: aFrom to: aTo

	holidayRule := aHolidayRule.
	from := aFrom.
	to := aTo! !

!CompoundHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2017 19:47:59'!
isHoliday: aDate 
	
	"esto lo hice sin tdd y la verdad es bastante feo debido a las limitaciones de Date en su protocolo.
	Se puede ver que lo hice sin tdd porque resolvi la inclusion de la fecha con un solo test...
	Tambien faltaria hacer paso 3, o sea reificar toda la verificacion de inclusion de fecha.
	Por otro lado esa verificacion de inclusion se puede mejorar si se usa una Duration  - Hernan"
	
	^ ((from<aDate or: [ from=aDate]) and: [ aDate < to or: [aDate=to]]) and: [ holidayRule isHoliday: aDate ]
	! !

!CompoundHolidayRule class methodsFor: 'as yet unclassified' stamp: 'HAW 5/5/2017 15:31:26'!
for: aHolidayRule from: aFrom to: aTo

	self toDo: 'verificar que aFrom <= aTo'.
	
	^self new initializeFor: aHolidayRule from: aFrom to: aTo
! !

!DateHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:41:32'!
initializeFor: aDate 
	
	date := aDate! !

!DateHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:41:48'!
isHoliday: aDate 
	
	^date = aDate! !

!DateHolidayRule class methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:41:22'!
for: aDate 
	
	^self new initializeFor: aDate! !

!DayOfWeekHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:34:10'!
initializeFor: aWeekDay

	weekDay := aWeekDay ! !

!DayOfWeekHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:36:18'!
isHoliday: aDate 
	
	^weekDay = aDate dayOfWeekName ! !

!DayOfWeekHolidayRule class methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:33:56'!
for: aWeekDay

	^self new initializeFor: aWeekDay! !

!MonthDayHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:39:37'!
initializeFor: aMonthDay 
	
	monthDay := aMonthDay ! !

!MonthDayHolidayRule methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:40:02'!
isHoliday: aDate 
	
	^aDate monthDay = monthDay ! !

!MonthDayHolidayRule class methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:39:26'!
for: aMonthDay 
	
	^self new initializeFor: aMonthDay! !

!MonthDay methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:04:50'!
= anObject

	^(anObject isKindOf: self class) 
		and: [ month = anObject month 
		and: [ day = anObject day ]]! !

!MonthDay methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:05:22'!
day
	
	^day! !

!MonthDay methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 20:58:38'!
initializeOn: aMonth day: aDay

	month := aMonth.
	day := aDay ! !

!MonthDay methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 21:05:11'!
month
	
	^month ! !

!MonthDay class methodsFor: 'as yet unclassified' stamp: 'HAW 5/4/2017 20:58:19'!
on: aMonth day: aDay

	self toDo: 'escribir las asseciones'.
	^self new initializeOn: aMonth day: aDay
	
	! !
