pipeline {
   agent any 
   stages{
   stage ('version') {
     steps{
       sh 'docker --version'
     }
    }
    stage ('pull') {
     steps{
       sh 'docker pull ubuntu'
     }
    }
    stage ('build') {
     steps{
       sh 'docker build .'
     }
    }      
    stage ('run') {
     steps{
       sh 'docker run -d -it ubuntu'
     }
    }
   }
}