-- Tüm segmentteki ürünlerin indirim oranı güncelleniyor. --
UPDATE product_segment 

SET dıscount = dıscount + 0.08;

-- Tüm segmentteki ürünlerin indirim miktarı hesaplanarak net ücret güncelleniyor. --
UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE p.segment_ıd = ps.ıd);

savepoint all_segment;  -- 1. save noktası

-- Lüks segmentindeki ürünlerin indirim oranı güncelleniyor. --
UPDATE product_segment 

SET dıscount = dıscount + 0.15

WHERE segment like '%Luxury%';

-- Lüks segmentteki ürünlerin indirim miktarı hesaplanarak net ücret güncelleniyor. --
UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE p.segment_ıd = ps.ıd)

WHERE segment_ıd IN (

                    SELECT p.ıd
                    
                    FROM product_segment ps
                    
                    WHERE ps.segment like '%Luxury%'
                );

savepoint luxury_segment;

SELECT sum(net_price) FROM product;

-- Lüks olmayan segmentindeki ürünlerin indirim oranı güncelleniyor. --
UPDATE product_segment

SET dıscount = dıscount + 0.05

WHERE segment = 'Mass';

-- Lüks olmayan segmentteki ürünlerin indirim miktarı hesaplanarak net ücret güncelleniyor. --
UPDATE product p

SET net_prıce = prıce - prıce * (SELECT dıscount FROM product_segment ps WHERE p.segment_ıd = ps.ıd)

WHERE segment_ıd IN (
                        SELECT product_segment.ıd
                        
                        FROM product_segment 
                        
                        WHERE product_segment.segment = 'Mass'

                    );
                    
SELECT sum(net_price) FROM product;

rollback;

rollback to all_segment;

--10568,81 -- 9661,46 -- 9540,72 -- 9477,72








