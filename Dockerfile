FROM osrf/ros:melodic-desktop-full-bionic 


# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install GLX-Gears
RUN apt update && apt install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*

# install LeGO-LOAM dependencies - GTSAM
RUN apt update && apt-get install wget
RUN wget -O ~/gtsam.zip https://github.com/borglab/gtsam/archive/4.0.0-alpha2.zip
RUN cd ~/ && unzip gtsam.zip
RUN cd ~/gtsam-4.0.0-alpha2/ && mkdir build && cd build && cmake .. && make install -j4

# Compile LeGO-LOAM
RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/src && git clone https://github.com/RobustFieldAutonomyLab/LeGO-LOAM.git
RUN /bin/sh -c '. /opt/ros/melodic/setup.sh; cd ~/catkin_ws ; catkin_make -j1'