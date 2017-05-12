!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:27:47'!
a_test03

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 0@0. 0@1 }.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:27:52'!
a_test04

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@1. 1@0. }.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 2@2) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:14:04'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 } withSize: 2@2.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:14:53'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:14:45'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:15:04'!
test04AliveCellWithMoreThanThreeTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 0@1. 1@2} withSize: 4@4..
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:26:50'!
test05DeadCellWithThreeAliveNeighResurects

	
	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0} withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 20:40:47'!
test06CreateCellOutsideBounds

	self should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4} withSize: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:anError| self assert: anError messageText equals:'celda fuera de rango']
	
	! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:20:52'!
deadCells
	|deadCells|
	deadCells := OrderedCollection new.
	
	(0 to: size x) do: [:x| (0 to: size y ) do: [:y| (aliveCells includes: x@y) not ifTrue:[deadCells add: x@y]]].
	
	^deadCells.! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:18:20'!
hasToResurrect: aCell
^(self numberOfAliveNeighboursOf: aCell) = 3.! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 19:56:21'!
hasToSurvive: aCell

	|numberOfAliveNeighbours|
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.

	^ numberOfAliveNeighbours= 2 or: [numberOfAliveNeighbours = 3 ]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/9/2017 20:53:16'!
initializeWith: aCollectionOfAliveCells 

	aliveCells := aCollectionOfAliveCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:21:44'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size:= aSize.
	 (aCollectionOfAliveCells allSatisfy:[:aCell | (aCell x between:0 and: (aSize x)) and:[aCell y between:0 and: (aSize y)]]) ifFalse:[ self error: 'celda fuera de rango'].	

	aliveCells := aCollectionOfAliveCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 21:04:26'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell]) union: (self deadCells select: [ :aDeadCell| self hasToResurrect:aDeadCell])
		! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'HAW 5/9/2017 20:52:29'!
withLiveCells: aCollectionOfAliveCells

	^self new initializeWith: aCollectionOfAliveCells ! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'dim 5/11/2017 20:30:50'!
withLiveCells: aCollectionOfAliveCells withSize: aSize

	^self new initializeWith: aCollectionOfAliveCells  withSize: aSize.! !
