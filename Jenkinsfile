pipeline {
    agent any

    stages {
        stage("Build") {
            steps {
                echo "Building.."
                sh "docker build -t tortoisebot-ros2-gazebo:latest ros2/gazebo/."
            }
        }
        stage("Test") {
            steps {
                echo "Testing.."
                sh "docker run --name tortoisebot-ros2-gazebo -d -v '/tmp/.X11-unix:/tmp/.X11-unix' -e 'DISPLAY=:2' tortoisebot-ros2-gazebo:latest"
                sh "sleep 30"
                sh "docker exec -d tortoisebot-ros2-gazebo bash -c 'source /opt/ros/galactic/setup.bash; source /ros2_ws/install/setup.bash; ros2 run tortoisebot_waypoints tortoisebot_action_server'"
                sh "docker exec -it tortoisebot-ros2-gazebo bash -c 'source /opt/ros/galactic/setup.bash; source /ros2_ws/install/setup.bash; colcon test --packages-select tortoisebot_waypoints --event-handler=console_direct+'"
            }
        }
        stage("Clean") {
            steps {
                echo "Cleaning.."
                sh "docker rm -vf $(docker ps -aq)"
            }
        }
    }
}