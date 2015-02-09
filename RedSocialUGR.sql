 -- Sentencias para la creación de la BD del SI "Red Social UGR"

 -- Borrado de lo anterior (si existiera)
 DROP DATABASE IF EXISTS RedSocialUGR;
 CREATE DATABASE IF NOT EXISTS RedSocialUGR;
 USE RedSocialUGR;

 DROP TABLE IF EXISTS estudiantes,
                      carreras;

 -- La creación de tablas hay que hacerla en conjunto, pero las separo para comprender mejor el código

 -- Creación de la tabla de estudiantes

 CREATE TABLE estudiantes (
   Correo           VARCHAR(50) NOT NULL,
   NombreEstudiante VARCHAR(50) NOT NULL,
   Apellidos        VARCHAR(50) NOT NULL,
   FechaNacimiento  DATE        NOT NULL,
   FotoPersonal     VARCHAR(70) DEFAULT NULL,
   Destrezas        VARCHAR(50) DEFAULT NULL,
   Hobbies          VARCHAR(50) DEFAULT NULL,
   EstadoActual     VARCHAR(30) DEFAULT NULL,
   Ocupacion        VARCHAR(30) DEFAULT NULL,
   PRIMARY KEY  (correo)
 );

 CREATE TABLE carreras (
   Nombre         VARCHAR(30) NOT NULL,
   Centro         VARCHAR(30) NOT NULL,
   PRIMARY KEY  (nombre)
 );

 CREATE TABLE cursa (
   CorreoAlumno  VARCHAR(50) NOT NULL,
   NombreCarrera VARCHAR(50) NOT NULL,
   PRIMARY KEY    (CorreoAlumno, NombreCarrera),
   FOREIGN KEY    (CorreoAlumno)   REFERENCES estudiantes  (Correo) ON DELETE CASCADE,
   FOREIGN KEY    (NombreCarrera)  REFERENCES carreras     (Nombre) ON DELETE CASCADE
 );

 -- Creación de la tabla muros

 CREATE TABLE foro (
   IdentificadorForo  INTEGER(50) NOT NULL,
   NombreForo         VARCHAR(50) NOT NULL,
   PRIMARY KEY  (IdentificadorForo)
 );

 CREATE TABLE tema (
   IdentificadorForo  INTEGER(50) NOT NULL,
   IdentificadorTema  INTEGER(50) NOT NULL,
   NombreTema         VARCHAR(50) NOT NULL,
   PRIMARY KEY  (IdentificadorForo, IdentificadorTema),
   FOREIGN KEY  (IdentificadorForo)   REFERENCES foro  (IdentificadorForo) ON DELETE CASCADE
 );

 CREATE TABLE post (
   IdentificadorForo  INTEGER(50) NOT NULL,
   IdentificadorTema  INTEGER(50) NOT NULL,
   IdentificadorPost  INTEGER(50) NOT NULL,
   CotenidoPost       VARCHAR(200) NOT NULL,
   PRIMARY KEY    (IdentificadorForo, IdentificadorTema, IdentificadorPost),
   FOREIGN KEY    (IdentificadorForo, IdentificadorTema)   REFERENCES tema  (IdentificadorForo,IdentificadorTema) ON DELETE CASCADE

 );

 CREATE TABLE muro (
   IdentificadorMuro INTEGER(50) NOT NULL,
   PRIMARY KEY  (IdentificadorMuro)
 );

 CREATE TABLE mensaje (
   IdentificadorMuro    INTEGER(50) NOT NULL,
   IdentificadorMensaje INTEGER(50) NOT NULL,
   CotenidoMensaje      VARCHAR(50) NOT NULL,
   PRIMARY KEY    (IdentificadorMuro, IdentificadorMensaje),
   FOREIGN KEY    (IdentificadorMuro)   REFERENCES muro  (IdentificadorMuro) ON DELETE CASCADE
 );

 CREATE TABLE crea (
   IdentificadorForo  INTEGER(50) NOT NULL,
   IdentificadorTema  INTEGER(50) NOT NULL,
   ContenidoMensaje   VARCHAR(200) NOT NULL,
   Correo             VARCHAR(50) NOT NULL,
   FechaCrea          DATE NOT NULL,
   PRIMARY KEY    (IdentificadorTema),
   FOREIGN KEY    (IdentificadorForo, IdentificadorTema)   REFERENCES tema  (IdentificadorForo,IdentificadorTema) ON DELETE CASCADE,
   FOREIGN KEY    (Correo)   REFERENCES estudiantes   (Correo) ON DELETE CASCADE
 );

  CREATE TABLE escribe1 (
    IdentificadorForo   INTEGER(50) NOT NULL,
    IdentificadorTema   INTEGER(50) NOT NULL,
    IdentificadorPost   INTEGER(50) NOT NULL,
    Correo              VARCHAR(50) NOT NULL,
    FechaEscribe1       DATE NOT NULL,
    PRIMARY KEY     (IdentificadorForo, IdentificadorTema, IdentificadorPost),
    FOREIGN KEY     (IdentificadorForo, IdentificadorTema, IdentificadorPost)   REFERENCES post  (IdentificadorForo,IdentificadorTema, IdentificadorPost) ON DELETE CASCADE,
    FOREIGN KEY     (Correo)   REFERENCES estudiantes   (Correo) ON DELETE CASCADE
  );

  CREATE TABLE escribe2 (
    IdentificadorMuro     INTEGER(50) NOT NULL,
    IdentificadorMensaje  INTEGER(50) NOT NULL,
    Correo                VARCHAR(50) NOT NULL,
    FechaEscribe2         DATE NOT NULL,
    PRIMARY KEY     (IdentificadorMuro, IdentificadorMensaje),
    FOREIGN KEY     (IdentificadorMuro, IdentificadorMensaje)   REFERENCES mensaje  (IdentificadorMuro,IdentificadorMensaje) ON DELETE CASCADE,
    FOREIGN KEY     (Correo)   REFERENCES estudiantes   (Correo) ON DELETE CASCADE
  );

   -- Creación de la tabla de asignaturas-centros
   CREATE TABLE carrera (
     NombreCarrera        VARCHAR(50) NOT NULL,
     Centro               VARCHAR(50) DEFAULT NULL,
     IdentificadorForo    INTEGER(50) NOT NULL,
     PRIMARY KEY(NombreCarrera),
     FOREIGN KEY    (IdentificadorForo)   REFERENCES foro  (IdentificadorForo)
   );

   CREATE TABLE asignatura (
     NombreAsignatura	      VARCHAR(50) NOT NULL,
     IdentificadorForo      INTEGER(50) NOT NULL,
     NombreCarrera          VARCHAR(50) NOT NULL,
     PRIMARY KEY(NombreAsignatura),
     FOREIGN KEY    (IdentificadorForo)   REFERENCES foro  (IdentificadorForo) ,
     FOREIGN KEY    (NombreCarrera)   REFERENCES carrera  (NombreCarrera)
  );

   CREATE TABLE documento (
     NombreAsignatura	    VARCHAR(50) NOT NULL,
     Ruta                 VARCHAR(50) NOT NULL,
     CorreoElectronico    VARCHAR(50) DEFAULT NULL,
     PRIMARY KEY(NombreAsignatura,ruta),
     FOREIGN KEY    (NombreAsignatura)   REFERENCES asignatura  (NombreAsignatura) ON DELETE CASCADE
   );



   -- Creación de la tabla actividades
 CREATE TABLE actividad (
   CorreoCreador        VARCHAR(50) NOT NULL,
   NombreActividad      VARCHAR(50) NOT NULL,
   Descripcion		      VARCHAR(200) DEFAULT NULL,
   FechaInicio		      DATE NOT NULL,
   FechaFin             DATE DEFAULT NULL,
   TipoEvento           INTEGER DEFAULT NULL,
   Publica              BOOLEAN,
   MuroAsociado	        INTEGER(50) NOT NULL,
   NombreCarrera        VARCHAR(50) DEFAULT NULL,
   PRIMARY KEY(CorreoCreador,NombreActividad),
   FOREIGN KEY    (CorreoCreador)   REFERENCES estudiantes  (Correo) ,
   FOREIGN KEY    (MuroAsociado)    REFERENCES muro  (IdentificadorMuro) ,
   FOREIGN KEY    (NombreCarrera)   REFERENCES carrera  (NombreCarrera)
);

 CREATE TABLE suscripcion (
   CorreoEstudianteSuscrito	VARCHAR(50) NOT NULL,
   CorreoEstudianteCreador  VARCHAR(50) NOT NULL,
   NombreActividad        	VARCHAR(50) NOT NULL,
   PermisoModificacion	 BOOLEAN DEFAULT FALSE,
   PermisoInvitacion		 BOOLEAN DEFAULT FALSE,
   PermisoExpulsion		   BOOLEAN DEFAULT FALSE,
   PermisoAscenso		     BOOLEAN DEFAULT FALSE,
   PRIMARY KEY  (CorreoEstudianteSuscrito, CorreoEstudianteCreador , NombreActividad ),
   FOREIGN KEY    (CorreoEstudianteSuscrito)   REFERENCES estudiantes  (Correo) ,
   FOREIGN KEY    (CorreoEstudianteCreador,NombreActividad)   REFERENCES actividad  (CorreoCreador,NombreActividad)
);



 -- Disparadores
 -- CREATE TRIGGER Taxpayer_Update
 -- AFTER UPDATE ON Taxpayers
 --   REFERENCING OLD ROW AS Old, NEW ROW AS New FOR EACH ROW
 -- BEGIN ATOMIC
 --   UPDATE National_Debt SET
 --       amount = amount + (New.payable - Old.payable);
 --   UPDATE Prime_Ministers SET
 --     approval_rating = approval_rating - 0.01;
 -- END;

 -- Eva
DELIMITER //
CREATE TRIGGER crearIdentificadorTema
BEFORE INSERT
  ON tema FOR EACH ROW
BEGIN
  DECLARE cuantos INTEGER;
  SELECT COUNT(*) INTO cuantos FROM tema;
  IF (cuantos = 0) THEN
    SET NEW.IdentificadorTema = 0;
  ELSE
    SELECT max(IdentificadorTema) INTO cuantos FROM tema;
    SET NEW.IdentificadorTema = NEW.IdentificadorTema +1;
  END IF;
END; //
DELIMITER ;


 -- Antonio


 -- Si se borra una carrera cursada, todas las asignaturas matriculadas y superadas de dicha carrera se borran
 DELIMITER //
 CREATE TRIGGER terminarCarrera
 AFTER DELETE
   ON cursa FOR EACH ROW
 BEGIN
   DECLARE carreras INTEGER;
   SELECT COUNT(*) INTO carreras FROM cursa WHERE OLD.CorreoAlumno=cursa.CorreoAlumno;
   IF (carreras = 0) THEN
      UPDATE estudiantes SET Ocupacion="Sin carrera" WHERE estudiantes.Correo=OLD.CorreoAlumno;
   END IF;
 END; //
 DELIMITER ;



 -- Carlos
 DELIMITER //
 CREATE TRIGGER modificarMuroActividad
 BEFORE UPDATE
  ON actividad FOR EACH ROW
 BEGIN
 DECLARE existemuro INTEGER;
   SELECT COUNT(*) INTO existemuro FROM muro WHERE OLD.MuroAsociado = NEW.MuroAsociado;
   IF (existemuro = 0) THEN
     INSERT INTO muro VALUES (NEW.MuroAsociado);
   END IF;
   DELETE FROM muro WHERE OLD.MuroAsociado=IdentificadorMuro;
 END; //
 DELIMITER ;

 -- Adrián
 DELIMITER //
 CREATE TRIGGER crearTemaDocumento
 AFTER INSERT
   ON documento FOR EACH ROW
 BEGIN
   DECLARE foro INTEGER;
   SELECT IdentificadorForo INTO foro from asignatura where NEW.NombreAsignatura=asignatura.NombreAsignatura;
   INSERT INTO tema VALUES(foro,0,NEW.Ruta);
 END; //
 DELIMITER ;

 -- NOTA: Lo suyo es echar esto a otros archivos y traerlos con "source <file>;"
 -- Inserción de tuplas en estudiantes

 INSERT INTO estudiantes (Correo,NombreEstudiante,Apellidos,FechaNacimiento) VALUES
 ('antonio@correo.ugr.es','Antonio','Álvarez Caballero',"1993-11-29"),
 ('evamaria@correo.ugr.es','Eva María','González García',"1992-02-09"),
 ('carlos@correo.ugr.es','Carlos','Parla Pérez',"1992-02-02"),
 ('adrian@correo.ugr.es','Adrián','Rho Rha',"1993-02-02");

 -- Inserción de tuplas en carreras

 -- nombre         VARCHAR(30) NOT NULL,
 -- centro         VARCHAR(30) NOT NULL,
 -- PRIMARY KEY(nombre)

 INSERT INTO carreras (Nombre, Centro) VALUES
 ('Doble Grado', 'ETSIIT/Ciencias');

 -- Inserción de tuplas en cursa
 -- correo_alumno  VARCHAR(50) NOT NULL,
 -- nombre_carrera VARCHAR(50) NOT NULL,

 INSERT INTO cursa (CorreoAlumno, NombreCarrera) VALUES
 ('antonio@correo.ugr.es','Doble Grado'),
 ('evamaria@correo.ugr.es','Doble Grado'),
 ('carlos@correo.ugr.es','Doble Grado'),
 ('adrian@correo.ugr.es','Doble Grado');
