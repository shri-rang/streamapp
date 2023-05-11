class Config {
  //set your api server url here
  static String apiServerUrl = "https://ox.spagreen.net/rest-api/";
  //  "https://app.ouchfilms.com/rest-api/";
  //set your api key here
  static String apiKey =
      //  "af01c9d88636465";

      "0u6ylqyds0zkedi8qyl7u8az";
  //set your onesignalID here
  static String oneSignalID = "2d48cea4-09c0-4c76-bcd9-23146a882853";
  //set stripe secret key
  static String stripepublishableKey =
      "pk_test_51M25oyEcDu49T1ODneT1iqMBPlpfkgMLFrZjtJEWxt5hAAI55hUmsiVeguWwAHjac2uY972Fn99dYrCv7NE4eE9p00nkcD1Zz2";
  //paypal secret key
  static String paypalSecretKey = "";
  //set term and conditions url here
  static String termsPolicyUrl =
      "https://oxoo.spagreen.net/demo/php/v13/terms/";

  static final bool enableFacebookAuth = false;
  static final bool enableGoogleAuth = true;
  static final bool enablePhoneAuth = true;
  static final bool enableAppleAuthForIOS = true;
  //publicKeyBase64 from play store to implement in app purchase
  static final String publicKeyBase64 =
      "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmXabTbO4NPnGS4ntejfjZz+ix4HxOOELGAXuHk4/Tjx9zasovTBDx3GqtbsSwOWmMdAbz00/+hjLIz92NwUmgkTXDJIQwI4D7bPBC+9fGiCnBE4KQzffm/VXfxS8hzgDIrSpQwQSDgyNOey/rLHFx/GIoayNdhU1EjVm5wOcMsrJuAvVCWLcoGUVCy5pgolEUpsKioDU67C/gWyC+P6ZN2CCJeHwBbpyJnpdo/kPalXnKDfHObKWRp7eqWxECQQFtQGOJ2pnhhbnXdO4OPd3yCO3HXR0b2t3qLWjobFHT3tSv1HDT/N8qonAGT4I4zU5/oKLAnP7QAdVcgFEXaSpbwIDAQAB";
}
