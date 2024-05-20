// Logistica.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { Logistica } from 'src/models/logistica.entity';
import { LogisticaService } from 'src/services/logistica.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('logistica')
export class LogisticaController {
  constructor(private readonly logisticaService: LogisticaService) {}

  @Get()
  findAll(): Promise<Logistica[]> {
    return this.logisticaService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string): Promise<Logistica | null> {
    return this.logisticaService.findById(id);
  }

  @Post()
  create(@Body() data: Logistica): Promise<Logistica> {
    return this.logisticaService.create(data);
  }

  @Put(':id')
  async updateLogistica(@Param('id') id: string, @Body() data: Partial<Logistica>): Promise<UpdateResult> {
    return this.logisticaService.updateLogistica(id, data);
  }

  @Delete(':id')
  async deleteLogistica(@Param('id') id: string): Promise<DeleteResult> {
    return this.logisticaService.deleteLogistica(id);
  }

}

