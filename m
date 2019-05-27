Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403012B989
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfE0Rup (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 13:50:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46731 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0Ruo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 13:50:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id j49so15414232otc.13;
        Mon, 27 May 2019 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szfrkxYTB3oS9uYVAvQcAHaVtZZAEKMCalggoiWkkvM=;
        b=ACRGDPCU4JiUBP6ShAcgH9cmU4IWA3saNBYva6SUbvOIdRYMS1YRY0c0tWyhrYLrqd
         NEKGiZ8tgEiva5giVOkczbf+nDGoO8A2RtrK30Q7QA4xidBN//QpiluqfksV7ZjJmGow
         mtTpmd7JFUOI/KELjOsEbFMZylX2EBP/Oh42j64UkFnMAuH9ERIJrPNPpSyNgGUH+l7n
         Sy2s6ZgJ3YZTVAod7zMIdEaVml2gG4dBiTb5wfVfhbyBIsFDv0zNeMUdTu57+FEuoM9E
         SfNDxLg/nBNkc+NUBrkrj4ZZbs2/QeqPlPMI/uR4jGdkpnzKPE9kTu+O6+jVofxsXt7n
         REkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szfrkxYTB3oS9uYVAvQcAHaVtZZAEKMCalggoiWkkvM=;
        b=eHAUwEYjKdNFQNHmS/ZCIjxh4/IS9zjEzcnfz3R5/18nAFQpT5PdTDjBG8YGHXZIdC
         qGlVXMtzPI77RvOQdFppch61JtBxBMDfGE97LesPX0Lm7PjPmTniE0acnJuPAVmW0aYn
         1u6wB13CVUH6U3ifsRbDL5D8+NZlSoD1jrBTuXcF6Hf5Oj9pOXOOZo8bnBkMf7W6TFYI
         atxaGCpxRjK8Wcw+ZHWU9Gln0EtRzx8cMPVqhmE/cQVAeelPn2VElur8zoobF8/+qTkf
         /HjONrQ9hMVXgJBthGFGdUEqKA5Gxjvno6AkZ7CaVxQPzwxgP88fTfxlm+TIPhnX93Zs
         YU8g==
X-Gm-Message-State: APjAAAWXGcmogjT9VCnpWiO0bdyE2N/wfUtkXqufwEDDfrVLcGS5MBVt
        G9zP3HBDtg/44PN7dJpYcmnyeCEIzxVXqvqTerxgOj2L+to=
X-Google-Smtp-Source: APXvYqw5Nce89yUOvRESxHDe40cny8RCzJRIgZJvL5llwkndlqbYEpXkgq2GWGpsOfknIkifaZkChPng2XztzeoskRg=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr18512077oto.6.1558979443935;
 Mon, 27 May 2019 10:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-14-martin.blumenstingl@googlemail.com> <4de7d436-32b7-e4ed-39b2-e85f75a17c16@baylibre.com>
In-Reply-To: <4de7d436-32b7-e4ed-39b2-e85f75a17c16@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 19:50:33 +0200
Message-ID: <CAFBinCCPsnX+OqjHgVi+tshE3EdVWS0Bk9qK1V+cg6DALnT1qA@mail.gmail.com>
Subject: Re: [PATCH 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when disabling
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Neil,

On Mon, May 27, 2019 at 2:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > meson_pwm_apply() has to consider the PWM polarity when disabling the
> > output.
> > With enabled=false and polarity=PWM_POLARITY_NORMAL the output needs to
> > be LOW. The driver already supports this.
> > With enabled=false and polarity=PWM_POLARITY_INVERSED the output needs
> > to be HIGH. Implement this in the driver by internally enabling the
> > output with the same settings that we already use for "period == duty".
> >
> > This fixes a PWM API violation which expects that the driver honors the
> > polarity also for enabled=false. Due to the IP block not supporting this
> > natively we only get "an as close as possible" to 100% HIGH signal (in
> > my test setup with input clock of 24MHz and measuring the output with a
> > logic analyzer at 24MHz sampling rate I got a duty cycle of 99.998475%
> > on a Khadas VIM).
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index 900d362ec3c9..bb48ba85f756 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -245,6 +245,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
> >  static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >                          struct pwm_state *state)
> >  {
> > +     struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
> >       struct meson_pwm *meson = to_meson_pwm(chip);
> >       int err = 0;
> >
> > @@ -252,7 +253,27 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >               return -EINVAL;
> >
> >       if (!state->enabled) {
> > -             meson_pwm_disable(meson, pwm);
> > +             if (state->polarity == PWM_POLARITY_INVERSED) {
> > +                     /*
> > +                      * This IP block revision doesn't have an "always high"
> > +                      * setting which we can use for "inverted disabled".
> > +                      * Instead we achieve this using the same settings
> > +                      * that we use a pre_div of 0 (to get the shortest
> > +                      * possible duration for one "count") and
> > +                      * "period == duty_cycle". This results in a signal
> > +                      * which is LOW for one "count", while being HIGH for
> > +                      * the rest of the (so the signal is HIGH for slightly
> > +                      * less than 100% of the period, but this is the best
> > +                      * we can achieve).
> > +                      */
> > +                     channel->pre_div = 0;
> > +                     channel->hi = ~0;
> > +                     channel->lo = 0;
> > +
> > +                     meson_pwm_enable(meson, pwm);
> > +             } else {
> > +                     meson_pwm_disable(meson, pwm);
> > +             }
> >       } else {
> >               err = meson_pwm_calc(meson, pwm, state);
> >               if (err < 0)
> >
>
> While not perfect, it almost fills the gap.
> Another way would be to use a specific pinctrl state setting the pin
> in GPIO output in high level, but this implementation could stay
> if the pinctrl state isn't available.
I just noticed that Amlogic updated the PWM IP block in G12A:
it now supports "constant enable" (REG_MISC_AB bits 28 and 29) as well
as PWM_POLARITY_INVERSED (REG_MISC_AB bits 26 and 27) natively!

I like your idea of having a specific pinctrl state.
we can implement that for anything older than G12A once we actually need it.
for G12A we can do better thanks to the updated IP block


Martin
