# WSL: sudo docker run --name cudaopencv --runtime=nvidia --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -it cudaopencv 

FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    g++ \
    wget \
    libgtkglext1 \
    libgtkglext1-dev \
    git \
    unzip \
    pkg-config \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbbmalloc2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-dev \
    && rm -rf /var/lib/apt/lists/*

# https://opencv.org/get-started/
WORKDIR /opt
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.x.zip
RUN unzip opencv.zip
RUN unzip opencv_contrib.zip

RUN mkdir -p build
WORKDIR /opt/build

RUN cmake \
-D CMAKE_BUILD_TYPE=RELEASE \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D WITH_TBB=ON \
-D OPENCV_DNN_CUDA=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D CUDA_ARCH_BIN=8.7 \
-D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib-4.x/modules \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF \
-D HAVE_opencv_python3=ON \
-D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
-D CUDNN_INCLUDE_DIR=/usr/include \
-D CUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.9 \
-D ENABLE_FAST_MATH=1 \
-D PYTHON_EXECUTABLE=/usr/bin/python3 \
-D WITH_GTK=ON \
-D WITH_OPENGL=ON \
../opencv-4.x 

RUN cmake --build . -j 16
RUN make install
RUN ldconfig

WORKDIR /workspace
RUN git clone https://github.com/vinicius-r-silva/examples

CMD ["/bin/bash"]