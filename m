Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755AC2CEA2E
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgLDIvD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 03:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDIvD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 03:51:03 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Dec 2020 00:50:22 PST
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2DC061A4F
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 00:50:22 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id EBCAFC64ED; Fri,  4 Dec 2020 08:44:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607071457; bh=0GRGIK4YsIhbmKXjmZr8ocLCjLu/Ct8TXGitNBF/kEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmcX1xwmjgUKHnX93Lw6UIv3GhF+t14P/YJ2GQNB6PzJUS82dgp1ZDh0k6FK/IneF
         KRZ7gZaGXzfm3577wvxNLOlFQ/xAFLyixCpnccbcQ9WHyidzvl3w6+kRoNp7Ga92r9
         fPKpVeGnmfpyXXA2vUkgBWBujSFR4LAhQiIAvWJ5DOmnlB0AhLRBDQAyCQInQ8eJLr
         +6lKh6wJeyr9dWX9qySYLycjvz14Ij3kou9t3fCYzvfRzy6jPcDSkOd1lzzvV0DsJx
         YntUspU35hmS1VWYYzzDaV0ZEraw4Eqea9nML1Pb0V9OwVIksA8sfICX4BwMatPxlN
         HDKQrm3r3ZHLA==
Date:   Fri, 4 Dec 2020 08:44:17 +0000
From:   Sean Young <sean@mess.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204084417.GA2154@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > you are sure that this won't discard relevant bits, please explain
> > this in a comment for the cursory reader.
> 
> What about an extra check then to make sure that the period has not been truncated,
> e.g:
> 
> 	value = DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> 
> 	/* dont accept a period that is too small or has been truncated */
> 	if ((value < PERIOD_MIN) ||
> 	    (value != DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> 		return -EINVAL;

Rather than doing another 64 bit division which is expensive (esp on 32 bit
kernels), you could assign to u64 and check:

	if (value < PERIOD || value > U32_MAX)
		return -EINVAL;

> > Also note that round_closed is probably wrong, as .apply() is
> > supposed to round down the period to the next achievable period. (But
> > fixing this has to do done in a separate patch.)
> 
> According to commit 11fc4edc4 rounding to the closest integer has been introduced
> to improve precision in case that the pwm controller is used by the pwm-ir-tx driver.
> I dont know how strong the requirement is to round down the period in apply(), but I
> can imagine that this may be a good reason to deviate from this rule.
> (CCing Sean Young who introduced DIV_ROUND_CLOSEST)

There was a problem where the carrier is incorrect for some IR hardware
which uses a carrier of 455kHz. With periods that small, rounding errors
do really matter and rounding down might cause problems.

A policy of rounding down the carrier is not the right thing to do
for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
edge cases.

Thanks

Sean
