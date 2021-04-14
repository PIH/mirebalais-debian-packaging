cd pihemr-debian-base

ARTIFACTS=/opt/bamboo5.9/artifacts
INTEGRATION_SHARED_DIR=${ARTIFACTS}/MIREBALAIS-INTEGRATION/shared
LATEST_BUILD_DIR=`ls -t ${INTEGRATION_SHARED_DIR}/|head -1`

DISTRO_DIR=home/tomcat7/.OpenMRS/distribution
MODULE_DIR=home/tomcat7/.OpenMRS/modules
OWA_DIR=home/tomcat7/.OpenMRS/owa

rm -fR ${DISTRO_DIR} && mkdir ${DISTRO_DIR}
rm -fR ${MODULE_DIR} && mkdir ${MODULE_DIR}
rm -fR ${OWA_DIR} && mkdir ${OWA_DIR}

unzip ${INTEGRATION_SHARED_DIR}/${LATEST_BUILD_DIR}/distribution-zip/mirebalais-distribution*.zip -d  ${DISTRO_DIR}/
mv ${DISTRO_DIR}/mirebalais-distribution-*/openmrs_webapps/openmrs.war ./openmrs.war
mv ${DISTRO_DIR}/mirebalais-distribution-*/openmrs_modules/* ${MODULE_DIR}/
mv ${DISTRO_DIR}/mirebalais-distribution-*/openmrs_owas/* ${OWA_DIR}/
rename 's/\.owa$/.zip/' ${OWA_DIR}/*.owa

rm -fR ${DISTRO_DIR}

debuild --no-tgz-check -i -us -uc -b
