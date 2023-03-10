 ------------------------------------------------------------------------------------------------
--На основании таблиц DE.LOG и DE.IP постройте структурированную таблицу посещений:

--DE11AN.XXXX_LOG ( DT DATE, LINK VARCHAR( 50 ), USER_AGENT VARCHAR( 200 ), REGION VARCHAR( 30 ) ).

--Также постройте отчет:

--DE11AN.XXXX_LOG_REPORT ( REGION VARCHAR( 30 ), BROWSER VARCHAR( 10 ) )
-- – в каких областях какой браузер является наиболее используемым.

--Просьба быть внимательным к названиям таблиц и полей – проверка полуавтоматическая. 
--Под USER_AGENT подразумевается вся строка описания клиента, 
--под BROWSER – только название браузера (Opera, Safari…). 
--XXXX означает ваши 4 уникальные буквы.
--На сервере должны быть созданы и наполнены данными таблицы, в classroom надо прислать файл с SQL кодом их создания.

--Важные замечания (вплоть до причины незачета задания):
--Не используйте регулярные выражения там, где можно обойтись без них.
--То, что вы видите в выводе клиента – это не всегда именно то, что содержится в базе данных.
------------------------------------------------
CREATE TABLE 
DE11AN.kart_LOG ( 
	DT DATE, 
	LINK VARCHAR( 50 ), 
	USER_AGENT VARCHAR( 200 ),
	REGION VARCHAR( 30 ) 
	);
--DROP TABLE DE11AN.kart_LOG;
--DELETE FROM DE11AN.kart_LOG;
------------------------------------------------
INSERT INTO DE11AN.kart_LOG (DT, LINK, USER_AGENT, REGION) (
	SELECT DT, LINK, USER_AGENT, REGION
	FROM (
		SELECT
			TRIM(REPLACE((SUBSTRING(DATA,1, STRPOS(DATA, '	'))), '	', ' '))AS IP,
			TO_DATE(
				split_part(
					REPLACE(
						REPLACE(
							REPLACE(DATA, '	', ' ')
							, '  ', ' ')
						, '  ', ' ')
					, ' ', 2)
				, 'YYYYMMDDHH24MISS') AS DT
			,
			split_part(
				REPLACE(
					REPLACE(
						REPLACE(DATA, '	', ' ')
						, '  ', ' ')
					, '  ', ' ')
				, ' ', 3) AS LINK
			,
			split_part(
				REPLACE(
					REPLACE(
						REPLACE(DATA, '	', ' ')
						, '  ', ' ')
					, '  ', ' ')
				, ' ', 6)
				||
				SUBSTRING(DATA, STRPOS(DATA, '(') - 1, LENGTH(DATA) - STRPOS(DATA, '(') + 1) AS USER_AGENT ----убираем n
		FROM DE.LOG
	) AS a
	INNER JOIN 	
		(SELECT DISTINCT
			IP, 
			REGION
		FROM (
			SELECT DISTINCT
				TRIM(REPLACE(SUBSTRING(DATA,1, STRPOS(DATA, '	')), '	', ' '))
					AS IP, ---до первой табуляции
				TRIM(REPLACE(SUBSTRING(DATA, STRPOS(DATA, '	')), '	', ' '))
					AS REGION --- после первой табуляции
			FROM DE.IP
			) AS s
		) as b
		ON a.IP = b.IP
)
------------------------------------------------------------------------------------------------
--Также постройте отчет:
--DE11AN.XXXX_LOG_REPORT ( REGION VARCHAR( 30 ), BROWSER VARCHAR( 10 ) )
-- – в каких областях какой браузер является наиболее используемым.	
------------------------------------------------
CREATE TABLE 
DE11AN.kart_LOG_REPORT  ( 
	REGION VARCHAR( 30 ), 
	BROWSER VARCHAR( 10 )
	);
--DROP TABLE DE11AN.kart_LOG_REPORT;
--DELETE FROM DE11AN.kart_LOG_REPORT;
------------------------------------------------
INSERT INTO DE11AN.kart_LOG_REPORT (REGION, BROWSER) (
	WITH count_BROWSER AS(
		SELECT 
			REGION,
			SUBSTRING(USER_AGENT,1 , STRPOS(USER_AGENT, '/') - 1) AS BROWSER, 
			COUNT(SUBSTRING(USER_AGENT,1 , STRPOS(USER_AGENT, '/') - 1)) As cnt
		FROM DE11AN.kart_LOG
		GROUP BY REGION, SUBSTRING(USER_AGENT,1 , STRPOS(USER_AGENT, '/') - 1)
		ORDER BY REGION
		)
	
	SELECT REGION, BROWSER---, cnt
	FROM count_BROWSER
	WHERE  (REGION, cnt) IN 
		(SELECT REGION, max(cnt) FROM count_BROWSER
		GROUP BY REGION
		)
	ORDER BY REGION
)
------------------------------------------------------------------------------------------------
