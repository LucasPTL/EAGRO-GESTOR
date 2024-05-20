import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Logistica {
  @PrimaryGeneratedColumn()
  id: string;
  @Column()
  id_movimento: string;
  @Column()
  data_operacao: Date;
  @Column()
  tipo: string;
  @Column()
  descricao: string;
}
