select * from prefeitos;

-- inner join, intercessão, Traz só os prefeitos que tem cidade.
select * from cidades c inner join prefeitos p on c.id = p.cidade_id;

-- left join, traz tudo do lado esquerdo, cidades.
select * from cidades c left join prefeitos p on c.id = p.cidade_id;

-- left outer join, traz tudo do lado esquerdo, cidades.
select * from cidades c left outer join prefeitos p on c.id = p.cidade_id;

-- right join, traz tudo do lado direito, prefeitos.
select * from cidades c right join prefeitos p on c.id = p.cidade_id;

-- full join, não suportado: select * from cidades c full join prefeitos p on c.id = p.cidade_id;
-- opção juntar left e right para formarl o full join
select * from cidades c left outer join prefeitos p on c.id = p.cidade_id
union -- não traz duplicados
select * from cidades c right join prefeitos p on c.id = p.cidade_id;

-- union all Traz duplicados das duas consultas
select * from cidades c left outer join prefeitos p on c.id = p.cidade_id
union all
select * from cidades c right join prefeitos p on c.id = p.cidade_id;
