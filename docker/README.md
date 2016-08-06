docker Cookbook
==================
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

Requirements
------------
If you use this recipe on a smaller (less then 1G RAM) instance please create a 4GB swap first. Otherwise the installation of docker server will fail

e.g.
#### packages

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### docker::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['docker']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### docker::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `docker` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[docker]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
