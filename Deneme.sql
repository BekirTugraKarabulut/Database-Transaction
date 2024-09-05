-- Tüm segmentlerin indirim oranlarını yükselttim.
UPDATE product_segment

SET dıscount = dıscount + 0.09;

-- Tüm net fiyatları yeni fiyatlarını değiştiricem.

UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE p.segment_ıd = ps.ıd);


savepoint all_segment;


-- Lüks segmentteki ürünlerin indirim oranlarını güncelledim.

UPDATE product_segment

SET dıscount = dıscount + 0.10

WHERE ıd = 2;

-- Lüks segmentteki ürünlerin net fiyatlarını güncelledim ve yazdırdım.

UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE ps.ıd = p.segment_ıd)

WHERE EXISTS (

                SELECT 1
                
                FROM product_segment ps
                
                WHERE ps.ıd = p.segment_ıd
                    and ps.ıd = 2

              );
              
savepoint lux_segment;              


-- Lüks olmayan segmentteki ürünlerin indirim oranlarını güncelledim.

UPDATE product_segment

SET dıscount = dıscount + 0.05

WHERE ıd = 3;


-- Lüks olmayan segmentteki ürünlerin net fiyatlarını güncelledim ve yazdırdım.

UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE p.segment_ıd = ps.ıd)

WHERE EXISTS (
                SELECT 1
                
                FROM product_segment ps
                
                WHERE p.segment_ıd = ps.ıd
                    and ps.ıd = 3
                    
                );
                
rollback to all_segment;                 
                                

SELECT *

FROM product_segment;

SELECT *

FROM product;

-- armchair 571,47  id : 1 , 499,03 , 499,03 , 499,03

-- bed 173,7  id : 3 , 153,13 , 153,13 , 141,7

-- bookcase 311,48  id : 2 , 223,53 , 186,89 , 186,89



