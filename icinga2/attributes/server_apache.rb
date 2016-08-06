
default['icinga2']['apache_modules'] = value_for_platform(
  %w(amazon debian ubuntu) => { 'default' => %w(default mod_python mod_php5 mod_cgi mod_ssl mod_rewrite) },
  %w(centos redhat fedora) => { '>= 7.0' => %w(default mod_wsgi mod_php5 mod_cgi mod_ssl mod_rewrite),
                                'default' => %w(default mod_python mod_php5 mod_cgi mod_ssl mod_rewrite) }
)
