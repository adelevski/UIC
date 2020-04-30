import matplotlib.pylab as plt
import cv2
import numpy as np

cap = cv2.VideoCapture('test.mp4')
video_number = 1


#image = cv2.imread('road.png')
#image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

#print(image.shape)
#height = image.shape[0]
#width = image.shape[1]


#region_of_interest_vertices = [
#            (230, height),
#            (500, 350),
#            (670, 350),
#            (1100, height)
#    ]


def region_of_interest(img, vertices):
    mask = np.zeros_like(img)
    # channel_count = img.shape[2]
    match_mask_color = (255)
    cv2.fillPoly(mask, vertices, match_mask_color)
    masked_image = cv2.bitwise_and(img, mask)
    return masked_image

#cropped_image = region_of_interest(image, 
#                             np.array([region_of_interest_vertices], np.int32))

#plt.imshow(cropped_image)
#plt.show()


def draw_the_lines(img, lines):
    img = np.copy(img)
    blank_image = np.zeros((img.shape[0], img.shape[1], 3), dtype=np.uint8)

    for line in lines:
        for x1, y1, x2, y2 in line:
            cv2.line(blank_image, (x1, y1), (x2, y2), (0, 255, 0), thickness=10)

    img = cv2.addWeighted(img, 0.8, blank_image, 1, 0.0)
    return img

#image = cv2.imread('road.png')
#image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
def process(image):
    print(image.shape)
    height = image.shape[0]
    width = image.shape[1]
    if video_number == 1:
        region_of_interest_vertices = [
            (230, height),
            (500, 350),
            (670, 350),
            (1100, height)
        ]
    else:
        region_of_interest_vertices = [
            (0, height),
            (420, 350),
            (730, 350),
            (1200, height),
            (1040, height),
            (665, 380),
            (480, 380),
            (140, 670)
        ]


    gray_image = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
    canny_image = cv2.Canny(gray_image, 100, 120)
    cropped_image = region_of_interest(canny_image,
                    np.array([region_of_interest_vertices], np.int32))

    lines = cv2.HoughLinesP(cropped_image, 
                            rho = 2,
                            theta = np.pi/180,
                            threshold = 160,
                            lines = np.array([]),
                            minLineLength = 40,
                            maxLineGap = 100)

    image_with_lines = draw_the_lines(image, lines)
    return image_with_lines



while(cap.isOpened()):
    ret, frame = cap.read()
    frame = process(frame)
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()