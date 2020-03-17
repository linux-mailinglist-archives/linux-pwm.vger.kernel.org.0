Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5B188AF4
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQQqM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:46:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34917 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQqM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 12:46:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id k26so22422435otr.2;
        Tue, 17 Mar 2020 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eJQW9u/oqLF6BZRfUiV1G5G6DviGGlWCr2b1498xxQ=;
        b=LMRx7nwWe7cMHMOWNUg05zRuPgY6DofzFHMhj1gQnEGael6LRUmB87NFm94a/wAfQX
         qykah79BwhO1P0ntFvhaKtyeXHgmlW5N/BGaWP5tIlIMKLhnE+3K5J8zhdQEUNxGgANf
         mXgbeSIOtdcNdJ2mSwcAt00z0uL/hD3bOfgu7xKu2E8K4MYFOKF5f/4rqd54WT8p+4JU
         Gzt//MblJ65rZBgIlXAHxF4Riy/dM6uPNIerdGo5NXG0RHt9RJHKUdWeTrkrfGrEMpeP
         U9ixsy97/bDAWsXfWP/01XRU5DVl8ZcLaF4BgdJ2y7RJ4bx/dRXjPBaFxBoG5mN/5vsB
         z+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eJQW9u/oqLF6BZRfUiV1G5G6DviGGlWCr2b1498xxQ=;
        b=RfpjAdih189gR1m9EytlEdi4rmNm3i6BvpNSS5Z8Fvl/NeACW0/hXfxFXRKYVb4VD5
         A65CDR9/G+AjO1cBZb3I4ctwra+yTbTZNp7Ntt1c2y7J/yD6a5B/6LalZ2MuSjbpnMjl
         zIzmSm+6Gwjws3Ezj7XlrtCfBjlhgcO68ew+jrh60thGIzmu0Ps7FPBF2DrZu6HKOziv
         oWDcGJHyh0pfoh6f0QQwdpoUaMCd2cRqYaZKuQSQfr17803CI/Dj2b6LEEZE2Tz+mQ/4
         mftaMMUF8hydG/a9mXPah6Mflz9h25NJSZ3KSuCcI4MGIrdLy4xmDeUUDsrwOnJgzHsV
         A3IA==
X-Gm-Message-State: ANhLgQ35rZVu1xRGN0xqC6ylF1+GTpyYTqvW9gmbvWR1eleQaWl/zv73
        stiXmaCYHnp52oo7dLN39HuXGleMW136HHG70A0=
X-Google-Smtp-Source: ADFU+vvntK56sIrmvkmT/qpvgh4Fm7v80qV219/QCLI53RZ9n5flRN/sXMIpPVYkFqh99ZsVYYoAnS05cZQy56ytVHY=
X-Received: by 2002:a9d:560b:: with SMTP id e11mr116304oti.226.1584463569050;
 Tue, 17 Mar 2020 09:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
In-Reply-To: <20200317155906.31288-1-dev@pascalroeleven.nl>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Tue, 17 Mar 2020 17:45:58 +0100
Message-ID: <CAO1O6sccq7c_S8ZMsChBKcVcCn-DDv6awZzNr2BEnh8TH6ZxGg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] pwm: sun4i: Properly turn pwm off and fix stuck
 output state
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all,

Den tis 17 mars 2020 kl 17:00 skrev Pascal Roeleven <dev@pascalroeleven.nl>:
>
> Hi all,
>
> For the last few days I've been debugging a lot to get pwm working again since
> recent changes in 5.6-rc1 broke it for me.
>
> Testing shows the pwm controller crashes (or the output gets stuck) when the
> period register is written when the channel is disabled while the clock gate is
> still on. Usually after multiple writes, but one write can also lead to
> unpredictable behaviour. Patch 3 and 4 fix this.
>
> Patch 2 contains a fix which wouldn't completely turn off the pwm if the
> output is disabled. The clock gate needs to stay on for at least one more
> period to ensure the output is properly disabled. This issue has been around
> for a long time but has probably stayed unnoticed because if the duty_cycle is
> also changed to 0, you can't tell the difference.
>
> Patch 1 removes some leftovers which aren't needed anymore.
>
> Obviously these patches work for my device, but I'd like to hear your opinion
> if any of these changes make sense. After days, this one is a bit blurry for me.
>
> Thanks to Uwe for some help with debugging.
>
> Pascal.
>
> Pascal Roeleven (4):
>   pwm: sun4i: Remove redundant needs_delay
>   pwm: sun4i: Disable pwm before turning off clock gate
>   pwm: sun4i: Move delay to function
>   pwm: sun4i: Delay after writing the period
>
>  drivers/pwm/pwm-sun4i.c | 53 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
>
> --
> 2.20.1
>

I also worked on sun4i-pwm some time ago, fixing a bunch of issues.
One was that disabling the pwm sometimes didn't turn off the signal,
because the gate and enable bit were modified in the same clock cycle.
Another was that the current code used an unnecessary sleep of a whole
period length (or more?) in case of an update to the period, which
could be very time-consuming if it's a very long interval, like 2
seconds.

Note that the behaviour is not unpredictable, if you know how it works ;)
I fiddled around a long time with devmem2, an oscilloscope and the
prescaler set to max to figure out how works internally.

Please try my version I just posted at https://pastebin.com/GWrhWzPJ.
It is based on this version from May 28, 2019:
https://github.com/torvalds/linux/blob/f50a7f3d9225dd374455f28138f79ae3074a7a3d/drivers/pwm/pwm-sun4i.c.
Sorry for not posting it inline, but GMail would break the formatting.
It contains quite many comments about how it works internally. I also
wrote a section at http://linux-sunxi.org/PWM_Controller, but it might
be a bit old (two years), so please rather look at the code and the
comments.

/Emil
