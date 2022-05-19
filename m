Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284F52CF23
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiESJP1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiESJP0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 05:15:26 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC857117;
        Thu, 19 May 2022 02:15:24 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id y15so102232qtx.4;
        Thu, 19 May 2022 02:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfcRoMNgXbpbp4lEQmFgNamkdeleq0kQBl4tE1oou8s=;
        b=6G4U2SLbnqeveTm5aQJb04sPcgL8mKR2j00411L/rvipHmSvoLfYd1mmaddNj9l36V
         niVp4+UQdwjLOEhcHeGHuo8yLX723agpLmyByImYt0+Vd4Cpnmm5ksuUWWpnE9zkCIUP
         A1i65dll/bt84YPGaaWccqenN6UB7huykK3V0uqR0bawC1UTqcgK19oUV+jyo/5QHPbo
         cwnHLaWR/yTh4QsLBWPOlohe9pEEgYQ/2OagBppTRVk/kI3xsG7sGP2lUozVcVFPg3m9
         A7IUJgJdCi9XOi6ZdxnOyg8dGsCxaGqJkd3LzIwZHuT3enBXYvtFbeEdeTQOFdKSq4C7
         Ee8g==
X-Gm-Message-State: AOAM531NpBbX3DVt+e3xVls/t/My7dmlB5J6+mKq0d39IbE2/qOQZfRr
        FClakGfuNxEJODsmufZq3PfFV8/z39jqEA==
X-Google-Smtp-Source: ABdhPJzX78567TB++gq69F0NXTfesOnt2zqRIwBdjK7VzT2Tg7qWUTLQ+ykv4fb7ZWIM0w4Yq2Nluw==
X-Received: by 2002:ac8:4e8b:0:b0:2f9:cae:cc8b with SMTP id 11-20020ac84e8b000000b002f90caecc8bmr3043171qtp.590.1652951723323;
        Thu, 19 May 2022 02:15:23 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id cp3-20020a05622a420300b002f3d7c13a24sm986120qtb.4.2022.05.19.02.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:15:22 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e78so7921696ybc.12;
        Thu, 19 May 2022 02:15:22 -0700 (PDT)
X-Received: by 2002:a25:4150:0:b0:64d:7747:9d93 with SMTP id
 o77-20020a254150000000b0064d77479d93mr3498425yba.36.1652951721872; Thu, 19
 May 2022 02:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com> <20220510151112.16249-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220510151112.16249-5-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 11:15:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoQ9rjOuubLYb=6j_LP=qVeG+u0nxmqh_Pkr+jDPWLUw@mail.gmail.com>
Message-ID: <CAMuHMdVoQ9rjOuubLYb=6j_LP=qVeG+u0nxmqh_Pkr+jDPWLUw@mail.gmail.com>
Subject: Re: [RFC 4/8] pwm: rzg2l-gpt: Add support for linking with POEG
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Biju,

On Tue, May 10, 2022 at 5:11 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> This patch add support for linking POEG group with pwm, so that
> POEG can control the output disable function.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -266,6 +291,36 @@ static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         return ret;
>  }
>
> +static int rzg2l_gpt_parse_properties(struct platform_device *pdev,
> +                                     struct rzg2l_gpt_chip *pc)
> +{
> +       static const u64 poeg_grp_addr[] = {
> +               POEG_GRP_A_ADDR, POEG_GRP_B_ADDR, POEG_GRP_C_ADDR, POEG_GRP_D_ADDR
> +       };
> +       struct device_node *np;
> +       unsigned int i;
> +       u64 addr;
> +
> +       pc->poeg_grp = GRP_INVALID;
> +       np = of_parse_phandle(pdev->dev.of_node, "renesas,poeg-group", 0);
> +       if (!np)
> +               return 0;
> +
> +       if (!of_property_read_u64(np, "reg", &addr)) {
> +               for (i = 0; i < ARRAY_SIZE(poeg_grp_addr); i++) {
> +                       if (addr == poeg_grp_addr[i]) {

Matching on addresses looks fragile to me.
Of course this is code, not DT, so it can be changed later.

Possible alternatives:
  1. Use a numeric property instead of a phandle, so you can store
     its value directly into pc->poeg_grp.
     This loses the linking by phandle, though, which is nice to
     have, and might be useful for other purposes later.
  2. Add a "renesas,id" property to each POEGx DT node, cfr.
     Documentation/devicetree/bindings/media/renesas,vin.yaml.

> +                               pc->poeg_grp = i;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       if (np)
> +               of_node_put(np);
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
