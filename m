Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDB2FA227
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbhARNu3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 08:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404585AbhARNiW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jan 2021 08:38:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212ADC061573
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 05:37:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id p13so18276973ljg.2
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bg93XL362AVXGunnCJTntg/2L6/UjPR4wDwgKIbKRBQ=;
        b=tT22AFPQBXfYUpn4D4t95QOfHW9D9Qdxsp7EDC4Hw9jbXJfWW9Utn1wvM43MralR2g
         xav95FkmswW7uI2tFYRCyb0t7Sp0HvHB2yW+G0z0Y6XiCsVWs/2GA08DRwH9Hfeit9Sg
         IU5jWo0EcghY4h7VePzXhh4blu0K5uiAja2OsJCCZA0gz9Yt7vkHdDmAo3x0T6ALMpiE
         urAQnHkiNGv6LI6emUBmqzhtX9OQDQN3LXWDOzGgQdiTHhP+628CGO6HxF8ScB6NG/D1
         ahPcfntMi5Rtlx5hZ59i11e6yHfJ3zoaSUdrs0Oy+l78Cudy2QuHnKBUIBisQepssXi8
         jNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg93XL362AVXGunnCJTntg/2L6/UjPR4wDwgKIbKRBQ=;
        b=OKvNEqVIpRxm6nh6Ttyns3imnRm5Io9jPYSFUf7SjqdCicRJNnfAN2O8Dr9UDtnYFu
         r3SW20w2kPcgWKGm44fIm0xnhc3PxNAt9XANQTCVouhvVEGGcNgUrZ3muWNsWOq3igsm
         WjaS0smOpqdVJWqcnqc05LoPKtXeczeQeUPjy/DGOL03oJB7ZZJAx1qOr24xIzZNEGRn
         86ZvOxJom40aRs0P0OdPwpcEcFrBQLAaZrDpNp28jR9H1bwTBjPkD0pqDsbB4g2bKQ1n
         fEDsbrUrjASkGNpFuMg3I0yJGTWd0t+wQRVlbY88HQBC5nv395uHw22UAeOKO2L92aua
         y9AQ==
X-Gm-Message-State: AOAM533QIOeHcpscrcev4Bh4hT+c/jyqjybNfIdYdtGoPW+yTEXHafM6
        ddMpc8Y3Tt5aBJIf8BFzZvbEJUGXjMjBUAOxumyCBA==
X-Google-Smtp-Source: ABdhPJzeQHJVy3mdr4mA/ljVIdYckzrXSuZPp+/KA+MF5yoxp3x7Nk3Kr0MB38f+tIidfsdxYeUVZd9ovK/bH5Ox5QY=
X-Received: by 2002:a2e:586:: with SMTP id 128mr10785631ljf.273.1610977060672;
 Mon, 18 Jan 2021 05:37:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610364681.git.baruch@tkos.co.il> <5e1b119a51df19ead32561e87ce2ee1441b67154.1610364681.git.baruch@tkos.co.il>
 <CACRpkdZAHpcgzXSJKZyQjBOriALZUoXbw_hBpPa_zxa27=F0hg@mail.gmail.com> <20210112103617.GB1551@shell.armlinux.org.uk>
In-Reply-To: <20210112103617.GB1551@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 14:37:29 +0100
Message-ID: <CACRpkdYvPigW+VXmGg7Wy-K3qWP3Q3QHXu2d1aa=Gt=MQ68UQA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] dt-bindings: ap806: document gpio
 marvell,pwm-offset property
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-pwm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 12, 2021 at 11:36 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> In any case, these offsets are a function of how it was originally
> chosen to describe the hardware in DT, rather than anything about the
> hardware itself. The choice to use a syscon/regmap is purely an
> implementation decision rather than something from the hardware, so
> this DT description is already based around describing what is required
> for the Linux implementation, rather than purely being a hardware
> description.

OK I will not complain about it then, this kind of thing happens
sometimes.

Thanks Russell!
Linus Walleij
