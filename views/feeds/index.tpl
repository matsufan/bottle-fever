%import time
%from utils.stringkit import shrink
%import logging
%from utils.timekit import time_since
%log = logging.getLogger()

<script type="text/python">
import zest

print(zest.zest('div'))
</script>

<table id="feeds" class="ink-table ink-hover ink-zebra ink-bordered">
    <thead>
        <tr>
%for h in headers:
%    if 'label' in h:
            <th>{{h['label']}}</th>
%    elif 'icon' in h:
            <th><i class="{{h['icon']}}"></i></th>
%    end
%end
        </tr>
    </thead>
    <tbody>
%for f in feeds:
        <tr>
%    for h in headers:
%        field = h['field']
%        value = f.get(field,'(unknown)')
%        if field in ['manage']:
%            if 'uri' in f:
%                value = '<a href="%s"><i class="%s"></i></a>' % (f['uri'] % f['id'], f['icon'])
%            else:
%                value = ''
%            end
%        end
%        if field in ['url','site_url']:
%            value = '<a href="%s">%s</a>' % (value, shrink(value,40))
%        elif field in ['title']:
%            value = '<a href="/feed/%d">%s</a>' % (f['id'],shrink(value,30))
%        end
%        if field in ['last_modified','last_checked']:
%            if value:
%               value = time_since(value) + ' ago'
%            else:
%               value = '(never)'
%            end
%        end
         <td>{{!value}}</td>
%    end
        </tr>
%end
    </tbody>
</table>
%rebase layout title=title, scripts=[]
