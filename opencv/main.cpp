#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

int main() {
    // Define image size
    const int width = 800, height = 400;
    
    // Create a grayscale gradient
    cv::Mat gradient(height, width, CV_8UC1);
    for (int x = 0; x < width; ++x) {
        gradient.col(x) = static_cast<uchar>((255 * x) / width);
    }
    
    // Apply the rainbow color map
    cv::Mat rainbow;
    cv::applyColorMap(gradient, rainbow, cv::COLORMAP_RAINBOW);
    
    // Show the image
    cv::imshow("Rainbow Image", rainbow);
    cv::waitKey(0);
    
    // Save the image
    cv::imwrite("rainbow.png", rainbow);
    
    return 0;
}
