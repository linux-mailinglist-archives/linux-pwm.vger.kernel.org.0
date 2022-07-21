Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38057CAC8
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiGUMlv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 21 Jul 2022 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMlu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 08:41:50 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE22F036;
        Thu, 21 Jul 2022 05:41:49 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id mz20so1080743qvb.0;
        Thu, 21 Jul 2022 05:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhhdyoFaSRqmOMFJ4Qng/uZ2QzQ3V6RT8IyD7axO0gg=;
        b=RIOw7IHGOsvN1IgVLUQQ2prk0GGRpjejv0YdsQQml8XJhhd38Ht2kZHnvc0HI//Q8e
         jtZOLG3PTUez5kTVyigrNxF+Q2bIO1KoI72qaZJ+2FjM0zqCoxfT1t4wObai5JTwz28H
         jGnnkROQ++kBoPVnomwxAex5254rgPG/hPNxheHt14+Yaib8rOdI9YSBcDUN4NuqHM3/
         6Cgrq5PsElXyeglgOzfQ3c6PukdaFznrZnB1k14SBQOk8nUDv6kkY4QEUov4MS0MNvXt
         McR9nmYTJpmfepKzq1B2m40raqJdfkCkyuiGTjP6WNcVkQGIldEJZgBJh26xJeL5Lvjy
         i/ZA==
X-Gm-Message-State: AJIora/HFlGSfwJt4rtOlaaUXdXaPgM/JYfaDeubRUFU1YqYNZ09xPou
        FS37+bbLdbp/xnCWYF6H/CUKeZbIpMMHkw==
X-Google-Smtp-Source: AGRyM1u9AMBCoQomfmowM2TQA9ojhLU7Q02HcXaZMw9rtak262eKw/S2Tsbh1meFi/BN32jmTT3csQ==
X-Received: by 2002:a05:6214:226c:b0:474:582:b447 with SMTP id gs12-20020a056214226c00b004740582b447mr5976670qvb.56.1658407308462;
        Thu, 21 Jul 2022 05:41:48 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006a79d8c8198sm1260194qkj.135.2022.07.21.05.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 05:41:48 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31e7c4b593fso15393097b3.13;
        Thu, 21 Jul 2022 05:41:47 -0700 (PDT)
X-Received: by 2002:a81:4f87:0:b0:31e:7122:16fb with SMTP id
 d129-20020a814f87000000b0031e712216fbmr6265307ywb.358.1658407307424; Thu, 21
 Jul 2022 05:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220719155910.576265-1-biju.das.jz@bp.renesas.com> <20220719155910.576265-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220719155910.576265-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 14:41:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWs_ah_UZdxnpA1hkPaSarokMhcj1r3_jt_oWFG6SWP+w@mail.gmail.com>
Message-ID: <CAMuHMdWs_ah_UZdxnpA1hkPaSarokMhcj1r3_jt_oWFG6SWP+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Tue, Jul 19, 2022 at 5:59 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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
> v2->v3:

Thanks for the update!

> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c

> +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64 period_cycles)
> +{
> +       u64 prescaled_period_cycles;
> +       u8 prescale;
> +       u16 i;

Why do prescale and i differ in type?
Why not use unsigned int?

> +
> +       prescaled_period_cycles = period_cycles >> 32;

So prescaled_period_cycles can be u32?

> +       prescale = 5;
> +       /* prescale 1, 4, 16, 64, 256 and 1024 */
> +       for (i = 0; i < 6; i++) {
> +               if ((1 << (2 * i)) > prescaled_period_cycles) {
> +                       prescale = i;
> +                       break;
> +               }
> +       }
> +
> +       return prescale;
> +}

> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +                           u64 duty_ns, u64 period_ns)
> +{
> +       struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
> +       struct gpt_pwm_device *gpt = &pc->gpt[pwm->hwpwm];
> +       unsigned long rate, pv, dc;
> +       u64 period_cycles;
> +       u8 prescale;
> +
> +       rate = clk_get_rate(pc->clk);
> +       /*
> +        * Refuse clk rates > 1 GHz to prevent overflowing the following
> +        * calculation.
> +        */
> +       if (rate > NSEC_PER_SEC)
> +               return -EINVAL;
> +
> +       period_cycles = mul_u64_u64_div_u64(rate, period_ns, NSEC_PER_SEC);

As NSEC_PER_SEC fits in 32-bit, and we know rate does, too, you can
use the cheaper mul_u64_u32_div(period_ns, rate, NSEC_PER_SEC) instead.

> +       prescale = rzg2l_calculate_prescale(pc, period_cycles);
> +
> +       pv = round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));
> +       period_cycles = mul_u64_u64_div_u64(rate, duty_ns, NSEC_PER_SEC);

Likewise.

> +       dc = round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));

Why are pv and dc unsigned long, which is either 32-bit or 64-bit?

> +static const struct of_device_id rzg2l_gpt_of_table[] = {
> +       { .compatible = "renesas,rzg2l-gpt", },
> +       { /* Sentinel */ },

Please drop the comma after the sentinel.

> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);

> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +       struct rzg2l_gpt_chip *rzg2l_gpt;
> +       struct clk *clk;
> +       int ret;
> +
> +       rzg2l_gpt = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> +       if (!rzg2l_gpt)
> +               return -ENOMEM;
> +
> +       rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(rzg2l_gpt->mmio))
> +               return PTR_ERR(rzg2l_gpt->mmio);
> +
> +       rzg2l_gpt->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
> +       if (IS_ERR(rzg2l_gpt->rstc))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +                                    "get reset failed\n");
> +
> +       rzg2l_gpt->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(rzg2l_gpt->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +                                    "cannot get clock\n");
> +
> +       platform_set_drvdata(pdev, rzg2l_gpt);
> +
> +       ret = reset_control_deassert(rzg2l_gpt->rstc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
> +                       ERR_PTR(ret));
> +               return ret;
> +       }
> +
> +       pm_runtime_enable(&pdev->dev);
> +
> +       ret = devm_add_action_or_reset(&pdev->dev,
> +                                      rzg2l_gpt_reset_assert_pm_disable,
> +                                      rzg2l_gpt);
> +       if (ret < 0)
> +               return ret;
> +
> +       clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);

Why optional?
You already have a pointer to this clock?

> +       if (IS_ERR(clk)) {
> +               rzg2l_gpt_reset_assert_pm_disable(rzg2l_gpt);

Isn't this called automatically, due to devm_add_action_or_reset()?

> +               return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +                                    "clk operation failed");
> +       }
> +
> +       if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> +               devm_clk_put(&pdev->dev, clk);

This is done to keep the clock enabled in case it was enabled before?
I think this deserves a comment.

> +
> +       rzg2l_gpt->chip.dev = &pdev->dev;
> +       rzg2l_gpt->chip.ops = &rzg2l_gpt_ops;
> +       rzg2l_gpt->chip.npwm = RZG2L_GPT_IO_PER_CHANNEL;
> +
> +       return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
