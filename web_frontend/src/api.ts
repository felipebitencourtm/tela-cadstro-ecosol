const GRAPHQL_URL = import.meta.env.VITE_API_URL ?? "http://localhost:3000/graphql";

const CREATE_USER = `
  mutation CreateUser($createUserInput: CreateUserInput!) {
    createUser(createUserInput: $createUserInput) {
      id
      username
      email
      address
    }
  }
`;

export class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
  }
}

export async function registerUser(data: {
  username: string;
  email: string;
  password: string;
  address: string;
}) {
  const { password, ...rest } = data;

  const res = await fetch(GRAPHQL_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      query: CREATE_USER,
      variables: {
        createUserInput: { ...rest, passwordHash: password },
      },
    }),
  });

  const text = await res.text();
  let body: any = null;
  try {
    body = JSON.parse(text);
  } catch {
  }

  console.log("GraphQL status:", res.status);
  console.log("GraphQL response:", text);

  if (!res.ok || body?.errors?.length) {
    const msg =
      body?.errors?.[0]?.message ??
      (Array.isArray(body?.message) ? body.message.join(", ") : body?.message) ??
      (text || "Erro ao criar conta.");
    throw new ApiError(res.status, msg);
  }

  return body.data.createUser;
}