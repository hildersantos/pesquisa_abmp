import "phoenix_html";
import { Socket } from "phoenix";
import "semantic";
import Vue from "vue";
const axios = require("axios");

// Criação de Questionário
if(document.getElementById("root")) {
    new Vue({
        el: "#root",
        data: {
            questionario: {
                nome: '',
                perguntas: [
                    {
                        tipo: '',
                        pergunta: '',
                        observacao: '',
                        respostas: [
                            {
                                resposta: ''
                            }
                        ]
                    }
                ]
            }
        },
        methods: {
            addpergunta: function(e) {
                this.questionario.perguntas.push({
                    tipo: '',
                    pergunta: '',
                    observacao: '',
                    respostas: [
                        {
                            resposta: ''
                        }
                    ]
                });
            },
            addresposta: function(i, e) {
                this.questionario.perguntas[i].respostas.push({
                    resposta: ''
                });
            },
            removeresposta: function(pi, i, e) {
                this.questionario.perguntas[pi].respostas.splice(i, 1);
            },
            submitform(e) {
                let data = {
                    questionario: this.questionario
                };
                if(this.questionario.id === undefined) {
                    axios.post('/api/questionarios', data)
                        .then( (response) => {
                            this.$set('questionario.id', response.data.data.id);
                        })
                        .catch( (response) => console.error(response));
                } else {
                    axios.patch('/api/questionarios/' + this.questionario.id, data)
                        .then( (response) => {
                        })
                        .catch( (response) => console.error(response));
                }
            }
        },
        ready: function() {
        }
    });
}


// Pesquisa em si
if(document.getElementById("pesquisa")) {

    Vue.component('barra-progresso', {
        template: '<div class="ui progress small gray"><div class="bar"></div><div class="label">Progresso Total</div></div>'
    });


    new Vue({
        el: "#pesquisa",
        data: {
            questionario: [

            ],
            empresas_respostas: [

            ]
        },
        ready() {
            axios.get('/api/empresas/'+empresa_id+'/questionario')
                .then( (response) => {
                    this.$set('questionario', response.data.data);
                })
                .catch( (response) => console.error('Erro ao pegar os dados'));
        }
    })

}
