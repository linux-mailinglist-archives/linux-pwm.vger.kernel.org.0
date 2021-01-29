Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32253308FF2
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Jan 2021 23:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhA2WRq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Jan 2021 17:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhA2WRo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Jan 2021 17:17:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DEC061574;
        Fri, 29 Jan 2021 14:17:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so10317786wrx.1;
        Fri, 29 Jan 2021 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjbXD/Cdr+QHwG9B3QZlpTa2KkeVmfJ9I1pyRoZjjEE=;
        b=G6xEChS9glp+w7ZjmNJFRVqi0IbvGoqbO9uwGNW2N+Z6mfQI0rjyLjUM1jr+wKlEEI
         JViX23Kpy2uYvEd/rFPRBq16G08SWFVWwRH7NCtCqzvMxYCxRIBrr+t6WjgNPmHh62Qo
         toVgVPZcSIpz6OdmygldwyXtSt1DWRxzO3VEm60b2dxoptuf3uQQPMiKNNBRZS3SX2wi
         hOFBjZGs5HVSRBHn8ZEiKmKCU4+7QEdQqzBSEIpwrkpvDczulSfqSGBxy8Mzgt/TYTZ7
         loXOMpna3qJT79tlXSrYEmj7/SnkKjG1doBThbAbClf88l9E9GycNiHVW2IJL/OXkeai
         YW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjbXD/Cdr+QHwG9B3QZlpTa2KkeVmfJ9I1pyRoZjjEE=;
        b=l9gzu0/Ts0u/ni26jANdiudYBe6mn93DWNawVzoOPCZrnP34BG+bdH5Co6xZUh9DoR
         VsB8+vUH+6Tw4o822hFKDdf3oGcCDuWWUG/bwMYa4cn+UeKksRQmdWLbtUiu3dlOoAn1
         EWE7iC5eWTzEhpdpJA3MJoKLDIW0FEFNs163ZzGCfsn799oDO3bFP11+Q2LGQClfUw4q
         d+QzUpjG90t+gqjXy30zzdTgxmvczqLMmb1D3CK8MR+UPdeKGIvdpshhM/wdvwek8TuM
         SLJHh9QDa/7ougH0tAkVECcqFVE+So+Q0gwJKCOjKS+GPeQ5RZdbi4J4re2GVnukXy3y
         BlhQ==
X-Gm-Message-State: AOAM533K6U2RPXyGuGggE5xu6xJWgzihx/glpWvHjrEon1eEbcH0vkIp
        81XOBmw++y6r9yi3BZSfaFndmilM2opn/9popr3Kva9AWMsJMw==
X-Google-Smtp-Source: ABdhPJy/ExFIu4LtSXprv+LcxqV9hJewLNuPkKO0igU+eyCBQ2E3uZa3XkXDKC71UgtGeeXPikNr1ipmbCbWBJ//kwo=
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr6653657wrt.85.1611958622829;
 Fri, 29 Jan 2021 14:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet> <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet> <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
In-Reply-To: <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 29 Jan 2021 17:16:51 -0500
Message-ID: <CAGngYiV5GGJvHTwG7k6mv76uR1RLnHOJoO8+d2ofiZAQi3K0BA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Clemens,

On Fri, Jan 29, 2021 at 4:24 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> LEN_ON = 409, LED_OFF = 1228 and
> LED_ON = 419, LED_OFF = 1238
> produce the same result. you can't see the difference between the two
> when scoping the channel. there are probably more ways to do this,
> some might surprise us. It's a tricky chip.

Please ignore this example, it's bogus. In my defence, it's a Friday
afternoon here :)

But consider the following: imagine the bootloader has enabled a few
pwm channels, and the driver's .probe() has left them on/unchanged.
Then the user enables another pwm channel, and tries to change the
period/prescaler. How would pca9685_may_change_prescaler() know
if changing the prescaler is allowed?

And the following: imagine the bootloader has enabled a few
pwm channels, and the driver's .probe() has left them on/unchanged.
After .probe(), the runtime_pm will immediately put the chip to sleep,
because it's unaware that some channels are alive.

I'm sure I'm overlooking a few complications here. probe not changing
the existing configuration, will add a lot of complexity to the driver.
I'm not saying this is necessarily bad, just a tradeoff. Or, a management
decision.

Sven
