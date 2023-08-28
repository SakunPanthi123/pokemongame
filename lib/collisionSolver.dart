import 'dart:developer';

String lDT = '';
String rDT = '';
String uDT = '';
String dDT = '';
String lrDT = '';
String udDT = '';
String ldDT = '';
String luDT = '';
String ruDT = '';
String rdDT = '';

void solver(String dir, String x, String y) {
  if (dir == 'l') {
    lDT += '[$x,$y], ';
    log('l: $lDT');
  }
  if (dir == 'r') {
    rDT += '[$x,$y], ';
    log('r: $rDT');
  }
  if (dir == 'u') {
    uDT += '[$x,$y], ';
    log('u: $uDT');
  }
  if (dir == 'd') {
    dDT += '[$x,$y], ';
    log('d: $dDT');
  }
  if (dir == 'lr') {
    lrDT += '[$x,$y], ';
    log('lr: $lrDT');
  }
  if (dir == 'ud') {
    udDT += '[$x,$y], ';
    log('ud: $udDT');
  }
  if (dir == 'ld') {
    ldDT += '[$x,$y], ';
    log('ld: $ldDT');
  }
  if (dir == 'lu') {
    luDT += '[$x,$y], ';
    log('lu: $luDT');
  }
  if (dir == 'ru') {
    ruDT += '[$x,$y], ';
    log('ru: $ruDT');
  }
  if (dir == 'rd') {
    rdDT += '[$x,$y], ';
    log('rd: $rdDT');
  }
}

void clear() {
  lDT = '';
  rDT = '';
  uDT = '';
  dDT = '';
  lrDT = '';
  udDT = '';
  ldDT = '';
  luDT = '';
  ruDT = '';
  rdDT = '';
}
