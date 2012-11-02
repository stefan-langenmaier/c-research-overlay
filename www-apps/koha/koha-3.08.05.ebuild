# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-4.2.1.ebuild,v 1.1 2012/04/18 23:33:56 idl0r Exp $

EAPI="4"
inherit depend.apache versionator eutils

DESCRIPTION="Koha is the first free and open source software library automation package (ILS)."
SRC_URI="http://download.koha-community.org/${P}.tar.gz"
HOMEPAGE="http://koha-community.org/"

LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""
SLOT="3.8"

COMMON_DEPS="
	>=dev-lang/perl-5.10
	dev-util/zebra
	app-portage/g-cpan
	media-gfx/graphicsmagick[perl]
	dev-perl/XML-Simple
	dev-perl/Business-ISBN
	dev-perl/CGI-Session
	dev-perl/Class-Factory-Util
	dev-perl/Data-ICal
	dev-perl/Date-Calc
	dev-perl/DateManip
	>=dev-perl/DateTime-0.58
	dev-perl/DateTime-Event-ICal
	dev-perl/DateTime-Format-DateParse
	dev-perl/DateTime-Format-ICal
	dev-perl/DateTime-Set
	dev-perl/DateTime-TimeZone
	dev-perl/Email-Date
	dev-perl/GD
	dev-perl/GD-Barcode
	dev-perl/HTML-Format
	dev-perl/HTML-Scrubber
	dev-perl/HTTP-Cookies
	dev-perl/HTTP-Message
	dev-perl/JSON
	dev-perl/Lingua-Stem
	dev-perl/Locale-PO
	dev-perl/MARC-Record
	dev-perl/MARC-XML
	dev-perl/MIME-Lite
	dev-perl/Mail-Sendmail
	dev-perl/Net-Z3950-ZOOM
	dev-perl/Number-Format
	dev-perl/PDF-API2
	dev-perl/POE
	dev-perl/Readonly
	dev-perl/Readonly-XS
	dev-perl/Schedule-At
	dev-perl/Template-Toolkit
	dev-perl/Text-CSV
	dev-perl/Text-CSV_XS
	dev-perl/Text-Iconv
	dev-perl/UNIVERSAL-require
	dev-perl/URI
	dev-perl/XML-Dumper
	dev-perl/XML-LibXSLT
	dev-perl/XML-RSS
	dev-perl/XML-SAX-Writer
	dev-perl/YAML-Syck
	dev-perl/libwww-perl
	dev-perl/net-server
	dev-perl/perl-ldap
	dev-perl/yaml

	perl-gcpan/Algorithm-CheckDigits
	perl-gcpan/Authen-CAS-Client
	perl-gcpan/Biblio-EndnoteStyle
	perl-gcpan/CGI-Session-Driver-memcached
	perl-gcpan/CGI-Session-Serialize-yaml
	perl-gcpan/DBD-SQLite2
	perl-gcpan/DublinCore-Record
	perl-gcpan/Gravatar-URL
	perl-gcpan/HTTP-OAI
	perl-gcpan/Lingua-Stem-Snowball
	perl-gcpan/Locale-Currency-Format
	perl-gcpan/MARC-Crosswalk-DublinCore
	perl-gcpan/Memoize-Memcached
	perl-gcpan/Modern-Perl
	perl-gcpan/PDF-API2-Simple
	perl-gcpan/PDF-Reuse
	perl-gcpan/PDF-Reuse-Barcode
	perl-gcpan/PDF-Table
	perl-gcpan/SMS-Send
	perl-gcpan/Template-Plugin-HtmlToText
	perl-gcpan/Test-Strict
	perl-gcpan/Test-YAML-Valid
	perl-gcpan/Text-CSV-Encoded
	perl-gcpan/Text-PDF
"

DEPEND="${COMMON_DEPS}"
RDEPEND="
	virtual/httpd-cgi

	${COMMON_DEPS}

	dev-perl/DBD-mysql

"


want_apache modperl

pkg_setup() {
	depend.apache_pkg_setup modperl
}



src_install () {
	insinto "/usr/src/${PN}"
	doins -r . || die
}
