Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC80270E84
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Sep 2020 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgISOZK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 19 Sep 2020 10:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgISOZK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:25:10 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E4D21582;
        Sat, 19 Sep 2020 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600525509;
        bh=kHRkKnYP82SMnFqUKvGenb2khehyXzI7WLF+nQ+tzgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2oYZ4BVC2fLdI6wdQldYFviXX+QrY8yA0ESlee7qs0Kg3rxm+3/6PF7RDdoanWhzk
         7SCrbarFFlCxPmeN8jVVYZ6eN2Dx0WuxN9pBX7Bej1bF3XrffumU+pypQxtnac8AZo
         1o0OYgAJM/AzKyeyqbeC+5fYnJHhdKDn1nORlUAE=
Received: by mail-ej1-f50.google.com with SMTP id r7so11824075ejs.11;
        Sat, 19 Sep 2020 07:25:09 -0700 (PDT)
X-Gm-Message-State: AOAM532oRJHdcR+yYRD/+FzSvaJSpRXr9lctERxcnRkNsxrPBQ9JP2RJ
        cRn2Nzdz5QLi/RRmIX6NtWC3RAaQZv6d2xxPMe0=
X-Google-Smtp-Source: ABdhPJxqLwyyHgA5Kx4Q6V81m6PRoMJ6U0hi/KURq0qDLpn+NftnXz1sAVg2ynpJvB3sE/6Veg68lbEq0jaBtPYIvhc=
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr43178032ejj.148.1600525507972;
 Sat, 19 Sep 2020 07:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152404.20636-1-krzk@kernel.org> <20200904152404.20636-8-krzk@kernel.org>
 <81a8248f-0d02-5646-36b2-5d4c3a7c4211@linaro.org>
In-Reply-To: <81a8248f-0d02-5646-36b2-5d4c3a7c4211@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 19 Sep 2020 16:24:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdJhfUsTqrTCouF+xQ1ChBWipBc6UaOBbewSPfrEw9Mtg@mail.gmail.com>
Message-ID: <CAJKOXPdJhfUsTqrTCouF+xQ1ChBWipBc6UaOBbewSPfrEw9Mtg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] dt-bindings: thermal: imx8mm-thermal: Add i.MX
 8M Nano compatible
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 19 Sep 2020 at 13:48, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/09/2020 17:23, Krzysztof Kozlowski wrote:
> > DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> > to fix dtbs_check warnings like:
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
> >     compatible:0: 'fsl,imx8mn-tmu' is not one of ['fsl,imx8mm-tmu', 'fsl,imx8mp-tmu']
> >     From schema: Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
> >     compatible: ['fsl,imx8mn-tmu', 'fsl,imx8mm-tmu'] is too long
> >
> >   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
> >     compatible: Additional items are not allowed ('fsl,imx8mm-tmu' was unexpected)
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
>
> Shall I pick this patch separately or did you merge the entire series ?

Thanks. Rob already picked this up.

Best regards,
Krzysztof
