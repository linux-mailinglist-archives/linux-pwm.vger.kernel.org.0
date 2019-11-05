Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2CF0864
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 22:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfKEVb3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 16:31:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfKEVb3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 16:31:29 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iS6QB-0000mq-Su; Tue, 05 Nov 2019 22:31:27 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iS6QB-0006Wc-Bj; Tue, 05 Nov 2019 22:31:27 +0100
Date:   Tue, 5 Nov 2019 22:31:27 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Fixes for v5.4-rc6
Message-ID: <20191105213127.gyxc2shjz2nq7ul5@pengutronix.de>
References: <20191102134800.3847540-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191102134800.3847540-1-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Sat, Nov 02, 2019 at 02:48:00PM +0100, Thierry Reding wrote:
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc6
> 
> for you to fetch changes up to 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:
> 
>   Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> pwm: Fixes for v5.4-rc6
> 
> It turned out that relying solely on drivers storing all the PWM state
> in hardware was a little premature and causes a number of subtle (and
> some not so subtle) regressions. Revert the offending patch for now.
> 
> ----------------------------------------------------------------
> Thierry Reding (1):
>       Revert "pwm: Let pwm_get_state() return the last implemented state"

In a different thread on the pwm mailing list I suggested to add

	pwm: bcm-iproc: prevent unloading the driver module while in use

to this pull request. You didn't comment and didn't add it. :-|
(https://patchwork.ozlabs.org/patch/1178972/)

While this is not a recent regression (it was introduced in 4.8-rc1) I
think it's still worth to be fixed, don't you agree?
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
