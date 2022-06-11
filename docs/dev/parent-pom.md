# PASS Parent POM

The PASS parent POM configures plugins and sets versions for dependencies common to the various Java projects. 
In addition, it defines a profile for release which is inherited by descendant projects.  

### Plugin Management

In order to ensure consistency among the various projects, we 
configure several plugins in the parent POM. These include the checkstyle and enforcer plugins, 
as well as various plugins related to release. 

### Key dependencies

Dependencies related to logging are managed in the parent pom to manage 
a single version of the slf4j logging framework to be used in all descendant projects.





### Release

To activate the release profile in any descendant of the 
parent pom, one invokes maven with

`mvn deploy -P release`



