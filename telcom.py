import pandas as pd
import matplotlib.pyplot as plt


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


# In[ ]:




