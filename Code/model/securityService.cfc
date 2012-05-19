/**
* I am a new Model Object
*/
component singleton{

	securityService function init(){

		return this;
	}

	function userValidator(){
		//validate a user
		var user = getUserSession();

		if( user.isAuthorized() ){
			return true;
		}

		//Check if single sign on cookie exists and is valid
		if( isSSOCookieValid() ){
			var authorized = authorizeUser(user);
			return authorized;
		}
		else{
			return false;
		}
	}


}
