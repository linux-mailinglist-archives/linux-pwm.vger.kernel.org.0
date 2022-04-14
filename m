Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACC500B12
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiDNKaG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiDNKaF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 06:30:05 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE0576E00;
        Thu, 14 Apr 2022 03:27:41 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 141so3520211qkf.3;
        Thu, 14 Apr 2022 03:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rRWJsUx4tY2eJ+CQFmf/dGdB1lbcB/+o9akE6lQgMvc=;
        b=NBjXSjJxEAm1jgjJ7uUibFmV95BB3Unn5/tUWlwU+vAFzy9m2NNpqloZYrRfknmECK
         cbiFzoX7m1UszdKsOj/iIJkNRTCNcnahIz8LIoHRRslQKgvUWm1rQZHgpXyWRMGHPuiu
         O0PstqoFtJqRcfeDPh1M/qdCpzR4sPt6r1fQj/P6IF/8bsGdCRpSQB687X8PYHGG7mz3
         iQtUF2awIEIDidCQZBjiHTVx7mULAdu0ANgWOexti8ukaTrlmT3BhHLLUkBlh4MRhP19
         08OZkRBfu7L5g1AWlT56oHJg/0oe9scGzzfm/vJGjK2RfHypGIA5cCDhsodO7CFuaQj1
         gkjg==
X-Gm-Message-State: AOAM530nTlYeGI98EH5VMhUQ6lVsIcsbklOR1t4uGyBuwNvIjuoTntBt
        8dfmHpc6gyrJZ+H+uWUzd270FvURVF6CzA==
X-Google-Smtp-Source: ABdhPJxT3Px5hO97No3KO36nFkrqq75j650U7jzv7hHtdRXZW43dN7H/AcwFaES01le/UWjUZjBX9Q==
X-Received: by 2002:a05:620a:17a9:b0:69c:832b:d1b2 with SMTP id ay41-20020a05620a17a900b0069c832bd1b2mr279525qkb.736.1649932060271;
        Thu, 14 Apr 2022 03:27:40 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id z64-20020a37b043000000b0069c0a57f42fsm797211qke.24.2022.04.14.03.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 03:27:39 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ef4a241cc5so43422457b3.2;
        Thu, 14 Apr 2022 03:27:39 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr1411713ywb.256.1649932059417; Thu, 14
 Apr 2022 03:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de> <20220413085050.61144-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-6-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 12:27:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
Message-ID: <CAMuHMdX7Kic2WG+f6hAdjz7SGSjWfi-UTdOrxtmV6D4zE3zh1Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] pwm: renesas-tpu: Improve precision of period and
 duty_cycle calculation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Dividing by the result of a division looses precision. Consider for example
> clk_rate = 33000000 and period_ns = 500001. Then
>
>         clk_rate / (NSEC_PER_SEC / period_ns)
>
> has the exact value 16500.033, but in C this evaluates to 16508. It gets
> worse for even bigger values of period_ns, so with period_ns = 500000001,
> the exact result is 16500000.033 while in C we get 33000000.
>
> For that reason use
>
>         clk_rate * period_ns / NSEC_PER_SEC
>
> instead which doesn't suffer from this problem. To ensure this doesn't
> overflow add a safeguard check for clk_rate.
>
> Incidentally this fixes a division by zero if period_ns > NSEC_PER_SEC.
> Another side effect is that values bigger than INT_MAX for period and
> duty_cyle are not wrongly discarded any more.

You forgot to mention that pwm_state.period is no longer truncated to u32.

>
> Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index fce7df418d62..c8c7a896fc55 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -242,42 +242,52 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  }
>
>  static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -                         int duty_ns, int period_ns, bool enabled)
> +                         u64 duty_ns, u64 period_ns, bool enabled)
>  {
>         struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
>         struct tpu_device *tpu = to_tpu_device(chip);
>         unsigned int prescaler;
>         bool duty_only = false;
>         u32 clk_rate;
> -       u32 period;
> +       u64 period;
>         u32 duty;
>         int ret;
>
>         clk_rate = clk_get_rate(tpu->clk);

As clk_get_rate() returns unsigned long, I think you should change
clk_rate from u32 to unsigned long, too.

> +       if (unlikely(clk_rate > 1000000000UL)) {

s/1000000000UL/NSEC_PER_SEC/

> +               /*
> +                * This won't happen in the nearer future, so this is only a
> +                * safeguard to prevent the following calculation from
> +                * overflowing. With this clk_rate * period_ns / NSEC_PER_SEC is
> +                * not greater than period_ns and so fits into an u64.
> +                */
> +               return -EINVAL;
> +       }
>
> -       period = clk_rate / (NSEC_PER_SEC / period_ns);
> +       period = mul_u64_u64_div_u64(clk_rate, period_ns, NSEC_PER_SEC);
>         if (period >= 64 * 0x10000 || period == 0)
>                 return -EINVAL;

Perhaps use "u64 period64" above, and

    /* We know period to fit into an u32 */
    period = (u32)period64;

to avoid introducing all casts below.

>
>         if (period < 0x10000)
>                 prescaler = 0;
>         else
> -               prescaler = ilog2(period / 0x10000) / 2 + 1;
> +               /*
> +                * We know period to fit into an u32, so cast accordingly to
> +                * make the division a bit cheaper
> +                */
> +               prescaler = ilog2((u32)period / 0x10000) / 2 + 1;

Using a loop would avoid the need for a division...

>
>         period >>= 2 * prescaler;
>
> -       if (duty_ns) {
> -               duty = (clk_rate >> 2 * prescaler)
> -                    / (NSEC_PER_SEC / duty_ns);
> -               if (duty > period)
> -                       return -EINVAL;
> -       } else {
> +       if (duty_ns)
> +               duty = mul_u64_u64_div_u64(clk_rate, duty_ns,
> +                                          (u64)NSEC_PER_SEC << (2 * prescaler));
> +       else
>                 duty = 0;
> -       }
>
>         dev_dbg(&tpu->pdev->dev,
>                 "rate %u, prescaler %u, period %u, duty %u\n",
> -               clk_rate, 1 << (2 * prescaler), period, duty);
> +               clk_rate, 1 << (2 * prescaler), (u32)period, duty);
>
>         if (tpd->prescaler == prescaler && tpd->period == period)
>                 duty_only = true;

With some (or all ;-) suggestions above taken into account:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

The display backlight still works fine on r8a7740/armadillo, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
