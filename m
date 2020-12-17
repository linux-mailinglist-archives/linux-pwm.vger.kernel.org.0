Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796E2DD69C
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 18:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQRxh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 12:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQRxf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Dec 2020 12:53:35 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7AC0617A7;
        Thu, 17 Dec 2020 09:52:55 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id x4so15389359vsp.7;
        Thu, 17 Dec 2020 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4wBtU5fm9orzQxfqfq4ZnR0tVlAljZj6kq4gq9ZFCw=;
        b=PRIDciiK3kxktIwkS5JXGn6CUwVypiatHkhHd/aGA3FRwHtmbNuzR6FwnFKfa0YNkE
         EBDFT48AvcoJ0Qf34eDkghFslX8GULpSP2/TpXCLMp5qxJYJZQmY8bIbCbs0puOMUNZp
         yDlzCkaR3Jj9Cb0ont1jBmwwfWlWU+16AC2HLh/hr9fXvULqLY/JKwKsgVJdp9pvRRks
         fV5UGcLUu3oLs+QxUCoYN+/mlQd0WqOO7AKrJqbvubZQcLUmzY0ZT4hABgIDNLN0Sh8h
         /6laFXSnSaou+YODJfRd3iUt0dugDRoyWHCn2/dsQ87LDE4z0pu6RDsoKK18nySZ80uC
         1opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4wBtU5fm9orzQxfqfq4ZnR0tVlAljZj6kq4gq9ZFCw=;
        b=iPs7Z9wzhysTZ4WXxsyreIXaSZTHiRiuiXyiCm3sQY3GXQRfJNETb+805noz5Z2HbI
         /V9vHhBRalrQaXioYebzPzajSVnVOELW4YVltRgXMUQwBbz2efYuNBnZ2R/7cWlss7TW
         z5npw0K/jN9Lp57tOc4RXRSrWc4Daex41DZFpxhPZCOo2pAR8Vm47t82fUgnIo8ipKaI
         tVP/E8FEwSIx939d99qSoLsiBEUNIXD/26nXOjVcYcbiFS232PFT3OzAoL0bt/PhjlBA
         R9xMCyQa9kNt/cqXjQlkLIH2VhfWOkZAozv4VK2Kqo5DPNH5MZTc+J3ALZ6cKTQLXNJ4
         SiUQ==
X-Gm-Message-State: AOAM532hJ3P0g2pRONN6Wm5u6rRbPUSZwd4qzVk6kURcvOKeZ6avoIEm
        MVOevRtia/UoPDitR9mJSpHYspixgpVa8x2bBQLODrTZln2GMg==
X-Google-Smtp-Source: ABdhPJzyjTIeTU/3R7AteB+QVM4R4vwSxKwAYLDKzEVicK7nyk46tR0iGdOQ6+J4LTisZ2iiZRCGmNAA/ISKLOOCxIY=
X-Received: by 2002:a67:2e16:: with SMTP id u22mr416762vsu.12.1608227574165;
 Thu, 17 Dec 2020 09:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
In-Reply-To: <X9uYqGboZg5DuEtf@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 17 Dec 2020 12:52:42 -0500
Message-ID: <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 17, 2020 at 12:43 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> >
> > Conclusion: .get_state() will always return "pwm disabled", so why do we
> > bother reading out the h/w?
>
> If there are no plans for the PWM core to call .get_state more often in
> the future, we could just read out the period and return 0 duty and
> disabled.

I'm not sure why we should even read out the period?
When a channel is disabled, the period is not externally visible,
therefore it's meaningless ?

As far as I can tell, we can use this for .get_state():
memset(&pwm->state, 0, sizeof(pwm_state));

>
> Thierry, Uwe, what's your take on this?
>
> > Of course, if we choose to leave the pwm enabled after .free(), then
> > .get_state() can even be left out! Do we want that? Genuine question, I do
> > not know the answer.
>
> I do not think we should leave it enabled after free. It is less
> complicated if we know that unrequested channels are not in use.
>

Good point, I agree with you.
