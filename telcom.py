#!/usr/bin/env python
# coding: utf-8

# In[62]:


import numpy as np
import tensorflow as tf
from tensorflow import keras
import pandas as pd
import matplotlib.pyplot as plt
pd.options.mode.chained_assignment = None


# In[ ]:





# In[1]:


df=pd.read_csv("F:/My programs/DataS/archive/WA_Fn-UseC_-Telco-Customer-Churn.csv")
df.head()



# In[2]:


df.shape


# In[6]:


df=df.drop('customerID',axis='columns')


# In[8]:


df.head()


# In[12]:


df.dtypes


# In[18]:


df['TotalCharges'].values


# In[39]:


pd.to_numeric(df['TotalCharges'],errors='coerce').isnull()


# In[40]:


df[pd.to_numeric(df['TotalCharges'],errors='coerce').isnull()]


# In[43]:


df_drop1=df[df['TotalCharges']!=' ']


# In[45]:


df_drop1


# In[46]:


df_drop1.shape


# In[52]:


df_drop1['TotalCharges']


# In[64]:


df_drop1.TotalCharges=pd.to_numeric(df_drop1['TotalCharges'])


# In[68]:


df_drop1['TotalCharges'].dtype


# In[73]:


for x in df:
    print(df[x].unique())


# In[90]:


def print_unique_dtype(df,y):
    for x in df:
        if df[x].dtype==y:
            print(f'{x}:{df[x].unique()}')


# In[84]:


print_unique_dtype(df_drop1,'object')


# In[93]:


print_unique_dtype(df_drop1,'float64')


# In[103]:


df2=pd.get_dummies(data=df,columns=['Contract'])


# In[105]:


df2


# In[109]:


x=df.drop('Churn',axis='columns')
y=df['Churn']


# In[112]:


from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2,random_state=69)


# In[114]:


x_train.shape


# In[115]:


y_test.value_counts()


# In[3]:


model=ANN(x_train,y_train,x_test,y_test,'binary_crossestropy'-1)


# In[2]:




