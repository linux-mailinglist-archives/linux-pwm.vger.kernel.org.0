Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA27EFF38
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfKEOBp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 09:01:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43909 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389377AbfKEOBo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 09:01:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so21498058wra.10;
        Tue, 05 Nov 2019 06:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wcd6F4hUjRzDP5lzJbcKbN83P0Izh8UopNSdrH/0wXs=;
        b=JuGsP7SaJj6polj8WOmJL+wp8KAuIHmo+o9netEjHZUnkfMZlpJrU5Jm+LWMA3UbQE
         iBvCJywvjXy6BYuWreZ9X+UIjDqjTId8lLv4aJjHAxtQxr8RZUTsxAHzztkUXuu506Ty
         6F4HI1awQ+O9jKKZxIJ1S0pujnzRSJAafQus3efQA1FUv5vt+kmWLEv5xQlUPr4OjGPE
         zNQZcnceOyLUnqj2qYpJiUPKgOyIQ5rxG7gBXoosxQZWOSJ3nHCDARXlwZrRxqqOHz9S
         23irGP3IQhh+AuczCRM/sS3LgaVNvLApVUWBkkRDwvNjAo4NyFva12WxB7pBuKjpOLuF
         606w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wcd6F4hUjRzDP5lzJbcKbN83P0Izh8UopNSdrH/0wXs=;
        b=RD2Fdg8y0Z/GNSC9OH3YRWFVKUAHti+joUaaPHYln9k0nPphOTE3bEpKyjJ2NMl5tr
         LuD0UBrc2fmw5NjGnZdPNbdQb0VIbGmZCZcdYpnS/jawGu2YBkfdKmv3Eu9f1Aa+79kA
         kmm4NjVhVUzpZoWWUDxfrSfg2jPxupyncoURmXKOMejcZCJDQIa9TCGWzvsEcmHis1mQ
         Z2aO6vgSzDqkbYJuF/5ezqTz6HshEeUWMzK3UZHuibDCsJE1TtYFfOGAyJrXyokrgjlI
         NBrakWMd/GkU7nK6XpadTqe2p6Dz2O3lAwY5nL5U3feJ+Ku7+fELCbq8/h/XVN12jQuc
         ZpLA==
X-Gm-Message-State: APjAAAWiTBFPuC1nUg9MQzqFB8BVyKMMMmMLtxMFKWpfLxOog5SihG2r
        pzqDsG44hIV60wSn/Th7DUXMJyxX9uYQMwZpHOs=
X-Google-Smtp-Source: APXvYqxRcCROBvE45IqEtn6OaqJk7IITVlNsi8UujVDIcnVf36fGS6gEz5kfeljJQVq3rkoKIyrIDQkO5S6JVNP7UKw=
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr27600001wrs.360.1572962502646;
 Tue, 05 Nov 2019 06:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-3-peron.clem@gmail.com>
 <a8908f1157e862164fb1bea07f8d5e1812325858.camel@pengutronix.de>
In-Reply-To: <a8908f1157e862164fb1bea07f8d5e1812325858.camel@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 5 Nov 2019 15:01:31 +0100
Message-ID: <CAJiuCcesD8kh_BpVLxyhk5UYYwGhp_tQkcsaY-LzxRTT5kO3Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] pwm: sun4i: Add an optional probe for reset line
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
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

Hi Philipp,

On Tue, 5 Nov 2019 at 14:36, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Tue, 2019-11-05 at 14:14 +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs deasserted reset line in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..9ba83769a478 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> [...]
> > @@ -365,6 +367,21 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> > +     if (IS_ERR(pwm->rst)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get reset failed %ld\n",
> > +                             PTR_ERR(pwm->rst));
> > +             return PTR_ERR(pwm->rst);
> > +     }
> > +
> > +     /* Deassert reset */
>
> Nitpick: isn't the API function name explanatory enough?

Yes I can remove this comment,

Cl=C3=A9ment
>
> regards
> Philipp
>
