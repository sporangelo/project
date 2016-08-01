my_apache Cookbook
===================
This cookbook installs an Apache2 service, the PBS way


Requirements
------------

Tested on Ubuntu 14.04 with Apache 2.4

Attributes
----------

TODO: Actually update this part :)
#### my_apache::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt> default['my_apache']['dir']</tt></td>
    <td> string </td>
    <td> apache2 configuration directory </td>
    <td><tt> /etc/apache2 </tt></td>
  </tr>
  <tr>
    <td><tt> default['my_apache']['root_group']</tt> </td>
    <td> string </td>
    <td> group owner </td>
    <td><tt> root </tt></td>
  </tr>
  <tr>
    <td><tt> default['my_apache']['lib_dir']</tt> </td>
    <td> string </td>
    <td> apache2 library directory </td>
    <td><tt> /usr/lib/apache2 </tt></td>
  </tr>
  <tr>
    <td><tt> default['my_apache'][libexec_dir']</tt> </td>
    <td> string </td>
    <td> apache2 modules directory </td>
    <td><tt> #{lib_dir}/modules </tt></td>
  </tr>
</table>

Usage
-----
<h1> my_apache </h1>

This one installs Apache2 and starts it with zzz-default site, in MPM Event mode and with mod_headers enabled.
To add other modules specify the relevant recipe <b>after</b> my_apache.

Any other recipe should be called AFTER my_apache.

Available module installation recipes:
<ul>
<li> my_apache::mod_headers </li>
<li> my_apache::mod_php </li>
<li> my_apache::mod_rewrite </li>
<li> my_apache::mod_wsgi </li>
<li> my_apache::mpm_event (default)</li>
<li> my_apache::mpm_prefork </li>
</ul>

<h2> my_apache::service </h2>

Starts apache2 and configures it as a boot time auto-start service
