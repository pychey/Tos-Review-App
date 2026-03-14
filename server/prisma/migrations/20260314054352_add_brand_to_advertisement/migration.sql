/*
  Warnings:

  - Added the required column `brandName` to the `Advertisement` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Advertisement" ADD COLUMN     "brandLogo" TEXT,
ADD COLUMN     "brandName" TEXT NOT NULL;
