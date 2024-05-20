import { Repository, UpdateResult, DeleteResult } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Pedido } from 'src/models/pedido.entity';


export class PedidoRepository extends Repository<Pedido> {
    constructor(
        @InjectRepository(Pedido)   
        private pedidoRepository: Repository<Pedido>,
      ) {
        super(
          pedidoRepository.target,
          pedidoRepository.manager,
          pedidoRepository.queryRunner,
        );
      }
 public async findAll(): Promise<Pedido[]> {
    return await this.find();
 }
 
 public async findById(id: string): Promise<Pedido | null> {
   return await this.findOne({ where: { id: id }});
}

public async createPedido(data: Partial<Pedido>): Promise<Pedido> {
    const Pedido = this.create(data);
    return this.save(Pedido);
 }

 public  async updatePedido(id: string, data: Partial<Pedido>): Promise<UpdateResult> {
    return this.update(id, data);
 }

 public async deletePedido(id: string): Promise<DeleteResult> {
    return this.delete(id);
 }

}
