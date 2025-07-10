-- india general elections 2024
create database if not exists elections;
use elections;

-- table creations
CREATE TABLE state (
    id VARCHAR(10) PRIMARY KEY,
    state VARCHAR(50)
);

CREATE TABLE partywise_results (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    won INTEGER
);

CREATE TABLE constituencywise_results (
    s_no INTEGER PRIMARY KEY,
    parliament_constituency VARCHAR(100) NOT NULL,
    constituency_name VARCHAR(100) NOT NULL,
    winning_candidate VARCHAR(100),
    total_votes INTEGER,
    margin INTEGER,
    constituency_id VARCHAR(10) UNIQUE NOT NULL,
    party_id VARCHAR(10),
    FOREIGN KEY (party_id) REFERENCES partywise_results(id)
);

CREATE TABLE constituencywise_details (
    s_no INTEGER,
    candidate_name VARCHAR(100),
    party_name VARCHAR(100),
    evm_votes INTEGER,
    postal_votes INTEGER,
    total_votes INTEGER,
    percentage_votes INTEGER,
    constituency_id VARCHAR(10)
);

drop table constituencywise_details;
CREATE TABLE constituencywise_results (
    s_no INTEGER,
    parliament_constituency VARCHAR(100) PRIMARY KEY,
    constituency_name VARCHAR(100),
    winning_candidate VARCHAR(100),
    total_votes INTEGER,
    margin INTEGER,
    constituency_id VARCHAR(10) NOT NULL,
    party_id VARCHAR(10),
    FOREIGN KEY (party_id) REFERENCES partywise_results(id)
);

CREATE TABLE statewise_results (
    constituency VARCHAR(100),
    const_no VARCHAR(10),
    parliament_constituency VARCHAR(100) PRIMARY KEY,
    leading_candidate VARCHAR(100),
    trailing_candidate VARCHAR(100),
    margin INTEGER,
    status VARCHAR(50),
    stateid VARCHAR(10),
    FOREIGN KEY (stateid) REFERENCES state(id)
);

desc constituencywise_results;

-- data exploration
SELECT * FROM state;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM statewise_results;

-- beginner level questions
-- 1.total seats

SELECT COUNT(*) AS total_seats
FROM constituencywise_results;

-- 2.total_seats from each state

SELECT 
    statewise_results.stateid,
    state.state,
    COUNT(*) AS total_seats
FROM 
    statewise_results
INNER JOIN 
    state ON statewise_results.stateid = state.id
GROUP BY 
    statewise_results.stateid, state.state;

-- seats won by NDA alliance 
SELECT sum(won) as total_seats
FROM partywise_results
WHERE name LIKE '%Bharatiya Janata Party%'
   OR name LIKE '%Telugu Desam%'
   OR name LIKE '%Janasena%'
   OR name LIKE '%Janata Dal (United)%'
   OR name LIKE '%Lok Janshakti%'
   OR name LIKE '%Apna Dal%'
   OR name LIKE '%Shiv Sena%'
   OR name LIKE '%Republican Party of India%'
   OR name LIKE '%Asom Gana Parishad%'
   OR name LIKE '%National People%'
   OR name LIKE '%Naga People%'
   OR name LIKE '%Hindustani Awam%'
   OR name LIKE '%All India Anna Dravida%'
   OR name LIKE '%Nishad%'
   OR name LIKE '%United People’s Party%'
   OR name LIKE '%Sikkim Krantikari%'
   OR name LIKE '%Indigenous People%'
   OR name LIKE '%All Jharkhand Students%'
   OR name LIKE '%Bharat Dharma Jana Sena%';


-- select nda parties seats
SELECT name, Won
FROM partywise_results
WHERE name LIKE '%Bharatiya Janata Party%'
   OR name LIKE '%Telugu Desam%'
   OR name LIKE '%Janasena%'
   OR name LIKE '%Janata Dal (United)%'
   OR name LIKE '%Lok Janshakti%'
   OR name LIKE '%Apna Dal%'
   OR name LIKE '%Shiv Sena%'
   OR name LIKE '%Republican Party of India%'
   OR name LIKE '%Asom Gana Parishad%'
   OR name LIKE '%National People%'
   OR name LIKE '%Naga People%'
   OR name LIKE '%Hindustani Awam%'
   OR name LIKE '%All India Anna Dravida%'
   OR name LIKE '%Nishad%'
   OR name LIKE '%United People’s Party%'
   OR name LIKE '%Sikkim Krantikari%'
   OR name LIKE '%Indigenous People%'
   OR name LIKE '%All Jharkhand Students%'
   OR name LIKE '%Bharat Dharma Jana Sena%';

-- total seats by indi alliance
SELECT SUM(Won) AS india_total
FROM partywise_results
WHERE name LIKE '%Indian National Congress%'
   OR name LIKE '%Dravida Munnetra Kazhagam%'
   OR name LIKE '%Aam Aadmi%'
   OR name LIKE '%Samajwadi Party%'
   OR name LIKE '%Trinamool%'
   OR name LIKE '%Rashtriya Janata Dal%'
   OR name LIKE '%Shiv Sena (UBT)%'
   OR name LIKE '%Nationalist Congress Party%'
   OR name LIKE '%Jharkhand Mukti%'
   OR name LIKE '%Communist Party of India%'
   OR name LIKE '%CPI(M)%'
   OR name LIKE '%IUML%'
   OR name LIKE '%VCK%'
   OR name LIKE '%RSP%';

-- partwise in indi allaince
SELECT name,won
FROM partywise_results
WHERE name LIKE '%Indian National Congress%'
   OR name LIKE '%Dravida Munnetra Kazhagam%'
   OR name LIKE '%Aam Aadmi%'
   OR name LIKE '%Samajwadi Party%'
   OR name LIKE '%Trinamool%'
   OR name LIKE '%Rashtriya Janata Dal%'
   OR name LIKE '%Shiv Sena (UBT)%'
   OR name LIKE '%Nationalist Congress Party%'
   OR name LIKE '%Jharkhand Mukti%'
   OR name LIKE '%Communist Party of India%'
   OR name LIKE '%CPI(M)%'
   OR name LIKE '%IUML%'
   OR name LIKE '%VCK%'
   OR name LIKE '%RSP%';

-- add new column alliance to partwise_results
alter table partywise_results add alliance varchar(100);
set sql_Safe_updates=0;
UPDATE partywise_results
SET alliance = CASE
    -- NDA Alliance
    WHEN name LIKE '%Bharatiya Janata Party%' THEN 'NDA'
    WHEN name LIKE '%Telugu Desam%' THEN 'NDA'
    WHEN name LIKE '%Janasena%' THEN 'NDA'
    WHEN name LIKE '%Janata Dal (United)%' THEN 'NDA'
    WHEN name LIKE '%Lok Janshakti%' THEN 'NDA'
    WHEN name LIKE '%Apna Dal%' THEN 'NDA'
    WHEN name LIKE '%Shiv Sena%' AND name NOT LIKE '%UBT%' THEN 'NDA'
    WHEN name LIKE '%Republican Party of India%' THEN 'NDA'
    WHEN name LIKE '%Asom Gana%' THEN 'NDA'
    WHEN name LIKE '%National People%' THEN 'NDA'
    WHEN name LIKE '%Nishad%' THEN 'NDA'
    WHEN name LIKE '%HAM%' THEN 'NDA'
    WHEN name LIKE '%AJSU%' THEN 'NDA'
    WHEN name LIKE '%BDJS%' THEN 'NDA'

    -- INDIA Alliance
    WHEN name LIKE '%Indian National Congress%' THEN 'INDIA'
    WHEN name LIKE '%Dravida Munnetra Kazhagam%' THEN 'INDIA'
    WHEN name LIKE '%Aam Aadmi%' THEN 'INDIA'
    WHEN name LIKE '%Samajwadi Party%' THEN 'INDIA'
    WHEN name LIKE '%Trinamool%' THEN 'INDIA'
    WHEN name LIKE '%Rashtriya Janata Dal%' THEN 'INDIA'
    WHEN name LIKE '%Shiv Sena (UBT)%' THEN 'INDIA'
    WHEN name LIKE '%Nationalist Congress Party%' THEN 'INDIA'
    WHEN name LIKE '%Jharkhand Mukti%' THEN 'INDIA'
    WHEN name LIKE '%Communist Party of India%' THEN 'INDIA'
    WHEN name LIKE '%CPI(M)%' THEN 'INDIA'
    WHEN name LIKE '%IUML%' THEN 'INDIA'
    WHEN name LIKE '%VCK%' THEN 'INDIA'
    WHEN name LIKE '%RSP%' THEN 'INDIA'

    -- Others
    ELSE 'OTHERS'
END;
set sql_safe_updates=1;
select *From 
partywise_results;
