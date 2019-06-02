Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720BC3238B
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2019 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFBOS1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 10:18:27 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35815 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBOS1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Jun 2019 10:18:27 -0400
Received: by mail-ot1-f52.google.com with SMTP id n14so13747072otk.2;
        Sun, 02 Jun 2019 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gV1qEV1VFZsBA5JmnTEr5cYWRUDz3Z118FE3e1CQpg8=;
        b=oaLJsP6TLkPFb/k3Ty33h2Pqx8VhZmFXuSZQ5iAfTlGBwY/vCt3kUMhphVvKnMuYei
         /k7sscrAa4B/D5N9vZ+sDZzyyKz5vdDyIhEy5v+bYv1AxqBOfMCwyTJbMxARrwUwgx8q
         tig57qr2w16BEitYpJhRGUdcDhRHDacntUO5Okypn2Z3BH+EYaJ9G3+b51FU+y2ZVLdd
         3QDcLsDHUo7el8Gnj9FTozn1PaIVpnaWuiP6HYdw92yxipfGuGou3i+xxjpzzl8Uv3HL
         Y+heDwCBVkSjhkNIybg1YAIaPcIGjW+LIflwFEuUKXGdxCO+CLP2biL+M46EKTZa62cG
         DomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gV1qEV1VFZsBA5JmnTEr5cYWRUDz3Z118FE3e1CQpg8=;
        b=LyXUiOQkyAbeq/xhtk40dw5MGqdkqY3ULwPgoMNriRumj3zhoGb+wl5DorU6D1YrHJ
         Llz9iPb7fNsD+/KMsk1/Lh2ayMx9yIvABIUrjuVt1pUWy/RCgiiz/ITNmQOgwoDPYASc
         LoqyQjuptixKewtORvSVUdZJuHasQFvQ2n3tkf1dCL4c0g4U1HyYYLVe0ade6UN/mTtv
         1oiuoxprI5A9zDQD/5KpNtuGVfBrB/UfZqteoYxlQzMDYXiCgBPDzBTaWSNrpSzGX9En
         FQysbDH86mUfZyhlJNdUHLdrOM4rzrRJ5pRdY/yrofHntSITGjfstDQMHVen1p3q7BcZ
         dzYA==
X-Gm-Message-State: APjAAAUr9ffFrVfwfR1itGSl5OX5yvGL8+cyHFiN2qYxj5ZSHYrxFY3l
        fKdNI8mQ3xTT+A/4/uQH3TdaT3Rq+yWoPr3ZsJ0=
X-Google-Smtp-Source: APXvYqwPMjTqfQdEKdinAiKPsdYwws1mQlFxM3FFrdBpNtIqhlTD6uB+f+/GOAJU84eFEQ723B4mMlaUosKmB8OlRnQ=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr9153798oto.224.1559485106608;
 Sun, 02 Jun 2019 07:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190601035709.85379-1-yuehaibing@huawei.com> <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
In-Reply-To: <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 2 Jun 2019 10:18:15 -0400
Message-ID: <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jun 1, 2019 at 12:05 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> I didn't look into the driver to try to understand that, but the
> definitely needs a comment to explain for the next person to think they
> can do a cleanup here.

Certainly.

But if we do restore the old behaviour, there may still be problems.
I'm unsure if the old synchronization was working correctly.
See the example at the end of this email.

An intuitive way forward would be to use a simple bitfield in
struct pca9685 to track if a specific pwm is in use by either
pwm or gpio. Protected by a mutex.

But it could be that the old behaviour is 'good enough' for
the driver's users (I am no longer one of them).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Let's take the example of two threads, racing to grab a pwm and gpio,
respectively. Assume the gpio is backed by the pwm, so they conflict.

[Thread 1]
drivers/pwm/core.c:

    if (pwm->chip->ops->request) {
        err =3D pwm->chip->ops->request(pwm->chip, pwm);
            [this calls pca9685_pwm_request()]
            [which calls pca9685_pwm_is_gpio()]
            [checks pwm chip_data, is NULL, pwm is free]
            [returns 0 - pwm request ok]
        if (err) {
            module_put(pwm->chip->ops->owner);
            return err;
        }
    }

        [CONTEXT SWITCH to Thread 2]
        static int pca9685_pwm_gpio_request(struct gpio_chip *gpio,
unsigned int offset)
        {
            struct pca9685 *pca =3D gpiochip_get_data(gpio);
            struct pwm_device *pwm;

            mutex_lock(&pca->lock);

            pwm =3D &pca->chip.pwms[offset];

            [pwm->flags do not (yet) have PWMF_REQUESTED]
            if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
                mutex_unlock(&pca->lock);
                return -EBUSY;
            }

            pwm_set_chip_data(pwm, (void *)1);

            mutex_unlock(&pca->lock);
            pm_runtime_get_sync(pca->chip.dev);
            return 0;
        }

[CONTEXT SWITCH back to Thread 1, still in pwm/core.c]

    set_bit(PWMF_REQUESTED, &pwm->flags);
    pwm->label =3D label;
