fedora_commons role
=========

from: http://fedorarepository.org/about 
Fedora is a robust, modular, open source repository system for the management and dissemination of digital content. It is especially suited for digital libraries and archives, both for access and preservation

The ansible script is based on the files found in this github repo: https://github.com/fcrepo4-exts/fcrepo4-vagrant

Caveat emptor: the fedora_auth and fedora_audit boolean switches may cause ansible to fail if the particular release does not exist.  It appears that the base fedora (with neither audit nor WebAC) is not compiled on every release.

Requirements
------------

- Tomcat and Java should already be installed
- Internet connection as it downloads war files directly.

Role Variables
--------------
* Tomcat
    - webapps_dir - string - the directory were war files are placed
    - tomcat_dir - string - the base of the directory where tomcat is installed
    - tomcat_user - string - the user that is currently used by tomcat
    - tomcat_group - string - the group that is currently used in tomcat
* Fuseki
    - install_fuseki - bool - install fuseki?
    - fuseki_version - string - the version of fuseki to install
    - fuseki_deploy_context - the tomcat context where fuseki will be installed
    - fuseki_base - string - the base directory where fuseki info goes
    - fuseki_base_url - string - the base of the url where fuseki is downloaded from
* Solr
    - install_solr - bool - install solr?
    - solr_version - string - the version of solr to install
    - solr_home - string - where solr should be installed
    - solr_deploy_context - string - the tomcat context to access solr
    - solr_base_url - string - the base of the url where solr will be downloaded from
    - solr_server_port - the port that solr will run in
* Karaf
    - java_home - string - used throughout the karaf installation and service instantiation (use group_vars or host_vars for this), by default it will use alternatives' output
    - install_karaf - bool - install karaf?
    - karaf_version - string - the version of karaf to install
    - karaf_base - string - the main directory that karaf should be referenced in
    - karaf_base_url - string - the base of the url where karaf is downloaded from
    - install_audit_service - bool - install the audit service with karaf (may generate double triples) 
* Fedora
    - fedora_version - string - the version to run
    - fedora_admin - string - the name of the admin user
    - fedora_pwd - string - the password of the admin user
    - fedora_users - list of dictionaries - for each user, the following dict values: name, pwd, roles (which correspond to username, password, and fedora roles)
    - fedora_roles - list of string - the fedora roles that will be in use
    - fedora_home - the main fedora directory
    - fedora_auth - bool - use web access control
    - fedora_audit - bool - use audit capabilities
    - fedroa_camel - bool - use the camel toolbox scripts 
    - fedora_deploy_context - string - the tomcat context to access fcrepo
    - fedora_base_url - string - the url of the fedora instance (default: http://localhost:8080/fcrepo/rest)
    - base_url - string - base of the url from which to download the fcrepo war files

Dependencies
------------
 - tomcat (You need to add -Dfcrepo.audit.container={{ fedora_audit_location }} -Dfcrepo.home=/path/to/{{fedora_home}}/fcrepo4-data -Dsolr.solr.home=/path/to/{{solr_home}} to tomcat_java_opts) 
 - Additionally, you currently need to use the oracle provider until the following issue is resolved: https://issues.apache.org/jira/browse/KARAF-4502

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: fedora_commons }

License
-------

BSD

Author Information
------------------
John Walsh - mjohnw@umich.edu

