sudo yum install openvpn easy-rsa -y
sudo cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn/


sudo echo "user nobody
           group nobody" >> /etc/openvpn/server/server.conf
sudo mkdir -p /etc/openvpn/easy-rsa/keys
sudo cp -r /usr/share/easy-rsa/3.0/* /etc/openvpn/easy-rsa
#sudo cd /etc/openvpn/easy-rsa/
sudo cat << EOF > /etc/openvpn/easy-rsa/vars

set_var EASYRSA                 "$PWD"
set_var EASYRSA_PKI             "$EASYRSA/pki"
set_var EASYRSA_DN              "cn_only"
set_var EASYRSA_REQ_COUNTRY     "RU"

set_var EASYRSA_REQ_PROVINCE    "Moscow"

set_var EASYRSA_REQ_CITY        "Moscow"

set_var EASYRSA_REQ_ORG         "MyOrg"

set_var EASYRSA_REQ_EMAIL       "openvpn@mydomain.net"

set_var EASYRSA_REQ_OU          "CA"

set_var EASYRSA_KEY_SIZE        2048

set_var EASYRSA_ALGO            rsa

set_var EASYRSA_CA_EXPIRE       7500

set_var EASYRSA_CERT_EXPIRE     365

set_var EASYRSA_NS_SUPPORT      "no"

set_var EASYRSA_NS_COMMENT      "CERTIFICATE AUTHORITY"

set_var EASYRSA_EXT_DIR         "$EASYRSA/x509-types"

set_var EASYRSA_SSL_CONF        "$EASYRSA/openssl-1.0.cnf"

set_var EASYRSA_DIGEST          "sha256"
