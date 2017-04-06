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
#Xte, Yte = mnist.train.next_batch(10000)  # whole test set

X_mg = mg.group(Xtr, Ytr)
mean = []
variance = []
variance_1= []
    
for i in range(10):
    mean.append([])
    variance.append([])
    variance_1.append([])
    mean[i] = mg.Mean(X_mg[i])
    variance[i], variance_1[i] = mg.Variance(X_mg[i], mean[i])
    
np.save("MixtureGaussian.npy",[variance, variance_1] )
np.save("MixtureGaussian_mean.npy",mean )
