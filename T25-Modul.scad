m_breite = 99;
m_tiefe = 99;
m_hoehe = 11;
wand = 2;
b_breite = 76; // 78 mit aussparung für Nasen
b_tiefe =78;
b_hoehe = 11;
d_dm = 60;
h_breite = 8;
h_tiefe = 4;
h_hoehe = 8;
r_breite = 65;
r_tiefe = 30;
r_hoehe = 2;
$fn=60;
    loch = 4;
    abstand_h = 1.5;
    abstand_d = 6;
    platine =1.5;

m_rand = (m_breite-b_breite)/2;

module rfid() {
    color("blue")
    difference() {
        cube([60,43,platine]);
        // Befestigungslöcher
        translate([7,10,-1])

            cylinder(d=loch, h=4);

        translate([7,36,-1])
        cylinder(d=loch, h=4);
        translate([44,5.5,-1])
        cylinder(d=loch, h=4);
        translate([44,40,-1])
        cylinder(d=loch, h=4);
    }
    translate([47,0,platine])
    //quarz
    cube([10,5,3.5]);
}

module rfid_mount() {
    translate([7,10,0])
    union() {
        cylinder(d=abstand_d, h=abstand_h);
        cylinder(d=loch-.2, abstand_h+platine*2);
    }
    translate([7,36,0])
    union() {
        cylinder(d=abstand_d, h=abstand_h);
        cylinder(d=loch-.2, abstand_h+platine*2);
    }
    translate([44,5.5,0])
    union() {
        cylinder(d=abstand_d, h=abstand_h);
        cylinder(d=loch-.2, abstand_h+platine*2);
    }
    translate([44,40,0])
    union() {
        cylinder(d=abstand_d, h=abstand_h);
        cylinder(d=loch-.2, abstand_h+platine*2);
    }
}

module raspi(b=65, t=30, h=2) {
    abstand = 3.5;
    abstand_b = b-2*abstand;
    abstand_t = t-2*abstand;
    loch = 3;
    color("green")
    difference() {    
    cube([b,t,h]);
        for(i=[0:1]) {
            for(j=[0:1]) {
                translate([abstand+j*abstand_b,abstand+i*abstand_t, -.1])
                cylinder(d=loch, h=2*h);
            }
        }
    }
}

module hausnummer() {
    // Hausnummer
    translate([22,15,-1])
    linear_extrude(2)
    text(text = "9", size = 72); 
}

module klingel(b,t) {
    translate([(m_breite-b)/2, 3*(m_tiefe-t)/4, -.1])
    cube([b, t, 4]);
}

module klingel_rund(d) {
    translate([m_breite/2, 3*m_tiefe/4, -.1])
    cylinder(d=d, 4);
}

    
module pfeil() {
    // Pfeil
    translate([3.5,10,m_hoehe-wand-1])
    linear_extrude(2)
    text(text ="^", size = 10);
    translate([4.9,10,m_hoehe-wand-1])
    linear_extrude(2)
    text(text ="I", size = 10); 
}

module kamera(x,y,z,d) {
    translate([x,y,z-.1])
    cylinder(h=4, d=d);
    translate([x,y,z+1])
    cylinder(h=4, d=d+2);
    }
    
module kamera_mount() {
    hoehe_sockel = 10;
    dm_sockel = 4;
    tiefe_loch = hoehe_sockel -2;
    dm_loch = 2;
    difference() {
        union() {
            translate([0,-10.5,0])
            cylinder(h=hoehe_sockel, d=dm_sockel);
            
            translate([0,10.5,0])
            cylinder(h=hoehe_sockel, d=dm_sockel);
            
            translate([12.5,-10.5,0])
            cylinder(h=hoehe_sockel, d=dm_sockel);
            
            translate([12.5,10.5,0])
            cylinder(h=hoehe_sockel, d=dm_sockel);
        }

        translate([0,-10.5,5])
        cylinder(h=tiefe_loch, d=dm_loch);
        
        translate([0,10.5,5])
        cylinder(h=tiefe_loch, d=dm_loch);
        
        translate([12.5,-10.5,5])
        cylinder(h=tiefe_loch, d=dm_loch);
        
        translate([12.5,10.5,5])
        cylinder(h=tiefe_loch, d=dm_loch);
    }
}

module raspi() {
    difference() {
        cube([31,65,1.5]);
        
        for(i=[0,1]) {
            for(j=[0,1]) {
                translate([3.5+j*24,3.5+i*58,-.1])
                cylinder(d=2.8,h=2);
            }
        }
        
    }
}
module raspi_mount() {
    for(i=[0,1]) {
        for(j=[0,1]) {
            translate([3.5+j*24,3.5+i*58,wand])
            difference() {
                cylinder(d=7,h=21);
                translate([0,0,6])
                cylinder(d=2.5,h=16);
            }
        }
    } 
  
}


module hohlraum(breite, tiefe, hoehe, radius) {
    // hohlraum unten
    translate([radius,radius,0])
    difference() {
        minkowski(){
            cube([breite-2*radius, tiefe-2*radius, hoehe]);
            sphere(r=radius);
        }
        translate([-radius,-radius,-(hoehe+radius)])
        cube([breite, tiefe, hoehe+2*radius]);        
    }
    // hohlraum oben
    translate([m_rand+wand+h_tiefe/2, (m_tiefe-b_tiefe)/2+wand, m_hoehe+wand])
    minkowski() {
        cube([breite-2*(wand+radius)-h_tiefe, tiefe-2*(wand+radius), 3*hoehe]);
        cylinder(d=radius, h=1);
    }
}

module deckel(breite, tiefe, hoehe, radius) {
    translate([m_rand+wand+h_tiefe/2, (m_tiefe-b_tiefe)/2+wand, 0])
    minkowski() {
        cube([breite-2*(wand+radius)-h_tiefe, tiefe-2*(wand+radius), hoehe]);
        cylinder(d=radius, h=.001);
    }
}

module gehaeuse() {
    difference() {
        union() {
            cube([m_breite, m_tiefe, m_hoehe]);
            translate([m_rand, (m_tiefe-b_tiefe)/2, m_hoehe])
            cube([b_breite, b_tiefe, b_hoehe]);

        }
        // Dichtung
        translate([wand,wand,m_hoehe-wand])
        difference() {
            cube([m_breite-2*wand, m_tiefe-2*wand, 2*wand]);
            translate([(m_breite-2*wand-b_breite)/2, (m_tiefe-2*wand-b_tiefe)/2,0])
            cube([b_breite,b_tiefe, 3*wand]);
        }
        // Haltemulden
        translate([m_rand-1,(m_tiefe-b_tiefe)/2+14,m_hoehe+1])
        cube([4,8,7]);
        translate([m_rand-1,(m_tiefe-b_tiefe)/2+b_tiefe-14-8,m_hoehe+1])
        cube([4,8,7]);
        translate([m_rand+b_breite-3,(m_tiefe-b_tiefe)/2+30,m_hoehe+1])
        cube([4,8,7]);
    }
    for(i=[0,1]) {
        for(j=[0,1]) {
            translate([m_rand+8+j*60,m_rand+5+i*66,wand])
            difference() {
                cylinder(d=7,h=18);
                translate([0,0,6])
                cylinder(d=2.5,h=16);
            }
        }
    }     
    
}

// Modul

difference() {

    gehaeuse();
    /*-m_hoehe+wand/2*/
    translate([m_rand/2,m_rand/2,-m_hoehe+wand/2+.5])
    hohlraum(b_breite+m_rand, b_tiefe+m_rand, m_hoehe-2*wand, m_rand);
    translate([(m_rand-wand)/2,(m_rand-wand)/2,m_hoehe+b_hoehe-wand])
    deckel(b_breite+m_rand+wand, b_tiefe+m_rand+wand,wand+.1, m_rand); 
   
    pfeil();
    
    // hausnummer();
    
    kamera(m_breite/2, 3*m_tiefe/5, 0, 14);
    
    // klingel(61,18);
    
    // klingel_rund(22);
   
}

/* rfid halterungen
translate([30,15,wand])
rfid_mount(); */

/* rfid karte 
translate([30,15,wand+abstand_h])
rfid(); */

/*translate([(m_breite-r_breite)/2, (m_tiefe-r_tiefe)/2, 10])
raspi(r_breite, r_tiefe, r_hoehe); */

/* kamera halterung*/
translate([m_breite/2, 3*m_tiefe/5, wand])
kamera_mount(); 

/* raspi 
translate([(m_breite-31)/2,(m_tiefe-65)/2, 23])
raspi();*/
translate([(m_breite-31)/2,(m_tiefe-65)/2, 0])
raspi_mount();

/* deckel 
color("red")
scale([.995,.995,1])
translate([(m_rand-wand)/2,(m_rand-wand)/2,m_hoehe+b_hoehe-wand])
deckel(b_breite+m_rand+wand, b_tiefe+m_rand+wand,wand, m_rand);*/

/* Deckelhalterung */
for(i=[0,1]) {
    for(j=[0,1]) {
        translate([m_rand+8+j*60,m_rand+5+i*66,wand])
        difference() {
        cylinder(d=7,h=18);
        translate([0,0,6])
        cylinder(d=2.5,h=16);
        }
    }
} 
