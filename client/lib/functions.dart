String getMonthName (int monthZ) {
  var month = monthZ + 1;
  switch (month) {
    case 1: return 'มกราคม'; break;
    case 2: return 'กุมภาพันธ์'; break;
    case 3: return 'มีนาคม'; break;
    case 4: return 'เมษายน'; break;
    case 5: return 'พฤษภาคม'; break;
    case 6: return 'มิถุนายน'; break;
    case 7: return 'กรกฎาคม'; break;
    case 8: return 'สิงหาคม'; break;
    case 9: return 'กันยายน'; break;
    case 10: return 'ตุลาคม'; break;
    case 11: return 'พฤศจิกายน'; break;
    case 12: return 'ธันวาคม'; break;
    default: {
      return 'ERROR';
    }
  }
}

String getMonthNameShort (int monthZ) {
  var month = monthZ + 1;
  switch (month) {
    case 1: return 'ม.ค'; break;
    case 2: return 'ก.พ'; break;
    case 3: return 'มี.ย'; break;
    case 4: return 'เม.ย'; break;
    case 5: return 'พ.ค.'; break;
    case 6: return 'มิ.ย'; break;
    case 7: return 'ก.ค.'; break;
    case 8: return 'ส.ค.'; break;
    case 9: return 'ก.ย.'; break;
    case 10: return 'ต.ค.'; break;
    case 11: return 'พ.ย.'; break;
    case 12: return 'ธ.ค.'; break;
    default: {
      return 'ERROR';
    }
  }
}

int convertYearToBE (int year) {
  return year + 543;
}