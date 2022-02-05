// Unterputzgehäuse
up_innen_breite = 100;
up_innen_tiefe = 300;
up_innen_hoehe = 47;
up_aussen_breite = 117;
up_aussen_tiefe = 318;
up_aussen_hoehe = 52;

// Rahmen
r_innen_breite = 100;
r_innen_tiefe = 300;
r_innen_hoehe = 11.5;
r2_innen_hoehe = 13.5;
r_aussen_breite = 131;
r_aussen_tiefe = 332;
r_aussen_hoehe = 18;

// Module
m_breite = 99;
m_tiefe = 99;
m_hoehe = 11;


// Rahmen
module rahmen(aussen_breite, aussen_tiefe, aussen_hoehe, innen_breite, innen_tiefe, innen_hoehe) {
    aus_breite = 80;
    aus_tiefe = 82;
    steg = 18;
    aus_diff = (aussen_tiefe - 3*aus_tiefe - 2*steg)/2;
    difference() {
        cube([aussen_breite, aussen_tiefe, aussen_hoehe]);
        translate([(aussen_breite-innen_breite)/2,
            (aussen_tiefe-innen_tiefe)/2,
            aussen_hoehe-innen_hoehe+.1])
        cube([innen_breite, innen_tiefe, innen_hoehe]);
        for(i=[0:2]) {
            translate([(aussen_breite-aus_breite)/2,aus_diff+i*(aus_tiefe+steg),-1])
            cube([aus_breite, aus_tiefe, 10]);
        }
    }
}


rahmen(r_aussen_breite, r_aussen_tiefe, r_aussen_hoehe, r_innen_breite, r_innen_tiefe, r_innen_hoehe);