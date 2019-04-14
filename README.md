# ssb-postgres
スタースキーマベンチマーク(SSB)をPostgreSQL上で試すためのSQLスクリプト群。

# Description
このスクリプト群は、https://www.cs.umb.edu/~poneil/StarSchemaB.PDF の記載内容を元に、
PostgreSQL上でスタースキーマベンチマークを実行するためのSQLスクリプトである。
現在、以下の4つのファイルを準備している。

* テーブル定義(tables.sql)
* データロード(load.sql)
* EXPLAIN実行(explain-analyze.sql)
* EXPLAIN ANALYZE実行(explain.sql)

このリポジトリには、データ生成のスクリプトは含まれていない。
データ生成用のツールは、ssb-gen(https://github.com/electrum/ssb-dbgen/)のリポジトリから
ソースをダウンロードしてmakeする必要がある。

# Example
PostgreSQL 11.2を用いて、データベースを生成してから、SSBのクエリを実行するまでの例を示す。

* ``createdb``コマンドでデータベースを生成する。

```
$ createdb ssb
```

* SSB用のテーブルを定義する。

```
$ psql ssb -f tables.sql
```
* ssb-dbgen ツールは事前にリポジトリのクローンあるいはDLしてビルドしておき、``dbgen``コマンドが動作するようにしておく。
* ssb-dbgen ツールを使って任意の大きさ(Scale Facotr)のデータを生成する。この例では、Scale Factor=1のデータを生成する。

```
$ ./dbgen -s 1 -T a
```

* 上記の例の場合、``dbgen``コマンドはカレントディレクトリに以下の5つのファイルを生成する。

```
$ ls -1 *.tbl
customer.tbl
date.tbl
head-customer.tbl
head-lineorder.tbl
lineorder.tbl
part.tbl
supplier.tbl
$
```

* 生成されたデータファイルを、``/tmp``ディレクトリに移動するか、``ln -s``コマンドによって``/tmp``からのシンボリックリンクを生成する。
* ``psql``コマンドを用いて、生成したデータをロードする。


``
$ psql ssb -f load.sql
``

* データロードが終わった後で、必要に応じて、``VACUUM``, ``ANALYZE``等のコマンドを実行する。
* SSBのクエリ(Q1～$4)の実行計画を取得する場合は、explain.sql を用いる。
* SSBのクエリ(Q1～$4)の実行時間を取得する場合は、explain-analyze.sql を用いる。 


# TODO

* orderlineを日付レンジでパーティション化することが有効化検証するための、テーブル定義の作成。
* pg_hint_planが有効なケースがあった場合、そのHINT句コメントを付与した、EXPLAIN実行スクリプトの作成。

# Author

@nuko_yokohama (ぬこ＠横浜)

