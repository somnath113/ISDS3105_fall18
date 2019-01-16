# package from here https://github.com/ropenscilabs/opencv


if (!require(opencv)) devtools::install_github("ropenscilabs/opencv")
library(opencv)


myPic <- ocv_camera() #shoot a pic
ocv_write(myPic, 'myPic.jpg')
myFace <- ocv_face(myPic) #detects the face
ocv_write(myFace, 'myFace.jpg') #saves it

test <- ocv_camera()
bitmap <- ocv_bitmap(test)

ggplot2::ggsave('bg.png', ggplot2::qplot(speed, dist, data = cars, geom = c("smooth", "point")), units = 'in', width = dim(bitmap)[2]/300, height = dim(bitmap)[3]/300)
bg <- ocv_read('bg.png')



ocv_copyto(ocv_read('myPic.jpg'), bg, ocv_facemask(ocv_read('myFace.jpg')))
purrr::map(c('myPic.jpg', 'myFace.jpg', 'bg.png'), unlink)
