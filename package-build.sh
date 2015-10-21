cd pihemr-debian-base

ARTIFACTS=/opt/bamboo5.9/artifacts
OMOD_ARTIFACT=$ARTIFACTS/MIREBALAIS-INTEGRATION/shared
LATEST_OMOD=`ls -t $OMOD_ARTIFACT/|head -1`

mkdir home/tomcat7/.OpenMRS/modules
unzip -j $OMOD_ARTIFACT/$LATEST_OMOD/omod-zip/mirebalais-distribution*.zip -d  home/tomcat7/.OpenMRS/modules/

WAR_ARTIFACT=$ARTIFACTS/MIREBALAIS-OPENMRS/shared
LATEST_WAR=`ls -t $WAR_ARTIFACT/|head -1`
cp $WAR_ARTIFACT/$LATEST_WAR/war/openmrs.war ./openmrs.war

debuild --no-tgz-check -i -us -uc -b
