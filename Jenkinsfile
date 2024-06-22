pipeline {
    agent any

    environment {
        // Définir des variables d'environnement pour les informations de version
        DOCKER_REPO = 'thedove' 
        IMAGE_NAME = 'node-webapp'   
        TAG = 'v${BUILD_NUMBER}'   
    }

    stages {
        stage('Checkout') {
            steps {
                // Extraire le code source depuis le dépôt Git
                git 'https://github.com/thedovekana/deploy-simple-node-app.git/'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh "docker build -t ${DOCKER_REPO}/${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                    // Pousser les images Docker vers le registre
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'dockerhub_password', usernameVariable: 'dockerhub_username')]) {
                        sh "echo ${dockerhub_password} | docker login --username ${dockerhub_username} --password-stdin"
                        sh "docker push ${DOCKER_REPO}/${IMAGE_NAME}:${TAG}"
                        sh "docker logout"
                    }
            }
        }
        stage('Send deployment playbooks to ansible server') {
            steps {
                    // Copie des playbooks vers le serveur ansible
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansiblemaster', sshCredentials: [encryptedPassphrase: '{AQAAABAAAAAQjeyLxMTMuUu4AGZj5lx455rA8ToxBinVE6PrciAxh3M=}', key: '', keyPath: '', username: 'vagrant'], transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'sudo rm -f deploy-node-app.yml get_tag.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//vagrant', remoteDirectorySDF: false, removePrefix: '', sourceFiles: ''), sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//vagrant', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '*.yml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('Deploy a container') {
            steps {
                    // deploiement d'un container sur le serveur docker
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansiblemaster', sshCredentials: [encryptedPassphrase: '{AQAAABAAAAAQ5bDva3fQf/RGA60E5rCZr9alrMSY3QxYfwgpHJPaaYk=}', key: '', keyPath: '', username: 'vagrant'], transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook get_tag.yml', execTimeout: 3000000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//vagrant', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansiblemaster', sshCredentials: [encryptedPassphrase: '{AQAAABAAAAAQ6a+iHKFzHBxTILG7a5pq/nnwUyl6XO1WBh3K4CCJ4WU=}', key: '', keyPath: '', username: 'vagrant'], transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook deploy-node-app.yml', execTimeout: 3000000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//vagrant', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                
            }
        }
    }
}
