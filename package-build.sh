cd mirebalais-debian-base

ARTIFACTS=/opt/bamboo-home/artifacts
OMOD_ARTIFACT=$ARTIFACTS/MIREBALAIS-INTEGRATION/shared
LATEST_OMOD=`ls -t $OMOD_ARTIFACT/|head -1`

mkdir home/tomcat6/.OpenMRS/modules
unzip -j $OMOD_ARTIFACT/$LATEST_OMOD/omod-zip/mirebalais-distribution*.zip -d  home/tomcat6/.OpenMRS/modules/

WAR_ARTIFACT=$ARTIFACTS/MIREBALAIS-OPENMRS/shared
LATEST_WAR=`ls -t $WAR_ARTIFACT/|head -1`
cp $WAR_ARTIFACT/$LATEST_WAR/war/openmrs.war ./mirebalais.war

perl -pi -e 's/mirebalais \(1.0-1\)/mirebalais (1.0.${bamboo.buildNumber}-1)/' mirebalais-debian-base/debian/changelog

debuild --no-tgz-check -i -us -uc -b
