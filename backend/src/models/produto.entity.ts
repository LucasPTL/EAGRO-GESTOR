import { Decimal } from '@prisma/client/runtime/library';
import { Column, Double, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Produto {
  @PrimaryGeneratedColumn()
  id: string;
  @Column()
  nome: string;
  @Column()
  descricao: string;
  @Column()
  preco: number;
  @Column()
  categoria: string;
}
