FROM ros:noetic-ros-base-focal

ENV DEBIAN_FRONTEND=noninteractive
ENV CATKIN_WS=/catkin_ws

# ------------------------------------------------------------------
# OS + Azure Kinect SDK + ROS deps
# ------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    curl gnupg2 lsb-release software-properties-common \
    build-essential git cmake \
    ros-noetic-rgbd-launch \
    ros-noetic-image-proc \
    ros-noetic-depth-image-proc \
    ros-noetic-robot-state-publisher \
    ros-noetic-joint-state-publisher \
    ros-noetic-tf \
 && rm -rf /var/lib/apt/lists/*

# Azure Kinect SDK repo (for 20.04)
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && apt-get install -y \
      libk4a1.4 libk4a1.4-dev k4a-tools && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------
# Catkin workspace + Azure Kinect ROS Driver (melodic branch)
# ------------------------------------------------------------------
RUN mkdir -p ${CATKIN_WS}/src
WORKDIR ${CATKIN_WS}/src

RUN git clone --branch melodic https://github.com/microsoft/Azure_Kinect_ROS_Driver.git azure_kinect_ros_driver

WORKDIR ${CATKIN_WS}
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Make ROS env available in interactive shells
RUN echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc && \
    echo 'source /catkin_ws/devel/setup.bash' >> /root/.bashrc

WORKDIR /catkin_ws
CMD ["bash"]

