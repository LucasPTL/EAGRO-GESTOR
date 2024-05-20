import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Pessoa {
  @PrimaryGeneratedColumn()
  id: string;
  @Column()
  nome: string;
  @Column()
  contato: string;
  @Column()
  endereco: string;
}
