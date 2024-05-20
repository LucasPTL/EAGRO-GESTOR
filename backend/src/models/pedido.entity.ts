import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Pedido {
  @PrimaryGeneratedColumn()
  id: string;
  @Column()
  data_operacao: Date;
  @Column()
  status: string;
  @Column()
  id_produto: string;
  @Column()
  id_pessoa: string;
  @Column()
  id_movimento: string;
  @Column()
  id_logistica: string;
}
