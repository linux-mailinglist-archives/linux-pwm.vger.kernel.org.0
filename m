Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE929EB64
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Oct 2020 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJ2MNk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Oct 2020 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgJ2MNj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Oct 2020 08:13:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC409C0613CF;
        Thu, 29 Oct 2020 05:13:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j5so1202383plk.7;
        Thu, 29 Oct 2020 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7ZEDn15eyX1XeDKP5z4w+qUietYP3YvKn3vn65Qc0E=;
        b=O2pvzOa6S8Ybvb5XjV0uWYBlsA0GFMm/Fk4bNuSnxqvWH2klL3473TfX0MZyOgcePE
         jg3q9vIfonz4peRj1NOB1YUc4W71MW3LdI/NQwdBbbmd4XqRcXUV1S4ljy8JQOl6mAEG
         Xf5JS3240Uryy+dhpli9H8oOWCNO7m2sdR/hVKtjr7PCEBJvi6ubTKvP9lYJn1fa9hZr
         cPvHaF8m2rq9GVetErmhoh32E8orcecbnAcEyru+Jc3qaW94VZwcTZilRjG5PWSQ4/sj
         ojkw20qNPhYXrxCU3ykudE17BfgKwyFicVr4BzDVio5FjeUfx1NA1FKHZJiOeFl9kiqU
         QYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7ZEDn15eyX1XeDKP5z4w+qUietYP3YvKn3vn65Qc0E=;
        b=tA7RT1osyr3AFlvqHouZMp5ZqgifwVbhnE8IBd9rKmW5SCx+BNg9kquLB8S8S+knN1
         b7audU6/MCJZ+yRos760PhTdclnbMcRrFzqRo/jjagSMhA8mHV27MWcXa0iXw5eKoGP/
         oqIrJHVxFDJHK70TF6+5y9hk0Ga8odI8r/NFcJwk9Gkz44lbe8/SjqxlowLxXKvtW5Z8
         ouTHZOhSbloUC9UWF9lpwTPgm2qloL3zuZ4mb4sKpJfA6wxTFBQgsui4FIrPWIbZh2pB
         JhrBYQEpeKfGRKgz6RKk9jUoi9o3fk105eehYrfGxZEocmM6LRIuhO2F9KruVu7A1n1y
         l3OA==
X-Gm-Message-State: AOAM530PpxNpj0oUh2cwVaC7ew9aAPaPssEOlJiHMWWrcpXTxyGzy3wH
        sWI0Opv8sl6Fezs8kr8U6Lr+374+nG+YykaLD8g=
X-Google-Smtp-Source: ABdhPJzQQtn9Lo5eT93NIA8y7EekBZVWR4mP9HtmRZxaja3G5tyjp2t60dDkJGJjK/oCSRSJHS6rB5KPpuR6HNPNgvY=
X-Received: by 2002:a17:902:bc4a:b029:d6:7ef9:689c with SMTP id
 t10-20020a170902bc4ab02900d67ef9689cmr3858929plz.21.1603973617254; Thu, 29
 Oct 2020 05:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
 <20201017052057.2698588-3-bjorn.andersson@linaro.org> <CAHp75VeVbK1Wx2BEPghtEbEghqDAF2jFFN9=ARLEw-rvTUZ3yw@mail.gmail.com>
 <20201020042403.GE6705@builder.lan>
In-Reply-To: <20201020042403.GE6705@builder.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 14:14:26 +0200
Message-ID: <CAHp75Vde5Qfe-Ycn69J_-8=GPpxChkp+L4WgrUsp+uK=NMdHug@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 20, 2020 at 7:29 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sun 18 Oct 15:12 CDT 2020, Andy Shevchenko wrote:
> > On Sat, Oct 17, 2020 at 8:41 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:

...

> > > +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> > > +                        size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> > > +{
> > > +       unsigned int idx;
> > > +       u8 val[2];
> >
> > __be16 val;
> >
> > > +       int i;
> > > +
> > > +       /* Hardware does not behave when LO_IDX == HI_IDX */
> > > +       if (len == 1)
> > > +               return -EINVAL;
> > > +
> > > +       idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> > > +                                        0, len, 0);
> > > +       if (idx >= lpg->lut_size)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i = 0; i < len; i++) {
> > > +               val[0] = pattern[i].brightness & 0xff;
> > > +               val[1] = pattern[i].brightness >> 8;
> >
> > cpu_to_be16();
> >
>
> I like it, but isn't that a le16?

Oh, yes.

> > > +               regmap_bulk_write(lpg->map,
> > > +                                 lpg->lut_base + LPG_LUT_REG(idx + i), val, 2);
> > > +       }
> > > +
> > > +       bitmap_set(lpg->lut_bitmap, idx, len);
> > > +
> > > +       *lo_idx = idx;
> > > +       *hi_idx = idx + len - 1;
> > > +
> > > +       return 0;
> > > +}

...

> > > +               period_n = (period_us * NSEC_PER_USEC) >> 6;
> > > +               n = 6;
> > > +       } else {
> > > +               period_n = (period_us >> 9) * NSEC_PER_USEC;
> > > +               n = 9;

> > Why inconsistency in branches? Can you rather derive n and calculate
> > only once like
> >
> >            period_n = (period_us >> n) * NSEC_PER_USEC;
> >
> > ?
>
> I inherited this piece from the downstream driver and I assume that the
> purpose was to avoid loss of precision. I will review this and if
> nothing else it seems like I would be able to cast period_us to more
> bits, do the multiply and then shift - in both cases.

Understood. Yes, please check if precision doesn't suffer and update
accordingly.

...

> > > +static void lpg_calc_duty(struct lpg_channel *chan, unsigned int duty_us)
> > > +{
> > > +       unsigned long max = (1 << chan->pwm_size) - 1;
> >
> > BIT() ?

Actually if you don't use BIT() here (or U suffix) it is UB for pwm_size == 31.

> >
> > > +       unsigned long val;
> > > +
> > > +       /* Figure out pwm_value with overflow handling */
> >
> > > +       if (duty_us < 1 << (sizeof(val) * 8 - chan->pwm_size))
> >
> > BITS_PER_TYPE, but actually BITS_PER_LONG here.
> >
> > BIT(BITS_PER_LONG - ...)
> >
>
> Again, this seems to just be a question of avoiding overflow of the 32
> bit duty_us. I'll double check the math here as well.

Can pwm_size be equal to 0?

> > > +               val = (duty_us << chan->pwm_size) / chan->period_us;
> > > +       else
> > > +               val = duty_us / (chan->period_us >> chan->pwm_size);
> > > +
> > > +       if (val > max)
> > > +               val = max;
> > > +
> > > +       chan->pwm_value = val;
> > > +}

...

> > > +static int lpg_blink_set(struct lpg_led *led,
> > > +                        unsigned long delay_on, unsigned long delay_off)
> > > +{
> > > +       struct lpg_channel *chan;
> > > +       unsigned int period_us;
> > > +       unsigned int duty_us;
> > > +       int i;
> > > +
> > > +       if (!delay_on && !delay_off) {
> > > +               delay_on = 500;
> > > +               delay_off = 500;
> > > +       }
> >
> > Homegrown duty cycle?
> > I mean, why simply not to pass the duty cycle in percentage in the first place?
>
> Can you explain what you're saying here.

Why not to use duty cycle (in %) and period (in us) as a parameter to
the function directly?

> > > +       duty_us = delay_on * USEC_PER_MSEC;
> > > +       period_us = (delay_on + delay_off) * USEC_PER_MSEC;
> > > +
> > > +       for (i = 0; i < led->num_channels; i++) {
> > > +               chan = led->channels[i];
> > > +
> > > +               lpg_calc_freq(chan, period_us);
> > > +               lpg_calc_duty(chan, duty_us);
> > > +
> > > +               chan->enabled = true;
> > > +               chan->ramp_enabled = false;
> > > +
> > > +               lpg_apply(chan);
> > > +       }
> > > +
> > > +       return 0;
> > > +}

...

> > Can you rather create a generic one under lib/ or start include/linux/math.h ?

> Forgot about this, but I've seen one on LKML, will find it and work on
> getting that accepted.

Note, I have submitted the patch that splits out math.h from kernel.h
(it's in Andrew's quilt and in Linux Next as of today), you may send a
follow up patch that adds this functionality.

...

> > > +       ret = of_property_read_u32(np, "color", &color);
> > > +       if (ret < 0 && ret != -EINVAL)
> >
> > This check is fishy. Either you have optional property or not, in the
> > latter case return any error code.
> >
>
> There's three possible outcomes here:
> 1) We found _one_ integer in the property, color is assigned and 0 is
> returned.

I didn't get this. Doesn't your YAML schema say that it must be a
single integer?

> 2) We found no property named "color", -EINVAL is returned without color
> being modified.
> 3) We found a property but it wasn't a single u32 value so a negative
> error (not EINVAL) is returned.
>
> > > +               return ret;
> > > +
> > > +       chan->color = color;
> >
> > So, it may be -EINVAL?!
> >
>
> So color will either be the value or the property color, or if omitted
> LED_COLOR_ID_GREEN.

If property is optional, we do simple

ret = of_read_property_...(&x);
if (ret)
 x = default_value;

Otherwise simple
ret = ...
if (ret)
  return ret;

is sufficient.

What you have done is a little bit unusual.

...

> > > +       ret = of_property_read_u32_array(np, "qcom,dtest", dtest, 2);
> > > +       if (ret < 0 && ret != -EINVAL) {
> > > +               dev_err(lpg->dev, "malformed qcom,dtest of %pOFn\n", np);
> > > +               return ret;
> > > +       } else if (!ret) {
> > > +               chan->dtest_line = dtest[0];
> > > +               chan->dtest_value = dtest[1];
> > > +       }
> >
> > Ditto.
> >
>
> We're in !ret and as such dtest is initialized.

As above.

...

> > > +       ret = of_property_read_u32(np, "color", &color);
> > > +       if (ret < 0 && ret != -EINVAL)
> > > +               return ret;
> >
> > Ditto.
> >
>
> As above, if no property color is specified, color remains 0 here which
> is not LED_COLOR_ID_MULTI and this is a single channel LED without its
> color specified.

As above.

-- 
With Best Regards,
Andy Shevchenko
