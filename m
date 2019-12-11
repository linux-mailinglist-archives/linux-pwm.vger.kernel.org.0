Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93811A71F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2019 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfLKJap (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Dec 2019 04:30:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39308 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfLKJao (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2019 04:30:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id i12so4511297qtp.6
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2019 01:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2BC+9/TiZfps/b95kJW4uBoQA4KaDxSNdYTJBUn4gCs=;
        b=NPdllIBA+bj+UStDT7bl1Rv1PclFC4OqrdpoNdXo7cz0Mj3FkjxI7pucjAVFANaogi
         NffE55LMj+mJ4LTVFm3bo448ejF9005PtfGOKoL+yTsoq5GKf6d0nGG27QNWKnRCeR0N
         p9x0u0eR+7IbL+Q6djt0iTdnKLCIC3O6fdu2+FXFF20Ghki/CCvNgGlK2G6q7JTApE73
         it0Wf6/UpiTErJcyhUgIPY4BHonA5IkzXb9j2/d0yRW8o99nrsbIYRxYpNzgVy0E6A/3
         vTglo5Mm4bq6+Ay6AKQU8yPUea8RGK3cdIxqXAqKlbCktXdNOBxZxzbzJB8yfqSQnjrL
         j5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2BC+9/TiZfps/b95kJW4uBoQA4KaDxSNdYTJBUn4gCs=;
        b=VKs7TtkhJf6sW8vRsDhsskGVJ7OorX7D0LGwZIGr9DgZJyaumzsTG1x6U8eXd3ZhHu
         6wMnfSu03Ma4+nDZM67Jf00j9yGEmfYZBd5NwZ7EftuwsYQSbF+x54aPzOEjxWVjXxwX
         iQhNvVuNaSpuHmdV1/mxWiTIcq+dyHKINREEoPONn2WbVbKuZM6NIgPYaC8C1zB2AAV5
         An4+vkNFOeSlAt0kv+P8RrokzdFvyFX14A/kRXyqCSWyxHfngSx7EjAvvk/8Baiacyun
         lq2S+p5Pz0O7+a6+6NWcdvIdWKKS/A9xGsFwq/w+eNtbKzuaS6lpxdK86o0aEdkX2NW6
         eMhg==
X-Gm-Message-State: APjAAAWiTpCA0pg+YmuOu/b4Cgnx8corLWy5T/EDyG7RDNkMrhDTNf+0
        k4CNl7LChy76QdmIx48AvvZ8eaigtTo+CsbpNIL79w==
X-Google-Smtp-Source: APXvYqxaTP18w6zc4VO5j7KsdsiDxibQ8t/74TgQNa6gYF+g7p5dJRc/VEErwcCQJiSS7ym4scFbWgWHFE2Li4AvAc4=
X-Received: by 2002:ac8:6691:: with SMTP id d17mr1791217qtp.57.1576056643909;
 Wed, 11 Dec 2019 01:30:43 -0800 (PST)
MIME-Version: 1.0
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com> <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
In-Reply-To: <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:30:33 +0100
Message-ID: <CAMpxmJWMSnTB6JF8vOCmQzE3swWhbx8uwNEzU=qf49L26QCDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

=C5=9Br., 4 gru 2019 o 11:09 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of
> > device trees) to determine the count of available interrupts. So
> > use this instead.
> >
> > As platform_irq_count() might return an error code (which
> > of_irq_count doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  Use %pe
>
> Great. Note that with %pe there is a dependency on commit 57f5677e535b
> ("printf: add support for printing symbolic error names") which was
> applied during the current merge window.
>

Why would %pe be better in this case? The function returned an int -
why convert it to a pointer?

Bart

> > V2:
> >  Update commit log, and add err handling
> >  Not tested, just code inspection
> >
> >
> >  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.=
c
> > index 4122683eb1f9..baee8c3f06ad 100644
> > --- a/drivers/gpio/gpio-bcm-kona.c
> > +++ b/drivers/gpio/gpio-bcm-kona.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/io.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/of_device.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/chained_irq.h>
> > @@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_de=
vice *pdev)
> >
> >       kona_gpio->gpio_chip =3D template_chip;
> >       chip =3D &kona_gpio->gpio_chip;
> > -     kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > -     if (kona_gpio->num_bank =3D=3D 0) {
> > +     ret =3D platform_irq_count(pdev);
> > +     if (!ret) {
> >               dev_err(dev, "Couldn't determine # GPIO banks\n");
> >               return -ENOENT;
> > +     } else if (ret < 0) {
> > +             if (ret !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Couldn't determine GPIO banks: (%pe=
)\n",
> > +                             ERR_PTR(ret));
>
> I'd say drop either the colon or the parenthesis.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
