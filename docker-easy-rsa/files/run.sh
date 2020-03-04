#!/usr/bin/env bash
WORKING_DIRECTORY=/var/lib/easy-rsa

execute() {
  printf "################################################################################\n"
  printf "# %-76s #\n" "$1"
  printf "################################################################################\n"

  $1
}

if [ ! -f ${WORKING_DIRECTORY}/openssl-easyrsa.cnf ] ; then
  ln -s /usr/share/easy-rsa/easyrsa "${WORKING_DIRECTORY}"
  ln -s /usr/share/easy-rsa/x509-types "${WORKING_DIRECTORY}"
  cp /usr/share/easy-rsa/openssl-easyrsa.cnf "${WORKING_DIRECTORY}"
  cp /usr/share/easy-rsa/vars.example "${WORKING_DIRECTORY}/vars"
fi

[ ! -d pki ] && execute "./easyrsa --batch --req-cn=${COMMON_NAME} init-pki"
[ ! -f pki/ca.crt ] && execute "./easyrsa --batch --req-cn=${COMMON_NAME} build-ca nopass"
#[ ! -f pki/private/${COMMON_NAME}.key ] && ./easyrsa --batch build-server-full ${COMMON_NAME} nopass
[ ! -f pki/crl.pem ] && execute "./easyrsa gen-crl"

ACTION="$1"
case "$ACTION" in
  create-user)
    USER="$2"
    if [ "$USER" != "" ] ; then
      if [ ! -f pki/private/${USER}.key ] ; then
        execute "./easyrsa --batch build-client-full ${USER} nopass"
        cat pki/issued/${USER}.crt pki/private/${USER}.key pki/ca.crt > pki/issued/${USER}.bundle.pem
        chmod go-rw pki/issued/${USER}.bundle.pem
      else
        echo "user already exists."
      fi
    else
      echo "create-user <username>"
    fi
    ;;
  create-server)
    NAME="$2"
    if [ "$NAME" != "" ] ; then
      if [ ! -f pki/private/${NAME}.key ] ; then
        execute "./easyrsa --batch build-server-full ${NAME} nopass"
      else
        echo "name already exists."
      fi
    else
      echo "create-server <name>"
    fi
    ;;
  export)
    USER="$2"
    if [ "$USER" != "" ] ; then
      execute "./easyrsa --batch export-p12 ${USER}"
    else
      echo "export <username>"
    fi
    ;;
  list)
    cat pki/index.txt
    ;;
  shell)
    bash
    ;;
  *)
    ;;
esac
