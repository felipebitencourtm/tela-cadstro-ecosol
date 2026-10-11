import { InputType, Field } from '@nestjs/graphql';
import { IsEmail, IsNotEmpty, MinLength, MaxLength, IsString } from 'class-validator';

@InputType()
export class CreateUserInput {
  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  username: string;

  @Field()
  @IsEmail()
  @MaxLength(250)
  email: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(250)
  address: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  passwordHash: string; 
}
