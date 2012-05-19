component extends="coldbox.system.testing.BaseModelTest" model="model.User"{

	function setup(){
		super.setup();
		user = model;
		mockValidator = getMockBox().createEmptyMock("model.validator");
		//mockValidator.$('checkEmail',false);
		mockValidator.$('checkEmail').$results(true,false);
		user.$property(propertyName="validator",mock=mockValidator);
	}

	function testCheckUserEmail(){
		user.setEmail('gratzc@compknowhow.com');
		assertEquals( true, user.checkUserEmail() );
		user.setEmail('gratz.C@@DF.GGvV');
		assertEquals( false, user.checkUserEmail() );
	}

	function testCallLogs(){
		//No calls yet
		assertTrue( user.$times(0) );

		user.$("checkUserEmail",false);
		user.checkUserEmail();

		// Asserts
		assertTrue( user.$times(1) );
		assertTrue( user.$times(1,"checkUserEmail") );

		user.$("getEmail",true);
		user.getEmail();

		assertTrue( user.$times(2) );
		assertTrue( user.$times(1,"getEmail") );
	}
}