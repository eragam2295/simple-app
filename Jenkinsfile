pipeline {
     agent { label  'dev' }
     tools {
         jdk  'openjdk 1.8'
         git  'Default'
         maven 'maven'
         dockerTool 'docker'
     }
     
    stages {
        stage ('scm checkout') {
            steps{
               git url:'https://github.com/eragam2295/simple-app.git'
        }
    }

       stage('mvn package'){
           steps{ 
             sh 'mvn clean package'
             sh 'pwd'
             sh 'ls -lr'
}
}
       stage('upload war to nexus'){
           steps{ 
                     nexusArtifactUploader artifacts: [
                              [
                                      artifactId: 'simple-app',
                                      classifier: '', 
                                      file: 'target/simple-app-3.0.0-SNAPSHOT.war', 
                                      type: 'war'
                           ]
                    ],
                    credentialsId: 'nexus3', 
                    groupId: 'in.javahome',
                    nexusUrl: '3.139.236.36:8081',
                   nexusVersion: 'nexus3', 
                   protocol: 'http', 
                   repository: 'simpleapp-release/',
                   version: '1.1.0'
           }
       }
       stage ('build docker image'){
           steps {
               sh 'docker build -t eragam2295/my-app1:2.1.0 .'
      }
   }
       stage ('push docker image'){
           steps {
               withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubpwd')]){
              sh "docker login -u eragam2295 -p ${dockerhubpwd}"
	    	}
              sh 'docker push eragam2295/my-app1:2.1.0'
      }
}   
       stage ( 'deploy to k8s' ) {
           steps{
               sshagent(['kops-machine']) {
                   sh  "scp -o StrictHostKeyChecking=no  services.yml  Deployment.yml  centos@18.220.109.97:/home/centos/"
                   script{
                       try{
                           sh "ssh centos@18.220.109.97 kubectl apply -f ."
                       }catch(error) {
                           sh "ssh centos@18.220.109.97 kubectl create -f ." 
                   }
                }     
           }
       }
}  
}
}

