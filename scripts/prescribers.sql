--1a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.

SELECT P.NPI AS NPI,
MAX(PR.total_claim_count) AS totalclaims
FROM prescriber AS P
INNER JOIN prescription AS PR
ON P.npi=PR.npi
GROUP BY P.NPI
ORDER BY MAX(PR.total_claim_count) DESC;

--Answer : Provider with npi 1912011792




--b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, and the total number of claims.

SELECT P.NPI AS NPI,p.nppes_provider_first_name, p.nppes_provider_last_org_name
,p.specialty_description,
MAX(PR.total_claim_count) AS totalclaims
FROM prescriber AS P
INNER JOIN prescription AS PR
ON P.npi=PR.npi
GROUP BY P.NPI,p.nppes_provider_last_org_name,p.nppes_provider_first_name,p.specialty_description
ORDER BY MAX(PR.total_claim_count) DESC;

--2a. Which specialty had the most total number of claims (totaled over all drugs)?

SELECT p.specialty_description,MAX(pr.total_claim_count) AS totalclaimcount
FROM prescriber AS P
INNER JOIN prescription AS PR
ON P.npi=PR.NPI
GROUP BY p.specialty_description
ORDER BY MAX(pr.total_claim_count) desc;

--Answer: Family Practice

--b. Which specialty had the most total number of claims for opioids?

SELECT p.specialty_description,MAX(pr.total_claim_count) AS totalclaimcount
FROM prescriber AS P
INNER JOIN prescription AS PR
ON P.npi=PR.NPI
LEFT JOIN drug AS D
ON d.drug_name=PR.drug_name
WHERE d.opioid_drug_flag = 'Y'
GROUP BY p.specialty_description
ORDER BY MAX(pr.total_claim_count) desc; 

Select *
FROM drug d
where d.opioid_drug_flag = 'Y'

--c. Challenge Question: Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?

SELECT specialty_description,p.npi AS PRESCRIBEnpi,PR.npi AS PRESCRIPTIONNPI
FROM prescriber AS P
LEFT JOIN prescription AS PR
ON P.npi=PR.npi
WHERE PR.npi IS NULL;

--Answer:Yes


--d. Difficult Bonus: Do not attempt until you have solved all other problems! For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?

--a. Which drug (generic_name) had the highest total drug cost?
SELECT DR.generic_name , MAX(PR.total_drug_cost) AS totatldrugcost
FROM prescription AS PR
LEFT JOIN drug AS DR
ON PR.drug_name=DR.drug_name
GROUP BY DR.generic_name
ORDER BY MAX(PR.total_drug_cost) DESC;

--Answer:Pirfenidone


--b. Which drug (generic_name) has the hightest total cost per day? Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.
SELECT DR.generic_name , SUM(PR.total_drug_cost)/SUM(PR.total_30_day_fill_count) AS totalcostperday
FROM prescription AS PR
LEFT JOIN drug AS DR
ON PR.drug_name=DR.drug_name
GROUP BY DR.generic_name
ORDER BY SUM(PR.total_drug_cost)/SUM(PR.total_30_day_fill_count) DESC;

--Answer:Chenodiol


a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.

b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

a. How many CBSAs are in Tennessee? Warning: The cbsa table contains information for all states, not just Tennessee.

b. Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population.

c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.

a. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

b. For each instance that you found in part a, add a column that indicates whether the drug is an opioid.

c. Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

The goal of this exercise is to generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. Hint: The results from all 3 parts will have 637 rows.

a. First, create a list of all npi/drug_name combinations for pain management specialists (specialty_description = 'Pain Managment') in the city of Nashville (nppes_provider_city = 'NASHVILLE'), where the drug is an opioid (opiod_drug_flag = 'Y'). Warning: Double-check your query before running it. You will only need to use the prescriber and drug tables since you don't need the claims numbers yet.

b. Next, report the number of claims per drug per prescriber. Be sure to include all combinations, whether or not the prescriber had any claims. You should report the npi, the drug name, and the number of claims (total_claim_count).

c. Finally, if you have not done so already, fill in any missing values for total_claim_count with 0. Hint - Google the COALESCE function.