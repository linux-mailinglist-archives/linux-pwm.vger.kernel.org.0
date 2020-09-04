Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403625E3B1
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIDW31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 18:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgIDW31 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 18:29:27 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA67208C7;
        Fri,  4 Sep 2020 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599258566;
        bh=+8dgVfOXgmURomqOzPuR2s0d+0XktF+kVIZ4JamC1Yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPfVtLk3VgVy9YY2bppjWvDV2nvJ00oTy/jZPGsp1pSsT+kcmQKDELrZFVKOe/MW4
         zJ45aqs0sB4ogJLfi9CwwVOS1v0zgXZFL4fluzz0xaGojKmgqLJSTmIwDbIBjLZCDs
         e36mpUibGpzlRequFLGXPuBTspvr9u7SNO8bieYo=
Received: by mail-ot1-f53.google.com with SMTP id g96so7253810otb.12;
        Fri, 04 Sep 2020 15:29:26 -0700 (PDT)
X-Gm-Message-State: AOAM530HI8S9w97j5PgXqi3vtRBxS4qaUMIMg4IDLgsN+4mUyfAvzmGg
        1lBYOqogNOdrbP+dn0+qOhkmDJ2fNHZwlCDxBg==
X-Google-Smtp-Source: ABdhPJyg8Cu0lq2UsQBYhJV227Jo2feqOcJKLxrdCLPxr9lVLm9MUPpbfMcEDGy7OIP/8N+4iwU7/9VeNN4vhk5EUSE=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr7261177otp.192.1599258565768;
 Fri, 04 Sep 2020 15:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152404.20636-1-krzk@kernel.org> <20200904152404.20636-14-krzk@kernel.org>
In-Reply-To: <20200904152404.20636-14-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Sep 2020 16:29:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOkerY14qc-7e5721Xsp0k6jm9oh1U1Lr-3SZA0HFgjw@mail.gmail.com>
Message-ID: <CAL_JsqKOkerY14qc-7e5721Xsp0k6jm9oh1U1Lr-3SZA0HFgjw@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] dt-bindings: mtd: nand-controller: Fix matching
 with size-cells==1
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 4, 2020 at 9:25 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Most of Freescale/NXP GPMI device trees use size-cells==1 (even when
> actually not needed except few boards).  This fixes dtbs_check warnings
> like:
>
>     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: #size-cells:0:0: 0 was expected
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 40fc5b0b2b8c..0879e1108837 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -34,7 +34,10 @@ properties:
>      const: 1
>
>    "#size-cells":
> -    const: 0
> +    description:
> +      Depends on your controller. Put zero unless you need a mapping between CS
> +      lines and dedicated memory regions.
> +    enum: [0, 1]

Humm, seems that was to describe partitions, but the expectation of
the nand binding is describing nand chips. It seems the nand chips are
never described and on 1 board even has partitions. I think you should
fix the dts to move 'partition@N' nodes under 'partitions' which is
preferred and needed if you ever describe nand chips. And then fix
'#size-cells' to be 0.

Rob
