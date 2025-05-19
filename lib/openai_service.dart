import 'dart:convert';

import 'package:guru/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future <String>  isArtPromptAPI(String prompt) async {
    try{
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers :{
          'Content-Type': 'application/json',
          'Authorization':'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": 'Dose this massage want to generate an AI picture , image, art or anything similar? $prompt . Simply answer in Yes or No.',
            }
          ],
        })
      );
      print(res.body);
      if(res.statusCode == 200){
        String content = 
          jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch(content){
          case 'Yes':
          case 'yes':
          case 'YES.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAI(prompt);
            return res;
        }
      }
      return 'An intenal error occurred'; 
  }
    catch(e){
      return e.toString();
    }
  }
  Future <String> chatGPTAI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try{
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers :{
          'Content-Type': 'application/json',
          'Authaorization':'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          'prompt': prompt,
        })
      );

      if(res.statusCode == 200){
        String content = 
          jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An intenal error occurred'; 
  }
    catch(e){
      return e.toString();
    }
  }
  Future <String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try{
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers :{
          'Content-Type': 'application/json',
          'Authaorization':'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        })
      );

      if(res.statusCode == 200){
        String imageUrl = 
          jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An intenal error occurred'; 
  }
    catch(e){
      return e.toString();
    }
  }

  // static isArtPromptAPI(String lastWords) {}

}