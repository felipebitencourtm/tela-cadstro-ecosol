import { Injectable, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { CreateUserInput } from './dto/create-user.input';
import { User } from './entities/user.entity';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(createUserInput: CreateUserInput): Promise<User> {

    const extinguisUser = await this.usersRepository.findOne({
      where: {email: createUserInput.email}
    });

    if (extinguisUser) {
      throw new ConflictException("Este e-mail já foi cadastrado.");
    }

    const salt = 10;
    const hashed = await bcrypt.hash(createUserInput.passwordHash, salt);
    const newUser = this.usersRepository.create({
        ...createUserInput,
        passwordHash: hashed,
    });



    return this.usersRepository.save(newUser);
  }

  findAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

}
