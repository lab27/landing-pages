#!/bin/sh

prefix=s3://www.bos-schweiz.ch

# create a temp file to hold html
tmp=$(mktemp --suffix=.html)

# MAPPING
# =======
#
# http://born2bewild.org/landing-pages -> http://bos-schweiz.ch/f
# -----------------------------------------------------------------------------
# /releases                            -> /f/auswilderungen/index.htm
# /releases/ost-kalimantan.html        -> /f/auswilderungen/ost-kalimantan.htm
# /releases/salat-island.html          -> /f/auswilderungen/salat-island.htm
# /releases/technische-details.html    -> /f/auswilderungen/technische-details.htm
#
# /entwicklung/                        -> /f/nachhaltige-entwicklung/index.htm
# /entwicklung/bildungsprojekte.html   -> /f/nachhaltige-entwicklung/bildungsprojekte.htm
# /entwicklung/gesundheit.html         -> /f/nachhaltige-entwicklung/gesundheit.htm
# /entwicklung/mawas.html              -> /f/nachhaltige-entwicklung/mawas.htm
# /entwicklung/mikrokredit.html        -> /f/nachhaltige-entwicklung/mikrokredit.htm

base='https://born2bewild.org/landing-pages/auswilderung'
target='/f/auswilderungen'

# retrieve html from primary hosting into temp file
wget -kO $tmp $base/

# convert specific links
sed -i "s|$base/ost-kalimantan.html|$target/ost-kalimantan.htm|" $tmp
sed -i "s|$base/salat-island.html|$target/salat-island.htm|" $tmp
sed -i "s|$base/technische-details.html|$target/technische-details.htm|" $tmp

# upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp $prefix$target/index.htm

# ost-kalimantan
wget -kO $tmp $base/ost-kalimantan.html
sed -i "s|$base/salat-island.html|$target/salat-island.htm|" $tmp
sed -i "s|$base/technische-details.html|$target/technische-details.htm|" $tmp
sed -i "s|$base/#ost-kalimantan|$target.htm#ost-kalimantan|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/ost-kalimantan.htm

# salat-island
wget -kO $tmp $base/salat-island.html
sed -i "s|$base/ost-kalimantan.html|$target/ost-kalimantan.htm|" $tmp
sed -i "s|$base/technische-details.html|$target/technische-details.htm|" $tmp
sed -i "s|$base/#salat-island|$target.htm#salat-island|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/salat-island.htm

# technische-details
wget -kO $tmp $base/technische-details.html
sed -i "s|$base/ost-kalimantan.html|$target/ost-kalimantan.htm|" $tmp
sed -i "s|$base/salat-island.html|$target/salat-island.htm|" $tmp
sed -i "s|$base/#technische-details|$target.htm#technische-details|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/technische-details.htm


base='https://born2bewild.org/landing-pages/entwicklung'
target='/f/nachhaltige-entwicklung'

# retrieve html from primary hosting into temp file
wget -kO $tmp $base/

# convert specific links
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp

# upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp $prefix$target/index.htm


# bildungsprojekte
wget -kO $tmp $base/bildungsprojekte.html
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#bildungsprojekte|$target.htm#bildungsprojekte|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/bildungsprojekte.htm

# gesundheit
wget -kO $tmp $base/gesundheit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#gesundheit|$target.htm#gesundheit|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/gesundheit.htm

# mawas
wget -kO $tmp $base/mawas.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#mawas|$target.htm#mawas|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mawas.htm

# mikrokredit
wget -kO $tmp $base/mikrokredit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/#mikrokredit|$target.htm#mikrokredit|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mikrokredit.htm


# remove temp file
rm $tmp

# send an email to local user root
mail -s "Landing pages have been updated." root <<EOF
List of landing pages

- http://www.bos-schweiz.ch/f/auswilderungen/
- http://www.bos-schweiz.ch/f/nachhaltige-entwicklung/
EOF
