Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19B8113CB0
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLEIAB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 03:00:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44549 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfLEIAA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 03:00:00 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1icm3L-0007fC-EI; Thu, 05 Dec 2019 08:59:59 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1icm3K-0000Ib-Sk; Thu, 05 Dec 2019 08:59:58 +0100
Date:   Thu, 5 Dec 2019 08:59:58 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.5-rc1
Message-ID: <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205061044.1006766-1-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Dec 05, 2019 at 07:10:44AM +0100, Thierry Reding wrote:
> The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:
> 
>   Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1
> 
> for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079dad4b6:
> 
>   pwm: imx27: Unconditionally write state to hardware (2019-10-21 16:58:09 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> pwm: Changes for v5.5-rc1
> 
> Various changes and minor fixes across a couple of drivers.
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       pwm: sun4i: Drop redundant assignment to variable pval
> 
> Fabrice Gasnier (3):
>       dt-bindings: pwm-stm32: Document pinctrl sleep state
>       pwm: stm32: Split breakinput apply routine to ease PM support
>       pwm: stm32: Add power management support
> 
> Ondrej Jirman (1):
>       pwm: sun4i: Fix incorrect calculation of duty_cycle/period
> 
> Rasmus Villemoes (1):
>       pwm: Update comment on struct pwm_ops::apply
> 
> Thierry Reding (8):
>       dt-bindings: pwm: mediatek: Remove gratuitous compatible string for MT7629
>       pwm: stm32: Validate breakinput data from DT
>       pwm: stm32: Remove clutter from ternary operator
>       pwm: stm32: Pass breakinput instead of its values
>       pwm: Read initial hardware state at request time
>       pwm: cros-ec: Cache duty cycle value
>       pwm: imx27: Cache duty cycle register value
>       pwm: imx27: Unconditionally write state to hardware

It's a bit of a surprise for me that you included the three last patches
as last minute changes. I'm not sure if I oppose them, but they were not
in next (as of next-20191205) and I would really like to have some time
for patches (that are not obvious fixes of course) there before they go
into a pull request. And if it's only to get some transparency.
(But in this case I had the impression that the discussion isn't over
yet, your last mail in the thread said: "I'm not sure yet about the
remainder of the series. Depending on what we decide to do about drivers
that can't (or don't want to) write all state through to the hardware,
patches 2-4 may become moot." in October which made me expect there is
still something to come, at least a statement before the fact. Still
more as also several further drivers are affected (according to my
research described in
https://patchwork.ozlabs.org/patch/1178351/#2282269).)

In return there are a few patches I would really have liked to be seen
here:

 - The series "Updates for the atmel PWM driver" that didn't get any
   response from you since August although it got some acks from the
   atmel guys.
   (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=127096&state=*,
   This is marked Superseeded for reasons unknown to me that I asked
   about in October.)

 - The series starting with "pwm: rcar: Drop useless call to
   pwm_get_state" from October which got reviews by a renesas guy.
   (https://patchwork.ozlabs.org/patch/1182649/,
   https://patchwork.ozlabs.org/patch/1182648/,
   Patchwork didn't identify this as a series, so listing the patches
   individually.)

 - The patch "pwm: implement tracing for .get_state() and
   .apply_state()" that got an review by Steven Rostedt.
   (https://patchwork.ozlabs.org/patch/1182679/)

 - The series starting with "pwm: omap-dmtimer: remove pwmchip in
   .remove before making it unfunctional" from November which IMHO is
   simple and contains two fixes
   (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=142030)

And I'm still waiting for feedback on

 - "Documentation: pwm: rework documentation for the framework" (since
   January)

 - "pwm: add debug knob to help driver authors" (since August)

:-(
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
