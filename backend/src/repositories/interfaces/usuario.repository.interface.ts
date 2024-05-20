import { Usuario } from "src/models/usuario.entity";

export interface PessoaRepositoryInterface {
 findAll(): Promise<Usuario[]>;
 findById(id: string): Promise<Usuario | null>;
 create(data: Partial<Usuario>): Promise<Usuario>;
 update(id: string, data: Partial<Usuario>): Promise<Usuario>;
 delete(id: string): Promise<void>;
 verificarUsuario(login:String, senha:String): Promise<boolean>;

}
