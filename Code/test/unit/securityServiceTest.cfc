/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="model.securityService"{

	void function setup(){
		super.setup();

		// init the model object
		model.init();

		security = model;
		//create a mock user object
		mockUser = getMockBox().createEmptyMock("model.User");
	}

	function testUserValidator(){
		//mock user authorizations according to case calls
		mockUser.$("isAuthorized").$results(true,false,false);
		security.$("getUserSession", mockUser);

		//case 1: authorized user
		assertTrue(security.userValidator());

		//case 2: unauthorized user with invalid cookie
		security.$("isSSOCookieValid",false);
		assertFalse( security.userValidator() );

		//case 3: unauthorized user with valid cookie
		security.$("isSSOCookieValid",true);
		//mock the authorizeUser void call
		security.$("authorizeUser",true);
		debug(security);
		assertTrue( security.userValidator() );
	}


}
