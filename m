Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96853AFE28
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jun 2021 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVHqC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Jun 2021 03:46:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFVHqB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Jun 2021 03:46:01 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M738r-1lulKA1g6B-008dTl for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021
 09:43:45 +0200
Received: by mail-wm1-f49.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so1050578wms.5
        for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021 00:43:45 -0700 (PDT)
X-Gm-Message-State: AOAM533byat7SXAC/Y+6zZggs/EsWG18g4grcLse0Xq2ZDJc5S9BMF6H
        SUuT+xONJPgR14vGkZE0as6P6RHOg/30tjiKigw=
X-Google-Smtp-Source: ABdhPJxe7FndZe4T1TjbMbkiKWnVqKhZWSL+17F7P/vjfO1rDtpMiK/YliI1otO7EtO7mLe4GKhqzMAvwlg7ptwnyCA=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr2915370wml.75.1624347825075;
 Tue, 22 Jun 2021 00:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jun 2021 09:41:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Ht9aRgG-AGqA4wNvVJG7tBXAoi1BDPtAHX6_JrDLKMQ@mail.gmail.com>
Message-ID: <CAK8P3a2Ht9aRgG-AGqA4wNvVJG7tBXAoi1BDPtAHX6_JrDLKMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: vt8500: Drop if with an always false condition
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:qZP/Rppax1f0I+1iB4fKf3PtXodRqMWcIG/pdgpHINjXLnE5z1O
 iMyHGyClPNC4bJlNfWo1Uc9H/zT5RpzK7jP2gEFQQHzdvg/qC0u9zhVFwcf0j/R7rb3tcyn
 EAoZ3X9p8LS0Cp5/64PG/8acCcad81pdIY4XzQIcahF53w7FnNRi2/fyIfaqxHKpVP2TzRR
 ZDVm39PMK+zLTQ1CxUuHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbI2eHYEgk0=:t+gRbqhD+bUqCbbC63j+4l
 UTU9a92tOB6VZUYZ9YDuXdNy1tveC7bizhSwoM9S/xSczp5Nbb/TFxaZU3g+eOeuNjCB0hF+k
 oE7awX/YnkPnwQok7IWMLI+hHguHgIlabxVuqeOB/YM4xW0qaexg5s4rOR5iSx1IEho3K5Nng
 m0yutWN2tx1o1hPRD/R1ISvi0IJzwpx+/0eI6FJ257HZighjfHuRGrx+yrGGuQF10Fojd1qWJ
 KiVsja5LCILDwpOGELLJTjVKVKQgwqUMdnMfkew2MKsFMpaW/z6tSGg/oyFLnb7zqaoPqQS6u
 vOtPyuKIQLs5EEv2uVYWXSWO3tNvQJpi6rsMq7s4zp5n/mllW+xg1aEOR0J6LbSPupqjIat0s
 mN+eO93g6h5gSmfzaedXUeJ1MkCmdeYjf5Y1/6DzUSwjK3D/4sNOJMnkKzYDeoZ/fnp6y/g+Q
 OG8rjbAspCs8YbCpd3IEddRjvwZHFNhSkl9uvS8c4lLx1Fq9H5kDTwUPw6SIEmw+574IF5Y7i
 uRu52eOvTEmumbbe4eBfBC++Xlh65QVu8UWxRI8ZFXqi1hiAi0KIjBmpkXFdNFkgeKcK43es8
 wCwRzvNcd2WEgbEfqYQFJvwxVy3BxJUghc4yUrxXioNUpqqKEfHIQ5qEIMVePRBqnafbMKW3P
 P5wg=
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 21, 2021 at 3:04 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> vt8500_pwm_remove() is only called after vt8500_pwm_probe() returned
> successfully. In this case driver data was set to a non-NULL value
> and so chip can never be NULL.
>
> While touching this code also put declaration and assignment in a single
> line.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Both patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
