// Pedido.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Pedido } from 'src/models/pedido.entity';
import { PedidoRepository } from 'src/repositories/pedido.repository';

import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class PedidoService {
  constructor(
    @InjectRepository(PedidoRepository)
    private pedidoRepository: PedidoRepository,
  ) {

  }

  async findAll(): Promise<Pedido[]> {
    return this.pedidoRepository.findAll();
  }

  async findById(id: string): Promise<Pedido | null> {
    return await this.pedidoRepository.findById(id);
  }
  

  async create(data: Partial<Pedido>): Promise<Pedido> {
    console.log(data)
    return this.pedidoRepository.createPedido(data);
  }

  async updatePedido(id: string, data: Partial<Pedido>): Promise<UpdateResult> {
    return this.pedidoRepository.updatePedido(id, data);
  }

  async deletePedido(id: string): Promise<DeleteResult> {
    return this.pedidoRepository.deletePedido(id);
  }

}
