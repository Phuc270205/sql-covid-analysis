-- cleaning the data


Select *
From SQL_Project.dbo.NashvilleHousing


-- Standardize Date Format 

Select SaleDateConverted, CONVERT(Date, SaleDate)
From SQL_Project.dbo.NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


-- Populate Property Address data

Select *
From SQL_Project.dbo.NashvilleHousing
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,  b.PropertyAddress)
From SQL_Project.dbo.NashvilleHousing a
JOIN SQL_Project.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID]
Where a.PropertyAddress is null
