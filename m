Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F632F2A55
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jan 2021 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392422AbhALIuK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jan 2021 03:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbhALIuK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jan 2021 03:50:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60783C061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 00:49:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so2123984lfg.10
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 00:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FO2rHm6UIMBu9Ki7Nf6OHymZ0+n2eoWJ/J9V6P3/8h8=;
        b=Gltf9TvRNOY0tSXrxiA4//zhOlERkD6r2FC2saFGS8t3sVaO5mcxegCfTZD0F5W+Ts
         8jcW3Nn/LZYgx7pT9L5qHEYSn+ZgO8cjuieFlIfq/7Fw9l6Ycc68mGr+U9mSVfennApU
         QHG6BQH6tL/5exf95jdd5lx+1pIc1Y8TSffGP+JxkGa0a7ZRAVklVOdGlHOXBlPIz6E/
         tnuzBJzCPgW7gkttsauSu26m+t2ixMU8Qn/fmAlctF8UbDwkJl0P65oBiS99ZahFXu8F
         gPDE+2CqbYla3vIJU4tbLTB1a4ckbCNhONdSmNqCHzc9jckjH45DzyQqd+Vlz1CSUMap
         C5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO2rHm6UIMBu9Ki7Nf6OHymZ0+n2eoWJ/J9V6P3/8h8=;
        b=AhnlIgOg3BzsL3/DuG1F4M9uzNAqCa0T9Ev4NZ2dcFvGOK3M/7CS0ZfxhullgsQV+E
         wGPG2wS0pGU5jS7ibI1aKweUQ92to9X2YJaqZA/eytBVqr30xUrNIJegjjQuY5/lpoZ+
         qLoFy6AWZ8ubKp/V626Tj/oDVdYbeij8vMUyZQ2UUSeG0RLpAy9VShwQVbM4SgglWOZ3
         PEE+/VBQq5Lx6QX9nEvitFwyWxRo7PRxmYbadi8IpUDILJPfl6Eoj/zzte3wuoD8A5Vg
         40x1bLUXdh/15NQwn7fkgNc4Z7naSzYcYfdHT0706FvOLU5hNVfL+KTtXs24uGSdMMEu
         CgEA==
X-Gm-Message-State: AOAM533coYVxNPT6Lol8yDFdmhDdXrWKin0TZaTMN89ieYAMq4l7CUnX
        Goc7zykFvT2YZqd7/Iry1pUXtmD49XSZG4N5aa1VOw==
X-Google-Smtp-Source: ABdhPJx8LV4CvQbya9pzC+Y865mc9FHowA10/ILhkSPbVdtQrtK5X8N9YI7+9he1ztb2VQ2P7WL2X6F4KIkvfb6LwpQ=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr1601550lfg.649.1610441367919;
 Tue, 12 Jan 2021 00:49:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610364681.git.baruch@tkos.co.il> <5e1b119a51df19ead32561e87ce2ee1441b67154.1610364681.git.baruch@tkos.co.il>
In-Reply-To: <5e1b119a51df19ead32561e87ce2ee1441b67154.1610364681.git.baruch@tkos.co.il>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jan 2021 09:49:16 +0100
Message-ID: <CACRpkdZAHpcgzXSJKZyQjBOriALZUoXbw_hBpPa_zxa27=F0hg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] dt-bindings: ap806: document gpio
 marvell,pwm-offset property
To:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Baruch,

this caught my eye:

On Mon, Jan 11, 2021 at 12:47 PM Baruch Siach <baruch@tkos.co.il> wrote:

> Update the example as well. Add the '#pwm-cells' and 'clocks' properties
> for a complete working example.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

(...)
> +Optional properties:
> +
> +- marvell,pwm-offset: offset address of PWM duration control registers inside
> +  the syscon block
(...)
>  ap_syscon: system-controller@6f4000 {
>         compatible = "syscon", "simple-mfd";
> @@ -101,6 +106,9 @@ ap_syscon: system-controller@6f4000 {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 gpio-ranges = <&ap_pinctrl 0 0 19>;
> +               marvell,pwm-offset = <0x10c0>;

This seems to be one of those cases where we start to encode things related
to the hardware variant into the device tree.

Is this just documenting ABI that was introduced in the past and we can not
do anything about now? In that case it is OK I suppose.

For a new binding we would certainly require that the system controller
provide a specific tertiary compatible string for this, lest we disguise
the not-so-simple system controller as "simple-mfd" so:

compatible = "syscon", "simple-mfd", "my-silicon-id";

Then detect the PWM offset by using
if(of_device_is_compatibe(np, "my-silicon-id"))
in the code rather than parsing any marvell,pwm-offset property.

Yours,
Linus Walleij
