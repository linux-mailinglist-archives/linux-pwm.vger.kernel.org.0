Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F04EFF67
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 15:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfKEOGd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 09:06:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34364 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfKEOGc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 09:06:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id v3so16590958wmh.1;
        Tue, 05 Nov 2019 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1Y/RM2Mz7kHjeXIz94GZRfB4ieyu+FKgqSY/1H3X9U=;
        b=kGrWivnaI6V9lkGpzTZ0OvRK5tGWrMKuxcql5NqByB8JizVWkPrpiZ0A9jJnaYPUhD
         +WaiDkhPUS25qGmGgZ+z7hKwuPcDZ3slW4w8ftU7dKCLrjRTyLiifXYEt7MR1dBxOGOc
         U1ZmE7mKt7LOLFhMEVdAxaw018otafaQbXIQbK114P+SkVno+hRipvoDUfkVGNMIabQf
         aZmXFuFaTchhjnY+FQgFhM2NHvYLGnPLVDWaQMzI5Y06UpYmFKmj4HkQzDyZPWr6lr8F
         tEiVQwX8DNNFxc37XSyfEKoxgkAS5wcV1siJBrsrHEKm9NVm3RGrI5PPjnZLKn/RsWGD
         uWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1Y/RM2Mz7kHjeXIz94GZRfB4ieyu+FKgqSY/1H3X9U=;
        b=YtuPL0QI/aWQn1lSuhjQMpEdrmTgE4XtYUx886E8HqSNa/fVfMpXjAtwyD5Oud4u5w
         cjB2Yfcd8Qm+kmaI03U88aKZoZvt9jfeASJc63WPV0G2ubAfZtdTv804eZGPR9N+9ohw
         hC4F+KTs45WJeLRZHZOYZWS0Qea+FIQTKh7P7OSWuQ40G0bOEpHWbw8SJLaLNjexglTO
         sxFoUl/e8tJsUSLXDDSjvBGio7qFq14ls1ZCw0kRM+gI6bXXeUoG2gGhXXuWSsMI9xrh
         xYYW6FnilUlRIkF3WFTnMrmL5qIptN7jVgMtC6MsUNyLS8n0cNiFpiFeL1y8gwFSwDG3
         yqhw==
X-Gm-Message-State: APjAAAXoMB4aORFeeUrqTqy35GQS2rUrVxsMWc+wP3wIzS8FVz8sFj18
        tj6xoBpW9J2lGnUeV2xlB9hi2vKMkd8vX291Se4=
X-Google-Smtp-Source: APXvYqxddcZh8iQRhjIgQrK0b9aLG19Xi2F8TSSTEuWMQxK7GJf3TbgIpTv/4hQg8PsgXtuLD7Bf0bZBo9A9To3U1ug=
X-Received: by 2002:a1c:2342:: with SMTP id j63mr4214667wmj.56.1572962788801;
 Tue, 05 Nov 2019 06:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-4-peron.clem@gmail.com>
 <20191105135745.mf63pelpbekmitgm@pengutronix.de>
In-Reply-To: <20191105135745.mf63pelpbekmitgm@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 5 Nov 2019 15:06:17 +0100
Message-ID: <CAJiuCceg4CeHf-ZtK0A=SzQGGQD5D7CK2Zcy5dzDshmY=yP9sg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] pwm: sun4i: Add an optional probe for bus clock
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 5 Nov 2019 at 14:57, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Nov 05, 2019 at 02:14:52PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it and a fallback for previous
> > bindings without name on module clock.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 45 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 9ba83769a478..54e19fa56a4e 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> > +     struct clk *bus_clk;
> >       struct clk *clk;
> >       struct reset_control *rst;
> >       void __iomem *base;
> > @@ -363,9 +364,35 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->base))
> >               return PTR_ERR(pwm->base);
> >
> > -     pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > -     if (IS_ERR(pwm->clk))
> > +     /* Get all clocks and reset line */
> > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > +     if (IS_ERR(pwm->clk)) {
> > +             dev_err(&pdev->dev, "get clock failed %ld\n",
> > +                     PTR_ERR(pwm->clk));
>
> Please only print this message if PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER.

I didn't do it because the sunxi clock can't be compiled as module but
indeed i can change it so it's more generic.

> You might also want to make use of commit 57f5677e535b ("printf: add
> support for printing symbolic error names") and use
>
>         dev_err(&pdev->dev, "get clock failed: %pe\n", pwm->clk);

Thanks I will change it,

Regards,
Cl=C3=A9ment

>
> Other than that the patch is fine for me.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
