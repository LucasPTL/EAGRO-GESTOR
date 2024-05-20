import { Produto } from "src/models/produto.entity";

export interface ProdutoRepositoryInterface {
 findAll(): Promise<Produto[]>;
 findById(id: string): Promise<Produto | null>;
 create(data: Partial<Produto>): Promise<Produto>;
 update(id: string, data: Partial<Produto>): Promise<Produto>;
 delete(id: string): Promise<void>;
}
