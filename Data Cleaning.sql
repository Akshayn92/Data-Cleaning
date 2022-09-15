select*
from Nashvillehousing

Select saleDateConverted, convert(Date,saleDate)
from Nashvillehousing

Update Nashvillehousing
SET SaleDate = convert(Date, SaleDate)
select*
from Nashvillehousing

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(Date, SaleDate)


--Property Address Amendment 

Select *
from NashvilleHousing
--Where PropertyAddress is Null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.propertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
on a.ParcelID= b.ParcelID
AND a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is NULL

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.propertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
on a.ParcelID= b.ParcelID
AND a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is NULL

Select PropertyAddress
from NashvilleHousing



-- Property adress into address and city
Select PropertyAddress
from NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1, CharINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

From NashvilleHousing

Alter Table  NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set Propertysplitaddress= SUBSTRING(PropertyAddress, 1, CharINDEX(',', PropertyAddress) -1)

Alter Table  NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set Propertysplitcity=SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


Select*
from NashvilleHousing

--Splitting owner Address using Parsename
Select Owneraddress
from NashvilleHousing

Select
Parsename(REPLACE(Owneraddress,',', '.'),3)
,Parsename(REPLACE(Owneraddress,',', '.'),2)
,Parsename(REPLACE(Owneraddress,',', '.'),1)
From Nashvillehousing


Alter Table  NashvilleHousing
Add PropertySplitaddress1 Nvarchar(255);
 
Update NashvilleHousing
Set PropertySplitaddress1= Parsename(REPLACE(Owneraddress,',', '.'),3)


Alter Table  NashvilleHousing
Add PropertySplitcity1 Nvarchar(255);

Update NashvilleHousing
Set PropertySplitcity1= Parsename(REPLACE(Owneraddress,',', '.'),2)



Alter Table  NashvilleHousing
Add PropertySplitstate Nvarchar(255);

Update NashvilleHousing
Set PropertySplitstate= Parsename(REPLACE(Owneraddress,',', '.'),1)

Select*
from NashvilleHousing



--Change Y and N to Yes and NO in 'SOLD as Vacant' field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
	When  SoldAsVacant ='N' Then 'No'
		Else SoldAsVacant
		END
From NashvilleHousing

Update NashvilleHousing 
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	When  SoldAsVacant ='N' Then 'No'
		Else SoldAsVacant
		END


Select*
from NashvilleHousing



--Remove Duplicates
with RowNumCTE As(
Select*,
	Row_NUMBER()over(
	Partition By ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order By
				UniqueID)
				row_num

From NashvilleHousing
)

Select*
from RowNumCTE
where row_num>1
Order by PropertyAddress




----Delete Unused column
Select*
from NashvilleHousing

Alter Table NashvilleHousing
Drop Column



