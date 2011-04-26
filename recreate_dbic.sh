#!/bin/sh
dbicdump -o dump_directory=. \
    -o components='["InflateColumn::DateTime"]' \
    Koha::Schema dbi:mysql:dbname=koha "root" ""
