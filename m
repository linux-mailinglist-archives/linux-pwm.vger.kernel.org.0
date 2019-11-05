Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF4EF810
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 10:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfKEJIv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 04:08:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38345 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbfKEJIv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 04:08:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so14733139pfp.5;
        Tue, 05 Nov 2019 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3IN+RmgrA9UuV2EXkkUk1yKQc727vvMO7nQN5m0x7fQ=;
        b=PPdE5lSoTbfeWE39yleufpUJr53ZwN4GoeYnjibmEiejj6I3/LTa9lm6tV3g7xUWHv
         Yr4N1EkLATrunX+49DRIstYvODsB6lS07WqRfokwahj/fXhXVb08/vJRtoiy299krnSc
         XC710aWgDBVoRaDNWcWvlLsKH+HoF6CLbyRJM7Gx9RqfLyeQ9XxmVjGAvwkvI4a1sE0g
         mSfd5SYaopG9NMT+TR9MxqRzjljl4HWATJdlpJJAEIn3adYb8iTM6vBanDE3QSDsDLZK
         Cmu4+rkNi9ZN4XCqbUFWjrSDf29jG0YOPBbsg/G7skYBVbjlOJv84ilFSx3AYKEualaK
         tKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3IN+RmgrA9UuV2EXkkUk1yKQc727vvMO7nQN5m0x7fQ=;
        b=P016hklU+PGiKAZNOKXgJLWAFECpx2oer62ZKkFa9+HhCf2N6V1WQU3bV95JcZm2sC
         1O5Zlksyay4p9QlyFF5bbapkL137228USAbnBJE/TM4Zyp+yAWcV3F7/d2Kcy/fjRCFh
         ZJ5S/YZ416D923tbqKYUsn7t67J2e9+DdtbwOh3cA8KgKJb2v8ucKJaJLoF+CqmW1maR
         WhDwZIvC9okiApohWh4NdB0bowxgjJC1TlYlKvBDURsg1pO8AwtHha2si0RyvB6QAZPt
         RSplacckidMqsYIfiPyPsBVeOjPC4+KVn94/VEO8Sz0E1VA/qhDYG+g8njo+IgLFo6/j
         YPWg==
X-Gm-Message-State: APjAAAW8VVNEJuCdBFdt4Cmki7XxCD34yCbhaOFnxhg4ekmTva6p6qbp
        pdz6i1iGmvUfL94mq3kp9lFuHVGumUSfmIdfqUk=
X-Google-Smtp-Source: APXvYqwcJpF1Dm56pg/Q3f42I41lxG7yrTVd2IBUReo74ZKyoGoglJgiG27q2ULFv8XHzvVwjYJ2Wx+9YAF2nZH0nA0=
X-Received: by 2002:aa7:8e8d:: with SMTP id a13mr6708143pfr.241.1572944930238;
 Tue, 05 Nov 2019 01:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
 <20191015163055.0d8f44e5@xps13> <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
 <20191104161103.64995b8a@xps13> <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
 <20191104203346.epdbzflnynh2gf3z@pengutronix.de> <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
 <20191105100157.2b6eb22b@xps13>
In-Reply-To: <20191105100157.2b6eb22b@xps13>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Nov 2019 11:08:39 +0200
Message-ID: <CAHp75Ve6_8dXJgF6c2OdZDeV=icyRondvMKwTxhom-RXDACfUA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Tue, Nov 5, 2019 at 11:02 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 5 Nov 2019
> 09:06:37 +0200:
> > On Mon, Nov 4, 2019 at 10:33 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:

> > For me it sounds more likely that PWM is a *pin function* of a pin
> > controller and actually this GPIO driver should be a pin controller
> > with corresponding function(s).
> >
>
> Ok, thanks for the input, I will address Thierry's comments and
> re-submit as a single file (same shape as in v1).

Perhaps I have to be more clear. What I meant is that pin control
should support PWM pin function and PCA953x be converted to a pin
control + GPIO + PWM.
Above definitely is not what you did and it's not for immediate submission.

I really would like to hear if it makes sense.

--=20
With Best Regards,
Andy Shevchenko
