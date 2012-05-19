/**
* The base model test case will use the 'model' annotation as the instantiation path
* and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
* responsibility to update the model annotation instantiation path and init your model.
*/
component extends="coldbox.system.testing.BaseModelTest" model="model.validator"{

	void function setup(){
		super.setup();

		// init the model object
		model.init();

	}

	function testCheckEmail(){
		assertEquals( true, model.checkEmail('gratzc@compknowhow.com') );
		assertEquals( false, model.checkEmail('gratz.C@@DF.GGvV') );
	}


}
