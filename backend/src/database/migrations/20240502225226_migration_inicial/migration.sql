-- CreateTable
CREATE TABLE "movimento_financeiro" (
    "id" TEXT NOT NULL,
    "data_inclusao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_vencimento" TIMESTAMP(3) NOT NULL,
    "data_pagamento" TIMESTAMP(3),
    "valor" DECIMAL(65,30) NOT NULL,
    "id_pessoa" INTEGER,
    "descricao" TEXT,

    CONSTRAINT "movimento_financeiro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "movimento_financeiro_pagamentos" (
    "id" TEXT NOT NULL,
    "id_movimento" TEXT NOT NULL,
    "valor" DECIMAL(65,30) NOT NULL,
    "data_operacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "movimento_financeiro_pagamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "logistica" (
    "id" TEXT NOT NULL,
    "id_movimento" TEXT NOT NULL,
    "data_operacao" TIMESTAMP(3) NOT NULL,
    "tipo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "logistica_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produto" (
    "uuid_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "preco" DECIMAL(65,30) NOT NULL,
    "categoria" TEXT NOT NULL,

    CONSTRAINT "produto_pkey" PRIMARY KEY ("uuid_id")
);

-- CreateTable
CREATE TABLE "pessoa" (
    "uuid_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "contato" TEXT NOT NULL,
    "endereco" TEXT NOT NULL,

    CONSTRAINT "pessoa_pkey" PRIMARY KEY ("uuid_id")
);

-- CreateTable
CREATE TABLE "pedido" (
    "uuid_id" TEXT NOT NULL,
    "data_pedido" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,
    "id_produto" TEXT NOT NULL,
    "id_pessoa" TEXT NOT NULL,
    "id_movimento" TEXT,
    "id_logistica" TEXT,

    CONSTRAINT "pedido_pkey" PRIMARY KEY ("uuid_id")
);

-- CreateTable
CREATE TABLE "usuario" (
    "uuid_id" TEXT NOT NULL,
    "login" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("uuid_id")
);

-- AddForeignKey
ALTER TABLE "movimento_financeiro_pagamentos" ADD CONSTRAINT "movimento_financeiro_pagamentos_id_movimento_fkey" FOREIGN KEY ("id_movimento") REFERENCES "movimento_financeiro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "logistica" ADD CONSTRAINT "logistica_id_movimento_fkey" FOREIGN KEY ("id_movimento") REFERENCES "movimento_financeiro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_id_produto_fkey" FOREIGN KEY ("id_produto") REFERENCES "produto"("uuid_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_id_pessoa_fkey" FOREIGN KEY ("id_pessoa") REFERENCES "pessoa"("uuid_id") ON DELETE RESTRICT ON UPDATE CASCADE;
