import Foundation

internal class ServicesManager {
    private static let share = ServicesManager()
    
    func fetchRequest<OutputObject: Decodable>(strUrl: String, completion: @escaping(Result<OutputObject, RequestError>) -> Void) {
         guard let url = URL(string: strUrl) else { return completion(.failure(RequestError( statusCode: 0,description: "Error URL", data: nil)))
         }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard let data = data else {
                return completion(.failure(RequestError( statusCode: 0,description: "Error desconocido \(String(describing: error))", data: nil)))
                
            }
            
            guard let httpResp = response as? HTTPURLResponse else {
                return completion(.failure(self.getError(response: response, data: data)))
            }
            
            if httpResp.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let respData = try decoder.decode(OutputObject.self, from: data)
                    completion(.success(respData))
                } catch {
                    print("Error en la serialización \(error)")
                    completion(.failure(RequestError( statusCode: 0,description: "Error en la serialización \(error)", data: data)))
                }
            } else {
                print("Error http \(String(describing: error?.localizedDescription)), statusCode: \(httpResp.statusCode)")
                completion(.failure(RequestError( statusCode: 0,description: "Error http \(String(describing: error?.localizedDescription)), statusCode: \(httpResp.statusCode)", data: data)))
            }
            
        }.resume()
    }
    
    func createRequest(urlString: String, HTTPMethod: HTTPMethod, bodyStr: String? =  nil, bodyObjAny: Any?, bodyObj: AnyObject? = nil) -> URLRequest?{
        
        let timeOutInterval: Double = 60
        
        guard let urlConexion = URL(string: urlString) else { return nil }
        
        var urlRequest = URLRequest(url: urlConexion)
 
        urlRequest.httpMethod = HTTPMethod.rawValue
        urlRequest.timeoutInterval = timeOutInterval
        if let dataBody = bodyStr {
            urlRequest.httpBody =  dataBody.data(using: String.Encoding.utf8)
        }
        
        if let databody = bodyObjAny {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: databody)
        }
        
        if let databody = bodyObj {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: databody)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
        
    }
    
    func fetchRequest<T: Codable>(with request: URLRequest, completion: @escaping(Result<T, RequestError>) -> Void) {

        URLSession.shared.dataTask(with: request) { data, response , error in
            guard let data = data else {
                return completion(.failure(RequestError( statusCode: 0,description: "Error desconocido", data: nil)))
                
            }
            
            guard let httpResp = response as? HTTPURLResponse else {
                return completion(.failure(self.getError(response: response, data: data)))
            }
            
            if httpResp.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let respData = try decoder.decode(T.self, from: data)
                    print("responseData: \(respData)")
                    completion(.success(respData))
                } catch {
                    print("Error en la serialización \(error)")
                    completion(.failure(RequestError( statusCode: 0,description: "Error en la serialización", data: data)))
                }
            } else {
                print("Error status code: \(httpResp.statusCode)")
                completion(.failure(RequestError( statusCode: 0,description: "Error status code: \(httpResp.statusCode)", data: data)))
            }
            
        }.resume()
    }
    
    fileprivate func getError(response: URLResponse?, data: Data) -> RequestError {
        guard let httpResponse = response as? HTTPURLResponse else {
            return RequestError(statusCode: 00, description: "Error getting description of server error.")
        }
        
        switch httpResponse.statusCode {
        case 401:
            return RequestError(statusCode: 401, description: "Invalid API key", data: data)
        case 404:
            return RequestError(statusCode: 404, description: "Request could", data: data)
        
        default:
            return RequestError(statusCode: 00, description: "Tuvimos un problema, vuelve a intentarlo más tarde", data: data)
        }
    }
}
