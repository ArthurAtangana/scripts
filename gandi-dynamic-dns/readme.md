<h1>Update DNS Record with Gandi LiveDNS API</h1>

bash script intended to update @ DNS records from domain registrar [Gandi.net](https://www.gandi.net)

The script takes in a list of domain names and your gandi API key, 
then updates the record's IP with your machine's current IP


cron job can udpate regularly (30 minutes or up to your needs) to diminish down time.

interfaces with Gandi's [LiveDNS API](https://api.gandi.net/docs/livedns/)




code modified from [@gbarre](https://gist.github.com/gbarre/92d53e2be4ae0497670533ebf96ea0ca)
