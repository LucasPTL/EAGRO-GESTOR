import { Repository, UpdateResult, DeleteResult } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Produto } from 'src/models/produto.entity';

export class ProdutoRepository extends Repository<Produto> {
    constructor(
        @InjectRepository(Produto)   
        private produtoRepository: Repository<Produto>,
      ) {
        super(
          produtoRepository.target,
          produtoRepository.manager,
          produtoRepository.queryRunner,
        );
      }
 public async findAll(): Promise<Produto[]> {
    return await this.find();
 }
 
 public async findById(id: string): Promise<Produto | null> {
   return await this.findOne({ where: { id: id }});
}

public async createProduto(data: Partial<Produto>): Promise<Produto> {
    const Produto = this.create(data);
    return this.save(Produto);
 }

 public  async updateProduto(id: string, data: Partial<Produto>): Promise<UpdateResult> {
    return this.update(id, data);
 }

 public async deleteProduto(id: string): Promise<DeleteResult> {
    return this.delete(id);
 }

}
