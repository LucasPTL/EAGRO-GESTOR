import { Pessoa } from 'src/models/pessoa.entity';

export interface PessoaRepositoryInterface {
 findAll(): Promise<Pessoa[]>;
 findById(id: string): Promise<Pessoa | null>;
 create(data: Partial<Pessoa>): Promise<Pessoa>;
 update(id: string, data: Partial<Pessoa>): Promise<Pessoa>;
 delete(id: string): Promise<void>;
}
