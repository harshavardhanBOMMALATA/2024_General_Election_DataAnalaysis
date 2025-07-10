# 2024_General_Election_DataAnalaysis
This project explores Indian General Election results using SQL and CSV data. We designed a normalized database with state, party, constituency, and candidate details. We analyzed key patterns like margins, party wins, and vote shares by solving SQL queries on structured election data.
## Project Overview

**Project Title**: 2024 General Election DataAnalaysis

**Level**: Advanced  

**Database**: `elections_db`

This project demonstrates the implementation of an Indian Election Results Analysis System using SQL. It includes designing normalized tables, defining relationships, and executing complex SQL queries. The goal is to showcase skills in database design, data manipulation, and analytical querying.

![election_project](indian_general_election.jpg)

## Objectives

1. **Design the Election Results Database**: Create and normalize tables for states, constituencies, candidates, parties, and election outcomes using real-world CSV data.
2. **Establish Relationships**: Implement foreign key constraints to ensure data integrity between tables.
3. **CRUD Operations**: Perform Create, Read, Update, and Delete operations to manage election data.
4. **CTAS (Create Table As Select)**: Use CTAS to generate derived tables for analytical insights like top margins and party-wise wins.
5. **Advanced SQL Queries**: Write complex queries to analyze state-wise results, vote margins, candidate comparisons, and party performance.

![schema](schema.png)

# 🗃️ Indian Elections SQL Project – Schema, CRUD, and Queries

## 🔨 Table Creation Scripts

```sql
-- State table
CREATE TABLE state (
    id INT PRIMARY KEY,
    state VARCHAR(100) NOT NULL
);

-- Statewise Results
CREATE TABLE statewise_results (
    stateid INT,
    parliament_constituency VARCHAR(100) PRIMARY KEY,
    winning_candidate VARCHAR(100),
    winning_party VARCHAR(100),
    margin INT,
    FOREIGN KEY (stateid) REFERENCES state(id)
);

-- Partywise Results
CREATE TABLE partywise_results (
    stateid INT,
    name VARCHAR(100),
    won INT,
    alliance VARCHAR(100),
    FOREIGN KEY (stateid) REFERENCES state(id)
);

-- Constituencywise Details
CREATE TABLE constituencywise_details (
    s_no INT,
    candidate_name VARCHAR(100) NOT NULL,
    party_name VARCHAR(100),
    evm_votes INT,
    postal_votes INT,
    total_votes INT,
    percentage_votes DECIMAL(5,2),
    constituency_id VARCHAR(100),
    FOREIGN KEY (constituency_id) REFERENCES statewise_results(parliament_constituency)
);
