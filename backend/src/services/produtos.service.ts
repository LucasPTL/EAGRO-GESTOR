// Produto.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Produto } from 'src/models/produto.entity';
import { ProdutoRepository } from 'src/repositories/produto.repository';
import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class ProdutoService {
  constructor(
    @InjectRepository(ProdutoRepository)
    private produtoRepository: ProdutoRepository,
  ) {

  }

  async findAll(): Promise<Produto[]> {
    return this.produtoRepository.findAll();
  }

  async findById(id: string): Promise<Produto | null> {
    return await this.produtoRepository.findById(id);
  }
  

  async create(data: Partial<Produto>): Promise<Produto> {
    console.log(data)
    return this.produtoRepository.createProduto(data);
  }

  async updateProduto(id: string, data: Partial<Produto>): Promise<UpdateResult> {
    return this.produtoRepository.updateProduto(id, data);
  }

  async deleteProduto(id: string): Promise<DeleteResult> {
    return this.produtoRepository.deleteProduto(id);
  }

}
