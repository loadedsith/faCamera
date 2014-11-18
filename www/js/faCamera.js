var FaCamera = {
  getPicture : function(success, failure){
    cordova.exec(success, failure, "FaCamera", "openCamera", []);
  },
  onFinish : function(success, failure){
    cordova.exec(success, failure, "FaCamera", "onFinish", []);
  },
  storeImage : function(success, failure, url){
    cordova.exec(success, failure, "FaCamera", "storeImage", [url]);
  }
}

if(module){
  module.exports = FaCamera;
}
