from time import sleep

from django.http import JsonResponse


def longterm(request):
    sleep(40)
    return JsonResponse({})


def healthz(request):
    return JsonResponse({})