var FaCamera = {
  getPicture : function(success, failure){
    cordova.exec(success, failure, "FaCamera", "openCamera", []);
  },
  onFinish : function(success, failure){
    cordova.exec(success, failure, "FaCamera", "onFinish", []);
  }
}

if(module){
  module.exports = FaCamera;
}
