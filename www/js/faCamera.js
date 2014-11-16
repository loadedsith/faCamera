var FaCamera = {
  getPicture : function(success, failure){
    alert("getPicture");
    cordova.exec(success, failure, "FaCamera", "openCamera", []);
  }
}

module.exports = FaCamera;