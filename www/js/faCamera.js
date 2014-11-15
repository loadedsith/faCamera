var FaCamera = {
	getPicture: function(success, failure){
		cordova.exec(success, failure, "FaCamera", "openCamera", []);
	}
};