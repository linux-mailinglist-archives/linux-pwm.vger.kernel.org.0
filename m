Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB89E188E1A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQTgD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 15:36:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46501 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgCQTgD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 15:36:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id x5so5344805oic.13;
        Tue, 17 Mar 2020 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7nkObttnyuidFBZaBgW6qJvNI3Jb0umzBOjIUFBrRU=;
        b=HUXvV5KsqGzMSCWZmdrYLdIRrm6Hhp1VF0db1gp21KfjG93cqg7/yVseU3OltAs+vY
         H1chZ03psQOzlE6BtHOKYvX+G5iQ2WaEisA5B20kSY8Sz0VCE5YOZdHYuYEGyN6t8w/b
         hrYkqqLvaNDJ5ywSGehY5nCq6AAh2COKLhc6CirueTqWYVvVuExz4GrCFT4h2MttZizy
         ccAT1Whik8zEbwth0zmUgC4JQqA4E3HVWX/BIlrxSZBN3INgwzGGBas3CIJZhu9w7Kl7
         DMpGzgUksqK24Ja/elzAuC0PIfpHJJzdabWXIIEROq3oPtVmAxy+LBTyV2D7xF3qn0hm
         VdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7nkObttnyuidFBZaBgW6qJvNI3Jb0umzBOjIUFBrRU=;
        b=ci0vaHAebQzdoF3GJEP+t0AYwwp6U7Y6sfwYdaLF0W+Z01KRWQZw1AKokv+oh+50Td
         gFtU/z8LCoSKWye+/FYXUKwxOBzSrzNDPZgiLNBIFK5hybw4BofD52FH8PZV/SZLPMqP
         zIBMfKM+XBAReXfElrvckYP3R3drH/k9PRDYZO6ODcWJxvYjybSP+NDd+p7ckeCHuiph
         cXvAzg4Z9s9BeSJZ1pBktf6U+CAbCULcfiiN3iji3ph+Ycd15uK2CogrfvKZtTMYQ+rT
         jHadjc1AEzjro7OR2T0b6AxsvsQ1WjcH1r8myhB9xZmXSLTmlR1ENkZJlUGVRDZLcekw
         XTKA==
X-Gm-Message-State: ANhLgQ2S5NUa4DuzQapWnZudpubOT6bQLH4T5QJjcdILGlvidlGhrlyX
        d2bFg0xrFnw7b7bormSwQ5IX67+eKAqZKe26D0OfyA==
X-Google-Smtp-Source: ADFU+vvfbTzEGODWHuIf7L8hPwGPzN1y0DiI8fQIxiox5aCCqB5RU/kUhZMxAlACRUhWDqBjGsKjSqKRtzal7WsxkTI=
X-Received: by 2002:aca:4bc5:: with SMTP id y188mr419059oia.9.1584473762676;
 Tue, 17 Mar 2020 12:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200317155906.31288-1-dev@pascalroeleven.nl> <CAO1O6sccq7c_S8ZMsChBKcVcCn-DDv6awZzNr2BEnh8TH6ZxGg@mail.gmail.com>
 <f96002831730bf262ee61df38642e042@pascalroeleven.nl>
In-Reply-To: <f96002831730bf262ee61df38642e042@pascalroeleven.nl>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Tue, 17 Mar 2020 20:35:51 +0100
Message-ID: <CAO1O6sd=RdopKxun8R-0-MGt_UP=MWFPAd5PQF3DPTCxDYt+ow@mail.gmail.com>
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

Hi,

Den tis 17 mars 2020 19:16Pascal Roeleven <dev@pascalroeleven.nl> skrev:
>
> On 2020-03-17 17:45, Emil Lenngren wrote:
> > Hi all,
> >
> > Den tis 17 mars 2020 kl 17:00 skrev Pascal Roeleven
> > <dev@pascalroeleven.nl>:
> >>
> >> Hi all,
> >>
> >> For the last few days I've been debugging a lot to get pwm working
> >> again since
> >> recent changes in 5.6-rc1 broke it for me.
> >>
> >> Testing shows the pwm controller crashes (or the output gets stuck)
> >> when the
> >> period register is written when the channel is disabled while the
> >> clock gate is
> >> still on. Usually after multiple writes, but one write can also lead
> >> to
> >> unpredictable behaviour. Patch 3 and 4 fix this.
> >>
> >> Patch 2 contains a fix which wouldn't completely turn off the pwm if
> >> the
> >> output is disabled. The clock gate needs to stay on for at least one
> >> more
> >> period to ensure the output is properly disabled. This issue has been
> >> around
> >> for a long time but has probably stayed unnoticed because if the
> >> duty_cycle is
> >> also changed to 0, you can't tell the difference.
> >>
> >> Patch 1 removes some leftovers which aren't needed anymore.
> >>
> >> Obviously these patches work for my device, but I'd like to hear your
> >> opinion
> >> if any of these changes make sense. After days, this one is a bit
> >> blurry for me.
> >>
> >> Thanks to Uwe for some help with debugging.
> >>
> >> Pascal.
> >>
> >> Pascal Roeleven (4):
> >>   pwm: sun4i: Remove redundant needs_delay
> >>   pwm: sun4i: Disable pwm before turning off clock gate
> >>   pwm: sun4i: Move delay to function
> >>   pwm: sun4i: Delay after writing the period
> >>
> >>  drivers/pwm/pwm-sun4i.c | 53
> >> ++++++++++++++++++++---------------------
> >>  1 file changed, 26 insertions(+), 27 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
> >
> > I also worked on sun4i-pwm some time ago, fixing a bunch of issues.
> > One was that disabling the pwm sometimes didn't turn off the signal,
> > because the gate and enable bit were modified in the same clock cycle.
> > Another was that the current code used an unnecessary sleep of a whole
> > period length (or more?) in case of an update to the period, which
> > could be very time-consuming if it's a very long interval, like 2
> > seconds.
> >
> > Note that the behaviour is not unpredictable, if you know how it works
> > ;)
> > I fiddled around a long time with devmem2, an oscilloscope and the
> > prescaler set to max to figure out how works internally.
> >
> > Please try my version I just posted at https://pastebin.com/GWrhWzPJ.
> > It is based on this version from May 28, 2019:
> > https://github.com/torvalds/linux/blob/f50a7f3d9225dd374455f28138f79ae3074a7a3d/drivers/pwm/pwm-sun4i.c.
> > Sorry for not posting it inline, but GMail would break the formatting.
> > It contains quite many comments about how it works internally. I also
> > wrote a section at http://linux-sunxi.org/PWM_Controller, but it might
> > be a bit old (two years), so please rather look at the code and the
> > comments.
> >
> > /Emil
>
> Hi Emil,
>
> Thank you very much, this is helpful. Ah it was your note on the wiki.
> That is indeed where I took the idea of keeping the gate on and
> disabling the panel from. As a scope is still on my wishlist, the rest
> was just trial-and-error. Judging from your code, there are more edge
> cases which might occur. I will test your code and try to integrate it.
> If it's okay with you, I can post it on your behalf?

Sure! I was thinking of sending a patch last year but never got the time :/
The devices I have tested on are Allwinner GR8 (A13) and V3s.

>
> If you ask me, it's really unfortunate Allwinner didn't provide a timing
> diagram for such a picky controller.

/Emil
