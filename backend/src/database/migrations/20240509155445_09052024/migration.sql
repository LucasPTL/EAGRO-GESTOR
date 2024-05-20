/*
  Warnings:

  - The primary key for the `pedido` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `uuid_id` on the `pedido` table. All the data in the column will be lost.
  - The primary key for the `pessoa` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `uuid_id` on the `pessoa` table. All the data in the column will be lost.
  - The primary key for the `produto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `uuid_id` on the `produto` table. All the data in the column will be lost.
  - The primary key for the `usuario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `uuid_id` on the `usuario` table. All the data in the column will be lost.
  - The required column `id` was added to the `pedido` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `pessoa` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `produto` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `id` was added to the `usuario` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "pedido" DROP CONSTRAINT "pedido_id_pessoa_fkey";

-- DropForeignKey
ALTER TABLE "pedido" DROP CONSTRAINT "pedido_id_produto_fkey";

-- AlterTable
ALTER TABLE "pedido" DROP CONSTRAINT "pedido_pkey",
DROP COLUMN "uuid_id",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "pedido_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "pessoa" DROP CONSTRAINT "pessoa_pkey",
DROP COLUMN "uuid_id",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "pessoa_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "produto" DROP CONSTRAINT "produto_pkey",
DROP COLUMN "uuid_id",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "produto_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "usuario" DROP CONSTRAINT "usuario_pkey",
DROP COLUMN "uuid_id",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "usuario_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_id_produto_fkey" FOREIGN KEY ("id_produto") REFERENCES "produto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_id_pessoa_fkey" FOREIGN KEY ("id_pessoa") REFERENCES "pessoa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
