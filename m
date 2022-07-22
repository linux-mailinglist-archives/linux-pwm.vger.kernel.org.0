Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA157E5CA
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Jul 2022 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiGVRpx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Jul 2022 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGVRpw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Jul 2022 13:45:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296502C66C
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jul 2022 10:45:51 -0700 (PDT)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B4D33F133
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jul 2022 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658511949;
        bh=+MBkXW0LeP92A9MOeqdeUTIUyNCajZyEzKLEvm/heRc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=H543RZtfjZRrfmnBr07CcQ1063rRRUM/i3VIL3MMkxlD02xR4QKQ/GL/DDBvBmhj/
         Kc9KWrerZaYZ8uPBtNiMduC4GowdLgntoACkDCu4GyCbDm7NmenXm0ca1IieyKaW3f
         mRV8szv0SRPY8MZPcGAMw8M/hwNqS1Hga3va3Lg41/33Tio3XpQlOOoq4zw4H4Vuxu
         Tx7OQnoHVZTNOBQsgpnu3SujCI5lkANzPnrXtb74OldLLtbN/fcBx4BgZ2bExAUnGs
         R1MSChCdG7aB5gbR+qsRSBMcHkFzKvtD07C7wguyCrU5bCmFWphQFmyOlW+G5f7dCH
         HYnRfLrws/PfQ==
Received: by mail-qv1-f69.google.com with SMTP id eq6-20020ad45966000000b0047405c4e6ffso3430765qvb.17
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jul 2022 10:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+MBkXW0LeP92A9MOeqdeUTIUyNCajZyEzKLEvm/heRc=;
        b=FdG4D95FOAH3OdZJlUW1OOMDE2uYZ4qWoSq/y4kpIV5eyycDWqOBH/8nVbEgwNIZbS
         ulwsh/4f2n9IuKGn58Lb3To64KaUiNrCGp+zN4wi9LMLc/xFBrOuCmNZyGKiJ9Utf2yc
         APruGV6fRZQWQW+iDf+Xa74WuCumfX7clX+PAkTWj61KnVmYaptMQud423N1A7wcPeK3
         GDjIeaFZ5pN4qbBzwAoB0Jo9B1nTtccGDBrI62Q6SIKdoVkOk+Q8KVT2u4jpEgy4V2Pp
         imFXCVl23khr2858CUk7toNF2WGi+x/bbh/aFFGGiw2BYkJpT+UCj/s8aUqIZB6gcFPS
         F4eQ==
X-Gm-Message-State: AJIora/OF46Bl7bIxJMQ78R9oyo8Fz7glFPKuPqAZyrUodsagR0e2TjW
        RFMnYKiQXS2rEjotQ6m/CsGjcrtIOl/vj4JdDCsh8S1mcv2P91MgwNn7WdOjvUzTpCG6bO31ZCB
        AXrVYDOBPlo3cUW7WGMYg88aILLEHSKrIIsFnuI3ciJx2UrWla8/ZLA==
X-Received: by 2002:a05:6214:d84:b0:473:3106:a97d with SMTP id e4-20020a0562140d8400b004733106a97dmr1122360qve.112.1658511948381;
        Fri, 22 Jul 2022 10:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uqu2/88oFu6K+6x70N3LDOqiqst44RokKg0M3zpdZRePRJs/gIxxH+9Ul/p9UTIPUto5kx29jisV8jOPUWtjA=
X-Received: by 2002:a05:6214:d84:b0:473:3106:a97d with SMTP id
 e4-20020a0562140d8400b004733106a97dmr1122347qve.112.1658511948205; Fri, 22
 Jul 2022 10:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de> <20220721103129.304697-7-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220721103129.304697-7-u.kleine-koenig@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 22 Jul 2022 19:45:32 +0200
Message-ID: <CAJM55Z_+AOmyFs-QgaQdnk4m7SN=JMcszjG+mtANzBcWkGYBkQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] pwm: sifive: Shut down hardware only after
 pwmchip_remove() completed
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 21 Jul 2022 at 12:32, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The PWMs are expected to be functional until pwmchip_remove() is called.
> So disable the clks only afterwards.
>
> Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Hi Uwe,

You didn't send a cover letter so unsure which mail to respond to, but
I tested this series with

https://lore.kernel.org/linux-riscv/20220705210143.315151-1-emil.renner.ber=
thing@canonical.com/

..and everything keeps working, so

Tested-by: Emil Renner Berhing <emil.renner.berthing@canonical.com>

/Emil
> ---
>  drivers/pwm/pwm-sifive.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index da40ade0ebdf..2d4fa5e5fdd4 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -308,6 +308,9 @@ static int pwm_sifive_remove(struct platform_device *=
dev)
>         struct pwm_device *pwm;
>         int ch;
>
> +       pwmchip_remove(&ddata->chip);
> +       clk_notifier_unregister(ddata->clk, &ddata->notifier);
> +
>         for (ch =3D 0; ch < ddata->chip.npwm; ch++) {
>                 pwm =3D &ddata->chip.pwms[ch];
>                 if (pwm->state.enabled)
> @@ -315,8 +318,6 @@ static int pwm_sifive_remove(struct platform_device *=
dev)
>         }
>
>         clk_unprepare(ddata->clk);
> -       pwmchip_remove(&ddata->chip);
> -       clk_notifier_unregister(ddata->clk, &ddata->notifier);
>
>         return 0;
>  }
> --
> 2.36.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
