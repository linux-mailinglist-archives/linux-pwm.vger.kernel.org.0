Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92452CF42
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiESJWT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiESJWS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 05:22:18 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD795EDE9;
        Thu, 19 May 2022 02:22:18 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id e17so4159447qvj.11;
        Thu, 19 May 2022 02:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhgeFeFRdUIRyT22DJNAUqQPg1LuURq1ZxTL89j+zr0=;
        b=FcNrX5wgdhQd/q+T0+lGP3HcU7k3h9xdWB8OPPdRN6pqSyIjhs0ND5fx4Wmdmp5OQM
         XZ4W32iw0Si5srQEGqPQzg53bmUroDEjbtYNZvrihnKj7/nfOJo4BPLNDJFgDSSlmyEw
         TpoEH2t2eDvtsw/bDrq7k7wICbuNC6YbJgcwfcuZiYsrOXQXNquPa21ALUGmJOXgqL8b
         m9b3Vjd0Zi9AvKU1dNRHzl8Zrp7FVcdr73ypACAPdyKB2qPPVUcVeFPwGna75/H2eEIa
         lfz835znLyuMW+GIxSQ4WPcN5GP9ErrnJUj6b1M0vG6sGZy5EnX/kZzTHIrMlsdhr5rz
         zVMA==
X-Gm-Message-State: AOAM532gJ2xKohV4TVVJIpp4d/dY8f0v4a+ni5wx/oBBjRBzZddkdVXp
        2GjYx4+o0Hc0iqT8ifW6LNIfT7MpTEwrrg==
X-Google-Smtp-Source: ABdhPJz90Dkd9ReTleX7N5nHwtTOPeEUXpy47U3uQHM3pHxZ8KafNP/NmA/xu3d7oUzldhHgIIQViQ==
X-Received: by 2002:ad4:5d6a:0:b0:461:cadb:b77 with SMTP id fn10-20020ad45d6a000000b00461cadb0b77mr3104760qvb.58.1652952136965;
        Thu, 19 May 2022 02:22:16 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bs26-20020ac86f1a000000b002f39b99f6bdsm982848qtb.87.2022.05.19.02.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:22:14 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ff155c239bso50893407b3.2;
        Thu, 19 May 2022 02:22:13 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr3661559ywg.316.1652952132631; Thu, 19
 May 2022 02:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com> <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 11:22:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUQ9FeaSO97-HhbL4fcxCKt1qb_d1R_L=-BxGH7x23yg@mail.gmail.com>
Message-ID: <CAMuHMdXUQ9FeaSO97-HhbL4fcxCKt1qb_d1R_L=-BxGH7x23yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Tue, May 10, 2022 at 4:43 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add device tree bindings for the General PWM Timer (GPT).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpt4: pwm@10048400 {
> +        compatible = "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
> +        reg = <0x10048400 0xa4>;

0x100

The rest looks good to me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
