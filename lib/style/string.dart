class Text {
  static var lbl_aplikasi = "Super Apps";

// TODO: Page Title
  static var page_absensi = "Absent";
  static var page_lihat_kantor = "Office Location";
  static var page_profile = "Profile";
  static var page_main_menu = "Home";
  static var page_report_absen = "Report Absent";
  static var page_beranda = "Home";
  static var page_notification = "Notification";
  static var page_report_absen_atasan_detail = "Report Absent Supervisor Detail";
  static var page_report_absen_atasan = "Report Absent Supervisor";

// TODO: List menu
  static var menu_human_capital = "Human Capital";
  static var menu_document_management = "Document Management";
  static var menu_project = "Project";
  static var menu_supply_chain = "Supply Chain";
  static var menu_finance = "FINANCE";
  static var menu_oss = "OSS";
  static var menu_tools = "Tools";
  static var menu_video = "Video";
  static var menu_link = "Link";

// TODO: Label Absen Page
  /* Report Absen */
  static var lbl_strip = "-";
  static var lbl_keterangan = "Description";
  static var lbl_filter = "Filter";
  static var lbl_nomor = "No.";
  static var lbl_tanggal = "Date";
  static var lbl_jam_masuk = "In";
  static var lbl_jam_pulang = "Out";
  static var lbl_ket = "Desc";
  static var lbl_mobile = "Mobile";
  static var lbl_fingerprint = "Fingerprint";
  static var lbl_web = "Web";
  static var lbl_izin = "Izin";
  static var lbl_sppd = "SPPD";
  static var lbl_sakit = "Sakit";
  static var lbl_cuti = "Cuti";
  static var lbl_pengganti_hari_libur = "Penugasan Di luar";
  static var lbl_penugasan_di_luar = "Pengganti Hari Libur";
  static var lbl_keterangan_absen = "Description Absent";
  static var lbl_tulis_disini = "Tulis Disini";

// TODO: Label Profile Page
  /* Profile */
  static var lbl_jenis_kelamin = "Jenis Kelamin";
  static var lbl_hari_lahir = "Hari Lahir";
  static var lbl_agama = "Agama";
  static var lbl_status_menikah = "Status Menikah";
  static var lbl_kantor = "Kantor";
  static var lbl_email = "Email";

// TODO: Label Lihat Kantor Page
  static var lbl_zoom_in = "Zoom In";

// TODO: Label Login Page
  /* Login */
  static var lbl_login = "Login";
  static var lbl_username = "Username";
  static var lbl_password = "Password";

// TODO: Label Main Menu Page
  /* Main Menu */
  static var lbl_more = "More";
  static var lbl_absent = "Absent";

  /* Notification */
  static var lbl_tidak_ada_notification = "Semua notifikasi telah dibaca.";

  static var hint_text = "";
  static var hint_password = "";
}

class Message {
  static var msg_lokasi_tidak_ada =
      "${Text.lbl_aplikasi} tidak dapat mendapatkan lokasi anda!!";
  static var msg_tap_again_to_exit = "Tekan kembali untuk keluar";
  static var msg_locked_apps = "Aplikasi segera hadir";
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
// TODO: URI Icon List Menu
  static var icon_human_capital = "assets/icon/main_menu_page/human_capital.svg";
  static var icon_document_management = "assets/icon/main_menu_page/document_management_abu.svg";
  static var icon_project = "assets/icon/main_menu_page/project_abu.svg";
  static var icon_supply_chain = "assets/icon/main_menu_page/supply_chain_abu.svg";
  static var icon_finance = "assets/icon/main_menu_page/finance_abu.svg";
  static var icon_oss = "assets/icon/main_menu_page/oss_abu.svg";
  static var icon_tools = "assets/icon/main_menu_page/tools_abu.svg";
  static var icon_video = "assets/icon/main_menu_page/video_abu.svg";
  static var icon_link = "assets/icon/main_menu_page/LINK_abu.svg";

// TODO: URI Icon Submenu Human Capital
  static var icon_report_absent = "assets/icon/main_menu_page/report_absent.svg";
  static var icon_office_location = "assets/icon/main_menu_page/human_capital.svg";
  static var icon_report_absent_supervisor = "assets/icon/main_menu_page/report_absent_supervisor.svg";

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
  static var icon_profile = "assets/icon/absen_page/profile_cuti.svg";
  static var icon_absent_failed = "assets/icon/absen_page/absent_failed.svg";

// TODO: URI Images
  static var uri_logo_ta_putih         = "assets/images/logo_ta_putih_nobwh.png";
  static var uri_absen_masuk           = "assets/images/absen_masuk_fingerprint.gif";
  static var uri_human_capital_absen   = "assets/images/human_capital_absen.png";
  static var uri_human_capital_report_absen   = "assets/images/human_capital_report_absen.gif";
  static var uri_human_capital_lokasi_kantor   = "assets/images/human_capital_lokasi_kantor.gif";
  static var uri_login_header   = "assets/images/login_header.png";
  static var uri_bg_profile   = "assets/images/bg_profile.png";
  static var uri_bg_detail_profile   = "assets/images/bg_detail_profile.png";

// TODO:  URI Icon Profile Page
  static var uri_gender   = "assets/icon/profile_page/gender.svg";
  static var uri_brithday   = "assets/icon/profile_page/birthday.svg";
  static var uri_religion   = "assets/icon/profile_page/religion.svg";
  static var uri_status_merried   = "assets/icon/profile_page/profile.svg";
  static var uri_office   = "assets/icon/profile_page/office.svg";
  static var uri_email   = "assets/icon/profile_page/email.svg";
  static var uri_team   = "assets/icon/profile_page/team.svg";
  static var uri_logout   = "assets/icon/profile_page/logout.svg";

// TODO:  URI Icon Main Menu Page
  static var uri_locked_apps = "assets/icon/main_menu_page/coming_soon.svg";
  static var uri_more_apps = "assets/icon/main_menu_page/more.svg";
  static var uri_hide_modalBottom = "assets/icon/main_menu_page/hide.svg";

  static var uri_ic_lokasi_kantor   = "assets/images/lokasi_kantor.png";
  static var uri_ic_naker   = "assets/images/naker.png";

// TODO:  Uri Icon Notification
  static var uri_empty_notification = "assets/icon/notification_page/notification_off.svg";
  static var uri_remainder_notification = "assets/icon/notification_page/megaphone.svg";
  static var uri_absen_notification = "assets/icon/notification_page/absenput.svg";
  static var uri_approval_notification = "assets/icon/notification_page/todolist.svg";
}
