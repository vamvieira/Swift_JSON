//
//  ViewController.swift
//  Exemplo Json - Nutella
//
//  Created by Usuário Convidado on 19/09/23.
//

import UIKit
var comic:Comic!=nil

class ViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var minhaImagem: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loadComic(){
        let jsonUrlString = "https://xkcd.com/info.0.json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in guard let data = data else {return}
            
            do {
                comic = try JSONDecoder().decode(Comic.self, from: data)
                //print(comic.title)
                let imagem = self.carregarImagem(urlImagem: comic.img)
                DispatchQueue.main.sync {
                    self.titulo.text = comic.title
                    self.id.text = String(comic.num)
                    self.data.text = comic.day + "/" + comic.month + "/" + comic.year
                    self.minhaImagem.image = imagem
                }
            }catch let jsonError{
                print("Error serialization Json", jsonError)
            }
        }
        .resume()
        
    }
    
    @IBAction func exibir(_ sender: Any) {
        loadComic()
    }
    
    func carregarImagem(urlImagem: String)->UIImage?{
        //Obtendo uma URL válida
        guard let url = URL(string: urlImagem)
        else{
            print("Não foi possível criar a URL")
            return nil
        }
        var image:UIImage? = nil
        do {
            //Obtendo os dados válidos
            let data = try Data(contentsOf: url, options: [])
            
            //Criando a imagem
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
}
