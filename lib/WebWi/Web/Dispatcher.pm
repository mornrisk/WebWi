package WebWi::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

post '/weight' => sub {
    my ($c) = @_;
    my $wi_id  = $c->req->param('wi_id');
    my $stable = $c->req->param('stable') // 1;
    my $weight = $c->req->param('weight');
    return $c->create_response(400, [], ["NG\r\n"]) unless $wi_id || $weight;

    $c->cache->set($wi_id, { stable => $stable, weight => $weight, }, 3);
    return $c->create_response(200, [], ["OK\r\n"]);
};

get '/:id' => sub {
    my ($c, $args) = @_;
    #my $wi = $c->cache->get($args->{id}) || return $c->res_404();
    return $c->render('wi.tx', { id => $args->{id} }, );
};

1;
