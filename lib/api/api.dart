
class Api{
  // host

  static var host_i = "10.204.200.8";
  //static var host_i = "203.130.242.238";
  static var host = "http://${host_i}:";

  // port
  static var p_hrmista = "3001";
  static var p_sso = "3002";
  static var p_super_apps = "3003";
  static var p_absen = "3004";

  // app sso
  static var login = host+p_sso+"/auth_post_sso/";

  // app hrmista
  static var profile = host+p_hrmista+"/data_profile/";

  // absen
  static var status_absen = host+p_absen+"/status_masuk_absen/";
  static var absen =  host+p_absen+"/absensi/";
  static var lihat_kantor = host+p_absen+"/lokasi_kantor/";
  static var report_absen = host+p_absen+"/report_absen/";

  // super apps
  static var menu =  host+p_super_apps+"/settings_super_apps/";
  static var notification =  host+p_super_apps+"/count_notification/";


  // versi aplikasi
  static var versi = "1";

}