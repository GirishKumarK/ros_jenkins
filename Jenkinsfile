pipeline {
    agent any

    stages {
        stage("Build") {
            steps {
                echo "Building.."
                sh "docker build -t tortoisebot-ros1-gazebo:latest ros1/gazebo/."
            }
        }
        stage("Test") {
            steps {
                echo "Testing.."
                sh "docker run --name tortoisebot-ros1-gazebo -d -v '/tmp/.X11-unix:/tmp/.X11-unix' -e 'DISPLAY=:2' tortoisebot-ros1-gazebo:latest"
                sh "sleep 45"
                sh "docker exec tortoisebot-ros1-gazebo bash -c 'source /opt/ros/noetic/setup.bash; source /ros1_ws/devel/setup.bash; rostest tortoisebot_waypoints waypoints_test.test --reuse-master'"
            }
        }
        stage("Clean") {
            steps {
                echo "Cleaning.."
                sh "docker rm -vf \$(docker ps -aq)"
            }
        }
    }
}