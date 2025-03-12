# web_ssl_install

Ansible role to install and configure web servers (Apache HTTPD or Nginx) with SSL certificates on Red Hat Enterprise Linux (RHEL) systems. This role handles the installation of web server packages, deployment of SSL certificates, and configuration of SSL settings.

## Requirements

- Ansible 2.9 or higher
- Red Hat Enterprise Linux (RHEL) 7 or higher
- SSH access to the target server

## Role Variables

### Default Variables

```yaml
web_server_type: "" 
cert_filename: "" 
html_se_type: "httpd_sys_content_t"
ssl_se_type: "cert_t"
required_packages:
  httpd: ["httpd", "mod_ssl"]
  nginx: ["nginx"]
Web Server Configuration
web_server_config:
  httpd:
    service_name: "httpd"
    ssl_conf_dir: "/etc/httpd/conf.d"
    ssl_conf_file: "/etc/httpd/conf.d/ssl_{{ ansible_fqdn }}.conf"
    cert_dir: "/etc/pki/tls/certs"
    key_dir: "/etc/pki/tls/private"
    packages: "{{ required_packages.httpd | default(['httpd', 'mod_ssl']) }}"
    install_task: "httpd/install.yml"
    document_root: "/var/www/html"
  nginx:
    service_name: "nginx"
    ssl_conf_dir: "/etc/nginx/conf.d"
    ssl_conf_file: "/etc/nginx/conf.d/ssl_{{ ansible_fqdn }}.conf"
    cert_dir: "/etc/pki/nginx"
    key_dir: "/etc/pki/nginx/private"
    packages: "{{ required_packages.nginx | default(['nginx']) }}"
    install_task: "nginx/install.yml"
    document_root: "/usr/share/nginx/html"
Temporary Directories for Certificate Setup
temp_dir: "/tmp/unzipped_certs" # Directory for extracted certificates
temp_zip_path: "/tmp/certificates.zip" # Path for uploaded ZIP file
backup_dir: "/var/backup/old_ssl" # Directory for backups (unused in install)
Certificate Source Paths
cert_base_path: "/runner/project/packages/certificates" # Base path for certificate files
cert_zip: "{{ cert_base_path }}/{{ cert_filename }}" # ZIP file (set cert_filename in playbook)
ca_trust_dir: "/etc/pki/ca-trust/source/anchors" # Directory for Root CA
root_ca_file_local: "{{ cert_base_path }}/Weizmann_Root_CA.pem" # Local Root CA file
root_ca_file_remote: "{{ ca_trust_dir }}/Weizmann_Root_CA.pem" # Remote Root CA file
Certificate File Patterns
org_name: "weizmann" # Organization name for file matching
cert_pattern: "*{{ org_name }}*cer" # Pattern for certificate files
key_pattern: "*{{ org_name }}*key" # Pattern for key files
ca_cert_pattern: "CACert.cer" # Pattern for CA certificate
Regex Patterns for File Filtering
cert_regex: ".*\\.cer$" # Regex for certificate files
key_regex: ".*\\.key$" # Regex for key files
ca_cert_regex: ".*CACert\\.cer$" # Regex for CA certificate
Network Configuration
ssl_port: 443 # Default SSL port

Dependencies
None.

Example Playbook
- hosts: all
  roles:
    - role: web_ssl_install
      web_server_type: "nginx" # Set in AAP
      cert_filename: "certificates.zip" # Set in AAP


License
MIT

Author Information
This role was created by Emile Krantz
