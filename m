Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE3620BF0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Nov 2022 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiKHJRL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 8 Nov 2022 04:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiKHJRF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Nov 2022 04:17:05 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8E31366;
        Tue,  8 Nov 2022 01:17:03 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id hh9so8297594qtb.13;
        Tue, 08 Nov 2022 01:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yJE9HWPq/xxP/heSuAJLkETpDJG6TIl222QeLYf2Fc=;
        b=cbhHnJCAFmA4iC/o2dOOpCznYkzuX/HhIJ6Y/DmGvqRmbCcWlyWb6QEZmOLDVYIAMb
         ZOigZ3apQkqPsiX5oIiBDfr+HNNgV1Ka/dMlqINaIexKEpRUWuIbU8BysGwQV8HOQjVP
         pz0nymKNX4zD2GkbyntW2K7qJVkhBV1bMVkltQHP6gl3CXW1FC5xYvmUyy0ns68M3dfo
         iK00b7qU0ajNIG41A2Fp+p7Sp9eLrvri6d4NcNoEYF5jtFRdgP/NnqwNZcEqSU2YXSap
         ghdBlC3FRSc3+1eh0ZVEqQlDJlvPq7t4E5zREK8iiNOGWmjzHrlgow5P7QLQlx17wwbx
         WgOw==
X-Gm-Message-State: ANoB5pk1/rsoCLWE6T9nPi6wLxySwltitQAx+0DHkHLsK01HvF1S8zIB
        7eCe5I5kan6tkcHUK4t6TSTR98EsKKFuww==
X-Google-Smtp-Source: AA0mqf5StXZ782w66Qzb/V0rcQlo3ii3ufURCGQhpC+jQ2YjK4fU0jnh4S3/0pSbDzD19z9EVs3n/g==
X-Received: by 2002:ac8:5f8e:0:b0:3a5:8591:7037 with SMTP id j14-20020ac85f8e000000b003a585917037mr8149958qta.47.1667899022354;
        Tue, 08 Nov 2022 01:17:02 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85313000000b003431446588fsm7838177qtn.5.2022.11.08.01.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:17:01 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id o70so16640567yba.7;
        Tue, 08 Nov 2022 01:17:01 -0800 (PST)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr50040680ybb.604.1667899021215; Tue, 08
 Nov 2022 01:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107171809.2797499-1-biju.das.jz@bp.renesas.com> <20221107171809.2797499-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221107171809.2797499-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 10:16:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaY5j--jSc2WUZ=Mmyr83RFvNiTNXKzv3fUSPk9wsKqQ@mail.gmail.com>
Message-ID: <CAMuHMdVaY5j--jSc2WUZ=Mmyr83RFvNiTNXKzv3fUSPk9wsKqQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] pwm: Add support for RZ/G2L GPT
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Mon, Nov 7, 2022 at 6:18 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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
> v9->v10:
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.

Thanks for the update!

> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c

> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +       DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);

[...]

> +       /*
> +        *  We need to keep the clock on, in case the bootloader has enabled the
> +        *  PWM and is running during probe().
> +        */
> +       *ch_en_bits = 0;

bitmap_zero(), which will be optimized to a single assignment.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
