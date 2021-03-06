component persistent="true" output="true"
{
    property name="id"                  fieldtype="id"      generator="native";
    property name="companyName"         ormtype="string"    length="150";
    property name="consumeUrl"          ormtype="string"    length="255";
    property name="issuerUrl"           ormtype="string"    length="150";
    property name="issuerID"            ormtype="string"    length="50";
    property name="certificate"         ormtype="string"    length="2000";
    property name="createdOn"           ormtype="timestamp";
    property name="updatedOn"           ormtype="timestamp";


    public function init(){
        for (var key in arguments){
            if (StructKeyExists(arguments, key) and not isStruct(arguments[key])){
                var newVal = arguments[key];
				if (isArray(newVal)){
					newVal = arrayToList(newVal);
				}

                if (not isStruct(newVal) and (newVal eq "''" or newVal eq '""' or trim(newVal) eq "" or IsNull(newVal))){
                    newVal = null;
				}
                variables[key] = newVal;

            }
        }

        if (isNull(this.createdOn)){
			setCreatedOn(getHttpTimeString());
        }

        return this;
	}

    public boolean function isReady(){
        // return tru if all fields are set
        return  len(getConsumeUrl()) &&
                len(getIssuerUrl()) &&
                len(getIssuerID()) &&
                len(getCertificate());
	}

	public string function getRedirectToIdentityProviderUrl(){
		return this.getIssuerUrl() & "/" & this.getIssuerID() & "/" & "sso/saml"
	}
}