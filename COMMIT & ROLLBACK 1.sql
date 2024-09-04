INSERT INTO colors

VALUES ('Pink');

INSERT INTO colors

VALUES ('Purple');

INSERT INTO colors

VALUES ('Grey');

UPDATE colors

SET color = 'Light Blue'

WHERE color = 'Blue';

commit;

SELECT *

FROM colors;