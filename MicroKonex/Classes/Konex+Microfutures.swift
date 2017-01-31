//
//  Konex+Microfutures.swift
//  Pods
//
//  Created by Fernando on 31/1/17.
//
//

import Microfutures
import Konex
import ObjectMapper

public extension KonexClient {
    
    public func mf_request(request: KonexRequest, plugins localPlugins: [KonexPlugin] = [], responseProcessors localResponseProcessors: [KonexResponseProcessor] = [], responseValidators localResponseValidators: [KonexResponseValidator] = []) -> Future<Any> {
        
        return Future { completion in
            self.request(
                request: request,
                plugins: localPlugins,
                responseProcessors: localResponseProcessors,
                responseValidators: localResponseValidators,
                onSuccess: { response in completion(.success(response)) },
                onError: { error in completion(.failure(error)) }
            )
        }
    }
    
    public func mf_requestObject<T:Mappable>(ofType type: T.Type, request: KonexRequest, plugins localPlugins: [KonexPlugin] = [], responseProcessors localResponseProcessors: [KonexResponseProcessor] = [], responseValidators localResponseValidators: [KonexResponseValidator] = []) -> Future<T> {
        
        return Future { completion in
            self.requestObject(
                ofType: type,
                request: request,
                plugins: localPlugins,
                responseProcessors: localResponseProcessors,
                responseValidators: localResponseValidators,
                onSuccess: { response in completion(.success(response)) },
                onError: { error in completion(.failure(error)) }
            )
        }
    }
    
    public func mf_requestArray<T: Mappable>(of type: T.Type, request: KonexRequest, plugins localPlugins: [KonexPlugin] = [], responseProcessors localResponseProcessors: [KonexResponseProcessor] = [], responseValidators localResponseValidators: [KonexResponseValidator] = []) -> Future<[T]> {
        
        return Future { completion in
            self.requestArray(
                of: type,
                request: request,
                plugins: localPlugins,
                responseProcessors: localResponseProcessors,
                responseValidators: localResponseValidators,
                onSuccess: { response in completion(.success(response)) },
                onError: { error in completion(.failure(error)) }
            )
        }
    }
    
}
