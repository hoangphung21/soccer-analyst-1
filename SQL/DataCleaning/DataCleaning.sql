/*
Cleaning Data in SQL
*/

Select *
from PortfolioProjects..Housing

-- Standardlize Date Format

Select SaleDate2, CONVERT(Date,saledate)
from PortfolioProjects..Housing

update Housing
Set SaleDate = CONVERT(Date,saledate)

Alter Table Housing
add Saledate2 Date;

update Housing
set Saledate2 = CONVERT(Date,saledate)

--Populate Property Address Data
-- Because each PropertyAddress has ParcelID so we gonna adding address to null based on parcel id
Select * 
from PortfolioProjects..Housing
order by ParcelID

Select h1.ParcelID,h1.PropertyAddress,h2.ParcelID,h2.PropertyAddress,
isnull(h1.PropertyAddress,h2.PropertyAddress)
from PortfolioProjects..Housing h1
join PortfolioProjects..Housing h2
	on h1.ParcelID = h2.ParcelID
	and h1.[UniqueID ] <> h2.[UniqueID ]
where h1.PropertyAddress is null

update h1 
set PropertyAddress = isnull(h1.PropertyAddress,h2.PropertyAddress)
from PortfolioProjects..Housing h1
join PortfolioProjects..Housing h2
	on h1.ParcelID = h2.ParcelID
	and h1.[UniqueID ] <> h2.[UniqueID ]
where h1.PropertyAddress is null

Select * 
from PortfolioProjects..Housing
order by PropertyAddress


-- Breaking out address into individual columns (Address,City,State)
Select PropertyAddress 
from PortfolioProjects..Housing

select
substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress) - 1) as Address,
substring(PropertyAddress,CHARINDEX(',',PropertyAddress) + 1,len(PropertyAddress)) as City
from PortfolioProjects..Housing

Alter Table Housing
add PropertySplitAddress nvarchar(255);

update Housing
set PropertySplitAddress = substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress) - 1)

Alter Table Housing
add PropertySplitCity nvarchar(255);

update Housing
set PropertySplitCity = substring(PropertyAddress,CHARINDEX(',',PropertyAddress) + 1,len(PropertyAddress))

select *
from PortfolioProjects..Housing


select OwnerAddress
from PortfolioProjects..Housing

select
PARSENAME(replace(OwnerAddress,',','.'),3),
PARSENAME(replace(OwnerAddress,',','.'),2),
PARSENAME(replace(OwnerAddress,',','.'),1)
from PortfolioProjects..Housing

Alter Table Housing
add OwnerSplitAddress nvarchar(255);

update Housing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3)

Alter Table Housing
add OwnerSplitCity nvarchar(255);

update Housing
set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2)

Alter Table Housing
add OwnerSplitState nvarchar(255);

update Housing
set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)

select OwnerSplitAddress,OwnerSplitCity,OwnerSplitState
from PortfolioProjects..Housing

-- change Y and N to Yes and No in "Sold as vacant"

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PortfolioProjects..Housing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end
from PortfolioProjects..Housing

update Housing
set SoldAsVacant = case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end
from PortfolioProjects..Housing



-- Remove Duplicates Data
-- Using CTE
--should use partition by something unique

with rowNumCTE as (
select *, 
ROW_NUMBER() over (
				partition by ParcelID,
							 PropertyAddress,
							 SalePrice,
							 SaleDate,
							 LegalReference
							 order by UniqueID
							 ) row_num

from PortfolioProjects..Housing
--order by ParcelID
)
Delete
from rowNumCTE
where row_num > 1




