// Unterputzgehäuse
up_innen_breite = 100;
up_innen_tiefe = 47;
up_innen_hoehe = 300;
up_aussen_breite = 117;
up_aussen_tiefe = 52;
up_aussen_hoehe = 318;

// Rahmen
r_innen_breite = 100;
r_innen_tiefe = 11.5;
r_innen_hoehe = 300;
r2_innen_hoehe = 13.5;
r_aussen_breite = 131;
r_aussen_tiefe = 18;
r_aussen_hoehe = 332;

// Module
m_breite = 99;
m_tiefe = 11;
m_hoehe = 99;


// Rahmen
module rahmen(aussen_breite, aussen_tiefe, aussen_hoehe, innen_breite, innen_tiefe, innen_hoehe) {
    aus_breite = 80;
    aus_hoehe = 82;
    steg = 18;
    aus_diff = (aussen_hoehe - 3 * aus_hoehe - 2 * steg)/2;
    difference() {
        cube([aussen_breite, aussen_tiefe, aussen_hoehe]);
        translate([(aussen_breite-innen_breite)/2,
             -.1,
            (aussen_hoehe-innen_hoehe)/2])
        cube([innen_breite, innen_tiefe, innen_hoehe]);
        for(i=[0:2]) {
            #translate([(aussen_breite-aus_breite)/2,aussen_tiefe/2,aus_diff+i*(aus_hoehe+steg)])
            cube([aus_breite, 10, aus_hoehe]);
        }
    }
}


rahmen(r_aussen_breite, r_aussen_tiefe, r_aussen_hoehe, r_innen_breite, r_innen_tiefe, r_innen_hoehe);
