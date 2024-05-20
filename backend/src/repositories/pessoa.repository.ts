import { Repository, UpdateResult, DeleteResult } from 'typeorm';
import { Pessoa } from 'src/models/pessoa.entity';
import { InjectRepository } from '@nestjs/typeorm';


export class PessoaRepository extends Repository<Pessoa> {
    constructor(
        @InjectRepository(Pessoa)   
        private pessoaRepository: Repository<Pessoa>,
      ) {
        super(
          pessoaRepository.target,
          pessoaRepository.manager,
          pessoaRepository.queryRunner,
        );
      }
 public async findAll(): Promise<Pessoa[]> {
    return await this.find();
 }
 
 public async findById(id: string): Promise<Pessoa | null> {
   return await this.findOne({ where: { id: id }});
}

public async createPessoa(data: Partial<Pessoa>): Promise<Pessoa> {
    const pessoa = this.create(data);
    return this.save(pessoa);
 }

 public  async updatePessoa(id: string, data: Partial<Pessoa>): Promise<UpdateResult> {
    return this.update(id, data);
 }

 public async deletePessoa(id: string): Promise<DeleteResult> {
    return this.delete(id);
 }

}
