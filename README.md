# Task Management App

## ERD


### User 

| Column Name   |   DataType    |
| :----:        |  :----:       | 
| id            |   Int         | 
| name          |   string      | 
| email         |   string      | 
| password      |   string      | 
| create_at     |   timestamp   |
| updated_at    |   timestamp   |

### Task

| Column Name   |   DataType    |
| :----:        |  :----:       | 
| id            |   Int         | 
| name          |   string      | 
| content       |   Text        | 
| status        |   string      | 
| deadline      |   timestamp   |
| create_at     |   timestamp   |
| updated_at    |   timestamp   |
| user_id       |   int         |