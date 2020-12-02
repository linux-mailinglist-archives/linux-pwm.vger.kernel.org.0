Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACA2CBB3F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 12:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgLBLKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 06:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgLBLKW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 06:10:22 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D524C0613D4
        for <linux-pwm@vger.kernel.org>; Wed,  2 Dec 2020 03:09:42 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so3407520ejb.13
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2020 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkjayID1bacGI3D2LpsWO7PkJQbjpWl13AmgYb8xoyM=;
        b=IUuvPpLBlNblbK5neUzp/EdZt5S1DqLy+A6+TRfqrlJbap/auT1Eey4GqE5BeB1Nin
         mdt8iX8/lGN6guZPauFwXMOsZ6Lei8azgdSxJ5fGG4ly6GOLwXzYiH/2CbVYJ8aEp7t9
         Qy0C00XG4WUhdcjYHUnySSO6lZdNylCY4TZKng+kk8N/X+UoDqj0xppe/XoaXWqddaWM
         eAtx8DXilcoYZmp5otJWJ2dhd+tkxTMW/vJutiwQZcY4YiZ6HGoMEAFFxYl50HxpDvEk
         c057Am9zcAjT0f8jiDF8rNl/AUr7McIVVO/QRfSBLCQHN9yM71EaNMTGUJuNORgf+XFW
         VGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkjayID1bacGI3D2LpsWO7PkJQbjpWl13AmgYb8xoyM=;
        b=SnLAHgqoXXMnj/14zLPOmV+HjvSkgm30KWv0l39EnqwoR3AaYH7lqKNCG9JGBNnfEH
         nFQ6XUbsBrJm0yKIuxR2T13I1tc5LF/VmbWf3gFgBQWkdz98pqyoLI1TkmVId5+42nh0
         p+rVYwQeyNiJyaqfQtgmHjixJVuR0V8Mm39Tm8dQ8N7HzYsyUShrJN1viw/zSywi9SdF
         EYKt9fUsXh6FZAgZpLdoO3RrVOq3Cu/Zem6t/xvZO0Ltz2GFsD0SpjCt9ZO+FdvnLWVl
         dlCtSjSx1o2+wUaW3tbtYgSLF89q6Xt559AGHFTNOfDAJO89Ttt6064SCOErx1t1rYZc
         pvDw==
X-Gm-Message-State: AOAM533DPBpWdgMe6XSoFBcUYGA7PKX0rjdfuvzrLQZZBVTwkCWpCvEL
        CxqulESUDwdyH3busJOaFjf9cnX6T7wsl1Gp3rPoiQ==
X-Google-Smtp-Source: ABdhPJyoW3ukAFLWS2eFHWy5P8lGecQCG3b/+GZaX4VSojbsz7P6Ia+rhxD7iAMnNmfiDHt3omb139v6iYUBQYuQzHI=
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr1777464ejl.155.1606907380986;
 Wed, 02 Dec 2020 03:09:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606892239.git.baruch@tkos.co.il>
In-Reply-To: <cover.1606892239.git.baruch@tkos.co.il>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 2 Dec 2020 12:09:30 +0100
Message-ID: <CAMpxmJV90Or-CHV9bZX9Z=Y5rES4y5BaNdtXq4r91e4p4S4Cjg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] gpio: mvebu: Armada 8K/7K PWM support
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 2, 2020 at 8:15 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> The gpio-mvebu driver supports the PWM functionality of the GPIO block for
> earlier Armada variants like XP, 370 and 38x. This series extends support to
> newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.
>
> This series adds adds the 'pwm-offset' property to DT binding. 'pwm-offset'
> points to the base of A/B counter registers that determine the PWM period and
> duty cycle.
>
> The existing PWM DT binding reflects an arbitrary decision to allocate the A
> counter to the first GPIO block, and B counter to the other one. In attempt to
> provide better future flexibility, the new 'pwm-offset' property always points
> to the base address of both A/B counters. The driver code still allocates the
> counters in the same way, but this might change in the future with no change to
> the DT.
>
> Tested AP806 and CP110 (both) on Armada 8040 based system.
>
> I marked this series as v3 to avoid confusion about the probe resource leak
> fix that I posted in a separate patch. The (improved) fix is now patch #1 in
> this series. That is the only change in v3.
>
> Baruch Siach (6):
>   gpio: mvebu: fix potential user-after-free on probe
>   gpio: mvebu: update Armada XP per-CPU comment
>   gpio: mvebu: switch pwm duration registers to regmap
>   gpio: mvebu: add pwm support for Armada 8K/7K
>   arm64: dts: armada: add pwm offsets for ap/cp gpios
>   dt-bindings: ap806: document gpio pwm-offset property
>
>  .../arm/marvell/ap80x-system-controller.txt   |   8 +
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   3 +
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  10 ++
>  drivers/gpio/gpio-mvebu.c                     | 170 +++++++++++-------
>  4 files changed, 128 insertions(+), 63 deletions(-)
>
> --
> 2.29.2
>

I applied the first three patches. For the last three - you'll need to
resend them with Rob Herring in Cc for an ack on the new property.

Bartosz
