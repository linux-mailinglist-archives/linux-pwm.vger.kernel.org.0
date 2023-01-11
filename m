Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B52665C27
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jan 2023 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAKNIr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Jan 2023 08:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjAKNIp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Jan 2023 08:08:45 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215122029;
        Wed, 11 Jan 2023 05:08:39 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id z12so13616241qtv.5;
        Wed, 11 Jan 2023 05:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3MocPgzq9GStN0Hq9debEE+uWhaJ0FvEGuzvA5p/Q8=;
        b=MwB+yLQg7c+WxcCVzS9Gf+3IcWkPhN6E4ttnxPEEgRVCYZnnJMu48wzfmaV/pBOZIe
         rXL4t7nlcKJSxQvj9rEuaTKZNpUpR47a9hFBycpTk81leUF0MeUj69OVSZuEYLhrp0ag
         DGxai7DVB1hrfjMvMuOK7GG8WUMU4riJAFYToAbmhrjTK4Q2TU9/dcUbTFIp+BzYdVE6
         e5ZlCRJwlXGXjCPO9pxKuuJTPpGONoyoMZNvqRNHLh0b8H6YwhYUi3FZ2CmZWhSRybpJ
         KVV/MB1C5qi1Uzj6uO95kwqHPNJugo3eZXlpDuVSEj7gpBNJGleFOFciM3ord5dd6544
         kYvg==
X-Gm-Message-State: AFqh2kqX1iAvlZgdTvVhwsa0P7h2utKK2UUBxRUoC/lHr+3vDldUN503
        vZq13Cf1PYHvhsw/aDdtILkauy2wHJvAkA==
X-Google-Smtp-Source: AMrXdXvdUmWnkM/fXTCnugiN6RrA7/zAHSHWN8ZoMgqnnIHoFfGwHmC0QaqFmQXEXXSAFIp8JSXFow==
X-Received: by 2002:a05:622a:4d47:b0:3aa:82c0:1ca3 with SMTP id fe7-20020a05622a4d4700b003aa82c01ca3mr113507898qtb.23.1673442517921;
        Wed, 11 Jan 2023 05:08:37 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o7-20020ac841c7000000b003a82562c90fsm7464789qtm.62.2023.01.11.05.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:08:37 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4c131bede4bso193987827b3.5;
        Wed, 11 Jan 2023 05:08:37 -0800 (PST)
X-Received: by 2002:a81:ac18:0:b0:475:f3f5:c6c with SMTP id
 k24-20020a81ac18000000b00475f3f50c6cmr1429557ywh.358.1673442517145; Wed, 11
 Jan 2023 05:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20221214132232.2835828-1-biju.das.jz@bp.renesas.com> <20221214132232.2835828-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221214132232.2835828-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 14:08:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL0U85fUXRdMV8TT1QwkzAfo_6baNa7wR6_bL6wS-BfQ@mail.gmail.com>
Message-ID: <CAMuHMdVL0U85fUXRdMV8TT1QwkzAfo_6baNa7wR6_bL6wS-BfQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Wed, Dec 14, 2022 at 2:22 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits × 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>
> This patch adds basic pwm support for RZ/G2L GPT driver by creating
> separate logical channels for each IOs.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache the
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale,If the PWM
>    is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()

Thanks for the update!

> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c

> +struct rzg2l_gpt_chip {
> +       struct pwm_chip chip;
> +       void __iomem *mmio;
> +       struct reset_control *rstc;
> +       struct clk *clk;
> +       struct mutex lock;
> +       unsigned long rate;
> +       u32 state_period[RZG2L_MAX_HW_CHANNELS];
> +       u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +       /*
> +        * The driver cannot read the current duty cycle/prescale from the
> +        * hardware if the hardware is disabled. Cache the last programmed
> +        * duty cycle/prescale value to return in that case.
> +        */
> +       u8 prescale[RZG2L_MAX_HW_CHANNELS];
> +       unsigned int duty_cycle[RZG2L_MAX_PWM_CHANNELS];

u32? The maximum value stored is U32_MAX.

> +};

> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                              struct pwm_state *state)
> +{
> +       struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> +       u32 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
> +       u32 offs = RZG2L_GET_CH_OFFS(ch_index);
> +       u8 prescale;
> +       u64 tmp;
> +       u32 val;
> +
> +       pm_runtime_get_sync(chip->dev);
> +       val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +       state->enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +       if (state->enabled) {
> +               prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +               val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +               tmp = NSEC_PER_SEC * (u64)val;
> +               state->period = DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * prescale);
> +
> +               val = rzg2l_gpt_read(rzg2l_gpt,
> +                                    offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm->hwpwm)));
> +               tmp = NSEC_PER_SEC * (u64)val;
> +       } else {
> +               /* If the PWM is disabled, use the cached value. */
> +               prescale = rzg2l_gpt->prescale[ch_index];
> +               tmp = NSEC_PER_SEC * (u64)rzg2l_gpt->duty_cycle[pwm->hwpwm];

Nit: Just set "val = rzg2l_gpt->duty_cycle[pwm->hwpwm];", and factor
"tmp = NSEC_PER_SEC * (u64)val;" out of the if-statement.

> +       }
> +
> +       state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * prescale);
> +       state->polarity = PWM_POLARITY_NORMAL;
> +       pm_runtime_put(chip->dev);
> +
> +       return 0;
> +}

> +static int __maybe_unused rzg2l_gpt_pm_runtime_suspend(struct device *dev)
> +{
> +       struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(rzg2l_gpt->clk);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused rzg2l_gpt_pm_runtime_resume(struct device *dev)
> +{
> +       struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
> +
> +       clk_prepare_enable(rzg2l_gpt->clk);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops rzg2l_gpt_pm_ops = {
> +       SET_RUNTIME_PM_OPS(rzg2l_gpt_pm_runtime_suspend, rzg2l_gpt_pm_runtime_resume, NULL)
> +};

DEFINE_RUNTIME_DEV_PM_OPS(), so you can drop the __maybe_unused
from the callbacks.

> +static struct platform_driver rzg2l_gpt_driver = {
> +       .driver = {
> +               .name = "pwm-rzg2l-gpt",
> +               .pm = &rzg2l_gpt_pm_ops,

pm_ptr(&rzg2l_gpt_pm_ops)?

> +               .of_match_table = of_match_ptr(rzg2l_gpt_of_table),
> +       },
> +       .probe = rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
