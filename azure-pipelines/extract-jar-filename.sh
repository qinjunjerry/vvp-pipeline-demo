jarFileName=`cat pom.xml| python -c "
import sys, xml.etree.ElementTree
root = xml.etree.ElementTree.fromstring(sys.stdin.read())
count = 0
for child in root:
  if child.tag.endswith('artifactId'):
    artifactId = child.text
    count += 1
  if child.tag.endswith('version'):
    version = child.text
    count += 1
if count == 2:
  print artifactId + '-' + version + '.jar'
else:
  sys.exit(1)
"`
echo "##vso[task.setvariable variable=jarFileName]$jarFileName"