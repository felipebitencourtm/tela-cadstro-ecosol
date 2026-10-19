import { useState, useRef, type ChangeEvent, type FormEvent } from "react";
import { registerUser, ApiError } from "../api";

const FIELD_ORDER = ["username", "email", "password", "address"] as const;
type FieldName = (typeof FIELD_ORDER)[number];

interface FormDataState {
username: string;
email: string;
password: string;
address: string;
}

interface FormErrorsState {
username?: string;
email?: string;
password?: string;
address?: string;
}

export default function Register() {

    const [isSubmitting, setIsSubmitting] = useState(false);
    const [submitError, setSubmitError] = useState<string | null>(null);


    const fieldRefs = useRef<
        Record<FieldName, HTMLInputElement | HTMLTextAreaElement | null>
    >({
        username: null,
        email: null,
        password: null,
        address: null,
    });

    const [formData, setFormData] = useState<FormDataState>({
        username: "",
        email: "",
        password: "",
        address: "",
    });

    const [errors, setErrors] = useState<FormErrorsState>({});

    const handleChangeOnForm = (
        e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
        setErrors((prev) => ({ ...prev, [name]: undefined }));
    };

    const validateForm = (): boolean => {
        const tempErrors: FormErrorsState = {};

        if (!formData.username.trim()) {
        tempErrors.username = "O nome de usuário é obrigatório.";
        } else if (formData.username.length > 100) {
        tempErrors.username = "O nome de usuário deve ter no máximo 100 caracteres.";
        }

        if (!formData.email.trim()) {
        tempErrors.email = "O e-mail é obrigatório.";
        } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
        tempErrors.email = "Formato de e-mail inválido.";
        } else if (formData.email.length > 250) {
        tempErrors.email = "O e-mail deve ter no máximo 250 caracteres.";
        }

        if (!formData.password) {
        tempErrors.password = "A senha é obrigatória.";
        } else if (formData.password.length > 50) {
        tempErrors.password = "A senha deve ter no máximo 50 caracteres.";
        }

        if (!formData.address.trim()) {
        tempErrors.address = "O endereço é obrigatório.";
        } else if (formData.address.length > 250) {
        tempErrors.address = "O endereço deve ter no máximo 250 caracteres.";
        }


        setErrors(tempErrors);

        const firstInvalid = FIELD_ORDER.find((field) => tempErrors[field]);
        if (firstInvalid) {
            fieldRefs.current[firstInvalid]?.focus();
        }

        return !firstInvalid;
    };

    const handleSubmit = async (e: any) => {
        e.preventDefault();
        if (!validateForm()) return;

        setIsSubmitting(true);
        setSubmitError(null);

        try {
            const user = await registerUser(formData);
            console.log("Usuário criado:", user);
            alert("Cadastro realizado com sucesso."); // temporary; replace with a redirect later
        } catch (err) {
            console.error("Erro no cadastro:", err);
            if (err instanceof ApiError && /already|exist|duplic|em uso/i.test(err.message)) {
            setErrors({ email: "Este e-mail já está em uso." });
            fieldRefs.current.email?.focus();
            } else {
            setSubmitError(err instanceof ApiError ? err.message : "Falha de conexão com o servidor.");
            }
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <div className="flex w-full flex-col justify-center p-7">
            <div className="mx-auto w-full max-w-md text-left">
                <div className="flex flex-col md:text-center md:items-center md:justify-center w-full">
                    <h1 className="font-black text-5xl">CRIAR <br className="md:hidden"/>CONTA</h1>
                    <div className="w-18 h-2 bg-black mb-10 mt-2"></div>
                </div>
                <form noValidate action="" id="register-form" onSubmit={handleSubmit} className="flex flex-col gap-2">
                    <div className="form-element">
                        <label htmlFor="username">NOME DE USUÁRIO</label>
                        <input
                            id="username"
                            type="text"
                            placeholder="Ex: usuario123"
                            name="username"
                            value={formData.username}
                            onChange={handleChangeOnForm}
                            ref={(el) => { fieldRefs.current.username = el; }}
                            aria-invalid={!!errors.username}
                            aria-describedby="username-error"
                        />
                        <p id="username-error" role="alert" className="h-4 text-xs text-red-600">
                            {errors.username}
                        </p>
                    </div>
                    <div className="form-element">
                        <label htmlFor="email">E-MAIL</label>
                        <input  id="email" type="email" placeholder="nome@exemplo.com.br" 
                        name="email"
                        value={formData.email}
                        onChange={handleChangeOnForm}
                            ref={(el) => { fieldRefs.current.email = el; }}
                            aria-invalid={!!errors.email}
                            aria-describedby="email-error"
                        />
                        <p id="email-error" role="alert" className="h-4 text-xs text-red-600">
                            {errors.email}
                        </p>
                    </div>
                    <div className="form-element">
                        <label htmlFor="password">SENHA</label>
                        <input id="password" type="password" placeholder="*********" 
                        value={formData.password}
                        name="password"
                        onChange={handleChangeOnForm}
                            ref={(el) => { fieldRefs.current.password = el; }}
                            aria-invalid={!!errors.password}
                            aria-describedby="password-error"
                        />
                        <p id="password-error" role="alert" className="h-4 text-xs text-red-600">
                            {errors.password}
                        </p>
                    </div>
                    <div className="form-element">
                        <label htmlFor="address">ENDEREÇO</label>
                        <textarea
                        id="address"
                        name="address"
                        className="h-32 md:h-30 resize-none"
                        placeholder="Rua, Número, Complemento, Bairro"
                        value={formData.address}
                        onChange={handleChangeOnForm}
                            ref={(el) => { fieldRefs.current.address = el; }}
                            aria-invalid={!!errors.address}
                            aria-describedby="address-error"
                        />
                        <p id="address-error" role="alert" className="h-4 text-xs text-red-600">
                            {errors.address}
                        </p>
                    </div>
                </form>
            </div>

            <div className="mx-auto w-full max-w-md mt-5 flex flex-col">
                {submitError && (
        <p role="alert" className="text-xs text-red-600 mb-2">{submitError}</p>
    )}
                <button className="bg-black text-white w-full p-4 font-bold cursor-pointer disabled:opacity-50"
        form="register-form"
        type="submit"
        disabled={isSubmitting}
        >
        {isSubmitting ? "ENVIANDO..." : "FINALIZAR CADASTRO"}
                        </button>
                <div className="flex flex-row justify-between text-xs mt-3">
                    <p>PASSO 01/01</p>
                    <p className="font-bold">STATUS: PENDENTE</p>
                </div>
            </div>
        </div>
    )
}

