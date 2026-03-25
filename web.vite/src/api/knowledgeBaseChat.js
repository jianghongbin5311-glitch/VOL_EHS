import http from './http'

/**
 * EHS 知识库问答 API
 */

/**
 * 发送问答请求
 * @param {Object} payload - { question: string, sessionId?: string }
 */
export const queryKnowledgeBase = (payload) => {
  return http.post('api/knowledgeBaseChat/query', payload, false)
}

/**
 * 测试知识库连接
 */
export const testKnowledgeBaseConnection = () => {
  return http.get('api/knowledgeBaseChat/testConnection', {}, false)
}
