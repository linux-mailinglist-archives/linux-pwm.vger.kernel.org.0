Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4666A13A240
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2020 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgANHrT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jan 2020 02:47:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgANHrT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jan 2020 02:47:19 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1irGus-0001W3-P1; Tue, 14 Jan 2020 08:47:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1irGus-0006ad-6e; Tue, 14 Jan 2020 08:47:10 +0100
Date:   Tue, 14 Jan 2020 08:47:10 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20200114074710.kxkz4664oap3r752@pengutronix.de>
References: <cover.1578959442.git.gurus@codeaurora.org>
 <21a1431edfa86e061528b80021351c25c76976a9.1578959442.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21a1431edfa86e061528b80021351c25c76976a9.1578959442.git.gurus@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 13, 2020 at 03:53:31PM -0800, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 in the structs of the
> PWM framework so that higher durations may be set.
> 
> Also make the relevant fixes to those drivers that use the period and
> duty_cycle struct members in division operations, viz. replacing the
> division operations with 64-bit division macros as appropriate.

I like the goal of this patch (i.e. expanding the domain of period and
duty-cycle). I wonder however if we need a more sophisticated approach
here. The problem I see is that if something breaks (and the fix isn't
easy) we will have to revert the whole patch touching (now) 15 files.

I didn't thought about that much, but it would be great if we could
prepare the affected drivers to work with both, int and u64 and switch
in a separate commit. Reverting would then become cheaper.
The conversion to 64-bit division macros could be done even without
actually converting period and duty cycle, couldn't it?

> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Reported-by: kbuild test robot <lkp@intel.com>

This Reported-by: looks wrong. It gave some hints about what had to be
improved in an earlier revision of this patch, but usually this means
that the patch is a fix for an earlier commit. So I would put this in
the text, something like:

	The kbuild test robot helped to improve this patch series to
	(hopefully) catch all code sites having to be adapted.

> [...]
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..ba9500a 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>  	/* Duty cycle 0..15 max */
> -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
>  }

In ir-rx51.c you used DIV_ROUND_CLOSEST_ULL to replace
DIV_ROUND_CLOSEST, here it is DIV64_U64_ROUND_CLOSEST. Maybe it is worth
to describe the relevant difference shortly in the commit log.

>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
