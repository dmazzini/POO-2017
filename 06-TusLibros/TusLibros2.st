!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'cartFactory aCart anExpiredCard today aNotExpiredCard aSalesBook dummyMerchantProcessor merchantProcessorWithoutDebitBehavior aProductA aProductB aProductC'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 19:11:13'!
test01ANewCartShouldBeEmpty

	self assert: cartFactory createCartWithCatalogWithOneProduct isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:07:28'!
test02WhenAProductIsAddedTheCartShouldNotBeEmpty

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:01'!
test03ACartIncludesAnAddedProduct

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA.
	
	self assert: (aCart includes: aProductA).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:07'!
test04ACartDoesNotIncludeAProductThatHasntBeenAdded

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	self deny: (aCart includes: aProductA).
! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:29'!
test05TheAmountOfAProductAfterAddingItTwiceIsTwo

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: aProductA; add: aProductA.
	
	self assert: (aCart amountOf: aProductA) = 2.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:08:55'!
test06TheAmountOfAProductAfterAddingThreeOfItIsThree

	aCart _ cartFactory createCartWithCatalogWithOneProduct.

	aCart add: 3 of: aProductA.
	
	self assert: (aCart amountOf: aProductA) = 3.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:09'!
test07AddingANegativeAmountOfAProductShouldRaiseError

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	self should: [aCart add: -1 of: aProductA.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart negativeOrZeroAmountErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:33'!
test08ACartWithProductsPrintsThem

	| aString |

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: 3 of: aProductA.
	
	aString _ String streamContents: [:aStream |
				aCart printOn: aStream.	].
			
	self assert: aString equals: '''aProductA'' ''aProductA'' ''aProductA'''.! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:44'!
test09AddingANonWholeNumberAmountOfAProductShouldRaiseError

	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	self should: [aCart add: 5/3 of: aProductA.]	
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart nonWholeNumberErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:09:49'!
test10AddingAProductThatDoesntBelongToTheCatalogShouldRaiseError
		
	aCart _ cartFactory createCartWithEmptyCatalog.
	
	self should: [aCart add: aProductA.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError |
						self assert: anError messageText equals: Cart productNotOnCatalogErrorMessage.
						self assert: aCart isEmpty .]! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:17:04'!
test11CanNotCreateACashierWithAnEmptyCart

	aCart _ cartFactory createCartWithEmptyCatalog.
	
	self should: [Cashier for: aCart payingWith: aNotExpiredCard to: dummyMerchantProcessor registeringIn: aSalesBook on: today.]
			raise: Error - MessageNotUnderstood 
 			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier emptyCartErrorMessage] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:10:09'!
test12CanNotCreateACashierWithAnExpiredCard
		
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: aProductA.
	
	self should: [Cashier for: aCart payingWith: anExpiredCard to: dummyMerchantProcessor registeringIn: aSalesBook on: today.]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier expiredCardErrorMessage.] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/25/2017 15:22:27'!
test13CreatingACardWithANumberWithMoreThanSixteenDigitsShouldRaiseError
	
	self should: [Card number: 12345678901234567 forOwner: 'Jaime'  thatExpiresOn:(Month month: today monthIndex year: today yearNumber + 1).]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Card invalidNumberErrorMessage.] ! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:10:50'!
test14CheckoutTotalForACartWithOneProductShouldBeEqualToThatProductPrice

	| aCashier |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	
	aCart add: aProductA.
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn:aSalesBook on: today.
	
	self assert: aCashier checkout total = (aCart catalog at: aProductA).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:15:17'!
test15CheckoutTotalShouldBeEqualToTheSumOfAllCartsProductsPrices

	| aCashier |
	
	aCart _ cartFactory createCartWithCatalogWithThreeProducts.
	
	aCart add: 1 of: aProductA; add: 2 of: aProductB; add: 3 of: aProductC.	
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn: aSalesBook on: today.
	
	self assert: aCashier checkout total = ((aCart catalog at: aProductA) + ((aCart catalog at: aProductB) *2) + ((aCart catalog at: aProductC) *3) ).! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/25/2017 15:43:30'!
test16CashierCanNotCheckoutACartWithNotEnoughCredit

	| aCashier merchantProcessorSimulator |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | self error: Cashier cardDoesNotHaveEnoughCreditErrorMessage ].
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today.
	
	self 
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier cardDoesNotHaveEnoughCreditErrorMessage.
			].! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:11:46'!
test17CashierCanNotCheckoutACartWithAStolenCard

	| aCashier merchantProcessorSimulator |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | self error: Cashier cardStolenErrorMessage ].
	
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today .
	
	self 
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier cardStolenErrorMessage.
			].! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/24/2017 20:14:18'!
test18CashierShouldNotInvokeMerchantProcessorIfTheCardIsExpired

	| merchantProcessorSimulator merchantProcessorDebits |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	merchantProcessorDebits _ 0.
	merchantProcessorSimulator _ MerchantProcessorSimulator with: [:anAmount :aCard | merchantProcessorDebits _ merchantProcessorDebits +1].
	
	self should: [Cashier for: aCart payingWith: anExpiredCard to: merchantProcessorSimulator registeringIn: aSalesBook on: today .]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [:anError |
					self assert: anError messageText equals: Cashier expiredCardErrorMessage.
					self assert: merchantProcessorDebits = 0. 
			] 
	
	
		! !

!CartTest methodsFor: 'tests' stamp: 'DIM 6/26/2017 07:37:14'!
test19SuccessfulCheckoutRegistersTheSale

	| aCashier aSale anItemSale |
	
	aCart _ cartFactory createCartWithCatalogWithOneProduct.
	aCart add: aProductA.
		
	aCashier _ Cashier for: aCart payingWith: aNotExpiredCard to: merchantProcessorWithoutDebitBehavior registeringIn: aSalesBook on: today.
	
	aSale _ aCashier checkout .
	anItemSale _ aSale itemSaleOf: aProductA.
	
	self assert: aSalesBook first = aSale.
	self assert: anItemSale product = aProductA.
	self assert: anItemSale quantity = 1.
	self assert: anItemSale unitPrice = 5.! !


!CartTest methodsFor: 'set up' stamp: 'DIM 6/24/2017 20:07:07'!
setUp

	cartFactory _ CartFactory new.
	
	aProductA _ 'aProductA'.
	aProductB _ 'aProductB'.
	aProductC _ 'aProductC'.
	
	today _ Date today.
	
	aSalesBook _ OrderedCollection new.
		
	anExpiredCard _ Card number: 0000000000000000 forOwner: 'Owner' thatExpiresOn: (Month month: today monthIndex year: today yearNumber - 1).

	aNotExpiredCard _ Card number: 0000000000000000 forOwner: 'Owner' thatExpiresOn: (Month month: today monthIndex year: today yearNumber + 1).	

	dummyMerchantProcessor _ MerchantProcessorSimulator with: [].	

	merchantProcessorWithoutDebitBehavior _ MerchantProcessorSimulator with: [:anAmount :aCard | ].! !


!classDefinition: #TusLibrosRestInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosRestInterfaceTest
	instanceVariableNames: 'validUser validUserPassword users invalidUser invalidPassword aValidBook anInvalidBook anotherValidBook aCatalog aMerchantProcessor aSalesBook tusLibrosInterface today aCardNumber cardOwner notExpiredDate expiredDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterfaceTest methodsFor: 'setUp' stamp: 'DIM 6/25/2017 21:34:36'!
setUp

	validUser _ 'validUser'.	
	validUserPassword _ 'validUserPassword'.
	
	users _ Dictionary new.
	users at: validUser put: validUserPassword.
	
	invalidUser _ 'invalidUser'.
	
	invalidPassword _ 'invalidPassword'.
	
	aValidBook _ 'valid book'.
	anInvalidBook _ 'invalid book'.
	anotherValidBook _ 'another valid book'.
	
	aCatalog _ Dictionary new.
	aCatalog at: aValidBook put:1; at: anotherValidBook put: 5.
	
	aMerchantProcessor _ MerchantProcessorSimulator with: [:anAmount :aCard | ].
	
	aSalesBook _ OrderedCollection new.
	
	tusLibrosInterface _ TusLibrosRestInterface withUsers: users catalog: aCatalog merchantProcessor: aMerchantProcessor salesBook: aSalesBook.
	
	today _ Date today.
	
	aCardNumber _ 0000000000000000.
	notExpiredDate _ (Month month: today monthIndex year: today yearNumber + 1).
	expiredDate _ (Month month: today monthIndex year: today yearNumber - 1).
	cardOwner _ 'Aldo'.! !


!TusLibrosRestInterfaceTest methodsFor: 'create cart' stamp: 'DIM 6/25/2017 21:27:02'!
test01CanCreateACartWithValidUserAndPassword

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self assert: ((tusLibrosInterface cart: cartId) belongsTo: validUser).! !

!TusLibrosRestInterfaceTest methodsFor: 'create cart' stamp: 'DIM 6/25/2017 21:27:12'!
test02CanNotCreateACartWithAnInvalidUser

	self 
		should: [ tusLibrosInterface createCartFor: invalidUser withPassword: invalidPassword.] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
					self assert: anError messageText equals: TusLibrosRestInterface invalidUserErrorMessage.				
			].

	
! !

!TusLibrosRestInterfaceTest methodsFor: 'create cart' stamp: 'DIM 6/25/2017 21:27:22'!
test03CanNotCreateACartWithValidUserAndInvalidPassword

	self 
		should: [  tusLibrosInterface createCartFor: validUser withPassword: invalidPassword.] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
					self assert: anError messageText equals: TusLibrosRestInterface invalidPasswordErrorMessage.				
			].! !

!TusLibrosRestInterfaceTest methodsFor: 'create cart' stamp: 'DIM 6/25/2017 21:27:33'!
test04ANewCartShouldBeEmpty

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self assert: ((tusLibrosInterface cart: cartId) isEmpty).! !


!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:27:44'!
test05ACartShouldContainsAnAddedBook

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 1 of: aValidBook toCart: cartId.
	
	self assert: ((tusLibrosInterface cart: cartId) includes: aValidBook).! !

!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:27:59'!
test06ACartDoesNotIncludeAProductThatHasntBeenAdded

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self deny: ((tusLibrosInterface cart: cartId) includes: aValidBook).! !

!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:28:13'!
test07CanNotAddABookThatIsNotInTheCatalogOfTheStore

	| cartId |
		
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self 
		should:  [ tusLibrosInterface add: 1 of: anInvalidBook toCart: cartId. ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :anError |
				self assert: anError messageText equals: TusLibrosRestInterface bookNotInTheCatalogErrorMessage.
				self deny: ((tusLibrosInterface cart: cartId) includes: anInvalidBook).
			]! !

!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:28:20'!
test08CanNotAddABookToACartThatNotExistsInTheStore

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self 
		should:  [ tusLibrosInterface add: 1 of: aValidBook toCart: cartId + 10. ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :anError |
				self assert: anError messageText equals: TusLibrosRestInterface cartDoesNotExistErrorMessage.
			]
! !

!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:28:29'!
test09AddingToACartANegativeAmountOfABookShouldRaiseError

	| cartId |

	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self 
		should:  [ tusLibrosInterface add: -1 of: aValidBook toCart: cartId. ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :anError |
				self assert: anError messageText equals: TusLibrosRestInterface negativeOrZeroAmountOfBooksErrorMessage.
			]
! !

!TusLibrosRestInterfaceTest methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 21:28:40'!
test10AddingANonWholeNumberAmountOfABookShouldRaiseError

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self 
		should:  [ tusLibrosInterface add: 5/9 of: aValidBook toCart: cartId. ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :anError |
				self assert: anError messageText equals: TusLibrosRestInterface nonWholeNumberAmountofBooksErrorMessage.
			]
! !


!TusLibrosRestInterfaceTest methodsFor: 'list cart' stamp: 'DIM 6/25/2017 21:28:46'!
test11CanListProductsOfAnExistingCart

	| cartId cartProducts |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 1 of: aValidBook toCart: cartId. 
	tusLibrosInterface add: 3 of: anotherValidBook toCart: cartId. 	
	
	cartProducts _ tusLibrosInterface listCart: cartId.
	
	self assert: (cartProducts occurrencesOf: aValidBook) = 1.
	self assert: (cartProducts occurrencesOf: anotherValidBook) = 3.
! !

!TusLibrosRestInterfaceTest methodsFor: 'list cart' stamp: 'DIM 6/25/2017 21:28:58'!
test12ListingProductsOfNotExistingCartShouldRaiseError

	self 
		should: [tusLibrosInterface listCart: 1.]
	 	raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |				
				self assert: anError messageText = TusLibrosRestInterface cartDoesNotExistErrorMessage.				
			]
	
	
	! !


!TusLibrosRestInterfaceTest methodsFor: 'checkout cart' stamp: 'DIM 6/25/2017 21:40:57'!
test13SuccessfulCheckoutRegistersTheSale

	| cartId aSale |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 1 of: aValidBook toCart: cartId. 
		
	aSale _ tusLibrosInterface checkOutCart: cartId cardNumber: aCardNumber cardExpiration: notExpiredDate cardOwner: cardOwner..

	self assert: (aSale user = validUser).	
	self assert: (tusLibrosInterface salesBook includes: aSale).

! !

!TusLibrosRestInterfaceTest methodsFor: 'checkout cart' stamp: 'DIM 6/25/2017 21:40:40'!
test14CanNotCheckoutCartThatNotExistInTheStore

	self 
		should: [ tusLibrosInterface checkOutCart: 1 cardNumber: aCardNumber cardExpiration: notExpiredDate cardOwner: cardOwner. ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
				self assert: anError messageText = TusLibrosRestInterface cartDoesNotExistErrorMessage.
				self assert: (tusLibrosInterface salesBook isEmpty).			
			]
	
! !

!TusLibrosRestInterfaceTest methodsFor: 'checkout cart' stamp: 'DIM 6/25/2017 21:40:24'!
test15CanNotCheckoutAnEmptyCart

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	self 
		should: [ tusLibrosInterface checkOutCart: cartId cardNumber: aCardNumber cardExpiration: notExpiredDate cardOwner: cardOwner.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
				self assert: anError messageText = TusLibrosRestInterface checkoutEmptyCartErrorMessage.
				self assert: (tusLibrosInterface salesBook isEmpty).			
			]
	
! !

!TusLibrosRestInterfaceTest methodsFor: 'checkout cart' stamp: 'DIM 6/25/2017 21:37:26'!
test16CanNotCheckoutACartWithAnExpiredCard

	| cartId |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 1 of: aValidBook toCart: cartId. 
	
	self 
		should: [ tusLibrosInterface checkOutCart: cartId cardNumber: aCardNumber cardExpiration: expiredDate cardOwner: cardOwner. ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
				self assert: anError messageText = TusLibrosRestInterface expiredCardErrorMessage.
				self assert: (tusLibrosInterface salesBook isEmpty).			
			]
	
! !


!TusLibrosRestInterfaceTest methodsFor: 'list purchases' stamp: 'DIM 6/26/2017 10:18:19'!
test17ListOfPurchasesOfAUserShouldIncludeAllBooksPurchased

	| cartId anotherCartId listOfPurchasesOfAUser |
	
	cartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 1 of: aValidBook toCart: cartId. 
	tusLibrosInterface add: 3 of: anotherValidBook toCart: cartId. 	
	
	tusLibrosInterface checkOutCart: cartId cardNumber: aCardNumber cardExpiration: notExpiredDate cardOwner: cardOwner. 
	
	anotherCartId _ tusLibrosInterface createCartFor: validUser withPassword: validUserPassword.
	
	tusLibrosInterface add: 4 of: aValidBook toCart: anotherCartId. 
	tusLibrosInterface add: 3 of: anotherValidBook toCart: anotherCartId. 	
	
	tusLibrosInterface checkOutCart: anotherCartId cardNumber: aCardNumber cardExpiration: notExpiredDate cardOwner: cardOwner. 
	
	listOfPurchasesOfAUser _ tusLibrosInterface purchasesOf: validUser withPassword: validUserPassword.
	
	self assert: (listOfPurchasesOfAUser at: aValidBook) = 5.
	self assert: (listOfPurchasesOfAUser at: anotherValidBook) = 6.	
	

	
	
	
	
	
	
! !

!TusLibrosRestInterfaceTest methodsFor: 'list purchases' stamp: 'DIM 6/26/2017 14:48:37'!
test18CanNotListPurchasesOfAnInvalidUser

	self 
		should: [ tusLibrosInterface purchasesOf: invalidUser withPassword: validUserPassword. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: anError messageText = TusLibrosRestInterface invalidUserErrorMessage.
			]
	
	
	
	

	
	
	
	
	
	
! !

!TusLibrosRestInterfaceTest methodsFor: 'list purchases' stamp: 'DIM 6/26/2017 14:50:25'!
test19CanNotListPurchasesOfAValidUserAndInvalidPassword

	self 
		should: [  tusLibrosInterface purchasesOf: validUser withPassword: invalidPassword.] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
					self assert: anError messageText equals: TusLibrosRestInterface invalidPasswordErrorMessage.				
			].! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'number owner expireOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'private' stamp: 'dim 6/20/2017 18:51:46'!
initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthOfYear

	number _ aCardNumber.
	
	owner _ aName.
	
	expireOn _ aMonthOfYear.! !


!Card methodsFor: 'testing' stamp: 'dim 6/20/2017 19:12:19'!
isExpiredOn: aDate

	| aMonthOfaYear |
	
	aMonthOfaYear  _ Month month: aDate monthIndex year: aDate yearNumber.
	
	^ expireOn start < aMonthOfaYear start.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'dim 6/20/2017 18:52:47'!
number: aCardNumber forOwner: aName thatExpiresOn: aMonthOfaYear.

	(self isValidCardNumber: aCardNumber) ifFalse: [self error: self invalidNumberErrorMessage].

	^ self new initializeWithNumber: aCardNumber forOwner: aName thatExpiresOn: aMonthOfaYear.
	
	! !


!Card class methodsFor: 'error messages' stamp: 'ad 6/16/2017 16:22:11'!
invalidNumberErrorMessage

	^ 'Card number should contain 16 digits'! !


!Card class methodsFor: 'validation' stamp: 'ad 6/16/2017 16:28:44'!
isValidCardNumber: aCardNumber
	
	^ (aCardNumber isKindOf: Integer) and: [aCardNumber asString size <= 16].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'dim 6/14/2017 18:57:33'!
initializeWith: aCatalog

	catalog _ aCatalog.
	products  _ Bag new.! !


!Cart methodsFor: 'adding' stamp: 'dim 6/14/2017 19:20:45'!
add: aProduct

	self add: 1 of: aProduct.! !

!Cart methodsFor: 'adding' stamp: 'DIM 6/21/2017 10:54:09'!
add: anAmount of: aProduct

	(catalog includesKey: aProduct) ifFalse: [ self error:  self class productNotOnCatalogErrorMessage ].
		
	(anAmount isKindOf: Integer) ifFalse: [self error: self class nonWholeNumberErrorMessage ].
	
	(anAmount > 0) ifFalse: [self error: self class negativeOrZeroAmountErrorMessage ].
	
	products add: aProduct withOccurrences: anAmount.! !


!Cart methodsFor: 'testing' stamp: 'DIM 6/21/2017 10:54:23'!
includes: aProduct

	^ products includes: aProduct.! !

!Cart methodsFor: 'testing' stamp: 'DIM 6/21/2017 10:53:44'!
isEmpty

	^ products isEmpty.! !


!Cart methodsFor: 'accessing' stamp: 'DIM 6/21/2017 10:52:36'!
amountOf: aProduct

	^ products occurrencesOf: aProduct.! !

!Cart methodsFor: 'accessing' stamp: 'DIM 6/24/2017 19:39:17'!
catalog

	^ catalog.! !

!Cart methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:59:25'!
itemsForSale

	| saleItems |
	
	saleItems _ Dictionary new.
	
	self productsDo: [ :aProduct |
			| aSaleItem |
			aSaleItem _ SaleItem withProduct: aProduct quantity: (self amountOf: aProduct) unitPrice: (catalog at: aProduct).	
			saleItems at: aProduct put: aSaleItem.	
		].
	
	^ saleItems

	
	! !

!Cart methodsFor: 'accessing' stamp: 'DIM 6/21/2017 10:52:27'!
products

	^ products copy.! !

!Cart methodsFor: 'accessing' stamp: 'ad 6/22/2017 12:38:03'!
totalPrice

	| totalPrice |
	
	totalPrice _ 0.
	
	self productsDo: [:aProduct |
		
			totalPrice _ totalPrice  + catalog at:aProduct .
		].			
		
	^ totalPrice.
				
	! !


!Cart methodsFor: 'printing' stamp: 'DIM 6/21/2017 10:53:32'!
printOn: aStream

	| iter |	
	
	iter _ 1.
	
	self productsDo: [:aProduct |
		
			aProduct printOn: aStream.
			
			(iter = products size) ifFalse: [ 
				
					aStream nextPutAll: ' '.].
				
			iter _ iter + 1.]! !


!Cart methodsFor: 'enumerating' stamp: 'DIM 6/21/2017 10:54:48'!
productsDo: aBlock

	products do: [:aProduct |
		
				aBlock value: aProduct ].
			
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'DIM 6/21/2017 10:55:04'!
negativeOrZeroAmountErrorMessage

	^ 'Can not add a negative or zero amount'! !

!Cart class methodsFor: 'error messages' stamp: 'DIM 6/21/2017 11:01:18'!
nonWholeNumberErrorMessage

	^ 'Can not add a non whole number amount.'! !

!Cart class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:09:08'!
productNotOnCatalogErrorMessage

	^ 'Product not listed on catalog'! !


!Cart class methodsFor: 'initialization' stamp: 'dim 6/14/2017 18:56:09'!
with: aCatalog
 
	^self new initializeWith: aCatalog ! !


!classDefinition: #CartFactory category: #TusLibros!
Object subclass: #CartFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 20:07:45'!
createCartWithCatalogWithOneProduct
	
	| aCatalogWithOneProduct |	
	
	aCatalogWithOneProduct  _ Dictionary new.
	
	aCatalogWithOneProduct at:'aProductA' put:5.
	
	^ Cart with: aCatalogWithOneProduct.! !

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 19:35:01'!
createCartWithCatalogWithThreeProducts
	
	| aCatalogWithThreeProducts |	
	
	aCatalogWithThreeProducts  _ Dictionary new.
	
	aCatalogWithThreeProducts at:'aProductA' put:5; at:'aProductB' put:10; at:'aProductC' put:20.	.
	
	^ Cart with: aCatalogWithThreeProducts.! !

!CartFactory methodsFor: 'cart creation' stamp: 'DIM 6/24/2017 19:10:53'!
createCartWithEmptyCatalog
		
	^ Cart with: Dictionary new.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart card date merchantProcessor salesBook user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'private' stamp: 'DIM 6/25/2017 19:14:18'!
initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook forAUser: aUser on: aDate 

	cart _ aCart.
	card _ aCard.
	merchantProcessor _ aMerchantProcessor.
	date _ aDate.
	salesBook _ aSalesBook.
	user _ aUser.! !

!Cashier methodsFor: 'private' stamp: 'DIM 6/23/2017 19:11:24'!
initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate 

	cart _ aCart.
	card _ aCard.
	merchantProcessor _ aMerchantProcessor.
	date _ aDate.
	salesBook _ aSalesBook.! !


!Cashier methodsFor: 'checkout' stamp: 'DIM 6/26/2017 07:40:00'!
checkout
	| totalPrice aSale |
	
	totalPrice  _ cart totalPrice.
	aSale _ Sale total: totalPrice user: user itemsSale: cart itemsForSale.

	merchantProcessor debit: totalPrice from: card.

	salesBook add: aSale.
	^ aSale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'DIM 6/25/2017 19:13:04'!
for: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook forAUser: aUser on: aDate 

	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	(aCard isExpiredOn: aDate ) ifTrue: [self error: self expiredCardErrorMessage].
	
	^ self new initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook forAUser: aUser on: aDate.
! !

!Cashier class methodsFor: 'initialization' stamp: 'DIM 6/23/2017 19:09:32'!
for: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate 

	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	(aCard isExpiredOn: aDate ) ifTrue: [self error: self expiredCardErrorMessage].
	
	^ self new initializeFor: aCart payingWith: aCard to: aMerchantProcessor registeringIn: aSalesBook on: aDate.
! !


!Cashier class methodsFor: 'error messages' stamp: 'DIM 6/23/2017 17:19:18'!
cardDoesNotHaveEnoughCreditErrorMessage
	
	^ 'Card does not have enough credit'.! !

!Cashier class methodsFor: 'error messages' stamp: 'DIM 6/23/2017 17:38:56'!
cardStolenErrorMessage

	^ 'The card was stolen' ! !

!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:30:23'!
emptyCartErrorMessage

	^ 'Can not create a cashier with an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'ad 6/16/2017 15:45:04'!
expiredCardErrorMessage

	^ 'Can not create a cashier with an expired card.'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'private' stamp: 'DIM 6/23/2017 17:10:57'!
initializeWith: aDebitBlock

	debitBlock _ aDebitBlock.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'DIM 6/23/2017 17:18:37'!
debit: anAmount from: aCard 

	debitBlock value: anAmount value: aCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'initialization' stamp: 'DIM 6/23/2017 17:10:16'!
with: aDebitBlock

	^ self new initializeWith: aDebitBlock.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total user itemsSale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'private' stamp: 'DIM 6/26/2017 07:55:02'!
initializeWithTotal: aTotal user: aUser itemsSale: anItemsSale

	itemsSale _ anItemsSale.
	total _ aTotal.
	user _ aUser.! !


!Sale methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:57:29'!
itemSaleOf: aProduct

	^ itemsSale at: aProduct.
	! !

!Sale methodsFor: 'accessing' stamp: 'DIM 6/26/2017 10:17:25'!
itemsSale

	^ itemsSale.! !

!Sale methodsFor: 'accessing' stamp: 'DIM 6/24/2017 18:24:39'!
total

	^ total.! !

!Sale methodsFor: 'accessing' stamp: 'DIM 6/25/2017 19:07:48'!
user

	^ user.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'initialization' stamp: 'DIM 6/26/2017 07:39:16'!
total: aTotal user: aUser itemsSale: anItemsSale

	^ self new initializeWithTotal: aTotal user: aUser itemsSale: anItemsSale.! !


!classDefinition: #SaleItem category: #TusLibros!
Object subclass: #SaleItem
	instanceVariableNames: 'product quantity unitPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleItem methodsFor: 'private' stamp: 'DIM 6/26/2017 07:47:18'!
initializeWith: aProduct quantity: aQuantity unitPrice: aUnitPrice
 
	product _ aProduct.
	quantity _ aQuantity.
	unitPrice _ aUnitPrice.
	! !


!SaleItem methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:57:52'!
product

	^ product.! !

!SaleItem methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:58:11'!
quantity

	 ^ quantity.! !

!SaleItem methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:58:32'!
unitPrice

	^ unitPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleItem class' category: #TusLibros!
SaleItem class
	instanceVariableNames: ''!

!SaleItem class methodsFor: 'initialization' stamp: 'DIM 6/26/2017 07:45:59'!
withProduct: aProduct quantity: aQuantity unitPrice: aUnitPrice

	^ self new initializeWith: aProduct quantity: aQuantity unitPrice: aUnitPrice.! !


!classDefinition: #TusLibrosCart category: #TusLibros!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'cart user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCart methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 01:19:58'!
add: anAmount of: aBook
 
	cart add: anAmount of: aBook.! !


!TusLibrosCart methodsFor: 'accessing' stamp: 'DIM 6/25/2017 00:14:57'!
belongsTo: aUser

	^ user = aUser.! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'DIM 6/26/2017 07:43:06'!
itemsForSale

	^ cart itemsForSale.! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'DIM 6/25/2017 14:26:55'!
listCart

	^ cart products.! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'DIM 6/25/2017 16:19:03'!
totalPrice

	^ cart totalPrice.! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'DIM 6/25/2017 19:11:23'!
user

	^ user.! !


!TusLibrosCart methodsFor: 'initialize' stamp: 'DIM 6/25/2017 00:14:19'!
initializeWith: aCart belongsTo: aUser

	cart _ aCart.
	user _ aUser.! !


!TusLibrosCart methodsFor: 'testing' stamp: 'DIM 6/25/2017 01:35:07'!
includes: aBook

	^ cart includes: aBook.! !

!TusLibrosCart methodsFor: 'testing' stamp: 'DIM 6/25/2017 10:19:27'!
isEmpty

	^ cart isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCart class' category: #TusLibros!
TusLibrosCart class
	instanceVariableNames: ''!

!TusLibrosCart class methodsFor: 'initialization' stamp: 'DIM 6/25/2017 00:13:29'!
cart: aCart belognsTo: aUser
 
	^ self new initializeWith: aCart belongsTo: aUser.! !


!classDefinition: #TusLibrosRestInterface category: #TusLibros!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'validUsers carts cartId catalog merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterface methodsFor: 'add to cart' stamp: 'DIM 6/25/2017 15:17:00'!
add: anAmount of: aBook toCart: aCartId
	
	(catalog includesKey: aBook) ifFalse: [ self error:  self class bookNotInTheCatalogErrorMessage ].
	
	(anAmount isKindOf: Integer) ifFalse: [self error: self class nonWholeNumberAmountofBooksErrorMessage ].
	
	(anAmount > 0) ifFalse: [self error: self class negativeOrZeroAmountOfBooksErrorMessage ].
	
	(carts includesKey: aCartId) ifFalse: [ self error: self class cartDoesNotExistErrorMessage].
	
	(carts at: aCartId) add: anAmount of: aBook.! !


!TusLibrosRestInterface methodsFor: 'accessing' stamp: 'DIM 6/24/2017 23:57:31'!
cart: aCartId
	
	^ carts at: aCartId.! !

!TusLibrosRestInterface methodsFor: 'accessing' stamp: 'DIM 6/25/2017 16:27:16'!
salesBook

	^ salesBook.! !


!TusLibrosRestInterface methodsFor: 'checkout cart' stamp: 'DIM 6/25/2017 21:38:43'!
checkOutCart: aCartId cardNumber: aCardNumber cardExpiration: aCardExpiration cardOwner: aCardOwner

	| aCard aCart aCashier |
	
	(carts includesKey: aCartId) ifFalse: [ ^ self error: self class cartDoesNotExistErrorMessage]. 
	aCart _ carts at: aCartId.
	
	aCard _ Card number: aCardNumber forOwner: aCardOwner thatExpiresOn: aCardExpiration.	
	(aCard isExpiredOn: Date today ) ifTrue: [^ self error: self class expiredCardErrorMessage].
	
	(aCart isEmpty) ifTrue: [ ^ self error: self class checkoutEmptyCartErrorMessage ].
	aCashier _ Cashier for: aCart payingWith: aCard to: merchantProcessor registeringIn: salesBook forAUser: aCart user on: Date today.
	
	^ aCashier checkout.
! !


!TusLibrosRestInterface methodsFor: 'create cart' stamp: 'DIM 6/25/2017 01:37:13'!
createCartFor: aUser withPassword: aPassword

	| aCart aTusLibrosCart |
	
	(validUsers includesKey: aUser) ifFalse: [^ self error: self class invalidUserErrorMessage].	
	
	((validUsers at: aUser) = aPassword) ifFalse: [ ^ self error: self class invalidPasswordErrorMessage].
	
	cartId _ cartId + 1.
	
	aCart _ Cart with: catalog.
	
	aTusLibrosCart _ TusLibrosCart cart: aCart belognsTo: aUser.
	
	carts at: cartId put: aTusLibrosCart.
	
	^ cartId.! !


!TusLibrosRestInterface methodsFor: 'initialize' stamp: 'DIM 6/25/2017 16:24:30'!
initializeWithUsers: aValidUsers catalog: aCatalog merchantProcessor: aMerchantProcessor salesBook: aSalesBook 
	
	carts _ Dictionary new.
	cartId  _ 0.
	validUsers _ aValidUsers.
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	salesBook _ aSalesBook.! !


!TusLibrosRestInterface methodsFor: 'list cart' stamp: 'DIM 6/25/2017 14:58:34'!
listCart: aCartId

	(carts includesKey: aCartId) ifFalse: [ self error: self class cartDoesNotExistErrorMessage].
	^ (carts at:aCartId) listCart.! !


!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'DIM 6/26/2017 14:51:14'!
purchasesOf: aUser withPassword: aPassword

	| salesOfAUser purchases |
	
	(validUsers includesKey: aUser) ifFalse: [^ self error: self class invalidUserErrorMessage].	
	
	((validUsers at: aUser) = aPassword) ifFalse: [ ^ self error: self class invalidPasswordErrorMessage].
	
	salesOfAUser _ salesBook select: [ :aSale |  aSale user = aUser].
	
	purchases _ Dictionary new.
		
	salesOfAUser do: [ :aSale | 
			aSale itemsSale do: [ :itemSale | 
					(purchases includesKey: itemSale product) 
					ifTrue:  [ | aQuantity |
							aQuantity _ purchases at: itemSale product.
							purchases at: itemSale product put: aQuantity + itemSale quantity.
						]
					ifFalse: [
							purchases at: itemSale product put: itemSale quantity.
						].
				].
		].
	
	^ purchases.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #TusLibros!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 10:48:31'!
bookNotInTheCatalogErrorMessage

	^ 'The book is not in the catalog of the store'.! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 11:25:53'!
cartDoesNotExistErrorMessage

	^ 'The Cart does not exists in the Store'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 19:57:28'!
checkoutEmptyCartErrorMessage

	^ 'Can not checkout with an empty cart.'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 19:46:21'!
expiredCardErrorMessage

	^ 'Can not create a cashier with an expired card.'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 19:45:36'!
expiredCardExistErrorMessage
	self shouldBeImplemented! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 01:03:38'!
invalidPasswordErrorMessage
	
	^ 'Invalid Passsword'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 00:57:25'!
invalidUserErrorMessage

	 ^ 'Invalid User'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 15:09:47'!
negativeOrZeroAmountOfBooksErrorMessage

	^ 'Can not add a negative or zero amount of Books'! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'DIM 6/25/2017 15:15:35'!
nonWholeNumberAmountofBooksErrorMessage

	^ 'Can not add a non whole number amount of Books.'! !


!TusLibrosRestInterface class methodsFor: 'initialization' stamp: 'DIM 6/25/2017 16:22:44'!
withUsers: aValidUsers catalog: aCatalog merchantProcessor: aMerchantProcessor salesBook: aSalesBook 

	^ self new initializeWithUsers: aValidUsers catalog: aCatalog merchantProcessor: aMerchantProcessor salesBook: aSalesBook.! !
