Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34477939
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfG0O1l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 10:27:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40990 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfG0O1k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2019 10:27:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so55585610eds.8;
        Sat, 27 Jul 2019 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5LMz+F5HmGiI0OaPOZ+zlAMKqfMWikw1NmVc9ZxKJI=;
        b=eaM6N5381gjsv+FDW/SVv39i+ZFK2rBVbhukYJCJp7lnR2TFmZ4Na1Xr3RmSXieqkU
         z+nuOHu6I5XzTJdC/pOggcBk3kmpv2nvYDQc/MbCh2DyL4/cVLRJRa6zRnyfPsFNNKs7
         II3jD3ZXhhrT+Yc49YoX9mj4GpIszsL9chPm7P0ogsIv0mERBX02apPX4I2f9vMrlFtc
         eEQQlQEFcrf0SO0uvWTOnYQJW9WZLYEMuNMw09Gmys8+6nu+uh/bmKcV/xDvDcUScrKy
         WTWqDP97CEpoPrQ2ugWEzE8G8Pq/7b2gpH6QOPQakBcQdhkfSAd6xONJKpQr6WufCvBB
         52nw==
X-Gm-Message-State: APjAAAUGPFH2FKoTUW8kQxTb0m0CUMKafO9maud3x5aMFXjRj0pZpv3p
        SQlNfwLNGPFrjly+Vf8jXKESQPHSvfo=
X-Google-Smtp-Source: APXvYqyiwbh05ja7vWezLLE0TLXW6sPR33Ne0kWT6TPD6L3dwLpZBQnXkdqvaVa74bZcsSIdaSDFzA==
X-Received: by 2002:a17:906:4582:: with SMTP id t2mr78017594ejq.242.1564237658044;
        Sat, 27 Jul 2019 07:27:38 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id e12sm14671554edb.72.2019.07.27.07.27.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 07:27:37 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id a15so50208726wmj.5;
        Sat, 27 Jul 2019 07:27:36 -0700 (PDT)
X-Received: by 2002:a7b:c051:: with SMTP id u17mr88536023wmc.25.1564237656507;
 Sat, 27 Jul 2019 07:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net> <20190727104628.jsdvpxvcpzru75v5@flea.home>
In-Reply-To: <20190727104628.jsdvpxvcpzru75v5@flea.home>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 27 Jul 2019 22:27:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v67h3Y1rhCSF-MTmVBOEnbWZKvvFg5DzGUWPqcxLcv-6tg@mail.gmail.com>
Message-ID: <CAGb2v67h3Y1rhCSF-MTmVBOEnbWZKvvFg5DzGUWPqcxLcv-6tg@mail.gmail.com>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 27, 2019 at 6:46 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add a quirk for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
> >  };
> >
> >  struct sun4i_pwm_data {
> > +     bool has_bus_clock;
> >       bool has_prescaler_bypass;
> >       bool has_reset;
> >       unsigned int npwm;
> > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> > +     struct clk *bus_clk;
> >       struct clk *clk;
> >       struct reset_control *rst;
> >       void __iomem *base;
> > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >               reset_control_deassert(pwm->rst);
> >       }
> >
> > +     if (pwm->data->has_bus_clock) {
> > +             pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +             if (IS_ERR(pwm->bus_clk)) {
> > +                     ret = PTR_ERR(pwm->bus_clk);
> > +                     goto err_bus;
> > +             }
> > +
> > +             clk_prepare_enable(pwm->bus_clk);
> > +     }
> > +
>
> The patch itself looks fine, but you should clarify which clock is
> being used by the old driver.
>
> My guess is that the "new" clock is actually the mod one, while the
> old one was both the clock of the register interface (bus) and the
> clock of the PWM generation logic (mod).

The H6 datasheet explicitly states:

    The clock source of PWM is OSC24M. The PWM is on APB1 Bus. Ensure
    that open APB1 Bus gating and de-assert reset signal when accessed
    to the PWM.

Older datasheets do not have anything about bus gating or resets. However
with slightly newer ones that have a system bus tree diagram, we can see
that PWM is on APB1 (or APB0/APBS for R_PWM). We can assume there is no
bus gate and thus it is directly attached to APB1, and that we never
modeled this part.

So the new clock is definitely the bus gate. You might want to introduce
a patch renaming sun4i_pwm_data.clk to sun4i_pwm_data.mod_clk before this
one.

ChenYu
