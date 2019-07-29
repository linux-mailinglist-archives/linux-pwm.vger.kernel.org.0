Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85D78522
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 08:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfG2Gnk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 02:43:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46603 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfG2Gnj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 02:43:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so58318304edr.13;
        Sun, 28 Jul 2019 23:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N3YcfI6Lt3N7Xfg/QsppatAiaJc9l2mfK7jxMUvJqWY=;
        b=ruNZ5YEUBG1D0cBfLarMvvTPCOfzNNKXypaliIhjwTzBAs1Rr3RR3XReoWXR3SubIh
         MtTwXxz2GK/waoekFOnXYASQPzOb7oO22PesxnksVL06DuWhu5YxiNVkW/aC1PEwZwD0
         l2wxET4OQzELqOEkZpmtUBjWbse9ncHzmzr9k2hvcGPMQxipjbJKuTDOM501l0qqTHB/
         vq1umPUpOAOw5Bkkj8Caexq/AmARqElWcg50cpLqU1+QpINNs8ohZZXjFm2io7Jm5Iph
         vwfaijClkYbtl5W++ATAWFKnIv1E4GP4iZjQsBS4Oqi2KYcVidiMel/XBG2of67bNjbv
         NQ3g==
X-Gm-Message-State: APjAAAVxN7dlJF8qDGCQPuOaoUZqU4LyJkRWmhcm/SO9YMxjKVT+LLV6
        GtDH2XCrK3GoPfhqwPh6yFmxENtGEnk=
X-Google-Smtp-Source: APXvYqzFdJFRI/52u5fOHTiP8mLDcJ4ShMlNVqfK+Uef0oXPRqygtDeBly8v6e3OscHYonJ6nylk+Q==
X-Received: by 2002:a17:906:3497:: with SMTP id g23mr83306443ejb.70.1564382617102;
        Sun, 28 Jul 2019 23:43:37 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id f36sm15796131ede.47.2019.07.28.23.43.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 23:43:36 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id r1so60460548wrl.7;
        Sun, 28 Jul 2019 23:43:36 -0700 (PDT)
X-Received: by 2002:adf:e941:: with SMTP id m1mr30982207wrn.279.1564382616355;
 Sun, 28 Jul 2019 23:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net> <20190729063630.rn325whatfnc3m7n@pengutronix.de>
In-Reply-To: <20190729063630.rn325whatfnc3m7n@pengutronix.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 29 Jul 2019 14:43:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
Message-ID: <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Cc += reset framework maintainer
>
> Hello Jernej,
>
> On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs deasserted reset line in order to work.
> >
> > Add a quirk for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index de78c824bbfd..1b7be8fbde86 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/time.h>
> > @@ -72,12 +73,14 @@ static const u32 prescaler_table[] = {
> >
> >  struct sun4i_pwm_data {
> >       bool has_prescaler_bypass;
> > +     bool has_reset;
> >       unsigned int npwm;
> >  };
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> >       struct clk *clk;
> > +     struct reset_control *rst;
> >       void __iomem *base;
> >       spinlock_t ctrl_lock;
> >       const struct sun4i_pwm_data *data;
> > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     if (pwm->data->has_reset) {
> > +             pwm->rst = devm_reset_control_get(&pdev->dev, NULL);
> > +             if (IS_ERR(pwm->rst))
> > +                     return PTR_ERR(pwm->rst);
> > +
> > +             reset_control_deassert(pwm->rst);
> > +     }
> > +
>
> I wonder why there is a need to track if a given chip needs a reset
> line. I'd just use devm_reset_control_get_optional() and drop the
> .has_reset member in struct sun4i_pwm_data.

Because it's not optional for this platform, i.e. it won't work if
the reset control (or clk, in the next patch) is somehow missing from
the device tree.

ChenYu

> >       pwm->chip.dev = &pdev->dev;
> >       pwm->chip.ops = &sun4i_pwm_ops;
> >       pwm->chip.base = -1;
> > @@ -383,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >       ret = pwmchip_add(&pwm->chip);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> > -             return ret;
> > +             goto err_pwm_add;
> >       }
> >
> >       platform_set_drvdata(pdev, pwm);
> >
> >       return 0;
> > +
> > +err_pwm_add:
> > +     reset_control_assert(pwm->rst);
> > +
> > +     return ret;
> >  }
> >
> >  static int sun4i_pwm_remove(struct platform_device *pdev)
> >  {
> >       struct sun4i_pwm_chip *pwm = platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     ret = pwmchip_remove(&pwm->chip);
> > +     if (ret)
> > +             return ret;
> >
> > -     return pwmchip_remove(&pwm->chip);
> > +     reset_control_assert(pwm->rst);
> > +
> > +     return 0;
> >  }
> >
> >  static struct platform_driver sun4i_pwm_driver = {
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
