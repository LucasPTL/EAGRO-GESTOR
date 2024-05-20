// pessoa.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { Pessoa } from 'src/models/pessoa.entity';
import { PessoaService } from 'src/services/pessoa.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('pessoa')
export class PessoaController {
  constructor(private readonly pessoaService: PessoaService) {}

  @Get()
  findAll(): Promise<Pessoa[]> {
    return this.pessoaService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string): Promise<Pessoa | null> {
    return this.pessoaService.findById(id);
  }

  @Post()
  create(@Body() data: Pessoa): Promise<Pessoa> {
    return this.pessoaService.create(data);
  }

  @Put(':id')
  async updatePessoa(@Param('id') id: string, @Body() data: Partial<Pessoa>): Promise<UpdateResult> {
    return this.pessoaService.updatePessoa(id, data);
  }

  @Delete(':id')
  async deletePessoa(@Param('id') id: string): Promise<DeleteResult> {
    return this.pessoaService.deletePessoa(id);
  }

}

