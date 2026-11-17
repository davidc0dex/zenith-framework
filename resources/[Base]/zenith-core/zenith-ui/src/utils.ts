export async function post(url: string, data: unknown = {}) {
    const response = await fetch(`https://zenith-core/${url}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    });
    return await response.json();
}