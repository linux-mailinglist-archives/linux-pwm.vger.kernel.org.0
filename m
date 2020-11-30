Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF442C7C26
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgK3Aoi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 19:44:38 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:41264 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgK3Aoi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Nov 2020 19:44:38 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Nov 2020 19:44:37 EST
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 4C519C00B0;
        Mon, 30 Nov 2020 00:36:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1V6n0WLH-Fzm; Mon, 30 Nov 2020 00:36:22 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6D7F3BFE42;
        Mon, 30 Nov 2020 00:36:10 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
References: <20200919193306.1023-1-simon@simonsouth.net>
        <2177360.ElGaqSPkdT@zen.local>
Date:   Sun, 29 Nov 2020 19:36:09 -0500
In-Reply-To: <2177360.ElGaqSPkdT@zen.local> (Trent Piepho's message of "Fri,
        20 Nov 2020 17:09:58 -0800")
Message-ID: <875z5nof46.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Trent Piepho <tpiepho@gmail.com> writes:
> Anyway, it seems like this solution has a race.  Isn't the pwm live
> and requestable as soon as pwmchip_add() returns?  Which would mean
> that disabling the clock here could race with other code requesting
> and enabling the pwm.

Yes, I think that's true. Glad you caught this.

> Seems like it would be safer to check the initial state and turn off
> the clock before calling pwmchip_add.

Yes. I tested this and it works, but on further consideration it seems
to me the code is actually doing things backwards: Instead of enabling
every PWM's clock and then turning off the clocks for PWMs that are not
themselves enabled, it should enable only the clocks for PWMs that
appear to be in use and leave the remaining clocks in their default
(presumably disabled) state. This should produce the same end result but
without the driver enabling clocks indiscriminately and without creating
a race condition.

I'll follow up with a patch for review that implements this change. I've
tested it as best I can on my own Pinebook Pro; everything works as it
did previously, with the display backlight on, no kernel hang and no
other apparent side effects.

> It seems like the issue is the driver was calling pwm_is_enabled()
> without first requesting the pwm with pwm_get().

This used to work because pwmchip_add() happened to invoke
rockchip_pwm_get_state(), which populates the PWM's pwm_state structure
from which pwm_is_enabled() reads. And I think that's why the code was
written the way it was originally: By waiting until pwmchip_add()
returned the PWM's state could be queried in a convenient manner,
without resorting to peeking at the hardware's registers.

Commit cfc4c189bc70 ("pwm: Read initial hardware state at request time")
changed this and pwmchip_add() no longer has the side effect of
populating the state structure, so the call to pwm_is_enabled() no
longer worked reliably. That's what I fixed with the patch you're
replying to, though now I wish I'd seen the larger issue.

As to why this code is needed in the first place (as I wondered recently
while working on it again), it seems to be a somewhat hacky way of
initializing the enable_count reference counter (see drivers/clk/clk.c)
of the already running clock to 1 instead of 0. This is necessary
because on SoCs like the RK3399 that use only a single clock for each
PWM, the driver treats the "APB" and "bus" clocks as referring to the
same physical device ("pc->pclk = pc->clk"), and without it functions
like rockchip_pwm_get_state() that enable the APB clock on entry and
disable it on exit would end up halting the PWM entirely.

-- 
Simon South
simon@simonsouth.net
