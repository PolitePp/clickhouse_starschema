### cluster init
`
yc managed-clickhouse cluster create \
	--name dbt-click \
	--network-name my-net \
	--clickhouse-resource-preset s2.small \
	--host type=clickhouse,zone-id=ru-central1-b,subnet-id=some_subnet,assign-public-ip=true \
	--clickhouse-disk-size 200 \
	--clickhouse-disk-type network-ssd \
	--user name=dbt,password=some_pass \
	--database name=dbt
`

### Костыли и правки
1) Хэш нормально не отрабатывал в модели, указал всё явно
2) Не хватало materialized для таблицы
3) Для того, чтобы убрать проблему с multistatement, разбил каждый ddl на одиночные запросы
4) Ссылки были указаны через ref, это неправильно, поправил на source

### Лайфхаки
1) Чтобы заново не генерить толстяка

`dbt run --exclude datamarts.lineorder_flat`

### Результаты запросов
1) Q2.1 (лень всё кидать, взял первые 4 стркои)

| sum | year | p_brand |
| --- | ----------- | ---- |
|12672281651|1992|MFGR#121|
|13001303186|1992|MFGR#1210|
|13805417452|1992|MFGR#1211|
|12776234014|1992|MFGR#1212|

2) Q3.3 (лень всё кидать, взял первые 4 стркои)

| c_city | s_city | year | revenue|
| --- | ----------- | ---- | ---- |
|UNITED KI1|UNITED KI5|1992|1178335603|
|UNITED KI1|UNITED KI1|1992|1052597356|
|UNITED KI5|UNITED KI1|1992|1026260086|
|UNITED KI5|UNITED KI5|1992|973349994|

3) Q4.2 (лень всё кидать, взял первые 4 стркои)

| year | s_nation | p_category | profit |
| --- | ----------- | ---- | ---- |
|1997|ARGENTINA|MFGR#11|20633150130|
|1997|ARGENTINA|MFGR#12|20911142211|
|1997|ARGENTINA|MFGR#13|20751352336|
|1997|ARGENTINA|MFGR#14|20725587334|