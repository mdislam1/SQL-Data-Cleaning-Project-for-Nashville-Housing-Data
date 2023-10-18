/*

Cleaning Data in SQL Queries

*/

SELECT * FROM NashvilleHousing 


-- Standardize Date Format

SELECT 
	SaleDate,
	CAST(SaleDate AS date)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate DATE


-- Populate Property Address data

SELECT 
	PropertyAddress
FROM NashvilleHousing


SELECT 
	A.UniqueID,
	A.PropertyAddress,
	A.UniqueID,
	B.PropertyAddress,
	ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM NashvilleHousing A 
JOIN NashvilleHousing B 
	ON A.ParcelID = B.ParcelID
	AND A.UniqueID != B.UniqueID
WHERE A.PropertyAddress IS NULL



UPDATE A 
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM NashvilleHousing A 
JOIN NashvilleHousing B 
	ON A.ParcelID = B.ParcelID
	AND A.UniqueID != B.UniqueID
WHERE A.PropertyAddress IS NULL



-- Breaking out Address into Individual Columns (Address, City, State)



SELECT 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1),
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress))
FROM NashvilleHousing



ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))



SELECT OwnerAddress FROM NashvilleHousing


SELECT 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT
	SoldAsVacant,
	CASE SoldAsVacant
		WHEN 'Y' THEN 'Yes'
		WHEN 'N' THEN 'No'
		ELSE SoldAsVacant
	END 
FROM NashvilleHousing



Update NashvilleHousing
SET SoldAsVacant = 	CASE SoldAsVacant
						WHEN 'Y' THEN 'Yes'
						WHEN 'N' THEN 'No'
						ELSE SoldAsVacant
					END 


-- Remove Duplicates


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
)
DELETE
From RowNumCTE
Where row_num > 1



-- Delete Unused Columns

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate









