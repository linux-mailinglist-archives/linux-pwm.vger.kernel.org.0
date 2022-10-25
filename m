Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E160CE71
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Oct 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJYOJ1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiJYOIk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 10:08:40 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4F61D72;
        Tue, 25 Oct 2022 07:05:38 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id a18so8124609qko.0;
        Tue, 25 Oct 2022 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X8nB5/AZOS66cfbKQk4GVxepBXIbJtRuh++PxkedrA=;
        b=RKt8YcKykocPWquaqO0zSER2XVdlKsHZSlTpDXOuNCo5qW4Hw7UlvGEa+4cv9QfWYl
         L3RWSJWzq/JgsxM/XwXUcfulm44wNhagfc/hHpFNJDcTdL+gofyxAS4nUIIAKakItXIP
         BDjPUlyapjMfQpHFZICxxUKEjFFvCU3Wu1/y8W33HVe8SDIELUu3b6a6K55/PL5onQ95
         4Y+135NrWO4Q7l3tUm68WfYYFnr4QgrOEUhhoM+C6sxXl+GZpjn/3Nb/26P9CMGTh72i
         fF6GOEmFnGs8kdbO4f6WZf/7hWZHJdXi4jCcUNtJf6iRd9KJo9Uzzvrt03csuy3TfE49
         FEQA==
X-Gm-Message-State: ACrzQf2AbKGK/H3hlKk0MRTMHUXePTLEkG2hAN260f1l+2aZZ/D+HVC1
        En4LRDCg0CB3wHxdoVLIIMWhvZUtgXOUDQ==
X-Google-Smtp-Source: AMsMyM7ubVxdbk5CpYdPw6e87ZWbRmiibLCdDubYIp2ofg15JXCPhDvSJeGKml4Yd07IuAqsToni5A==
X-Received: by 2002:a05:620a:66a:b0:6ee:83d0:7896 with SMTP id a10-20020a05620a066a00b006ee83d07896mr27201597qkh.81.1666706737618;
        Tue, 25 Oct 2022 07:05:37 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id k11-20020ac85fcb000000b0039953dcc480sm1648767qta.88.2022.10.25.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:05:37 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id m125so1504992ybb.6;
        Tue, 25 Oct 2022 07:05:36 -0700 (PDT)
X-Received: by 2002:a25:d24a:0:b0:6ca:4a7a:75cd with SMTP id
 j71-20020a25d24a000000b006ca4a7a75cdmr23773016ybg.89.1666706736362; Tue, 25
 Oct 2022 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com> <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 16:05:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWE+H=aXkt61hZK6mbQairwdk1F522mZRemC0T5LxQtMg@mail.gmail.com>
Message-ID: <CAMuHMdWE+H=aXkt61hZK6mbQairwdk1F522mZRemC0T5LxQtMg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 10, 2022 at 4:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add support for RZ/G2L MTU3 PWM driver. The IP supports
> following PWM modes
>
> 1) PWM mode{1,2}
> 2) Reset-synchronized PWM mode
> 3) Complementary PWM mode{1,2,3}
>
> This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver
> by creating separate logical channels for each IOs.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1994,6 +1994,12 @@ config MFD_RZ_MTU3_CNT
>           SoCs. This IP supports both 16-bit and 32-bit phase counting mode
>           support.
>
> +config MFD_RZ_MTU3_PWM
> +       tristate "Renesas RZ/G2L MTU3 PWM Timer support"
> +       depends on MFD_RZ_MTU3

depends on PWM || COMPILE_TEST

Note that currently the build fails if CONFIG_PWM=n.
I have sent a patch to fix that
"[PATCH] pwm: Add missing dummy for devm_pwmchip_add()".
https://lore.kernel.org/r/12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be

> +       help
> +         Enable support for RZ/G2L MTU3 PWM Timer controller.
> +
>  config MFD_STM32_LPTIMER
>         tristate "Support for STM32 Low-Power Timer"
>         depends on (ARCH_STM32 && OF) || COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
