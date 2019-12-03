Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D046910FB28
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfLCJyq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 04:54:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34769 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLCJyp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Dec 2019 04:54:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so2401100otf.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2019 01:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wVf6LBQRDptqpCKdFOlhcvzs6k4hCdHUr7W60r3qycU=;
        b=oHI6od5exA7qVjlcTCQw0+n2wjli17j/iVzx3noeDCu4V3HzrIlHduDDkCTJP7l/51
         Ry07HR27Y9ZPhvbEkcdcVRn4GRv0Ilg6bjPZeZ1v6sNcv/iL9ESjYjNQcKPNpn1nPPeC
         7hPKzEG9Az4z+JF9fC6AZaKVkNYlye6V5N54248nxcR+C9v3nN01w3UowIXqgqFbFIaB
         B17JRFf7i7Mf+SFxRgCVTc8d3eSwBxOxEydyc6OIKc2mrwz6v13GeZ0Saeyb4UV7mybb
         zgZ8VOs9wtivWXnCOF0udd6eJZeTt5crpeYVX7cysYwwZwpxrnS7lK1TXY3/azMwxDP4
         Xfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wVf6LBQRDptqpCKdFOlhcvzs6k4hCdHUr7W60r3qycU=;
        b=Su1xhzuRqOtBshjpu+zDdUZtuVDFxlhGGdrPM/43Hxi30H82lQ3tHohrt9lXqD85cq
         YHI5C5maaR//NS95f/u4GSnAqSk2OcWawt8tsM9GjhsZSx3HtBihebIHiIzvITAZq9Gf
         gMcz6wkyOgUdoNwFKNZm6Vtf4LSckAWcKu4X6aqM0XAiDYuxQXOsqMcdjaXz6jW/uwWX
         A/+qdmo1sAeEE7V4InOZQMnHLDJprAaAhce1w1nTgI43bhUcSj2EPf2QZEgpaaZFA3I4
         ZeeYndl9HT2yLBu7UhkyyRjLuzMEvFFf5/i6PCE2j9hE1e9L0i8Fxj+ZFHFwIk3K+7nx
         s1mg==
X-Gm-Message-State: APjAAAWFUdWQ5m8ceElHeH0Qw2lEqAz0bahwkDBLodaKMzNxuQNdrD3f
        NRDeM2IMFgx6ci7pO+XUHIiCDQsYOpwoNRuMNKp98g==
X-Google-Smtp-Source: APXvYqz0sCOl2T56rzFFmFxXDNqEA1Su7oYhijes4DWKPsLe4dL2J8rVjvNT5Hduusy2UHqlYckjBc70LYVHXZ91nKA=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr2574205otb.85.1575366884881;
 Tue, 03 Dec 2019 01:54:44 -0800 (PST)
MIME-Version: 1.0
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com> <20191203065751.w23dypag4745qv7i@pengutronix.de>
In-Reply-To: <20191203065751.w23dypag4745qv7i@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 3 Dec 2019 10:54:34 +0100
Message-ID: <CAMpxmJUVN=HqDsHRTD_BhgxZB63yh6S2XHfnzx7LkESvR1NYUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

wt., 3 gru 2019 o 07:57 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use platform_irq_count to replace of_irq_count
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Code inspection, not tested
> >
> >  drivers/gpio/gpio-bcm-kona.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.=
c
> > index 4122683eb1f9..c50721980a7c 100644
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
> > @@ -586,7 +585,7 @@ static int bcm_kona_gpio_probe(struct platform_devi=
ce *pdev)
> >
> >       kona_gpio->gpio_chip =3D template_chip;
> >       chip =3D &kona_gpio->gpio_chip;
> > -     kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > +     kona_gpio->num_bank =3D platform_irq_count(pdev);
>
> of_irq_count returns 0 or a positive int while platform_irq_count might
> return a negative error code. This needs handling. Also I wonder why
> platform_irq_count() is better than of_irq_count() which would be good
> to describe in the commit log.
>

In general I like drivers to use generic APIs whenever possible. There
are a lot of drivers that use some random of_ routines just because
the developer didn't know any better and it turns out we now have
generic device properties and a lot of platform device helpers.
Consolidation is always good.

Waiting for v2.

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
