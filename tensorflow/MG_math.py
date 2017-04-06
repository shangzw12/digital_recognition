import numpy as np
import math
import numpy.matlib

def group(data, label):
    assert len(data) == len(label)
    res= []
    for i in range(10):
            res.append([])
    for i in range(len(label)):
        res[np.argmax(label[i])].append(data[i])
    return res #from 0 to 9
    
# all are array
def Normal(X, mu, Sigma, Sigma_1):
    assert len(X) == len(mu)
    assert len(X) == len(Sigma)
    #print (len(X) ,"\n" , len(mu) ,"\n" ,len(Sigma))
    m_x = np.matrix(X)
    m_mu = np.matrix(mu)
    m_sigma = np.matrix(Sigma)
    m_sigma_1 = np.matrix(Sigma_1)
    return -(math.log(2*math.pi) )\
    -1/2.0*((m_x-m_mu)*(m_sigma_1)*(m_x - m_mu).T).item(0)
    
# return array
def Mean(data):
    assert len(data) !=0
    tmp = np.matrix(np.zeros(len(data[0])))
    for i in range(len(data)):
        tmp += np.matrix(data[i])
    tmp  = tmp/(len(data))
    return np.squeeze(np.asarray(tmp))

# return 2-D array
def Variance(data, mean):
    m_mean = np.matrix(mean)
    var = np.matrix(np.matlib.zeros((len(mean), len(mean))))
    for i in range(len(data)):
        var += (np.matrix(data[i]) - m_mean ).T *(np.matrix(data[i]) - m_mean )
    var = var / len(data)
    delta = 0.001 + np.matrix(np.identity(len(mean)))
    return np.squeeze(np.asarray(var + delta)), np.squeeze(np.asarray((var + delta).I))

    
