# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/redmine/redmine-1.4.3.ebuild,v 1.2 2012/08/16 03:58:52 flameeyes Exp $

EAPI="3"

USE_RUBY="ruby18"
inherit eutils depend.apache ruby-ng

DESCRIPTION="Kete is a collaboration engine. It is open source software that you can use to create and share online. Write topics and upload images, audio, video, documents. Discuss them all. Link them together. It's a fun way to get things done."
HOMEPAGE="http://kete.net.nz/"
SRC_URI="kete-1.2.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="passenger"
SLOT="1.2"

RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.6)[ssl]
	dev-util/zebra
	dev-libs/yaz
	app-portage/g-cpan
"

ruby_add_rdepend "virtual/ruby-ssl
	>=dev-ruby/rails-2.3.5:2.3
	passenger? ( www-apache/passenger )
"

KETE_DIR="/var/lib/${PN}"

#pkg_setup() {
#	enewgroup redmine
#	# home directory is required for SCM.
#	enewuser redmine -1 -1 "${REDMINE_DIR}" redmine
#}

#all_ruby_prepare() {
#	rm -r log files/delete.me || die

#	# bug #406605
#	rm .gitignore .hgignore || die

#	rm Gemfile config/preinitializer.rb || die
#	epatch "${FILESDIR}/${PN}-1.4.1-bundler.patch" || die

#	echo "CONFIG_PROTECT=\"${EPREFIX}${REDMINE_DIR}/config\"" > "${T}/50${PN}"
#	echo "CONFIG_PROTECT_MASK=\"${EPREFIX}${REDMINE_DIR}/config/locales ${EPREFIX}${REDMINE_DIR}/config/settings.yml\"" >> "${T}/50${PN}"
#}

all_ruby_install() {
#	dodoc doc/{CHANGELOG,INSTALL,README_FOR_APP,RUNNING_TESTS,UPGRADING} || die
#	dodoc doc/{README_FOR_APP} || die
#	rm -fr doc || die
#	dodoc README.rdoc || die
#	rm README.rdoc || die

#	keepdir /var/log/${PN} || die
#	dosym /var/log/${PN}/ "${KETE_DIR}/log" || die

	insinto "${KETE_DIR}"
	doins -r . || die
#	keepdir "${KETE_DIR}/files" || die
#	keepdir "${KETE_DIR}/public/plugin_assets" || die
#
#	fowners -R redmine:redmine \
#		"${REDMINE_DIR}/config" \
#		"${REDMINE_DIR}/files" \
#		"${REDMINE_DIR}/public/plugin_assets" \
#		"${REDMINE_DIR}/tmp" \
#		/var/log/${PN} || die
#	# for SCM
#	fowners redmine:redmine "${REDMINE_DIR}" || die
	# bug #406605
#	fperms -R go-rwx \
#		"${KETE_DIR}/config" \
#		"${KETE_DIR}/files" \
#		"${KETE_DIR}/tmp" \
#		/var/log/${PN} || die

#	if use passenger ; then
		has_apache
		insinto "${APACHE_VHOSTS_CONFDIR}"
		doins "${FILESDIR}/10_kete_vhost.conf" || die
#	else
#		newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
#		newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
#		keepdir /var/run/${PN} || die
#		fowners -R redmine:redmine /var/run/${PN} || die
#		dosym /var/run/${PN}/ "${REDMINE_DIR}/tmp/pids" || die
#	fi

#	doenvd "${T}/50${PN}" || die
}

#pkg_postinst() {
#	einfo
#	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
#		elog "Execute the following command to upgrade environment:"
#		elog
#		elog "# emerge --config \"=${CATEGORY}/${PF}\""
#		elog
#		elog "For upgrade instructions take a look at:"
#		elog "http://www.redmine.org/wiki/redmine/RedmineUpgrade"
#	else
#		elog "Execute the following command to initlize environment:"
#		elog
#		elog "# cd ${EPREFIX}${REDMINE_DIR}"
#		elog "# cp config/database.yml.example config/database.yml"
#		elog "# \${EDITOR} config/database.yml"
#		elog "# chown redmine:redmine config/database.yml"
#		elog "# emerge --config \"=${CATEGORY}/${PF}\""
#		elog
#		elog "Installation notes are at official site"
#		elog "http://www.redmine.org/wiki/redmine/RedmineInstall"
#	fi
#	einfo
#}

#pkg_config() {
#	if [ ! -e "${EPREFIX}${REDMINE_DIR}/config/database.yml" ] ; then
#		eerror "Copy ${EPREFIX}${REDMINE_DIR}/config/database.yml.example to ${EPREFIX}${REDMINE_DIR}/config/database.yml and edit this file in order to configure your database settings for \"production\" environment."
#		die
#	fi
#
#	local RAILS_ENV=${RAILS_ENV:-production}
#	local RUBY=${RUBY:-ruby18}
#
#	cd "${EPREFIX}${REDMINE_DIR}"
#	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
#		einfo
#		einfo "Upgrade database."
#		einfo
#
#		einfo "Migrate database."
#		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
#		einfo "Upgrade the plugin migrations."
#		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate:upgrade_plugin_migrations # || die
#		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate_plugins || die
#		einfo "Clear the cache and the existing sessions."
#		${RUBY} -S rake tmp:cache:clear || die
#		${RUBY} -S rake tmp:sessions:clear || die
#	else
#		einfo
#		einfo "Initialize database."
#		einfo
#
#		einfo "Generate a session store secret."
#		${RUBY} -S rake generate_session_store || die
#		einfo "Create the database structure."
#		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
#		einfo "Insert default configuration data in database."
#		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake redmine:load_default_data || die
#		einfo
#		einfo "If you use sqlite3. please do not forget to change the ownership of the sqlite files."
#		einfo
#		einfo "# cd \"${EPREFIX}${REDMINE_DIR}\""
#		einfo "# chown redmine:redmine db/ db/*.sqlite3"
#		einfo
#	fi
#}
