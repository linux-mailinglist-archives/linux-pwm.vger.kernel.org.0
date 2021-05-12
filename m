Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05F37B8F4
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhELJTn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELJTm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 05:19:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F3C061574
        for <linux-pwm@vger.kernel.org>; Wed, 12 May 2021 02:18:35 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9803113otg.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 May 2021 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ilHpinXfJbBO00ILl8M3cL9co4ZLrs2Vn6MnmXJH7Ac=;
        b=OpYb3E4eC+El3f8COSWswjpzDbG74EZU9suX/LZaPOWAmGPxMlcl3qy6UBzSRHICf0
         Y2WOguxoF8nNew/YOA4M0/WLN9WRtZxPXf8zBnnPNinvB9EQMoUxK07ivCaTWzBSuTNU
         Ut+yFn5yWNKnSWelekyNqx7tQ5pNtFVtjDmpN9jM87iVMLscahq2jLc6DIF4Y2Bw1WeY
         qsN8283JRlxYbihv+OjKa11ci0flV/XdvTleu5y/xpp5fC3c+mkFS0aZV+N4Q+67ej+m
         opSNyUzGiK1TMy+RtfXyM5QI4RDfECZTHlQciDgPdvNuKqoi8XfDWzfKRhMG77yBIIIr
         t4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ilHpinXfJbBO00ILl8M3cL9co4ZLrs2Vn6MnmXJH7Ac=;
        b=TklagE2hRjtxMbSGtAjaBcLxLO5QXWLBiJDFhpF4Hc15va6VwBtTLLqpieoBOhRGE8
         hD4qLVBOEG98h4/srgzFY/0X4N5GalQJfyodlNkV0V7XEKa4kBNZVwsUvUftTMdZreF4
         2YIOnidwG3FhFqVAiiDAKJcv7tMMEQ2+AsTybGarQCZBIagHfHUK6144eDL+19yy8kA5
         vgjWc3Pouj5Q8M0vwH+yuoKaHb6LrG1QdXOaCyoxL8tBzPVXux/hMWywdM/L5S0NMF91
         G67FACzZ/RMX3u8YWygQHJxjDJPRLzct90ahQ6PfXTcmQNXN+291gQ/B9iR03sekQsKu
         ialw==
X-Gm-Message-State: AOAM531V0RZx8vXkC+mTrB6BbPQ8AfXSv84HnTjVgBmqVhu3SP/tnt4F
        GdZz9Xlf+gmTexv9qXw2QcGaHTv19Hi4nylHPwRbdFQ9UtPZbw==
X-Google-Smtp-Source: ABdhPJxL5e7JMKGEAMi+g54pI1yxPu1G+9tSMQnIgWLQZ0pKp4sbyHdu8tnX79kJNw/uYM4GtFc0VbCLWkaoTi0R2lE=
X-Received: by 2002:a9d:e88:: with SMTP id 8mr28771453otj.239.1620811114262;
 Wed, 12 May 2021 02:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
 <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com> <20210512044133.6yfwyluzdx6yfh4c@pengutronix.de>
In-Reply-To: <20210512044133.6yfwyluzdx6yfh4c@pengutronix.de>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 12 May 2021 11:18:24 +0200
Message-ID: <CAO1O6sfZ0O7JExw07UytBcNROc9TQsu9bBp-+zFF3824PxxvRA@mail.gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Roman Beranek <roman.beranek@prusa3d.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Den ons 12 maj 2021 kl 06:41 skrev Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de>:
>
> Hello Emil,
>
> On Wed, May 12, 2021 at 02:55:26AM +0200, Emil Lenngren wrote:
> > Well that's one way of "solving it" ;)
> >
> > But on what hardware do you really need to wait until one full pulse
> > cycle ends, before a disable command takes effect?
> >
> > On the hardware I've tested on (GR8 and V3s), it's enough to wait at
> > most two clock cycles in order for it to take effect before we can
> > close the gate. And with clock cycle I mean 24 MHz divided by the
> > prescaler. With prescaler 1, that's 84 nanoseconds. By closing the
> > gate when the pwm should be disabled, I guess we could save some
> > nanoampere or microampere (is this important?)
>
> If I understood correctly you really have to wait longer to achieve that
> the output is inactive in the disabled state. Do you talk about the same
> thing?

Exactly, i.e. after writing 0 to the EN bit, we don't have to wait
until the current period ends before we can observe that the output
signal goes to the inactive state.

Simple test:

1. Set pwm interval to a long time like 2 seconds, and duty to 50%.
2. Enable clock gating.
3. Enable the pwm by writing 1 to the EN bit.
4. Observe the LED blink once per second.
5. Now at a random time write 0 to the EN bit in order to disable the
pwm. Don't turn off the clock gating.
6. If you just look with the eye it appears the LED turns off
immediately, regardless of when in the pulse cycle we disabled it.

Just tested the above using "devmem" on a V3s.

By using a large prescaler and testing some different prescalers, I've
concluded that it takes at least 1 and at most 2 clock cycles before
we can safely turn off the gate and be certain that the output pin has
changed to disabled.

It would be good if people having other hardware could confirm this is
correct there as well.

Please take a look at some previous material I wrote:
https://lkml.org/lkml/2020/3/17/1158
https://linux-sunxi.org/PWM_Controller_Register_Guide (Observed
behaviour on GR8 from NextThing)
https://pastebin.com/GWrhWzPJ

/Emil
