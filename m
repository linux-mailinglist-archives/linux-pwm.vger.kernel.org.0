Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08A67B721
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jan 2023 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAYQqk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Jan 2023 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAYQqi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Jan 2023 11:46:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114159564;
        Wed, 25 Jan 2023 08:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 287156155C;
        Wed, 25 Jan 2023 16:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFFAC433D2;
        Wed, 25 Jan 2023 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674665195;
        bh=xfla28zJBRsWQXlBseFrkXF56zvwRirAY/10+O6Gusg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dlm6sDlROFpggiDg+SA67d6opXGecZCzhdxg7YeK/ToJXgpYMtPrjPZnPNswbiNQO
         RU3i9whhAz/orOrH/Z4Xhfgiu7svabkuoqJJVe1CZPd/YtzbF3Sf3JwH5fz+1Lprny
         IECDs6KubJB6cjehtcbUdoveg5kLh++iTN88G+VafS9z9QzecwVqV/O9lIbT71yZ/O
         1W2efdb1/nLx8hsKhQWusZmyC+4ymleM7BeWWBXD0PKd5r6CvzX6tK34fPYZWJfhoM
         HNHspSWjR/GPEKJ/iHfjDgV3Eji7kG6zPNztQO9g2YsyMR8LOqzu+gNxwDKD3FLm5I
         YmOW1D8PfpcDg==
Received: by mail-vs1-f51.google.com with SMTP id k6so20378731vsk.1;
        Wed, 25 Jan 2023 08:46:35 -0800 (PST)
X-Gm-Message-State: AFqh2kr7Q33XUvaQamy8B7FHagWBB5ubhPrA7gOSgCnGwyKQS906V1W3
        AzeKVVn80aQaeDTmJbjg89ZPvCQiIOAvFYsjQA==
X-Google-Smtp-Source: AMrXdXukkClxVJmORCFGUtNIYT840ix5e1Pd5Glna3rS2gUNazjUpgsHwDnIQtt7qoedMPCgyP02fjS7IrIEoFB0Z1Y=
X-Received: by 2002:a67:f506:0:b0:3d3:c767:4570 with SMTP id
 u6-20020a67f506000000b003d3c7674570mr4933608vsn.85.1674665194514; Wed, 25 Jan
 2023 08:46:34 -0800 (PST)
MIME-Version: 1.0
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <06289641-18b1-320d-6162-7ae176452f31@gmail.com> <167452325371.3118653.16373677195744392136.robh@kernel.org>
 <d8f0a5a9-5a16-1f63-8444-86434ff52e34@gmail.com>
In-Reply-To: <d8f0a5a9-5a16-1f63-8444-86434ff52e34@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 10:46:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgo65fiE8+dzMHNRu3XJ8eBm43w8MoQdCwwm2zvxJeFA@mail.gmail.com>
Message-ID: <CAL_JsqKgo65fiE8+dzMHNRu3XJ8eBm43w8MoQdCwwm2zvxJeFA@mail.gmail.com>
Subject: Re: [PATCH 7/8] dt-bindings: interrupt-controller: Add Amlogic Meson
 GPIO interrupt controller binding
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 24, 2023 at 1:04 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 24.01.2023 02:22, Rob Herring wrote:
> >
> > On Mon, 23 Jan 2023 22:30:08 +0100, Heiner Kallweit wrote:
> >> Add Amlogic Meson GPIO interrupt controller binding.
> >> Tested with make targets dt_binding_check and dtbs_check.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  .../amlogic,meson-gpio-intc.txt               | 38 ----------
> >>  .../amlogic,meson-gpio-intc.yaml              | 72 +++++++++++++++++++
> >>  2 files changed, 72 insertions(+), 38 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> >>
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
>
> Patch 4 of the series fixes these warnings.

Then you can ignore them.

You did change the binding somewhat and that should be detailed in the
commit message. Granted, the original details on 'compatible' seem to
have a typo and are ambiguous on the order of entries.

> Did you apply the full series?

No, because patchwork doesn't get the full series nor do I see the
full thread when reviewing these bot emails before sending them. If I
see a conversion and warnings that look like the schema should be
fixed rather than the dts files, then you get this email. Though on
further review, dropping 'amlogic,meson-gpio-intc' seems fine given it
is often in the wrong spot (it should be last as it is least
specific).

Rob
