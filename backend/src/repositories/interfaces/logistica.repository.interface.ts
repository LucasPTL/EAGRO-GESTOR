import { Logistica } from "src/models/logistica.entity";

export interface LogisticaRepositoryInterface {
 findAll(): Promise<Logistica[]>;
 findById(id: string): Promise<Logistica | null>;
 create(data: Partial<Logistica>): Promise<Logistica>;
 update(id: string, data: Partial<Logistica>): Promise<Logistica>;
 delete(id: string): Promise<void>;
}
