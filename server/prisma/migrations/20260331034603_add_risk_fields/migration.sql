-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "riskConfidence" DOUBLE PRECISION,
ADD COLUMN     "riskLevel" TEXT,
ADD COLUMN     "riskReason" TEXT,
ADD COLUMN     "riskRules" TEXT[];
