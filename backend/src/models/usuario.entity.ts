import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Usuario {
  @PrimaryGeneratedColumn()
  id: string;
  @Column()
  login: string;
  @Column()
  senha: string;
}
