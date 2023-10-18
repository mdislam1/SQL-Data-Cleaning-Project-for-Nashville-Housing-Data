# SQL-Data-Cleaning-Project-for-Nashville-Housing-Data

This SQL project focuses on cleaning and transforming data from the `NashvilleHousing` table, addressing issues such as date standardization, populating missing data, breaking down addresses into individual columns, and handling categorical data.

**Analysis Steps:**

1. **Standardize Date Format:**
   - Converts the `SaleDate` column to the standard date format.

2. **Populate Property Address Data:**
   - Fills missing values in the `PropertyAddress` column by matching entries based on the `ParcelID`.

3. **Breaking out Address into Individual Columns:**
   - Splits the `PropertyAddress` column into separate columns for address and city.

4. **Breaking out Owner Address into Individual Columns:**
   - Parses the `OwnerAddress` column to create separate columns for address, city, and state.

5. **Change Y and N to Yes and No:**
   - Converts values in the `SoldAsVacant` column from 'Y' and 'N' to 'Yes' and 'No', respectively.

6. **Remove Duplicates:**
   - Identifies and removes duplicate entries based on selected columns, ensuring data integrity.

7. **Delete Unused Columns:**
   - Removes columns such as `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, and `SaleDate` that are no longer needed after data cleaning.

**Note:**
- The project enhances the usability and reliability of the Nashville housing dataset by addressing issues related to date formats, missing data, and categorical values.
- Data cleaning steps ensure that the dataset is ready for further analysis, reducing the likelihood of errors and improving overall data quality.
- The SQL scripts provide a clear and structured approach to handling various data cleaning tasks, making it easy for other analysts or data scientists to replicate the process.
