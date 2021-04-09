Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CDB35A79E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhDIUJ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 16:09:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhDIUJ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 16:09:57 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6Kl7-1lbioB1Cv3-016jT4; Fri, 09 Apr 2021 22:09:42 +0200
Received: by mail-ot1-f48.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so984993oti.9;
        Fri, 09 Apr 2021 13:09:41 -0700 (PDT)
X-Gm-Message-State: AOAM531kWBOsDk6s+Dopu80OC600JMVwTDmNlTh/7UJOWUunpZE2tWtl
        zrQN59U7a7ojDeKY7M217ZhqW7K6UPaSNqQOAKo=
X-Google-Smtp-Source: ABdhPJxgrpDN9niRoNJxEKNx9C3ESXH4MOZLEU3LztsYaa0J5NzZ/rEFwV/cMlf6ndV4sAexBU7tKL0P9BMH4NAvC0U=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr13951880otq.251.1617998980848;
 Fri, 09 Apr 2021 13:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210409090819.24805-1-nsaenz@kernel.org>
In-Reply-To: <20210409090819.24805-1-nsaenz@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Apr 2021 22:09:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3k94hJDJzCJSAC=jVF7S88vzUTK4V_cR31u0ve5jJJig@mail.gmail.com>
Message-ID: <CAK8P3a3k94hJDJzCJSAC=jVF7S88vzUTK4V_cR31u0ve5jJJig@mail.gmail.com>
Subject: Re: [PATCH] pwm: raspberrypi-poe: Fix mailbox message initialization
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        kernel test robot <lkp@intel.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:My4Shks7QHgMxSJ/kdBcZMkykldbq39U6c07xM0O6AJoGJBKET0
 9L4QmZo088neJ2eTofR0ekylltqccVZaWpf20wkMkIY3/YqAuomrqa1tDN4hugl4ErVDcZJ
 80CED+8jIrOGeyJAnjff/UgGstiJwIREZhqrHLMtu3s4ova5ZTL7XI9SvhfMLq7IslKl/ML
 /YU0kn15/+gFe9efNj5Mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iIOvEf3l7U=:ua2uhpjK1MrwXNXG3VnEti
 0JrVjakwrbPXcBAz0kMEH9RsQnLjL254Y5JNUW1mbH1s7hvyjKIX8pS+kCmasgaXaktpg9JxX
 +c+fW6DAlM7RpbPpsssqMfV8Z6xNX0S49U+nMnXuUanyV2OaXfHFfWiNo3A0+72d+YVpWVCVB
 p38FbSt4sDlQ2P7ewVShxPzOtCSEs7B58e1CcIcuVyevF1r7Qry2zEV00uHndOnPdunxTHuu/
 +jT9Ea//xs91+Xpnteex3UyqGuFwWRDa9+TZ+30bkSihpfqy5kdZ4npN0RnEgXL+4ArAF/KBJ
 B7MU3iYau/lBQhLfm5UTSwn7ghyVXYYGGNXn7f6SDibtTiE0u53aKzEjVjS2wDx2PUndMmn9T
 dT7rum48jM2WHKnBMefSjCblM6GDVjJCO0TJAW3yAgsqtySxtJvbaXiqGDcb2O/+qpRlWqZ9a
 lZOj5JodQtVAxiuaRsf+NDtg7BuacAWOjocM//zP5/+tLrH3B+K0O0WSm4hMB0B8Zv4HIF56B
 rsHqBksMfTj22K0H9iDeOr7rvrilwv15T3S8V/cT9yKGb1TMog8mKWNjCo+xABGEuZCCFuuVt
 4kt+GBdqXZDFQPEtMhqAVykB6vJV+e+reu
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 9, 2021 at 11:08 AM Nicolas Saenz Julienne
<nsaenz@kernel.org> wrote:
>
> For testing purposes this driver might be built on big-endian
> architectures. So make sure we take that into account when populating
> structures that are to be passed to RPi4's mailbox.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 79caa362eab6 ("pwm: Add Raspberry Pi Firmware based PWM bus")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---
>
> @arndb: This was just meged into the arm-soc tree some days ago. Should I
> prepare a second PR once it's been reviewed?

Yes, that would be good. If you have no other driver patches that I should
pick up, just forward the patch (with the Ack) to soc@kernel.org and I
can just apply it.

        Arnd
