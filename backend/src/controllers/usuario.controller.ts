// Usuario.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param, HttpCode, HttpStatus, HttpException } from '@nestjs/common';
import { Usuario } from 'src/models/usuario.entity';
import { UsuarioService } from 'src/services/usuario.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('usuario')
export class UsuarioController {
  constructor(private readonly UsuarioService: UsuarioService) {}

  @Get()
  findAll(): Promise<Usuario[]> {
    return this.UsuarioService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string): Promise<Usuario | null> {
    return this.UsuarioService.findById(id);
  }

  @Post()
  create(@Body() data: Usuario): Promise<Usuario> {
    return this.UsuarioService.create(data);
  }

  @Put(':id')
  async updateUsuario(@Param('id') id: string, @Body() data: Partial<Usuario>): Promise<UpdateResult> {
    return this.UsuarioService.updateUsuario(id, data);
  }

  @Delete(':id')
  async deleteUsuario(@Param('id') id: string): Promise<DeleteResult> {
    return this.UsuarioService.deleteUsuario(id);
  }

  @Post('/verificarUsuario')
  @HttpCode(200) 
  async verificarUsuario(@Body() loginData: { login: string; senha: string }) {
    const usuario = await this.UsuarioService.verificarUsuario(loginData.login, loginData.senha);
    if (usuario.length > 0) {
      return usuario;
    } else {
      throw new HttpException('Usuário não encontrado', HttpStatus.NOT_FOUND);
    }
  }

}

