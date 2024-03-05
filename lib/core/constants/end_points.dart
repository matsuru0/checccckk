class ServerEndPoints {
  static const GetClients = 'http://localhost:5000/api/clients';
  static const DeleteClient = 'http://localhost:5000/api/clients/delete/';
  static const EditClient = 'http://localhost:5000/api/clients/edit/';
  static const AddClient = 'http://localhost:5000/api/clients/add/';

  static const GetAntecedents = 'http://localhost:5000/api/antecedents/';
  static const EditAntecedents = 'http://localhost:5000/api/antecedents/edit';
  static const DeleteAntecedents =
      'http://localhost:5000/api/antecedents/delete/';

  static const AddAntecedent = "http://localhost:5000/api/antecedents/add";
  static const GetTreatements = 'http://localhost:5000/api/treatements/';
}
