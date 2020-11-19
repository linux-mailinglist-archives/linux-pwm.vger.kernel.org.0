Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9892B994D
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgKSR3i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 12:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgKSR3i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Nov 2020 12:29:38 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AECC0613CF;
        Thu, 19 Nov 2020 09:29:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 81so4857464pgf.0;
        Thu, 19 Nov 2020 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efTE6Si5xSk9WNqWHuHnl+9mK7jZzt5RKrBEPd3Xe+A=;
        b=WJwO+/QUiAjERoyPRXj7+iobrVKddq/6qTJ1rgHR9n5uq/izOT9mlyLUB3kdPSAo1b
         I/PrPL8Am7kmJafyeZR8HvJLzzJdVwjXp4u9f/MeRLk9q9J+k86KjiGIxj0ynONz1x6n
         EmK3G9rbOoxPZN0YiZrS+opf5UBafe8v4wk7LJnSoPe4YPooEsPkA3Xp4PxsYZXNyYPp
         yPNgbPU6/+pXMsr+i63OFpsjC8gNL/2YOuCAvUaONR0VvNQPRdaMfiu7Dx5Sd1l14MOE
         vvCToiWqvUST3gNk6PeXFMsJOkzIc08gWoICQDT6WS+SaT1HO2TeMHQ1RJyVagmLGIe4
         HFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efTE6Si5xSk9WNqWHuHnl+9mK7jZzt5RKrBEPd3Xe+A=;
        b=dY1e9A3TdAaorDX+hvasxfKLWs29+WTkVX988eabP4iM/se3fW1gjAFi31HiBrT0uW
         qSNlZPKea93EvOoNS+PnaEcdANIZLuqEIBksVILdSy+PgKFqZPynjXcnypbZtRp6m9mX
         j2m2INOQRFFCgb/n51ZKqU8QLE0jwVe0vhvruXOF/jPhYuycEFdUmFOZmn4Tl/85LKGO
         vuwZS+tlX+KjcPyqY3OKjuFajTzRW+ECimwujFZqtFiEUdG8WDJbEiukGcpneswrg28A
         0m7zIIhAk+mpMdsvdkBua9pWp71EsT9hS83dGVAOZyBos/U43QXW4HK09csnzrtgLUmk
         CIFw==
X-Gm-Message-State: AOAM531mxAeVLBrguuFND3hPXWHGjFrthFlUgU1B/AKxLN4p01UKpB1p
        FRJzUf6FPWwSAmhUyB3aEKht9d6IJEE/86XS2hk=
X-Google-Smtp-Source: ABdhPJw8mEWfV+p6Qymznf6dkwfI7lPaYeWnAG4GVRIAZSfibWp7mD3Kl5ZrctLYHk8IzK7lQRGbRjGnBEkYaPsqPsk=
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr5793491pjw.158.1605806977200;
 Thu, 19 Nov 2020 09:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
 <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com>
 <20201119100005.GA703@workstation.tuxnet> <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
 <20201119160013.GA217674@workstation.tuxnet>
In-Reply-To: <20201119160013.GA217674@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 19 Nov 2020 12:29:26 -0500
Message-ID: <CAGngYiUELShMgFnvq6XzF0v=2UAwj7gJsPmbdGkmyAbzhM8OLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 19, 2020 at 11:00 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> One thing I noticed: The driver currently assumes that it comes out of
> POR in "active" state (comment at end of probe and PM calls).
> However, the SLEEP bit is set by default / after POR.

Very good point, the comment is probably not correct.

It would be wrong to assume that the chip is in any particular
state when probe() runs. There is no reset pin, so the CPU running
Linux could have reset while manipulating the chip, there could even
be leftover state from a bootloader talking to the chip, etc...

I remember running into this myself at the time.

However, we want to make sure that the runtime pm puts the chip to sleep,
no matter its initial state. So the current code is correct, but the
comment can be changed to:

/*
 * Chip activity state unknown. Tell the runtime pm that the chip is
 * active, so pm_runtime_enable() will force it into suspend.
 * Which is what we want as all outputs are disabled at this point.
 */

> 2) If !CONFIG_PM: Clear the SLEEP bit in .probe

Is anyone likely to use this driver without CONFIG_PM? My kernel won't even
build without it...

If you personally have no use for it, then I would not bother with the
!CONFIG_PM case. Just formalize in Kconfig that the driver needs PM.

I think we can add "depends on PM" or "select PM", I am not sure which one
to use here.

Sven
