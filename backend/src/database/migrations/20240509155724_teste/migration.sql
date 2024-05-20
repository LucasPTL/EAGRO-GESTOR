/*
  Warnings:

  - The primary key for the `pessoa` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `usuario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `id` on the `pessoa` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `usuario` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "pessoa" DROP CONSTRAINT "pessoa_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "pessoa_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "usuario" DROP CONSTRAINT "usuario_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "usuario_pkey" PRIMARY KEY ("id");
