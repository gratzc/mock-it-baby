component  hint="An Example User Object" output="false" accessors="true"
{

	property name="FName";
	property name="LName";
	property name="Email";
	property name="Password";

	property name="validator" inject="id:validator";

	//hard to mock in a method call, here we are also testing the collaborator, this expanding our test
	function checkUserEmail(){
		//var validator = createObject("component","model.Validator");
		var email = trim(this.getEmail());

		return validator.checkEmail(email);
	}

	/*//code we can test, this is our SUT
	function checkEmail(){
		var email = trim(this.getEmail());

		return validator.checkEmail(email);
	}*/
}