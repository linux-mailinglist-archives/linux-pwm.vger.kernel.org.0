Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9611401
	for <lists+linux-pwm@lfdr.de>; Thu,  2 May 2019 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBHQo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 2 May 2019 03:16:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHQn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 May 2019 03:16:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4150D27124E;
        Thu,  2 May 2019 08:16:41 +0100 (BST)
Date:   Thu, 2 May 2019 09:16:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190502091638.0f5a40b0@collabora.com>
In-Reply-To: <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
        <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
        <1707507.TOMHpQGrZ7@phil>
        <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
        <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
        <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
        <20190429065613.n52uwgys5eugmssd@pengutronix.de>
        <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 29 Apr 2019 11:04:20 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Sun, Apr 28, 2019 at 11:56 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:  
> > > Hi,
> > >
> > > I'm not sure if I'm misreading you, but I thought I'd add here before
> > > this expires out of my inbox:
> > >
> > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:  
> > > > My intention here is more to make all drivers behave the same way and
> > > > because only two drivers updated the pwm_state this was the variant I
> > > > removed.  
> > >
> > > To be clear, this patch on its own is probably breaking things. Just
> > > because the other drivers don't implement the documented behavior
> > > doesn't mean you should break this driver. Maybe the others just
> > > aren't used in precise enough scenarios where this matters.
> > >  
> > > > When you say that the caller might actually care about the exact
> > > > parameters I fully agree. In this case however the consumer should be
> > > > able to know the result before actually applying it. So if you do
> > > >
> > > >         pwm_apply_state(pwm, { .period = 17, .duty_cycle = 12, ...})
> > > >
> > > > and this results in .period = 100 and .duty_cycle = 0 then probably the
> > > > bad things you want to know about already happend. So my idea is a new
> > > > function pwm_round_state() that does the adaptions to pwm_state without
> > > > applying it to the hardware. After that pwm_apply_state could do the
> > > > following:
> > > >
> > > >         rstate = pwm_round_state(pwm, state)
> > > >         pwm.apply(pwm, state)
> > > >         gstate = pwm_get_state(pwm)
> > > >
> > > >         if rstate != gstate:
> > > >                 warn about problems  
> > >
> > > For our case (we're using this with pwm-regulator), I don't recall [*]
> > > we need to be 100% precise about the period, but we do need to be as
> > > precise as possible with the duty:period ratio -- so once we get the
> > > "feedback" from the underlying PWM driver what the real period will
> > > be, we adjust the duty appropriately.  
> >
> > I admit that I didn't understood the whole situation and (some) things
> > are worse with my patches applied. I still think that changing the
> > caller's state variable is bad design, but of course pwm_get_state
> > should return the currently implemented configuration.  
> 
> Regardless of the pros and cons of the current situation, hopefully
> we're in agreement that we shouldn't break existing users?  In general
> I'll probably stay out of the debate as long as we end somewhere that
> pwm_regulator is able to somehow know the actual state that it
> programmed into the hardware.
> 
> +Boris too in case he has any comments.

Well, the pwm_round_state() approach sounds okay to me, though I don't
really see why it's wrong to adjust the state in pwm_apply_state()
(just like clk_set_rate() will round the rate for you by internally
calling clk_round_rate() before applying the config). Note that
pwm_config() is doing exactly the same: it adjusts the config to HW
caps, excepts in that case you don't know it.

I do understand that some users might want to check how the HW will
adjust the period/duty before applying the new setup, and in that
regard, having pwm_round_rate() is a good thing. But in any case, it's
hard for the user to decide how to adjust things to get what it wants
(should he increase/decrease the period/duty?).

My impression is that most users care about the duty/period ratio with
little interest in accurate period settings (as long as it's close
enough to what they expect of course). For the round-up/down/closest
aspect, I guess that's also something we can pass to the new API. So,
rather than passing it a duty in ns, maybe we could pass it a ratio
(percent is probably not precise enough for some use cases, so we could
make it per-million).
