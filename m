Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAD500AC7
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiDNKMn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiDNKMl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 06:12:41 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A1240B9;
        Thu, 14 Apr 2022 03:10:16 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id t2so1240352qta.5;
        Thu, 14 Apr 2022 03:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Y5f59RIyVrrmTqEzX+r9Z7m0Vm2tYpNuFpxt9TfdIo=;
        b=icYEw3YqNfPQ21rligHTIr3FMDRW4wD0Vn+50sJE2MDkXpaut5QJ6mNImdPCWT6IlF
         li3kJfDPvEc6A13oBuOitNM9t6KxWW5LAjOXIpnZ0FORKNAiiv90OsfHFrBzxMhkFo3O
         4KIU9dJiSzMI9DjUspYdzOtZTqvOTAtmE0mPKRkePeze1P1EDJRNqgNF6HqbdowUsla/
         qa7CnB50BNY5L8O5229eWIXR1uqH39RcqNNdjKabf5h73z3HlD12MntmnRuqy0JuZ+//
         Ow6YzyEKJQXP8ceNzRN+pr78A9VjSo9cvzLlxMYhAP0f1NZDmKMj4H8KkvxJTG3QKTd8
         de3A==
X-Gm-Message-State: AOAM533OUd60ymEYvvrtYMC7a7hz8nvsX6Ymg0OkRIUn0x28b/y/YJmk
        WoQt2PlMKkBZCNqvtgsEVwrh7MZgYSjBhQ==
X-Google-Smtp-Source: ABdhPJzUyBD9bOfUGHuVo2+tgSczZB93eQI45GRiSY2AdBhlWL1MteOzd0pKVt4JuhmX7L2TVhbTMg==
X-Received: by 2002:a05:622a:229e:b0:2f1:d077:52b3 with SMTP id ay30-20020a05622a229e00b002f1d07752b3mr1090081qtb.127.1649931015106;
        Thu, 14 Apr 2022 03:10:15 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a060f00b002e2070bf899sm889873qta.90.2022.04.14.03.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 03:10:14 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id v77so8466033ybi.12;
        Thu, 14 Apr 2022 03:10:14 -0700 (PDT)
X-Received: by 2002:a25:23c9:0:b0:641:d94c:8bf1 with SMTP id
 j192-20020a2523c9000000b00641d94c8bf1mr1206692ybj.546.1649931014457; Thu, 14
 Apr 2022 03:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de> <20220413085050.61144-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-5-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 12:10:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6u3xrnZrxsx8h6-zfZ=6sH=ehnQ6KCthB5QNFU5rexQ@mail.gmail.com>
Message-ID: <CAMuHMdW6u3xrnZrxsx8h6-zfZ=6sH=ehnQ6KCthB5QNFU5rexQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] pwm: renesas-tpu: Improve maths to compute register settings
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your patch!

On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The newly computed register values are intended to exactly match the
> previously computed values. The main improvement is that the prescaler
> is computed directly instead of with a loop. This uses the fact, that
> prescalers[i] = 1 << (2 * i).
>
> Assuming a moderately smart compiler, the needed number of divisions for
> the case where the requested period is too big, is reduced from 5 to 2.

I'm not worried about the divisions, but about the ilog2(), which
uses fls().  The TPU block also exists on SuperH SoCs (although
currently no SH Linux code has it enabled), and SH uses the fls()
implementation from asm-generic.

> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -244,7 +244,6 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                           int duty_ns, int period_ns, bool enabled)
>  {
> -       static const unsigned int prescalers[] = { 1, 4, 16, 64 };
>         struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
>         struct tpu_device *tpu = to_tpu_device(chip);
>         unsigned int prescaler;
> @@ -254,26 +253,21 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         u32 duty;
>         int ret;
>
> -       /*
> -        * Pick a prescaler to avoid overflowing the counter.
> -        * TODO: Pick the highest acceptable prescaler.
> -        */
>         clk_rate = clk_get_rate(tpu->clk);
>
> -       for (prescaler = 0; prescaler < ARRAY_SIZE(prescalers); ++prescaler) {
> -               period = clk_rate / prescalers[prescaler]
> -                      / (NSEC_PER_SEC / period_ns);
> -               if (period <= 0xffff)
> -                       break;
> -       }
> +       period = clk_rate / (NSEC_PER_SEC / period_ns);
> +       if (period >= 64 * 0x10000 || period == 0)
> +               return -EINVAL;
>
> -       if (prescaler == ARRAY_SIZE(prescalers) || period == 0) {
> -               dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
> -               return -ENOTSUPP;
> -       }
> +       if (period < 0x10000)
> +               prescaler = 0;
> +       else
> +               prescaler = ilog2(period / 0x10000) / 2 + 1;
> +
> +       period >>= 2 * prescaler;

Although the above is correct, I find it hard to read.
Hence I'd keep a loop, like:

    unsigned int prescaler = 0;
    ...
    while (period > 0x10000) {
            period >>= 2;
            prescalar++;
    }

This would even save 2 lines of code ;-)

>
>         if (duty_ns) {
> -               duty = clk_rate / prescalers[prescaler]
> +               duty = (clk_rate >> 2 * prescaler)
>                      / (NSEC_PER_SEC / duty_ns);
>                 if (duty > period)
>                         return -EINVAL;

Anyway:
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
