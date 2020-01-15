#include <QApplication>
#include "opencv2/opencv.hpp"

int main(int argc, char *argv[])
{
   QApplication a(argc, argv);
   using namespace cv;
   Mat image = imread("/home/breno/Pictures/qt.png");
   imshow("Output", image);
   return a.exec();
}
