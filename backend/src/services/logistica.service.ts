// Logistica.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Logistica } from 'src/models/logistica.entity';
import { LogisticaRepository } from 'src/repositories/logistica.repository';
import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class LogisticaService {
  constructor(
    @InjectRepository(LogisticaRepository)
    private logisticaRepository: LogisticaRepository,
  ) {

  }

  async findAll(): Promise<Logistica[]> {
    return this.logisticaRepository.findAll();
  }

  async findById(id: string): Promise<Logistica | null> {
    return await this.logisticaRepository.findById(id);
  }
  

  async create(data: Partial<Logistica>): Promise<Logistica> {
    console.log(data)
    return this.logisticaRepository.createLogistica(data);
  }

  async updateLogistica(id: string, data: Partial<Logistica>): Promise<UpdateResult> {
    return this.logisticaRepository.updateLogistica(id, data);
  }

  async deleteLogistica(id: string): Promise<DeleteResult> {
    return this.logisticaRepository.deleteLogistica(id);
  }

}
