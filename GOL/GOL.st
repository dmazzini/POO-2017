!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'tests' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/15/2017 15:39:07'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/15/2017 15:39:18'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/15/2017 15:39:40'!
test05DeadCellWithThreeAliveNeighResurrects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 13:51:22'!
test06GameCreatedWithCellsOutsideBoundariesShouldThrowAnError

	self 
		should: [ GameOfLife withLiveCells: { 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'No se puede comenzar el juego con celulas fuera del tablero.' ]! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 14:10:39'!
test07DeadCellWithLessThanThreeAliveNeighboursStaysDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 14:12:19'!
test08DeadCellWithMoreThanThreeAliveNeighboursStaysDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 0@0. 1@0. 1@2. } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 14:24:40'!
test09AccessingPositionOutsideBoundariesShouldThrowAnError

	| game |
	
	game := GameOfLife withLiveCells: { } withSize: 3@3.

	self 
		should: [ game isAliveAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'No hay celulas fuera del tablero.' ]! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 15:13:19'!
test10TwoCellsAtTheSamePositionAtGameCreationAreConsideredAsOne

	| game |
	
	game := GameOfLife withLiveCells: { 1@1. 1@1 } withSize: 3@3.

	^ self assert:  ( game countOfAliveCells ) = 1.! !

!GOLTest methodsFor: 'tests' stamp: 'ad 5/16/2017 15:33:34'!
test11NewGenerationDoesNotExpandOutsideOfBoundaries

	| game |
	
	game := GameOfLife withLiveCells: { 0@0. 1@0. 2@0 } withSize: 3@3.
	
	game nextGeneration.

	^ self assert:  ( game numberOfAliveNeighboursOf: 1@0) = 1.! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'private' stamp: 'dim 5/13/2017 19:42:09'!
initializeWith: aCollectionOfAliveCells withBoard: aBoard

	board := aBoard.
	aliveCells := aCollectionOfAliveCells.
	! !


!GameOfLife methodsFor: 'testing' stamp: 'ad 5/15/2017 15:59:29'!
cellsThatRevive

	^ self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ]! !

!GameOfLife methodsFor: 'testing' stamp: 'ad 5/15/2017 15:58:46'!
cellsThatSurvive

	^ aliveCells select: [ :aCell | self hasToSurvive: aCell ]! !

!GameOfLife methodsFor: 'testing' stamp: 'ad 5/16/2017 15:01:13'!
countOfAliveCells
	
	^ aliveCells size! !

!GameOfLife methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'testing' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'testing' stamp: 'ad 5/16/2017 14:32:01'!
isAliveAt: aCell

	(board containsPoint: aCell) ifFalse: [self error: 'No hay celulas fuera del tablero.'].

	^(aliveCells includes: aCell)! !

!GameOfLife methodsFor: 'testing' stamp: 'ad 5/15/2017 16:01:30'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not! !


!GameOfLife methodsFor: 'accessing' stamp: 'ad 5/16/2017 15:42:11'!
allCells
	
	| allCells |
	
	allCells _ OrderedCollection new.
	(board origin) x to: (board corner) x - 1 do: [ :x |
		(board origin) y to: (board corner) y - 1 do: [ :y |
			allCells add: x@y]].
	
	^ allCells ! !

!GameOfLife methodsFor: 'accessing' stamp: 'ad 5/15/2017 15:56:56'!
deadCells
	
	^ self allCells difference: aliveCells.! !

!GameOfLife methodsFor: 'accessing' stamp: 'ad 5/16/2017 15:34:55'!
numberOfAliveNeighboursOf: aCell

	self isAliveAt: aCell.

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'game functions' stamp: 'ad 5/15/2017 16:02:28'!
nextGeneration
	
	aliveCells := (self cellsThatSurvive ) union:
		(self cellsThatRevive)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'instance creation' stamp: 'ad 5/16/2017 15:02:59'!
withLiveCells: aCollectionOfAliveCells withSize: aPoint

	|aBoard|
	
	aBoard := Rectangle origin:0@0 corner:aPoint.
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | aBoard containsPoint: aCell ]) ifFalse: [ self error: 'No se puede comenzar el juego con celulas fuera del tablero.' ].
	
	^self new initializeWith: (aCollectionOfAliveCells asSet) withBoard: aBoard.! !
