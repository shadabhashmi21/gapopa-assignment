/// This key is required to make authenticated requests to the API.
const String apiKey = '46324991-08d5162223e626aa856989ca3';

/// The numbers of queries we will get in each API call.
const int perPageQuery = 100;

/// The aspect ratio used for displaying items in a grid layout.
const double gridAspectRatio = 1 / 0.93;

/// A constant defining the timeout duration for API requests.
const Duration apiTimeout = Duration(seconds: 30);

/// A constant defining the base URL for the API.
const String baseUrl = 'https://pixabay.com/';