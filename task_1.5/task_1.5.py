import json
import pandas as pd

# with open('/Users/prohorovsvv/Downloads/task_de_sprint/task_1.5/data.json', 'r') as file:
#     data = json.load(file)

# data_list = []

# for i in data['data']:
#     data_list.append([i['title'], i['work experience'], i['salary'], i['region']])
    
# df = pd.DataFrame(data_list, columns= data['data'][0].keys())

# print(df)

df = pd.read_csv('ds_salaries.csv')
# print(df.columns)
group_job_title = df.groupby('job_title').count()
print(group_job_title)