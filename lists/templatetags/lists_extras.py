from django import template

from datetime import datetime


register = template.Library()


# Thanks to Dan Jacob and Sean Vieira for making the following snippet
# available at http://flask.pocoo.org/snippets/33/
# minor changes by me: register filter, removing tzinfo and python 3 fix
@register.filter('humanize')
def humanize_time(dt, past_='antes', future_='depois', default='agora'):
    """
    Returns string representing 'time since'
    or 'time until' e.g.
    3 days ago, 5 hours from now etc.
    """

    now = datetime.utcnow()
    # remove tzinfo
    dt = dt.replace(tzinfo=None)
    if now > dt:
        diff = now - dt
        dt_is_past = True
    else:
        diff = dt - now
        dt_is_past = False

    periods = (
        (diff.days // 365, 'ano', 'anos'),
        (diff.days // 30, 'mês', 'meses'),
        (diff.days // 7, 'semana', 'semanas'),
        (diff.days, 'dia', 'dias'),
        (diff.seconds // 3600, 'hora', 'horas'),
        (diff.seconds // 60, 'minuto', 'minutos'),
        (diff.seconds, 'segundo', 'segundos'),
    )

    for period, singular, plural in periods:

        if period:
            return '%d %s %s' % (
                period,
                singular if period == 1 else plural,
                past_ if dt_is_past else future_
            )

    return default


@register.filter('in_seconds')
def in_seconds(dt):
    return int(
        (dt.replace(tzinfo=None) - datetime(1970, 1, 1)).total_seconds()
    )
