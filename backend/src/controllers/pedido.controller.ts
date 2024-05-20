// Pedido.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { Pedido } from 'src/models/pedido.entity';
import { PedidoService } from 'src/services/pedido.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('pedido')
export class PedidoController {
  constructor(private readonly pedidoService: PedidoService) {}

  @Get()
  findAll(): Promise<Pedido[]> {
    return this.pedidoService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string): Promise<Pedido | null> {
    return this.pedidoService.findById(id);
  }

  @Post()
  create(@Body() data: Pedido): Promise<Pedido> {
    return this.pedidoService.create(data);
  }

  @Put(':id')
  async updatePedido(@Param('id') id: string, @Body() data: Partial<Pedido>): Promise<UpdateResult> {
    return this.pedidoService.updatePedido(id, data);
  }

  @Delete(':id')
  async deletePedido(@Param('id') id: string): Promise<DeleteResult> {
    return this.pedidoService.deletePedido(id);
  }

}

