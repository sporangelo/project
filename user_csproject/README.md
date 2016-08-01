user_csproject Cookbook
=====================
This cookbook creates and configures the main username of the server

Requirements
------------
Tested on Ubuntu 14.10

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Required</th>
    <th>Possible Values</th>
  </tr>
  <tr>
    <td><tt>[:csproject_environment][:username]</tt></td>
    <td>string</td>
    <td>The username to create</td>
    <td>yes</td>
    <td>any valid Linux username</td>
  </tr>
  <tr>
    <td><tt>[:csproject_environment][:password]</tt></td>
    <td>string</td>
    <td>The password for the above specified user</td>
    <td>no</td>
    <td>Any string</td>
  </tr>
  <tr>
    <td><tt>[:csproject_environment][:environment]</tt></td>
    <td>string</td>
    <td>The type of environment</td>
    <td>no</td>
    <td>qa, stating, dev, prod</td>
  </tr>
  <tr>
    <td><tt>[:csproject_environment][:sudo]</tt></td>
    <td>array</td>
    <td>The array of Cmnd_Alias commands allowed to the above specified user</td>
    <td>no</td>
    <td>See the below example, or, even better, the csproject_sudo.erb template for more</td>
  </tr>
</table>

Just include `csproject_environment` in your stack's json:

```json
"csproject_environment": {
    "environment": "dev",
    "username": "csprojectapp",
    "password": "somePasswd",
    "sudo": [
        "MEMCACHED",
        "MYSQLD",
        "APACHE",
        "REBOOT",
        "INSTALL",
        "TOOLS",
        "NGINX"
    ]
  }
```

Usage
-----
#### user_csproject::default
This recipe creates a user with default home directory

#### user_csproject::sudoers
This recipe grants the specified sudo privileges for the user created in the above mentioned recipes

License and Authors
-------------------
Authors: csproject Team
