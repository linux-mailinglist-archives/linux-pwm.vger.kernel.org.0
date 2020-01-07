Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F33132633
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 13:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGMbS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jan 2020 07:31:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45433 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 07:31:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so38690461lfa.12
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jan 2020 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EebLSaihLU2tARTr8IPQ7uxTqO1LTm4gAhmzGy3UgE=;
        b=FlGvyvi2QPBrqo2r4Jue30+UaktwLcp+KLUSPcvRGN/2BaMLLxQCzspsz8Eq3GmLzd
         Nrv0IdyDSVVeZeRJza4UCzrDBLsJO3WK4lS8sWpZsaGTKZYL+exCo2xkiSf4lMrGxS3V
         O/HXc2S8gz3bmtLmHzxaW/sJdAR+nUuSDVQSB2asPTwuEA0IbNHvqBPIchofCxdcHcKS
         OEEy/3pGWuFBbaL7Ok/BcVMSr/M6v3ePO5J4A8TwSB4RBOQCo4bFWBIWtLcYJ9N6M89O
         Dyi019Lv6vQkQdGdoa8pwBQzbkx7n8LfuHI9rALcG/Fr6NzydOKxKMgMB7a4JajaCs9Y
         ydvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EebLSaihLU2tARTr8IPQ7uxTqO1LTm4gAhmzGy3UgE=;
        b=Pbr1a+EX0BGtL9dr8z7+Ulj5px30YAZtFkjIX9VPaSZtfteDOm8H/UesKAwHzm3LIQ
         V5MkHqM2Ih7yR0OJhpw/y+mN/TeDfLc4ra+A002hiKXOUk9576xPgSplD+8Cq3jy7Xpn
         CRD5ZvJrj6V+6s1bt01LrPYUiubIc3vOM2GOKyRqPDQmS+fnkeML2WnRarM37OZbpSp9
         SsL+WfEfLQUKJIMfuLklwR9BY+35C5kOG3P66H99boz/ppq9NWQ95M/mN5DGG9a+2WEb
         x/KWlrC61rEA2mo804b0whIyHBZGLAGT+l0b7JMLrHSD6257JnDyDCXNsrldwlpTsYs3
         kclg==
X-Gm-Message-State: APjAAAVOWYzIGKgz4Aj9UFox0UDs5tBYUbvkPZCNEfUh2zxCPyG27tXs
        7QTXO0AuqUfP2v4wJOo4Vk7OuS0sB6ss9y3bhrEUWQ==
X-Google-Smtp-Source: APXvYqyBuRwxF96vFYNvlrUvjUjmWThDAJPetB+s1J0E1Mz7v2ejmMMutsemtESFHjYL7jQnTSsmSoWiKAwaDs6P7Qs=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58501816lfi.93.1578400276043;
 Tue, 07 Jan 2020 04:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20191129191023.2209-1-miquel.raynal@bootlin.com> <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:31:04 +0100
Message-ID: <CACRpkdYsE8e4LfYkiaYyqdcPsgg6r4pqzHKwqUBveoLou_hSnw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 16, 2019 at 10:51 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 29, 2019 at 9:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.
>
> Thanks for an update!
>
> Still I think it's wrong approach. What should be done is:
>  - adding a pin configuration type of PWM (when, for example, argument
> defines duty cycle and period)
>  - conversion to pin control of this driver
>  - enabling pin configuration PWM for it.
>
> For now it looks like a custom way of doing it.
> If GPIO maintainers are okay with it, I'll not object, just want to
> have than something like TODO updated for the matter.

Yeah well that is a possible way, it pretty much lies with the PWM
maintainer, I have one guiding stanza "rough consensus and running
code". Making big upfront code conversions just to get a small piece
of hardware going is just too much from me as subsystem maintainer,
a dual sub-system driver is perfectly fine in my opinion.

That said contributors are encouraged to extend scope and be
ambitious and set precedents for others to follow by going the extra
mile.

(That sounds like corporate management!)

But that must be voluntary work outside the scope of just hardware
enablement.

Yours,
Linus Walleij
