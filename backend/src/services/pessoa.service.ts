// pessoa.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Pessoa } from 'src/models/pessoa.entity';
import { PessoaRepository } from 'src/repositories/pessoa.repository';
import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class PessoaService {
  constructor(
    @InjectRepository(PessoaRepository)
    private pessoaRepository: PessoaRepository,
  ) {

  }

  async findAll(): Promise<Pessoa[]> {
    return this.pessoaRepository.findAll();
  }

  async findById(id: string): Promise<Pessoa | null> {
    return await this.pessoaRepository.findById(id);
  }
  

  async create(data: Partial<Pessoa>): Promise<Pessoa> {
    console.log(data)
    return this.pessoaRepository.createPessoa(data);
  }

  async updatePessoa(id: string, data: Partial<Pessoa>): Promise<UpdateResult> {
    return this.pessoaRepository.updatePessoa(id, data);
  }

  async deletePessoa(id: string): Promise<DeleteResult> {
    return this.pessoaRepository.deletePessoa(id);
  }

}
