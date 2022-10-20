# -*- coding: utf-8 -*-
"""Heart Patient DataSet for Classification.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1703Cx-KUjaw4KFyLpt918N6NzIO2o1cM
"""

#Heart Patient DATA

# Commented out IPython magic to ensure Python compatibility.
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# %matplotlib inline
sns.set_style('whitegrid')
plt.style.use('fivethirtyeight')
import warnings
warnings.filterwarnings('ignore')

df=pd.read_csv("/content/heart_failure_clinical_records_dataset.csv")

"""# New Section"""

df.head()

df.shape

df.info()

round(df.describe(),2)

import missingno as mno
mno.bar(df)

plt.figure(figsize=(15,4))
df.isnull().sum().sort_values(ascending=False).plot(kind='bar',color='blue')
plt.show()

for i in df:
    if df[i].dtype=='int64'or df[i].dtype=='float64':
        print('This is related -',i)
        print()
        sns.displot(df[i])
        plt.show()
        print()
        sns.boxplot(df[i])
        plt.show()
        print('**************************************')

sns.pairplot(df,hue="DEATH_EVENT")
plt.show()

dummydata=pd.get_dummies(df)

dummydata.head()



plt.figure(figsize=(15,8))
dummydata.corr()['DEATH_EVENT'].sort_values(ascending=False).plot(kind='bar')

data=[24,63,64,1,54,56,17,45,22,34,56,89,90]

type_citizen=[]
for i in (df['age']):
    # print(i)
    if i<=28:
        type_citizen.append('Young Citizen')
    elif i>28 and i<=45:
        type_citizen.append('Junior Cititzen')
    else:
        type_citizen.append('Senior Citizen')

set(type_citizen)

df['Citizen']=type_citizen

piechart=(df['Citizen'].value_counts()*100/len(df))\
.plot.pie(autopct='%.1f%%',labels=['Senior Citizen','Junior Citizen','Young Citizen'],figsize=(5,5),fontsize=12)
plt.show()

agesum=sns.displot(df['age'],kde=True,color='darkred')
# agesum.set_title('# of the age of the patient')

fig, (ax1,ax2,ax3)=plt.subplot(nrows=1,ncols=3,sharey=True,figsize=(20,6))

ax=sns.distplot(df[df['Citizen']=='Senior Citizen']['platelets'],kde=True,ax=ax1)
ax=sns.distplot(df[df['Citizen']=='Junior Citizen']['platelets'],kde=True,ax=ax2)
ax=sns.distplot(df[df['Citizen']=='Young Citizen']['platelets'],kde=True,ax=ax3)