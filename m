Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33F64B749
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 15:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiLMOYX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 13 Dec 2022 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiLMOYT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 09:24:19 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA801EADF;
        Tue, 13 Dec 2022 06:24:18 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id h16so11913438qtu.2;
        Tue, 13 Dec 2022 06:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0jEotrptLhX70qm2KsIOI53cs0q1LQcHTE7sl9TrjM=;
        b=AbD6XBGEO/8Dm8/4C1V1gy4u3W3IjOgITfkafYLHzb8S+s35vlZvXT+A1FmSgZb8Xd
         Jj+u8dJS/ViWgoNiq4SiLLVtSIP2i3CvFumUtOhKPYXRfXL3gau2Ngyh4V/XZvjSLbEb
         eDbB6nKGR3Ze1SN2DMdfkiMatjYq3ZgT6AtfXyAi1YGC4FQ1YZxIbT2uYpINncNrDcPJ
         yRhZHsBYiO97xHLnjUIpgqWmYpML1Jk9SqHoLL3g0xrGur6KsnJlZT2HV87M+6wcVAu1
         KrncXDD2O58TPc6MOdKa4330KVLju/gyZzTQlG9jVV7WlWBOxg+nKsGlHhN0qd313bf/
         qurA==
X-Gm-Message-State: ANoB5plCKfuq+/swYEnPcIkbXOuoqN9UnKuv0uq3x8NdKeMgOEAfSkkc
        18giVZIkPo/84ScN+dKJRVT3ZmOAUsUnyQ==
X-Google-Smtp-Source: AA0mqf4nuUgdATqwcuqybJR6VllYf8g5pGS6miS+iYMtJHsD8n3g0I83EqlKNt/Rvv9AvppIn9HoIA==
X-Received: by 2002:ac8:1194:0:b0:39c:dbaa:fa08 with SMTP id d20-20020ac81194000000b0039cdbaafa08mr25724220qtj.42.1670941457426;
        Tue, 13 Dec 2022 06:24:17 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z11-20020ac87cab000000b003a7e4129f83sm7572194qtv.85.2022.12.13.06.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:24:17 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id i186so17765002ybc.9;
        Tue, 13 Dec 2022 06:24:16 -0800 (PST)
X-Received: by 2002:a25:9:0:b0:6f9:29ef:a5ee with SMTP id 9-20020a250009000000b006f929efa5eemr38476139yba.380.1670941456572;
 Tue, 13 Dec 2022 06:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20221111162325.471963-1-biju.das.jz@bp.renesas.com> <20221111162325.471963-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221111162325.471963-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Dec 2022 15:24:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzT7=xT1nJ9o7eSgzUGu5vb1c=gWg=CgJ9Ay1tmJgpDQ@mail.gmail.com>
Message-ID: <CAMuHMdUzT7=xT1nJ9o7eSgzUGu5vb1c=gWg=CgJ9Ay1tmJgpDQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] pwm: Add support for RZ/G2L GPT
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

On Fri, Nov 11, 2022 at 5:23 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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
> v10->v11:

> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c

> +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                               struct pwm_state *state)
> +{

As of commit 6c452cff79f8bf1c ("pwm: Make .get_state() callback return
an error code") in pwm/for-next, this needs to return an error code
(but you probably already know).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
