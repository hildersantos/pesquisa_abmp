import 'phoenix_html'
import { Socket } from 'phoenix'
import 'semantic'
import Vue from 'vue'
const axios = require('axios')
import _ from 'lodash'

// Criação de Questionário
if (document.getElementById('root')) {
  const app = new Vue({
    el: '#root',
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
      addpergunta: function (e) {
        this.questionario.perguntas.push({
          tipo: '',
          pergunta: '',
          observacao: '',
          respostas: [
            {
              resposta: ''
            }
          ]
        })
      },
      removepergunta: function (i, e) {
        e.preventDefault()
        this.questionario.perguntas.splice(i)
      },
      addresposta: function (i, e) {
        this.questionario.perguntas[i].respostas.push({
          resposta: ''
        })
      },
      removeresposta: function (pi, i, e) {
        this.questionario.perguntas[pi].respostas.splice(i, 1)
      },
      submitform (e) {
        let data = {
          questionario: this.questionario
        }
        if (this.questionario.id === undefined) {
          axios.post('/api/questionarios', data)
                .then((response) => {
                  this.$set('questionario.id', response.data.data.id)
                })
                .catch((response) => console.error(response))
        } else {
          axios.patch('/api/questionarios/' + this.questionario.id, data)
                .then((response) => {
                })
                .catch((response) => console.error(response))
        }
      }
    },
    ready: function () {
    }
  })
}

// Pesquisa em si
if (document.getElementById('pesquisa')) {
  const pesquisa = new Vue({
    el: '#pesquisa',
    data: {
      questionario: [
      ],
      ui: {
        botaoenvio: 'Finalizar Questionário'
      }
    },
    methods: {
      enviaform (e) {
        let empresas_respostas = []
        _.forEach(this.questionario.perguntas, (o) => {
          if(o.picked) {
            empresas_respostas.push({
              empresa_id: empresa_id,
              resposta_id: o.picked
            })
          } else {
            let respostas = _.filter(o.respostas, (r) => {
              return r.replica !== undefined
            })
            _.forEach(respostas, (r) => {
              empresas_respostas.push({
                empresa_id: empresa_id,
                resposta_id: r.id,
                replica: r.replica
              })
            })
          }
        })
        // Faço a requisição ajax após formar tudo em empresas_respostas
        let data = {
          empresas_respostas: empresas_respostas
        }
        if (this.$get('ui.botaoenvio') !== 'Registrando pesquisa, aguarde...') {
          this.$set('ui.botaoenvio', 'Registrando pesquisa, aguarde...')
          axios.post('/api/empresas_respostas/responses', data)
              .then((response) => {
                console.log(response)
                window.location = window.location.protocol + '//' + window.location.hostname + (window.location.port ? ':'+window.location.port : '') + '/final'
              })
              .catch((response) => {
                this.$set('ui.botaoenvio', 'Ocorreu um erro ao enviar os dados... verifique e tente novamente')
              })

        }
      }
    },
    ready () {
      axios
      .get('/api/empresas/' + empresa_id + '/questionario')
      .then((response) => {
        this.$set('questionario', response.data.data)
      })
      .catch((response) => console.error(response))
    }
  })
}
