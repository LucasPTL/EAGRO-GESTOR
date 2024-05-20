import { Pedido } from "src/models/pedido.entity";

export interface PedidoRepositoryInterface {
 findAll(): Promise<Pedido[]>;
 findById(id: string): Promise<Pedido | null>;
 create(data: Partial<Pedido>): Promise<Pedido>;
 update(id: string, data: Partial<Pedido>): Promise<Pedido>;
 delete(id: string): Promise<void>;
}
