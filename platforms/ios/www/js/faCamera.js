var FaCamera = {
getPicture: function(success, failure){
  console.log("getPicture");
		cordova.exec(success, failure, "FaCamera", "openCamera", []);
}
};
module.exports = FaCamera;