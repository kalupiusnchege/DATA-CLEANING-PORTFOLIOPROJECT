-- CLEANING DATA IN SQL QUERIES 


SELECT [Sale Date]  
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]


--STANDARDIZE SALE DATE FORMAT 

SELECT [Sale DateConverted], CONVERT(Date,[Sale Date]) 
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]

UPDATE [NashvilleHousingData]
SET [Sale Date] = CONVERT(Date,[Sale Date])

ALTER TABLE [NashvilleHousingData]
ADD [Sale DateConverted] Date;

UPDATE [NashvilleHousingData]
SET [Sale DateConverted] = CONVERT(Date,[Sale Date])

-- POPULATE PROPERTY ADDRESS DATA 


SELECT *
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]
--WHERE [Property Address] IS NULL
ORDER BY [Parcel ID]



SELECT A.[Parcel ID], A.[Property Address], B.[Parcel ID], B.[Property Address], ISNULL(A.[Property Address],B.[Property Address])
FROM [PortfolioProject ].[dbo].[NashvilleHousingData] A
JOIN [PortfolioProject ].[dbo].[NashvilleHousingData] B
    ON A.[Parcel ID] = B.[Parcel ID]
	AND A.[Unnamed: 0] <> B.[Unnamed: 0]
WHERE A.[Property Address] IS NULL


UPDATE A 
SET [Property Address] = ISNULL(A.[Property Address],B.[Property Address])
FROM [PortfolioProject ].[dbo].[NashvilleHousingData] A
JOIN [PortfolioProject ].[dbo].[NashvilleHousingData] B
    ON A.[Parcel ID] = B.[Parcel ID]
	AND A.[Unnamed: 0] <> B.[Unnamed: 0]
WHERE A.[Property Address] IS NULL


-- CHANGE Y AND N TO YES AND NO IN "Sold As Vacant" FIELD

SELECT DISTINCT([Sold As Vacant]), COUNT([Sold As Vacant])
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]
GROUP BY ([Sold As Vacant])
ORDER BY 2
-- NOTE THIS DATA HAS ALREADY BEEN WORKED ON FROM THE MAIN DATASET.


-- REMOVE DUPLICATES 

WITH [ROWNUMCTE] AS(
SELECT *,
     ROW_NUMBER() OVER (
	 PARTITION BY [Parcel ID],
	              [Property Address],
				  [Sale Price],
				  [Sale Date],
				  [Legal Reference]
				  ORDER BY 
				  [F1]
				  ) rom_num

FROM [PortfolioProject ].[dbo].[NashvilleHousingData]
--ORDER BY [Parcel ID]
)
SELECT *
FROM  [ROWNUMCTE] 
WHERE rom_num > 1 
ORDER BY [Property Address]


SELECT *
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]


-- DELETE UNUSED COLUMN 


SELECT *
FROM [PortfolioProject ].[dbo].[NashvilleHousingData]


ALTER TABLE [PortfolioProject ].[dbo].[NashvilleHousingData]
DROP COLUMN [SALEDATECONVERTED], [Sale Date]

ALTER TABLE [PortfolioProject ].[dbo].[NashvilleHousingData]
DROP COLUMN [Unnamed: 0]