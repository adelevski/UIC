import numpy as np
import matplotlib.pyplot as plt
from sklearn import metrics
import seaborn as sns
from sklearn.linear_model import LogisticRegression
from struct import unpack


########### DATA LOADER FUNCTION #################################################
def loader(image_file, label_file):
    images = open(image_file, 'rb')
    labels = open(label_file, 'rb') #opening the image and label files in binary

    #the image metadata
    images.read(4) #skipping magic number
    num_of_images = images.read(4)
    num_of_images = unpack('>I', num_of_images)[0] #big endian unsigned integer unpacking
    rows = images.read(4)
    rows = unpack('>I', rows)[0]
    cols = images.read(4)
    cols = unpack('>I', cols)[0]

    #the label metadata
    labels.read(4)
    N = labels.read(4)
    N = unpack('>I', N)[0]

    #Getting the data
    x = np.zeros((N, rows*cols), dtype=np.uint8) #numpy array init
    y = np.zeros(N, dtype=np.uint8) #another numpy array init
    for i in range(N):
        for j in range(rows*cols):
            tmp_pixel = images.read(1) #just need single byte
            tmp_pixel = unpack('>B', tmp_pixel)[0] #big endian unsigned char unpacking
            x[i][j] = tmp_pixel
        tmp_label = labels.read(1)
        y[i] = unpack('>B', tmp_label)[0]

    images.close()
    labels.close()
    return (x, y)
###############################################################################

#loading in the data with the loader function
train_img, train_lbl = loader('data/train-images-idx3-ubyte',
                                    'data/train-labels-idx1-ubyte')
test_img, test_lbl = loader('data/t10k-images-idx3-ubyte',
                                  'data/t10k-labels-idx1-ubyte')


################  VISUALIZING DATA #######################
plt.figure(figsize=(20,4))
for index, (image, label) in enumerate(zip(train_img[0:5], train_lbl[0:5])):
    plt.subplot(1, 5, index + 1)
    plt.imshow(np.reshape(image, (28,28)), cmap=plt.cm.gray)
    plt.title('Training: %i\n' % label, fontsize=20)
##########################################################



################# FITTING THE MODEL ###################

logisticRegr = LogisticRegression(solver = 'saga')
logisticRegr.fit(train_img, train_lbl)

########################################################


##################### Confusion Matrix ##################

score = logisticRegr.score(test_img, test_lbl)
print(score)
predictions = logisticRegr.predict(test_img)
cm = metrics.confusion_matrix(test_lbl, predictions)

plt.figure(figsize=(9,9))
sns.heatmap(cm, annot=True, fmt='.3f', linewidths=0.5, square=True, cmap='Blues_r');
plt.ylabel('Actual Label');
plt.xlabel('Predicted Label');
all_sample_title = 'Accuracy Score: {0}'.format(score)
plt.title(all_sample_title, size=15);
#######################################################################
