// Usuario.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Usuario } from 'src/models/usuario.entity';
import { UsuarioRepository } from 'src/repositories/usuario.repository';
import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class UsuarioService {
  constructor(
    @InjectRepository(UsuarioRepository)
    private usuarioRepository: UsuarioRepository,
  ) {

  }

  async findAll(): Promise<Usuario[]> {
    return this.usuarioRepository.findAll();
  }

  async findById(id: string): Promise<Usuario | null> {
    return await this.usuarioRepository.findById(id);
  }
  

  async create(data: Partial<Usuario>): Promise<Usuario> {
    console.log(data)
    return this.usuarioRepository.createUsuario(data);
  }

  async updateUsuario(id: string, data: Partial<Usuario>): Promise<UpdateResult> {
    return this.usuarioRepository.updateUsuario(id, data);
  }

  async deleteUsuario(id: string): Promise<DeleteResult> {
    return this.usuarioRepository.deleteUsuario(id);
  }

  async verificarUsuario(login: string, senha:string): Promise<any>{
    return this.usuarioRepository.verificarUsuario(login,senha);
  }

}
