// Produto.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { Produto } from 'src/models/produto.entity';
import { ProdutoService } from 'src/services/produtos.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('produto')
export class ProdutoController {
  constructor(private readonly produtoService: ProdutoService) {}

  @Get()
  findAll(): Promise<Produto[]> {
    return this.produtoService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string): Promise<Produto | null> {
    return this.produtoService.findById(id);
  }

  @Post()
  create(@Body() data: Produto): Promise<Produto> {
    return this.produtoService.create(data);
  }

  @Put(':id')
  async updateProduto(@Param('id') id: string, @Body() data: Partial<Produto>): Promise<UpdateResult> {
    return this.produtoService.updateProduto(id, data);
  }

  @Delete(':id')
  async deleteProduto(@Param('id') id: string): Promise<DeleteResult> {
    return this.produtoService.deleteProduto(id);
  }

}

