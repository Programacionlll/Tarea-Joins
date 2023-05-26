CREATE DATABASE University_BD
use University_BD
-----------------------------------------------------------------
CREATE TABLE Universidades (
    idUniversidad INT PRIMARY KEY,
    nombreUniversidad VARCHAR(100),
    idPaisU INT,
	Criterio varchar(250),
	Ano INT,
	Score int
);

CREATE TABLE Paises (
    idPais INT PRIMARY KEY,
    nombrePais VARCHAR(100)
);


INSERT INTO Paises (idPais, nombrePais)
VALUES (1, 'Estados Unidos'),
(2, 'Reino Unido'),
(3, 'Canadá')
;

INSERT INTO Universidades (idUniversidad, nombreUniversidad, idPaisU, Criterio, Ano, Score)
values (1, 'Universidad de Harvard',1, 'CWUR','2011',100),
(2,	'Instituto de Tecnolog�a de Massachusetts',	1, 'CWUR','2011',97),
(3,	'Universidad de Stanford',	1, 'Times Higher Education World University','2011',95),	
(4,	'Universidad de Cambridge',	2, 'QS','2011',94),	
(5,	'Universidad de Oxford',	2, 'CWUR','2011',93),	
(6,	'Universidad de Princeton',	1, 'CWUR','2011',93),
(7,	'Universidad de Columbia',	1, 'SHANGAI','2011',92),
(8,	'Universidad de Chicago',	1, 'CWUR','2011',92),
(9,	'Universidad de Pensilvania',1, 'SHANGAI','2011',91),
(10,	'Universidad McGill', 3, 'QS','2012',87);

Delete from Universidades

DROP TABLE Universidades

select *from Universidades

select *from Paises

----Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.----
SELECT nombreUniversidad, nombrePais
FROM Universidades
JOIN Paises  ON idPaisU = idPais;

----Conocer cuantas universidades hay en cada pais.----
SELECT nombrePais, COUNT(*) AS cantidadUniversidades
FROM Paises 
JOIN Universidades  ON idPais = idPaisU
GROUP BY nombrePais;

---Conocer cuantos paises no tienen universidades en el ranking.---

SELECT COUNT(*) AS CantidadPaisesSinUniversidades
FROM Paises 
LEFT JOIN Universidades  ON idPais = idPaisU
WHERE idPaisU IS NULL;

------Mostrar los criterios de cada tipo de ranking.-----
CREATE TABLE Rankings(
  idRanking INT PRIMARY KEY,
  nombreRanking VARCHAR(50),
  descripcion VARCHAR(255),
);
INSERT INTO Rankings(
idRanking,
nombreRanking,
descripcion)
values (1,'Ranking de Shanghai','Número de premios Nobel y medallas Fields entre el personal académico y exalumnos.
Número de investigadores altamente citados.
Artículos publicados en revistas científicas de prestigio.
Desempeño per cápita en relación con el tamaño de la institución.'),
(2,'Times Higher Education World University','Calidad de la enseñanza y aprendizaje.
Investigación y actividad de publicaciones.
Citas de investigación y reputación de investigación.
Ingresos y perspectivas internacionale'),
(3,'U.S. News & World Report Best Global Universities','Investigación y reputación de investigación.
Enfoque en áreas específicas de estudio.
Cantidad y calidad de publicaciones científicas.
Impacto y citaciones de la investigación.'),
(4,'QS World University ','Reputación académica y empleabilidad de los graduados.
Citas de investigación y calidad de la producción científica.
Relación profesor-estudiante.
Proporción de profesores internacionales y estudiantes internacionales'),
(5,'CWUR World University Rankings','Calidad de la educación.Empleo de graduados.alidad de la facultad. Citas de investigación');

delete Rankings
select *from Rankings



--- Conocer el ranking que tiene mas criterios---
SELECT TOP 1 idRanking, COUNT(*) AS cantidadCriterios
FROM Rankings
GROUP BY idRanking
ORDER BY cantidadCriterios DESC;

-----Cual es el top de universidades de forma descendente del ano 2012 por cada criterio---

SELECT Criterio, nombreUniversidad
FROM Universidades
WHERE Ano = 2012
ORDER BY Criterio DESC;


-----Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'----
CREATE TABLE RankingUniversidades (
  idUniversidad INT PRIMARY KEY,
  Universidad VARCHAR(100),
  tipoRanking VARCHAR(100),
  score INT
);
DROP TABLE RankingUniversidades

INSERT INTO RankingUniversidades (idUniversidad, Universidad, tipoRanking, score)
VALUES
  (1, 'Universidad de Harvard', 'Center for World University Rankings', 100),
  (2, 'Instituto de Tecnologia de Massachusetts', 'Center for World University Rankings', 97),
  (3, 'Universidad de Oxford', 'Center for World University Rankings', 93),
  (4, 'Universidad de Princeton', 'Center for World University Rankings', 93),
  (5, 'Universidad de Chicago', 'Center for World University Rankings', 92);


SELECT Universidad, COUNT(*) AS cantidad_scores_100
FROM RankingUniversidades
WHERE tipoRanking = 'Center for World University Rankings' AND score = 100
GROUP BY Universidad
ORDER BY cantidad_scores_100 DESC;



-----Mostrar que paises se posicionaron con universidades con un score mayor a 90----
SELECT DISTINCT idPaisU
FROM Universidades
WHERE score > 90;



-----Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'---
SELECT nombreUniversidad
FROM Universidades
WHERE Criterio = 'SHANGAI ';


-----Mostrart el top 10 de las peores posiciones del tipo ranking 'Times Higher....'----
SELECT TOP 10 nombreUniversidad, Score
FROM Universidades
WHERE Criterio = 'Times Higher Education World University'
ORDER BY Score ASC;
