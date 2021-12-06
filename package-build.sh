#!/usr/bin/env sh
cd pihemr-debian-base

ARTIFACTS=/opt/bamboo5.9/artifacts
INTEGRATION_SHARED_DIR=${ARTIFACTS}/MIREBALAIS-INSTALL/shared
LATEST_BUILD_DIR=`ls -t ${INTEGRATION_SHARED_DIR}/|head -1`

DISTRO_DIR=home/tomcat7/.OpenMRS/distribution
MODULE_DIR=home/tomcat7/.OpenMRS/modules
OWA_DIR=home/tomcat7/.OpenMRS/owa
FRONTEND_DIR=home/tomcat7/.OpenMRS/frontend
SITE_FRONTEND_DIR_RELATIVE_TO_FRONTEND=../configuration/frontend

rm -fR ${DISTRO_DIR} && mkdir ${DISTRO_DIR}
rm -fR ${MODULE_DIR} && mkdir ${MODULE_DIR}
rm -fR ${OWA_DIR} && mkdir ${OWA_DIR}
rm -fR ${FRONTEND_DIR} && mkdir ${FRONTEND_DIR}

unzip ${INTEGRATION_SHARED_DIR}/${LATEST_BUILD_DIR}/distribution-zip/pihemr*.zip -d  ${DISTRO_DIR}/
mv ${DISTRO_DIR}/pihemr-*/openmrs_webapps/openmrs.war ./openmrs.war
mv ${DISTRO_DIR}/pihemr-*/openmrs_modules/* ${MODULE_DIR}/
mv ${DISTRO_DIR}/pihemr-*/openmrs_owas/* ${OWA_DIR}/
rename 's/\.owa$/.zip/' ${OWA_DIR}/*.owa
mv ${DISTRO_DIR}/pihemr-*/openmrs_frontend/* ${FRONTEND_DIR}/
ln -s ${SITE_FRONTEND_DIR_RELATIVE_TO_FRONTEND} ${FRONTEND_DIR}/site

rm -fR ${DISTRO_DIR}

debuild --no-tgz-check -i -us -uc -b
