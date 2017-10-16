/**
* Form entity
*/
component persistent="true" table="cb_member"{

	// Primary Key
	property name="memberID" fieldtype="id" column="memberID" generator="identity" setter="false";

	// Properties
	property name="firstName" notnull="true" length="200";
	property name="lastName" notnull="true" length="200";
	property name="email" notnull="true" length="255" index="idx_email";
	property name="username" notnull="true" length="100" unique="true" index="idx_login";
	property name="password" notnull="true" length="100" unique="true" index="idx_login";
	property name="isActive" notnull="true" ormtype="boolean" default="false" dbdefault="0" index="idx_login,idx_active";
	property name="lastLogin" notnull="false" ormtype="timestamp";
	property name="createdDate" notnull="true" ormtype="timestamp" update="false";

	public void function preInsert(){
		setCreatedDate( now() );
	}

	// Constructor
	function init(){
		return this;
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return len( getMemberID() );
	}

	/*
	* Validate entry, returns an array of error or no messages
	*/
	array function validate(){
		var errors = [];

		// limits
		firstName			= left(firstName,200);
		lastName			= left(lastName,200);
		email				= left(email,255);
		username			= left(username,100);
		password			= left(password,100);

		// Required
		if( !len(firstName) ){ arrayAppend(errors, "First Name is required"); }
		if( !len(lastName) ){ arrayAppend(errors, "Last Name is required"); }
		if( !len(email) ){ arrayAppend(errors, "Email is required"); }
		if( !len(username) ){ arrayAppend(errors, "Username is required"); }
		if( !len(password) ){ arrayAppend(errors, "Password is required"); }
		if( !len(isActive) ){ arrayAppend(errors, "Is Active is required"); }

		return errors;
	}

	function saveMember(passwordChange=false){
		// hash password if new member
		if( !this.isLoaded() OR arguments.passwordChange ){
			this.setPassword( hash(this.getPassword(), "SHA-256") );
		}
		// save the member
		save( member );
	}
}