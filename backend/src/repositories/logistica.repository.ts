import { Repository, UpdateResult, DeleteResult } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Logistica } from 'src/models/logistica.entity';


export class LogisticaRepository extends Repository<Logistica> {
    constructor(
        @InjectRepository(Logistica)   
        private logisticaRepository: Repository<Logistica>,
      ) {
        super(
          logisticaRepository.target,
          logisticaRepository.manager,
          logisticaRepository.queryRunner,
        );
      }
 public async findAll(): Promise<Logistica[]> {
    return await this.find();
 }
 
 public async findById(id: string): Promise<Logistica | null> {
   return await this.findOne({ where: { id: id }});
}

public async createLogistica(data: Partial<Logistica>): Promise<Logistica> {
    const Logistica = this.create(data);
    return this.save(Logistica);
 }

 public  async updateLogistica(id: string, data: Partial<Logistica>): Promise<UpdateResult> {
    return this.update(id, data);
 }

 public async deleteLogistica(id: string): Promise<DeleteResult> {
    return this.delete(id);
 }

}
