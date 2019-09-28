class Text {
// TODO: Page Title
  static var page_absensi = "Absen";
  static var page_lihat_kantor = "Lihat Kantor";
  static var page_profile = "Profile";
  static var page_main_menu = "Main Menu";
  static var page_report_absen = "Report Absen";
  static var page_beranda = "Beranda";
  static var lbl_aplikasi = "Super Apps";

// TODO: Label Absen Page
  static var lbl_strip = "-";
  static var lbl_keterangan = "Keterangan";
  static var lbl_filter = "Filter";
  static var lbl_nomor = "No.";
  static var lbl_tanggal = "Tanggal";
  static var lbl_jam_masuk = "Jam Masuk";
  static var lbl_jam_pulang = "Jam Pulang";
  static var lbl_ket = "Ket";
  static var lbl_mobile = "Mobile";
  static var lbl_fingerprint = "Fingerprint";
  static var lbl_web = "Web";
  static var lbl_izin = "Izin";
  static var lbl_sppd = "SPPD";
  static var lbl_sakit = "Sakit";
  static var lbl_cuti = "Cuti";
  static var lbl_pengganti_hari_libur = "Penugasan Di luar";
  static var lbl_penugasan_di_luar = "Pengganti Hari Libur";
  static var lbl_keterangan_absen = "Keterangan Absen";
  static var lbl_tulis_disini = "Tulis Disini";

// TODO: Label Profile Page
  static var lbl_jenis_kelamin = "Jenis Kelamin";
  static var lbl_hari_lahir = "Hari Lahir";
  static var lbl_agama = "Agama";
  static var lbl_status_menikah = "Status Menikah";
  static var lbl_kantor = "Kantor";
  static var lbl_email = "Email";

// TODO: Label Lihat Kantor Page
  static var lbl_zoom_in = "Zoom IN";

// TODO: Label Login Page
  static var lbl_login = "Login";
  static var lbl_username = "Username";
  static var lbl_password = "Password";

// TODO: Label Main Menu Page
  static var lbl_human_capital = "Human Capital";

  static var hint_text = "";
  static var hint_password = "";
}

class Message {
  static var msg_lokasi_tidak_ada =
      "${Text.lbl_aplikasi} tidak dapat mendapatkan lokasi anda!!";
  static var msg_tap_again_to_exit = "Tap back again to leave";
  static var msg_locked_apps = "aplikasi segera hadir";
  static var msg_cek_koneksi_internet = "Cek koneksi internet anda!";

//  Message Absen Page
  static var msg_absen_masuk = "Absen masuk berhasil !Selamat bekerja rekan ";
  static var msg_absen_pulang = "Absen pulang berhasil !Semoga hari esok akan lebih indah ";
  static var msg_absen_complete = "Absen pulang berhasil !Semoga hari esok akan lebih indah ";

}

class Images {
  // TODO: URI Images Main Menu Page
  static var uri_logo_ta_putih = "assets/images/logo_ta_putih_nobwh.png";
  static var uri_human_capital_absen = "assets/images/human_capital_absen.png";
  static var uri_human_capital_report_absen =
      "assets/images/human_capital_report_absen.gif";
  static var uri_human_capital_lokasi_kantor =
      "assets/images/human_capital_lokasi_kantor.gif";

// TODO: URI Images Absen Page
  static var uri_absen_masuk = "assets/images/absen_masuk_fingerprint.gif";

// TODO: URI Images Login Page
  static var uri_login_header = "assets/images/login_header.png";

// TODO: URI Images Profile Page
  static var uri_bg_profile = "assets/images/bg_profile.png";
  static var uri_bg_detail_profile = "assets/images/bg_detail_profile.png";

// TODO: URI Images Lihat Kantor Page
  static var uri_ic_lokasi_kantor = "assets/images/lokasi_kantor.png";
  static var uri_ic_naker = "assets/images/naker.png";
}

class Icons {
// TODO: URI Icon Profile Page
  static var icon_gender = "assets/icon/profile_page/gender.svg";
  static var icon_brithday = "assets/icon/profile_page/birthday.svg";
  static var icon_religion = "assets/icon/profile_page/religion.svg";
  static var icon_status_merried = "assets/icon/profile_page/profile.svg";
  static var icon_office = "assets/icon/profile_page/office.svg";
  static var icon_email = "assets/icon/profile_page/email.svg";
  static var icon_team = "assets/icon/profile_page/team.svg";
  static var icon_logout = "assets/icon/profile_page/logout.svg";

// TODO: URI Icon Main Menu Page
  static var icon_locked_apps = "assets/icon/main_menu_page/coming_soon.svg";

// TODO: URI Icon Absen Page
  static var icon_absen_masuk = "assets/icon/absen_page/absen_masuk.svg";
  static var icon_absen_pulang = "assets/icon/absen_page/absen_pulang.svg";
  static var icon_absen_complete = "assets/icon/absen_page/absen_complete.svg";
}
