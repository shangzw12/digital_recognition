import MG_math as mg
import math
import numpy as np
import tensorflow as tf
from numpy import linalg
from numpy import matrix
import pickle as pk

# Import MNIST data
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("/tmp/tensorflow/mnist/input_data", one_hot=True)

# load mnist data
# They are numpy.ndarray
Xtr, Ytr = mnist.train.next_batch(45000)  # whole training set
Xte, Yte = mnist.train.next_batch(10000)  # whole test set

X_mg = mg.group(Xtr, Ytr)
mean = []
[variance, variance_1] = np.load("MixtureGaussian.npy")
mean = np.load("MixtureGaussian_mean.npy")
with tf.Session() as sess:
    accuracy = 0
    for i in range(len(Xte)):
        prob = []
        for j in range(10):
            prob.append(mg.Normal(Xte[i], mean[j], variance[j], variance_1[j]))
        #print(prob)
        pred = np.argmax(prob)
        print("Test", i, "Prediction:", pred,
                "True Class:", np.argmax(Yte[i])) # return index
        if pred == np.argmax(Yte[i]):
                accuracy += 1. / len(Xte)
    print("Done!")
    print("Accuracy:", accuracy)