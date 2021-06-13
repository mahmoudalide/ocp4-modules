#bin/bash

mkdir -p /srv/nfs/mosip/minio
mkdir -p /srv/nfs/mosip/softhsm/keymanager
mkdir -p /srv/nfs/mosip/mz/kafka
mkdir -p /srv/nfs/mosip/dmz/kafka
mkdir -p /srv/nfs/mosip/mosip-config
mkdir -p /srv/nfs/mosip/landing_folder
mkdir -p /srv/nfs/mosip/softhsm/ida
mkdir -p /srv/nfs/mosip/reg-client

git clone https://github.com/mosip/mosip-config --branch 1.1.5 -q --single-branch  /srv/nfs/mosip/mosip-config
cp ./softhsm-prep/files/softhsm2.conf /srv/nfs/mosip/softhsm/keymanager
cp -R ./softhsm-prep/files/tokens /srv/nfs/mosip/softhsm/keymanager
cp ./softhsm-prep/files/softhsm2.conf /srv/nfs/mosip/softhsm/ida
cp -R ./softhsm-prep/files/tokens /srv/nfs/mosip/softhsm/ida
cp ./reg-client-prep/templates/mosip_cer.cer /srv/nfs/mosip/reg-client/
cp ./reg-client-prep/templates/maven-metadata.xml /srv/nfs/mosip/reg-client/


helmsman --dry-run -f targets/uat.yaml -group all


./ida_zk.py --server {{site.sandbox_internal_url}} --disable_ssl_verify