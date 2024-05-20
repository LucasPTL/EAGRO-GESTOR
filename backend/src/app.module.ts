import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PessoaController } from './controllers/pessoa.controller';
import { PessoaService } from './services/pessoa.service';
import { Pessoa } from './models/pessoa.entity';
import { PessoaRepository } from './repositories/pessoa.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Usuario } from './models/usuario.entity';
import { UsuarioService } from './services/usuario.service';
import { UsuarioRepository } from './repositories/usuario.repository';
import { UsuarioController } from './controllers/usuario.controller';
import { Produto } from './models/produto.entity';
import { ProdutoController } from './controllers/produto.controller';
import { ProdutoService } from './services/produtos.service';
import { ProdutoRepository } from './repositories/produto.repository';
import { Logistica } from './models/logistica.entity';
import { LogisticaController } from './controllers/logistica.controller';
import { LogisticaService } from './services/logistica.service';
import { LogisticaRepository } from './repositories/logistica.repository';

  @Module({
    imports: [
      TypeOrmModule.forRoot({
        type: 'postgres',
        host: 'localhost',
        port: 5432,
        username: 'postgres',
        password: 'postgres',
        database: 'backend',
        entities: [Pessoa,Usuario,Produto,Logistica], 
        synchronize: false,
      }),
      TypeOrmModule.forFeature([Pessoa, Usuario, Produto, Logistica]), 
    ],
    controllers: [AppController, PessoaController, UsuarioController, ProdutoController, LogisticaController],
    providers: [AppService, PessoaService, PessoaRepository, UsuarioService, UsuarioRepository, ProdutoService, ProdutoRepository, LogisticaService, LogisticaRepository],
  })
  export class AppModule {}
