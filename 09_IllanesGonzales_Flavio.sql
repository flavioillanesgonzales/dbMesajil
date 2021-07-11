USE MASTER
GO
DROP DATABASE  IF EXISTS dbMESAJIL
GO
CREATE DATABASE dbMESAJIL
GO
USE dbMESAJIL
GO
SET DATEFORMAT dmy
GO
-- tables
-- Table: BOLETA
CREATE TABLE BOLETA (
    IDBOL int  NOT NULL IDENTITY(1, 1),
    IDCLI int  NOT NULL,
    IDEMP int  NOT NULL,
    TOTBOL decimal(10,3)  NOT NULL,
    FECBOL date  NOT NULL,
    CONSTRAINT BOLETA_pk PRIMARY KEY  (IDBOL)
);

-- Table: BOLETA_DETALLE
CREATE TABLE BOLETA_DETALLE (
    IDBOLDET int  NOT NULL IDENTITY(1, 1),
    IDBOL int  NOT NULL,
    IDPRO int  NOT NULL,
    CANTDET int  NOT NULL,
    SUBDET decimal(10,2)  NOT NULL,
    CONSTRAINT BOLETA_DETALLE_pk PRIMARY KEY  (IDBOLDET)
);

-- Table: CATEGORIA
CREATE TABLE CATEGORIA (
    IDCAT int  NOT NULL IDENTITY(1, 1),
    NOMCAT varchar(100)  NOT NULL,
    NOMTIP varchar(100)  NOT NULL,
    CONSTRAINT CATEGORIA_pk PRIMARY KEY  (IDCAT)
);

-- Table: CLIENTE
CREATE TABLE CLIENTE (
    IDCLI int  NOT NULL IDENTITY(1, 1),
    NOMCLI varchar(60)  NOT NULL,
    APECLI varchar(60)  NOT NULL,
    CELCLI char(9)  NOT NULL,
    CORCLI varchar(60)  NOT NULL,
    DIRCLI varchar(100)  NOT NULL,
    CODUBI char(6)  NOT NULL,
    IDUSU int NULL,
    ESTCLI char(1)  NOT NULL,
    CONSTRAINT CLIENTE_pk PRIMARY KEY  (IDCLI)
);

-- Table: EMPLEADO
CREATE TABLE EMPLEADO (
    IDEMP int  NOT NULL IDENTITY(1, 1),
    IDSUC int  NOT NULL,
    NOMEMP varchar(60)  NOT NULL,
    APEEMP varchar(60)  NOT NULL,
    COREMP Varchar(60)  NOT NULL,
    CELEMP char(9)  NOT NULL,
    DIREMP varchar(100)  NOT NULL,
    CODUBI char(6)  NOT NULL,
    SUEEMP decimal(8,3)  NOT NULL,
    IDUSU int  NULL,
    TIPEMP char(1)  NOT NULL,
    ESTEMP char(1)  NOT NULL,
    CONSTRAINT EMPLEADO_pk PRIMARY KEY  (IDEMP)
);

-- Table: MARCA
CREATE TABLE MARCA (
    IDMAR int  NOT NULL IDENTITY(1, 1),
    NOMMAR varchar(100)  NOT NULL,
    NOMMOD varchar(100)  NOT NULL,
    COMMAR varchar(120) NULL,
    IDCAT int  NOT NULL,
    CONSTRAINT MARCA_pk PRIMARY KEY  (IDMAR)
);

-- Table: PRODUCTO
CREATE TABLE PRODUCTO (
    IDPRO int  NOT NULL IDENTITY(1, 1),
    IDMAR int  NOT NULL,
    MATPRO varchar(60)   NULL,
    COLPRO varchar(60)  NULL,
    DESPRO varchar(500)   NULL,
    CARPRO varchar(300)  NULL,
    CANPRO int  NOT NULL,
    PREPRO decimal(12,3)  NOT NULL,
    ESTPRO char(1)  NOT NULL,
    CONSTRAINT PRODUCTO_pk PRIMARY KEY  (IDPRO)
);

-- Table: SUCURSAL
CREATE TABLE SUCURSAL (
    IDSUC int  NOT NULL IDENTITY(1, 1),
    CELSUC char(9)  NOT NULL,
    CORSUC varchar(70)  NOT NULL,
    DIRSUC varchar(100)  NOT NULL,
    CODUBI char(6)  NOT NULL,
    ESTSUC char(1)  NOT NULL,
    CONSTRAINT SUCURSAL_pk PRIMARY KEY  (IDSUC)
);

-- Table: UBIGEO
CREATE TABLE UBIGEO (
    CODUBI char(6)  NOT NULL,
    NOMDEP varchar(50)  NOT NULL,
    NOMPRO varchar(50)  NOT NULL,
    NOMDIS varchar(50)  NOT NULL,
    CONSTRAINT UBIGEO_pk PRIMARY KEY  (CODUBI)
);

-- Table: USUARIO
CREATE TABLE USUARIO (
    IDUSU int  IDENTITY(1, 1),
    NOMUSU varchar(50)  NOT NULL,
    CONUSU varchar(50)  NOT NULL,
    NIVUSU char(1)  NOT NULL,
    ESTUSU char(1)  NOT NULL,
    CONSTRAINT USUARIO_pk PRIMARY KEY  (IDUSU)
);

-- foreign keys
-- Reference: BOLETA_BOLETA_DETALLE_IDBOL (table: BOLETA_DETALLE)
ALTER TABLE BOLETA_DETALLE ADD CONSTRAINT BOLETA_BOLETA_DETALLE_IDBOL
    FOREIGN KEY (IDBOL)
    REFERENCES BOLETA (IDBOL);

-- Reference: CATEGORIA_MARCA_IDCAT (table: MARCA)
ALTER TABLE MARCA ADD CONSTRAINT CATEGORIA_MARCA_IDCAT
    FOREIGN KEY (IDCAT)
    REFERENCES CATEGORIA (IDCAT);

-- Reference: CLIENTE_BOLETA_IDCLI (table: BOLETA)
ALTER TABLE BOLETA ADD CONSTRAINT CLIENTE_BOLETA_IDCLI
    FOREIGN KEY (IDCLI)
    REFERENCES CLIENTE (IDCLI);

-- Reference: EMPLEADO_BOLETA_IDEMP (table: BOLETA)
ALTER TABLE BOLETA ADD CONSTRAINT EMPLEADO_BOLETA_IDEMP
    FOREIGN KEY (IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: MARCA_PRODUCTO_IDMAR (table: PRODUCTO)
ALTER TABLE PRODUCTO ADD CONSTRAINT MARCA_PRODUCTO_IDMAR
    FOREIGN KEY (IDMAR)
    REFERENCES MARCA (IDMAR);

-- Reference: PRODUCTO_BOLETA_DETALLE_IDPRO (table: BOLETA_DETALLE)
ALTER TABLE BOLETA_DETALLE ADD CONSTRAINT PRODUCTO_BOLETA_DETALLE_IDPRO
    FOREIGN KEY (IDPRO)
    REFERENCES PRODUCTO (IDPRO);

-- Reference: SUCURSAL_EMPLEADO_IDSUC (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT SUCURSAL_EMPLEADO_IDSUC
    FOREIGN KEY (IDSUC)
    REFERENCES SUCURSAL (IDSUC);

-- Reference: UBIGEO_CLIENTE_CODUBI (table: CLIENTE)
ALTER TABLE CLIENTE ADD CONSTRAINT UBIGEO_CLIENTE_CODUBI
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: UBIGEO_EMPLEADO_CODUBI (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT UBIGEO_EMPLEADO_CODUBI
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: UBIGEO_SUCURSAL_CODUBI (table: SUCURSAL)
ALTER TABLE SUCURSAL ADD CONSTRAINT UBIGEO_SUCURSAL_CODUBI
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: USUARIO_CLIENTE_IDUSU (table: CLIENTE)
ALTER TABLE CLIENTE ADD CONSTRAINT USUARIO_CLIENTE_IDUSU
    FOREIGN KEY (IDUSU)
    REFERENCES USUARIO (IDUSU);

-- Reference: USUARIO_EMPLEADO_IDUSU (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT USUARIO_EMPLEADO_IDUSU
    FOREIGN KEY (IDUSU)
    REFERENCES USUARIO (IDUSU);



INSERT INTO UBIGEO
	(CODUBI,NOMDEP,NOMPRO,NOMDIS)
VALUES
	('150101','LIMA','LIMA','LIMA'),
	('150102','LIMA','LIMA','ANCON'),
	('150103','LIMA','LIMA','ATE'),
	('150104','LIMA','LIMA','BARRANCO'),
	('150105','LIMA','LIMA','BREÑA'),
	('150106','LIMA','LIMA','CARABAYLLO'),
	('150107','LIMA','LIMA','CHACLACAYO'),
	('150108','LIMA','LIMA','CHORRILLOS'),
	('150109','LIMA','LIMA','CIENEGUILLA'),
	('150110','LIMA','LIMA','COMAS'),
	('150111','LIMA','LIMA','EL AGUSTINO'),
	('150112','LIMA','LIMA','INDEPENDENCIA'),
	('150113','LIMA','LIMA','JESUS MARIA'),
	('150114','LIMA','LIMA','LA MOLINA'),
	('150115','LIMA','LIMA','LA VICTORIA'),
	('150116','LIMA','LIMA','LINCE'),
	('150117','LIMA','LIMA','LOS OLIVOS'),
	('150118','LIMA','LIMA','LURIGANCHO'),
	('150119','LIMA','LIMA','LURIN'),
	('150120','LIMA','LIMA','MAGDALENA DEL MAR'),
	('150121','LIMA','LIMA','MAGDALENA VIEJA'),
	('150122','LIMA','LIMA','MIRAFLORES'),
	('150123','LIMA','LIMA','PACHACAMAC'),
	('150124','LIMA','LIMA','PUCUSANA'),
	('150125','LIMA','LIMA','PUENTE PIEDRA'),
	('150126','LIMA','LIMA','PUNTA HERMOSA'),
	('150127','LIMA','LIMA','PUNTA NEGRA'),
	('150128','LIMA','LIMA','RIMAC'),
	('150129','LIMA','LIMA','SAN BARTOLO'),
	('150130','LIMA','LIMA','SAN BORJA'),
	('150131','LIMA','LIMA','SAN ISIDRO'),
	('150132','LIMA','LIMA','SAN JUAN DE LURIGANCHO'),
	('150133','LIMA','LIMA','SAN JUAN DE MIRAFLORES'),
	('150134','LIMA','LIMA','SAN LUIS'),
	('150135','LIMA','LIMA','SAN MARTIN DE PORRES'),
	('150136','LIMA','LIMA','SAN MIGUEL'),
	('150137','LIMA','LIMA','SANTA ANITA'),
	('150138','LIMA','LIMA','SANTA MARIA DEL MAR'),
	('150139','LIMA','LIMA','SANTA ROSA'),
	('150140','LIMA','LIMA','SANTIAGO DE SURCO'),
	('150141','LIMA','LIMA','SURQUILLO'),
	('150142','LIMA','LIMA','VILLA EL SALVADOR'),
	('150143','LIMA','LIMA','VILLA MARIA DEL TRIUNFO')
GO

INSERT INTO USUARIO
	(NOMUSU,CONUSU,NIVUSU,ESTUSU)
VALUES
	('ADMIN','1234','4','A'),
	('MOOD','5678','4','A'),
	('LOOPER','2003','4','A'),
	('LOKID','199921','3','A'),
	('USEADD','KLK123','3','A'),
	('SIRWELL','KALLO12','3','A'),
	('MAIK12','MKK122','2','A'),
	('MICH22','MICHIII','2','A'),
	('SONYA123','2000WE','1','A'),
	('CAARL343','23331','1','A'),
	('LAYKA133','LYY333333','1','A'),
	('SIMON22','KARLO344','1','A'),
	('CR7','CRR122','1','A'),
	('FIORELAGG12','MARTINEZ22','1','A')
GO

INSERT INTO CLIENTE
	(NOMCLI,APECLI,CELCLI,CORCLI,DIRCLI,CODUBI,IDUSU,ESTCLI)
VALUES
	('EMERSON CARLOS','PEREZ LOPEZ','934535646','Carlo@gmail.com','Jr. Gonzales Prada 501','150141','10','A'),
	('SONYA MARIELA','RAMOZ FRETEL','945436754','Soofsa@hotmail.com','Av. el Parque4','150140','9','A'),
	('ELENA MARICIELO','CACEDA CABEZAS','934285845','CACELIN34@gmail.com','Los Higos 102','150114',NULL,'A'),
	('PEDRO MARTIN','HUASHAM HUAMAN','934234434','PEPE@gmail.com','Av Gral Trinidad Moran 698','150116',NULL,'A'),
	('MIRELLA ANDREA','RAMOS QUIROZ','949586772','Miree@gmail.com','Sagrada Familia 14,','150132',NULL,'A'),
	('ANDRES WALTER','VILCHEZ RIVAZ','948593283','ADREW@hotmail.com','MZ s/n Lt 43','150117','12','A'),
	('CALOS ALBERTO','FINRESH ESQUIVAZ','934324563','Calin@gmail.com','Av. Alfredo Mendiola','150117',NULL,'A'),
	('MARIA FERNANADA','CAMPOS ABURTO','938475829','Mafhii@outlook.com','Av. Defensores del Morro','150108','11','A'),
	('FIORELA FRANCESCA','RAMOZ MARTINEZ','976584736','Leyfi@gmail.com','Asoc. Los jardines de Manchay, Quebrada Retamal','150123','14','A'),
	('VICTORIA KATHERINE','ALFARO FERNANDEZ','965768539','Vicky@gmail.com','B-, San Pedro 50','150119',NULL,'A')
GO

INSERT INTO SUCURSAL
	(CELSUC,CORSUC,DIRSUC,CODUBI,ESTSUC)
VALUES
	('934934276','tienda107@mesajilhnos.com','Av. Garcilaso de la Vega 1249 – Tienda 107 – Lima','150115','A'),
	('998192606','ventas@mesajil.com','Av. Garcilaso de la Vega 1261- Tienda 213 – Lima','150115','A'),
	('977572751','ventas@mesajil.com','Jr. Camaná 1127 Lima – Cercado','150115','A'),
	('983472621','tiendasi@mesajilhnos.com','Av. República de Colombia 130 – 136 -San Isidro','150131','A'),
	('934934848','tiendalamolina@mesajilhnos.com','Av. Javier Prado Este 5940 – La Molina','150114','A')
GO

INSERT INTO EMPLEADO
	(IDSUC,NOMEMP,APEEMP,COREMP,CELEMP,DIREMP,CODUBI,SUEEMP,IDUSU,TIPEMP,ESTEMP)
VALUES
	('1','JHONN RAUL','MONTOYA SUAREZ','Monto@gmail.com','956784769','Jr. los Cerezos 198','150114','3000','1','A','A'),
	('1','LIONEL ERIC','SHANTAL RODRIGUEZ','Ericc@hotmail.com','948378798','Martir Olaya','150131','2200','4','J','A'),
	('1','NICOL BRISA','VALDEZ RIOS','NIkki@gmail.com','948375948','Vía Malecón San Pedro 21','150119','1200','6','V','A'),
	('2','PAOLA RITA','PEREZ HUAMAN','Paolin@gmail.com','939433495','Carr. Panamericana Sur Km 29.5','150119','3300','2','A','A'),
	('2','BENJAMIN BRANDON','LUZIARDO TORRES','Benjaroodes@hotmail.com','955325935','Kilómetro 26.5, Antigua Panamericana Sur','150119','2250','5','J','A'),
	('2','MARIANA JASMIN','TIPO CAJAMARCA','MARIMARI@gmail.com','953255935','AH LAS BRISAS Mz. "M" Lte. "19','150104','1600','8','V','A'),
	('3','EDSON SIMON','PEREIRA GUSTAVO','EDSIN@hotmail.com','958675485','Av. los girasoles calle thomsomp','150107','4000','3','A','A'),
	('3','NAOMI CARLA','CAMA ROBLES','Naomi@gmail.com','995847273','Calle siempre viva nro 15','150113','2800','6','J','A'),
	('3','ANA MARIA','LOPEZ SARMIENTO','ANi@hotmail.com','948573666','Los jaureguis rinconada calle 13','150116','1600','7','V','A'),
	('4','JHAS TOMAS','SAAVEDRA MANZO','Jhas@gmail.com','924219424','Roncina cillonez calle 14','150114','3000','1','A','A'),
	('4','MICHELL MYKE','CENTEMO AGUILAR','maicol@outlook.com','948302840','Av. los escombros del sur','150117','2500','6','J','A'),
	('4','SAYURI LINDA','ROMAN CASAS','Sasi@hotmail.com','947773856','Calle las ruinas nº 12','150120','1200','8','V','A'),
	('5','DIEGO ROGER','CARRILLO DIAZ','Dieguin@gmail.com','948987267','Paradero las brisas','150128','2800','3','A','A'),
	('5','HUMBERTO JOSE','KRISPIN LUYO','ahmbert@gmail.com','938472839','Lusicsalas, frente al cine MegaPlaza','150124','2000','4','J','A'),
	('5','ALEJANDRO LUCIANO','GARBOZO GARCIA','aleje@hotmail.com','938472748','Av. Libertad nº 7','150129','1200','7','V','A')
GO

INSERT INTO CATEGORIA
	(NOMCAT,NOMTIP)
VALUES
	('COOLER PARA LAPTOP','ENFRIADOR'),
	('ADAPTOR','INALÁMBRICO'),
	('DESKTOP, LAPTOP & DESKTOP GAMING','ESCRITORIO'),
	('IMPRESORA TÉRMICA, IMPRESORAS, IMPRESORAS & SUMINISTROS','PARA CASA'),
	('AUDÍFONOS','ENTRADA USB'),
	('IMPRESORA TÉRMICA, IMPRESORAS, IMPRESORAS & SUMINISTROS','MONOFUNCIONAL'),
	('IMPRESORA TÉRMICA, IMPRESORAS, IMPRESORAS & SUMINISTROS','MUNTIFUNCIONAL'),
	('TARJETAS GRÁFICAS, TARJETAS DE VIDEO, IMPRESORAS & SUMINISTROS','PC')
GO

INSERT INTO MARCA
	(NOMMAR,NOMMOD,COMMAR,IDCAT)
VALUES
	('LOGITECH','H390','WINDOWS, MAC OS, CROME OS','5'),
	('LOGITECH','H570e','WINDOWS, MAC OS, LINUX','5'),
	('AMD, ASUS','GA401IV-HA381T','WINDOWS, MAC OS, LINUX','3'),
	('HP','250 G8','WINDOWS, MAC OS, LINUX','3'),
	('HP','IMPRESORA HP LASER 1072','Puerto USB 2.0 de alta velocidad, conexión inalámbrica 802.11 b/g/n','6'),
	('XEROX','C405V/DN','WINDOWS, MAC OS, LINUX','7'),
	('JBL','Harman T750BT','ANDROID, IOS','5'),
	('iDOCK','iDock N10 Office','','1'),
	('EVGA','NVIDIA GeForce RTX 2060','','8'),
	('JBL','Tune 110','WINDOWS, ANDROID','5')
GO

INSERT INTO PRODUCTO
	(IDMAR,MATPRO,COLPRO,DESPRO,CARPRO,CANPRO,PREPRO,ESTPRO)
VALUES
	('1','','','Claridad y confort asequibles
	Para quienes se ganan la vida al teléfono, unos confortables audífonos con micrófono ayudan a 
	que cada llamada resulte más productiva. Elegantes y duraderos, los audífonos con micrófono Logitech 
	H570e ofrecen confort día tras día. Y además son fáciles de usar: basta con conectarlos a la PC o Mac con 
	el cable USB. H570e incluye funciones premium de supresión de ruido para ofrecer sonido nitidísimo a un precio 
	asequible.','','50','179.55','A'),

	('5','','NEGRO','Diseñada para adaptarse a su espacio
	Puede colocar esta impresora prácticamente en cualquier lugar, 
	ya que es pequeña y compacta. Obtenga velocidades de impresión 
	de hasta 20 ppm A4.','','100','422.94','A'),

	('6','','BLANCO','Seguridad de vanguardia para impresoras y datos
	La conectividad plantea el riesgo de una intrusión cibernética, 
	pero nuestra tecnología ConnectKey protege contra las amenazas con 
	una estricta seguridad de la impresora y de los 
	datos.','Controladores de escaneado: TWAIN, WIA (Network only)','20','4049.85','A'),

	('3','','NEGRO','Mecanizado de precisión
	El llamativo diseño exterior de la tapa se 
	consigue mediante un proceso de fresado CNC 
	que crea 6 536 perforaciones perfectamente espaciadas 
	en una superficie muy reducida. Este elegante y sutil 
	patrón, permite que los 1 215 mini-LED situados en el 
	panel opcional AniMe Matrix emitan la cantidad de luz 
	exacta.','','15','6004.95','A'),

	('4','','PLOMO','Diseñado para empresas
	Realice proyectos con confianza con la última 
	tecnología que incluye FreeDos y la potencia deL 
	procesador Intel Core i5-1035G1 , con memoria de 8gb y 
	opciones de almacenamiento de estado sólido.','','50','3223.92','A'),

	('2','','NEGRO','Los auriculares inalámbricos JBL TUNE 750BTNC ofrecen 
	el potente sonido JBL con bajos puros y cancelación activa del ruido 
	para que disfrutes de una experiencia de audio envolvente y bajos 
	intensos.','Cancelación activa de ruido: Sí ,Alexa: Sí, Micrófono integrado: Sí','40','438.90','A'),

	('8','ALUMINIO','','Panel de Aluminio
	El elaborado panel de aluminio y el potente
	flujo de aire hace de N10 tenga una mejor 
	calidad','2 ventiladores de 14 cm.
	4 puertos USB 2.0 (1+3)
	2 Altavoces 2.0','50','105.74','A'),

	('9','','','Las tarjetas gráficas EVGA GeForce RTX de la 
	serie 20 funcionan con la nueva arquitectura NVIDIA Turing 
	para brindarle nuevos e increíbles niveles de realismo, velocidad, 
	eficiencia energética e inmersión en los juegos.','6144 MB, 192 bit GDDR6
	14000 MHz (effective)
	336 GB/s Memory Bandwidth','10','2992.50','A'),

	('4','','','El diseño agresivo de la HP Pavilion Gaming 
	Laptop trae la nueva tecnología de enfriamiento, poderosos 
	gráficos NVIDIA® GeForce® GTX™ y la última generación de procesadores 
	Intel® Core™ para que seas el número uno.','','4','3986.01','A'),

	('10','','AZUL','Le presentamos los auriculares intraaurales JBL TUNE110. Son ligeros, cómodos y compactos.','Sensibilidad del driver 
	a 1kHz1mW (dB): 96.0
	Respuesta de frecuencia dinámica: 
	20 Hz - 20 kHz
	Impedancia de entrada (ohms): 16.0
	Número de drivers por auricular: 1.0','30','43.89','A')
GO

INSERT INTO BOLETA
	(IDCLI,IDEMP,TOTBOL,FECBOL)
VALUES
	('2','9','782.04','08-07-2021'),
	('4','3','14284.20','08-07-2021'),
	('3','6','105.740','09-07-2021'),
	('7','9','10657.29','09-07-2021'),
	('1','3','43.890','10-07-2021'),
	('6','6','2992.500','10-07-2021'),
	('8','3','105.740','10-07-2021'),
	('9','3','6447.84','11-07-2021'),
	('1','9','4207.46','11-07-2021'),
	('10','9','4516.68','11-07-2021')
GO

INSERT INTO BOLETA_DETALLE
	(IDBOL,IDPRO,CANTDET,SUBDET)
VALUES
	('1','1','2','359.1'),
	('1','2','1','422.94'),
	('2','3','2','8099.7'),
	('2','4','1','6004.950'),
	('2','1','1','179.55'),
	('3','7','1','105.740'),
	('4','1','1','179.550'),
	('4','2','1','422.940'),
	('4','3','1','4049.850'),
	('4','4','1','6004.950'),
	('5','10','1','43.890'),
	('6','8','1','2992.500'),
	('7','7','1','105.740'),
	('8','5','2','3223.920'),
	('9','7','1','105.740'),
	('9','6','3','877.8'),
	('9','5','1','3223.920'),
	('10','3','1','4049.850'),
	('10','2','1','422.940'),
	('10','10','1','43.890')
GO

/* Creación de Vistas */
-- Vista que visualiza la venta con inforación del cliente y el vendedor a cargo de esa venta

CREATE VIEW VBoleta
AS
    SELECT 
	    UPPER(B.IDBOL) AS 'Número de Boleta',
        CONCAT(C.NOMCLI, ', ',C.APECLI) AS 'Nombre y Apellido del Cliente',
        C.CELCLI AS 'Celular del cliente',
		CONCAT(E.NOMEMP, ', ',E.APEEMP) AS 'Nombre y Apellido del Vendedor',
		B.TOTBOL AS 'Total de venta',
		B.FECBOL AS 'Fecha de la venta',
		ROW_NUMBER() OVER (ORDER BY IDBOL DESC) AS 'ROW'
    FROM 
        BOLETA AS B 
        INNER JOIN CLIENTE AS C
		ON 
        B.IDCLI = C.IDCLI
		INNER JOIN EMPLEADO AS E
		ON B.IDEMP = E.IDEMP
GO

-- Vista que visualiza la ganancia que se está teniendo por sucursal hasta el momento
CREATE VIEW VGanancia
AS
    SELECT 
	    
		S.CORSUC AS 'Correo del sucursal',
		S.DIRSUC AS 'Dirección de la sucursal',
		CONCAT(U.NOMDIS, ', ', U.NOMPRO, ', ',U.NOMDEP) AS 'Distrito',
		SUM(B.TOTBOL) AS 'Ganancia total'
    FROM 
        BOLETA AS B 
		INNER JOIN EMPLEADO AS E
		ON B.IDEMP = E.IDEMP
		INNER JOIN SUCURSAL AS S
		ON E.IDSUC = S.IDSUC
		INNER JOIN UBIGEO AS U
		ON S.CODUBI = U.CODUBI
	GROUP BY S.CORSUC , S.DIRSUC, U.NOMDIS, U.NOMPRO, U.NOMDEP
GO

-- Vista que visualiza los productos y sus atributos completos

CREATE VIEW VProducto
AS
    SELECT 
	M.NOMMAR as 'Marca',
	M.NOMMOD as 'Modelo',
	M.COMMAR as 'Compatibilidad',
	P.COLPRO as 'Color',
	P.CANPRO as 'Cantidad',
	P.PREPRO as 'Precio'
	-- C.NOMCAT as 'Categoria',
	-- C.NOMTIP as 'Tipo'
    FROM 
        PRODUCTO AS P
		INNER JOIN MARCA AS M
		ON P.IDMAR = M.IDMAR
		INNER JOIN CATEGORIA AS C
		ON C.IDCAT = M.IDCAT
GO


/* Store Procedure para crear una venta (cabecera) */
CREATE PROCEDURE spInsertBoleta
    (
		@codigoCliente INT,
        @codigoVendedor INT,
		@totalboleta DECIMAL,
		@fechaboleta DATE
    )
AS
    BEGIN
    SET NOCOUNT ON
        BEGIN TRY
            BEGIN TRAN
                INSERT INTO BOLETA
                    (IDCLI, IDEMP, TOTBOL, FECBOL)
                VALUES
                    (UPPER(@codigoCliente), @codigoVendedor, @totalboleta,@fechaboleta) 
        END TRY
        BEGIN CATCH
            SELECT 'No se ha registrado la Boleta' AS 'ERROR'
            IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
        END CATCH
    END 
GO   

/* Store Procedure para crear una venta (Detalle)*/
CREATE PROCEDURE spInsertBoletaDetalle
    (
        @codigoProducto INT,
		@cantidadProducto INT
    )
AS
    BEGIN
    SET NOCOUNT ON
        BEGIN TRY
            BEGIN TRAN
            DECLARE @codigoBoleta INT
            DECLARE @stockProducto INT
            DECLARE @precioProducto DECIMAL
            DECLARE @totalVenta DECIMAL
            DECLARE @stockActual INT
            SET @codigoBoleta = (SELECT MAX(V.IDBOL) FROM dbo.BOLETA AS V)
            SET @stockProducto = (SELECT PRODUCTO.CANPRO FROM dbo.PRODUCTO WHERE PRODUCTO.IDPRO=@codigoProducto)
            SET @precioProducto = (SELECT PRODUCTO.PREPRO FROM PRODUCTO WHERE PRODUCTO.IDPRO=@codigoProducto)
            SET @totalVenta = @cantidadProducto * @precioProducto
            SET @stockActual = @stockProducto - @cantidadProducto
                INSERT INTO dbo.BOLETA_DETALLE
                (IDPRO, CANTDET)
                VALUES
                (@codigoProducto, @cantidadProducto)
                IF (@stockProducto >= @cantidadProducto)
                    UPDATE dbo.PRODUCTO
                    SET PRODUCTO.CANPRO = (PRODUCTO.CANPRO - @cantidadProducto)
                    WHERE PRODUCTO.IDPRO = @codigoProducto
                    ROLLBACK TRAN
                COMMIT TRAN;
        END TRY
        BEGIN CATCH
            SELECT 'No se ha registrado la venta' AS 'ERROR'
            IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
        END CATCH
    END 
GO