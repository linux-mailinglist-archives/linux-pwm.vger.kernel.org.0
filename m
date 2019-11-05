Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C38EF5EA
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 08:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfKEHGu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 02:06:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38183 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfKEHGu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 02:06:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id w8so8900341plq.5;
        Mon, 04 Nov 2019 23:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ShytpwrE9c/FcWybQ1i8wdsSV+dPeLCEN7Fog34ck4M=;
        b=Qly7w3n56sEAX8+qHxDiN0dOm97fk2e0bMCHv0C7hzT7UxfgIHCXpHeCMbGxEqOu12
         65kDjs8Q4QCxfhIo3eSam+2r87znfS+EIEpbWO4LkJnMB2KLlRe3E3Vxe9NC+fOnwAlx
         g0BIa5NvEYLq91N8mr2/gDG40xpT1AI0+/IQYWWZ4XNWuA5nUPdJ0nPTbH7eIkfS+PFd
         Owwjk8EccsG3BOZFZS8KGioNjnJhZne32XkdNUjXM0NvIboRHqc9qUT2lSq6kEIYm/Mp
         1kgFJ8CYjbvzPOaU71RrfSiL8A1WQe2dzV8y0Trw6MUfemuDZ/TOhAUojHwDAV1e9dhf
         5SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ShytpwrE9c/FcWybQ1i8wdsSV+dPeLCEN7Fog34ck4M=;
        b=gMn4LDaBmmLoFnW1uo5yTDjWrfka6hfyrQCalMwdv4zl2I/8GhaMJFRU7WQ3wwrOaI
         zOxET5RMdhAUxBuySiaTFRXq/vqZxJjPmOey5E1IZ2ZC3JpI0TWz7ioUEvtou83CLd+/
         yOjY+xIpv9KJbkuXUpMUlTcTUbm9nL+kBShGtVEKnBIMDxwfdcVvi7kamXbiL6RSnBGA
         5bgJiki2FWrODaMfjD9eEnWoc0Te2uY65gnkbscKQ1NEj34FPqNZbb5l+0x+imVSAAEJ
         3pKI0uqRTVqYugD8YBQBYkRo9POMGcMhSh1BHyyYhweoSi52xd1KP5mbwq+BX+kFibK4
         pT1g==
X-Gm-Message-State: APjAAAXECVRENdvBxIH/mpAVI8Y24b7CEHBvXHkOT68A9LsMBcuy1GnU
        s7ytDDZB/QOHg2a4y83oU5YRTRYi8lG5UwdJV/g=
X-Google-Smtp-Source: APXvYqwCsvxlaaO9BJWDSs1t0acsmzJfTzTMCiW3dcP5aUui10WRJLGndqyUkT6KTRWGUChZEmuWlBLbeXmoPpc0IB4=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr32247185plp.18.1572937609577;
 Mon, 04 Nov 2019 23:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
 <20191015163055.0d8f44e5@xps13> <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
 <20191104161103.64995b8a@xps13> <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
 <20191104203346.epdbzflnynh2gf3z@pengutronix.de>
In-Reply-To: <20191104203346.epdbzflnynh2gf3z@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Nov 2019 09:06:37 +0200
Message-ID: <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 4, 2019 at 10:33 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Nov 04, 2019 at 04:32:23PM +0100, Bartosz Golaszewski wrote:
> > pon., 4 lis 2019 o 16:11 Miquel Raynal <miquel.raynal@bootlin.com> napi=
sa=C5=82(a):
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 15 Oct 2019
> > > 17:55:33 +0300:
> > >
> > > > Or other way around. PWM registers GPIO (which actually I prefer si=
nce
> > > > we have PCA9685 case where PWM provides GPIO functionality, though =
via
> > > > different means)

> While it's not nice to have a driver that provides two different devices
> (here: gpio controller and pwm controller) similar things are not
> unseen. And for example the splitting of watchdog
> (drivers/watchdog/stmp3xxx_rtc_wdt.c) and rtc
> (drivers/rtc/rtc-stmp3xxx.c) of the device in the mx28 is more trouble
> than worth.
>
> So I'd vote for putting it in a single file that lives where the
> bigger/more complex part fits to. So assuming that's the GPIO part (as
> the driver supports several variants and not all of them have a PWM
> function if I'm not mistaken) having it in drivers/gpio is fine for me.

For me it sounds more likely that PWM is a *pin function* of a pin
controller and actually this GPIO driver should be a pin controller
with corresponding function(s).

--=20
With Best Regards,
Andy Shevchenko
