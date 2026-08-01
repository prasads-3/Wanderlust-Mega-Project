@Library('Shared') _

pipeline {
    agent any

    environment {
        SONAR_HOME = tool "Sonar"
    }

    parameters {
        string(name: 'FRONTEND_DOCKER_TAG', defaultValue: '', description: 'Setting docker image for latest push')
        string(name: 'BACKEND_DOCKER_TAG', defaultValue: '', description: 'Setting docker image for latest push')
    }

    stages {

        stage("Validate Parameters") {
            steps {
                script {
                    if (params.FRONTEND_DOCKER_TAG == '' || params.BACKEND_DOCKER_TAG == '') {
                        error("FRONTEND_DOCKER_TAG and BACKEND_DOCKER_TAG must be provided.")
                    }
                }
            }
        }

        stage("Workspace cleanup") {
            steps {
                cleanWs()
            }
        }

        stage("Git: Code Checkout") {
            steps {
                script {
                    code_checkout(
                        "https://github.com/prasads-3/Wanderlust-Mega-Project.git",
                        "main"
                    )
                }
            }
        }

        stage("Trivy: Filesystem scan") {
            steps {
                script {
                    trivy_scan()
                }
            }
        }

        stage("OWASP: Dependency check") {
            steps {
                script {
                    owasp_dependency()
                }
            }
        }

        stage("SonarQube: Code Analysis") {
            steps {
                script {
                    sonarqube_analysis(
                        "Sonar",
                        "wanderlust",
                        "wanderlust"
                    )
                }
            }
        }

        stage("SonarQube: Code Quality Gates") {
            steps {
                script {
                    sonarqube_code_quality()
                }
            }
        }

        stage("Exporting environment variables") {
            parallel {

                stage("Backend env setup") {
                    steps {
                        script {
                            dir("Automations") {
                                sh "bash updatebackendnew.sh"
                            }
                        }
                    }
                }

                stage("Frontend env setup") {
                    steps {
                        script {
                            dir("Automations") {
                                sh "bash updatefrontendnew.sh"
                            }
                        }
                    }
                }

            }
        }

        stage("Docker: Build Images") {
            steps {
                script {

                    dir("backend") {
                        docker_build(
                            "wanderlust-backend-beta",
                            "${params.BACKEND_DOCKER_TAG}",
                            "prasad3737"
                        )
                    }

                    dir("frontend") {
                        docker_build(
                            "wanderlust-frontend-beta",
                            "${params.FRONTEND_DOCKER_TAG}",
                            "prasad3737"
                        )
                    }

                }
            }
        }

        stage("Docker: Push to DockerHub") {
            steps {
                script {

                    docker_push(
                        "wanderlust-backend-beta",
                        "${params.BACKEND_DOCKER_TAG}",
                        "prasad3737"
                    )

                    docker_push(
                        "wanderlust-frontend-beta",
                        "${params.FRONTEND_DOCKER_TAG}",
                        "prasad3737"
                    )

                }
            }
        }

        stage("GitOps: Update Repository") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'github-token',
                    usernameVariable: 'GITHUB_USER',
                    passwordVariable: 'GITHUB_TOKEN'
                )]) {
                    script {
                        dir("Automations") {
                            sh """
                                export BACKEND_DOCKER_TAG=${params.BACKEND_DOCKER_TAG}
                                export FRONTEND_DOCKER_TAG=${params.FRONTEND_DOCKER_TAG}
                                export GITHUB_USER=\$GITHUB_USER
                                export GITHUB_TOKEN=\$GITHUB_TOKEN

                                chmod +x update-gitops.sh
                                ./update-gitops.sh
                            """
                        }
                    }
                }
            }
        }

    }

    post {
        success {

            archiveArtifacts(
                artifacts: '**/*.xml',
                allowEmptyArchive: true,
                followSymlinks: false
            )

            echo "CI Pipeline Completed Successfully."
        }
    }
}
