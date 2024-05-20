import { Repository, UpdateResult, DeleteResult, QueryResult } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Usuario } from 'src/models/usuario.entity';
import { PrismaClient } from '@prisma/client';

export class UsuarioRepository extends Repository<Usuario> {
    constructor(
        @InjectRepository(Usuario)   
        private usuarioRepository: Repository<Usuario>,
      ) {
        super(
          usuarioRepository.target,
          usuarioRepository.manager,
          usuarioRepository.queryRunner,
        );
      }
 public async findAll(): Promise<Usuario[]> {
    return await this.find();
 }
 
 public async findById(id: string): Promise<Usuario | null> {
   return await this.findOne({ where: { id: id }});
}

public async createUsuario(data: Partial<Usuario>): Promise<Usuario> {
    const Usuario = this.create(data);
    return this.save(Usuario);
 }

 public  async updateUsuario(id: string, data: Partial<Usuario>): Promise<UpdateResult> {
    return this.update(id, data);
 }

 public async deleteUsuario(id: string): Promise<DeleteResult> {
    return this.delete(id);
 }

 public async verificarUsuario(login: string, senha: string): Promise<any> {
   try {
     const query = `SELECT * FROM usuario WHERE login = $1 AND senha = $2`;
     const resultado = await this.query(query, [login, senha]);  
     return resultado;
   } catch (error) {
     console.error('Erro ao verificar usuário:', error);
     return null;
   }
 }
 
 
 
}
