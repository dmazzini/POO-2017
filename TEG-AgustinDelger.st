!classDefinition: #TiradaDeDadosTEGTest category: #TEG!
TestCase subclass: #TiradaDeDadosTEGTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!TiradaDeDadosTEGTest methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 19:32:33'!
test01APlayerCanNotAttackOrDefendMoreThanThreeOrLessThanOneArmies

	| aTEGDiceThrower  |

	aTEGDiceThrower _ TEGDiceThrower new.
	
	
	self should: [aTEGDiceThrower throwForAttackerWith: 1 andDefenderWith: 4.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
							self assert: anError messageText equals: 'Invalid amount of armies.'].! !

!TiradaDeDadosTEGTest methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 20:34:57'!
test02AttackerWinsWhenBothPlayingWithOneDiceAndHeGetsAGreaterNumber

	|  aManualDice aTEGDiceThrower  result |
	
	aManualDice _ ManualDice forNumbers: {2. 1}.
	
	aTEGDiceThrower _ TEGDiceThrower newWithDice: aManualDice.	
	
	result _ aTEGDiceThrower throwForAttackerWith: 1 andDefenderWith: 1.
	
	self assert: (result at: 'attacker' ) equals: #(2).
	self assert: (result at: 'defender' ) equals: #(1).
	self assert: (result at: 'attackerLoses' ) equals: 0.
	self assert: (result at: 'defenderLoses' ) equals: 1.! !

!TiradaDeDadosTEGTest methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 20:35:02'!
test03DefenderWinsWhenBothPlayingWithOneDiceAndHeGetsAGreaterOrEqualNumber

	|  aManualDice aTEGDiceThrower  result |
	
	aManualDice _ ManualDice forNumbers: #(1 2).
	
	aTEGDiceThrower _ TEGDiceThrower newWithDice: aManualDice.	
	
	result _ aTEGDiceThrower throwForAttackerWith: 1 andDefenderWith: 1.
	
	self assert: (result at: 'attacker' ) equals: #(1).
	self assert: (result at: 'defender' ) equals: #(2).
	self assert: (result at: 'attackerLoses' ) equals: 1.
	self assert: (result at: 'defenderLoses' ) equals: 0.! !

!TiradaDeDadosTEGTest methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 20:51:12'!
test04AttackerLosesOneArmyWhenThrowingTwoDicesAndDefenderOneAndDefenderGetsAGreaterNumber

	|  aManualDice aTEGDiceThrower  result |
	
	aManualDice _ ManualDice forNumbers: #(1 1 2).
	
	aTEGDiceThrower _ TEGDiceThrower newWithDice: aManualDice.	
	
	result _ aTEGDiceThrower throwForAttackerWith: 2 andDefenderWith: 1.
	
	self assert: (result at: 'attacker' ) equals: #(1 1).
	self assert: (result at: 'defender' ) equals: #(2).
	self assert: (result at: 'attackerLoses' ) equals: 1.
	self assert: (result at: 'defenderLoses' ) equals: 0.! !

!TiradaDeDadosTEGTest methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 21:03:13'!
test05DefenderLosesOneArmyWhenAttackerThrowsTwoDicesAndDefenderOneAndAttackerGetsAGreaterNumber

	|  aManualDice aTEGDiceThrower  result |
	
	aManualDice _ ManualDice forNumbers: #(1 3 2).
	
	aTEGDiceThrower _ TEGDiceThrower newWithDice: aManualDice.	
	
	result _ aTEGDiceThrower throwForAttackerWith: 2 andDefenderWith: 1.
	
	self assert: (result at: 'attacker' ) equals: #(3 1).
	self assert: (result at: 'defender' ) equals: #(2).
	self assert: (result at: 'attackerLoses' ) equals: 0.
	self assert: (result at: 'defenderLoses' ) equals: 1.! !


!classDefinition: #Dice category: #TEG!
Object subclass: #Dice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!Dice methodsFor: 'throw' stamp: 'ad 7/18/2017 20:25:42'!
throw

	self subclassResponsibility.! !


!classDefinition: #ManualDice category: #TEG!
Dice subclass: #ManualDice
	instanceVariableNames: 'pos numbers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!ManualDice methodsFor: 'private' stamp: 'ad 7/18/2017 20:19:07'!
initializeWithNumbers: anArrayOfIntegers
	
	pos _ 1.
	numbers _ anArrayOfIntegers.! !


!ManualDice methodsFor: 'throw' stamp: 'ad 7/18/2017 20:46:50'!
throw

	|result|
	
	result _ numbers at: pos.
	
	pos _ pos \\ numbers size + 1.
	
	^ result.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualDice class' category: #TEG!
ManualDice class
	instanceVariableNames: ''!

!ManualDice class methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 20:00:25'!
forNumbers: anArrayOfIntegers 
	
	^self new initializeWithNumbers: anArrayOfIntegers.! !


!classDefinition: #RandomDice category: #TEG!
Dice subclass: #RandomDice
	instanceVariableNames: 'random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!RandomDice methodsFor: 'throw' stamp: 'ad 7/18/2017 20:28:32'!
throw

	^ random nextInteger: 6.
	! !


!RandomDice methodsFor: 'initialization' stamp: 'ad 7/18/2017 20:27:49'!
initialize

	random _ Random new.! !


!classDefinition: #TEGDiceThrower category: #TEG!
Object subclass: #TEGDiceThrower
	instanceVariableNames: 'dice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG'!

!TEGDiceThrower methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 21:02:27'!
checkAmountsFor: anAmountOfArmiesForAttacker and: anAmountOfArmiesForDefender

	((anAmountOfArmiesForAttacker between: 1 and: 3 ) and: (anAmountOfArmiesForDefender between: 1 and: 3 )) ifFalse: [	self error: 'Invalid amount of armies.'].

	! !

!TEGDiceThrower methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 21:23:35'!
showResult: aDicOfResults

	| resultMessage |
	
	resultMessage _ String streamContents: [:aStream | 
						aStream nextPutAll: 'Atacante: '.
								   "cr lo tengo".
						(aDicOfResults at: 'attacker') printOn: aStream.
						aStream nextPutAll: '   Defensor: '.
						(aDicOfResults at: 'defender') printOn: aStream.
						aStream nextPutAll: '   El atacante pierde ';
									nextPutAll: (aDicOfResults at: 'attackerLoses') asString;
									nextPutAll: ' ejercitos y el defensor pierde ';
									nextPutAll: (aDicOfResults at: 'defenderLoses') asString;
									nextPutAll: '      '.].

	Transcript show: resultMessage.! !

!TEGDiceThrower methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 21:05:52'!
throwDiceTimes: anAmountOfTimes

	| result |
	
	result _ OrderedCollection new.
	anAmountOfTimes timesRepeat: [result add: dice throw.].
	result sort: [:a :b | a > b ] .
	
	^ result.! !

!TEGDiceThrower methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 21:07:28'!
throwForAttackerWith: anAmountOfArmiesForAttacker andDefenderWith: anAmountOfArmiesForDefender

	| result attackersResult defendersResult pos attackersDefeatedArmies defendersDefeatedArmies |

	self checkAmountsFor: anAmountOfArmiesForAttacker and: anAmountOfArmiesForDefender.
	
	attackersResult _ self throwDiceTimes: anAmountOfArmiesForAttacker.
	defendersResult _ self throwDiceTimes: anAmountOfArmiesForDefender.
	
	pos _ 1.
	attackersDefeatedArmies  _ 0.
	defendersDefeatedArmies  _ 0.
	(anAmountOfArmiesForAttacker min: anAmountOfArmiesForDefender) timesRepeat: 
				[((attackersResult at: pos) > (defendersResult at: pos)) 
						ifTrue: [ defendersDefeatedArmies  _ defendersDefeatedArmies + 1]
						ifFalse: [ attackersDefeatedArmies  _ attackersDefeatedArmies + 1 ].
				pos _ pos + 1. ].
	
	result _ Dictionary new.
	result at: 'attacker' put: attackersResult asArray;
			at: 'defender' put: defendersResult asArray;
			at: 'attackerLoses' put: attackersDefeatedArmies;
			at: 'defenderLoses' put: defendersDefeatedArmies.
			
	self showResult: result. 
	
	^result.! !


!TEGDiceThrower methodsFor: 'private' stamp: 'ad 7/18/2017 20:00:01'!
initializeWith: aDice 
	
	dice _ aDice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TEGDiceThrower class' category: #TEG!
TEGDiceThrower class
	instanceVariableNames: ''!

!TEGDiceThrower class methodsFor: 'as yet unclassified' stamp: 'ad 7/18/2017 19:59:24'!
newWithDice: aDice 
	
	^ self new initializeWith: aDice.! !
