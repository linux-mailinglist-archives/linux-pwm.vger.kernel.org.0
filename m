Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFE2CEA57
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgLDI7W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 03:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDI7W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 03:59:22 -0500
X-Greylist: delayed 861 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Dec 2020 00:58:42 PST
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B69C061A4F;
        Fri,  4 Dec 2020 00:58:42 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1B564C64ED; Fri,  4 Dec 2020 08:58:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607072320; bh=IYTDk70WNSCDc8naxwChw+wSsEIU4zlAqni7tyI0unw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihKetByfzidaMAodbQR7qA5lRB5aSIswT9ByE+cmiUj8Ldr56Xt1LDZl4IZurk2Fy
         VQhoc6sfplVCAm3H+52TVtdIxFnlG5/5l2kerZxbCxcSKqv3xnQMCPknbZAydDcAJa
         ttNfX9/MPXKipeNadJ0dWE2uNl/vvA7wokFLYD/uXOqJGACSNIfGa7P7HArQ+O08Ff
         xZ4xz9v4633agJJIeqpOrZF/OHR8WWNYm1m66vNckXPArxIwdT4lSZel77TU8tD9BY
         bKF9c46hXf5B/3D7TnYtO9+JTZJhojeQkhrnCxaVnIf5K6saNBGVlxCHpr/K0xyRyR
         eZ6OHqXPuhALw==
Date:   Fri, 4 Dec 2020 08:58:39 +0000
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
Message-ID: <20201204085839.GA2937@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204084417.GA2154@gofer.mess.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > According to commit 11fc4edc4 rounding to the closest integer has been introduced
> > to improve precision in case that the pwm controller is used by the pwm-ir-tx driver.
> > I dont know how strong the requirement is to round down the period in apply(), but I
> > can imagine that this may be a good reason to deviate from this rule.
> > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
> 
> There was a problem where the carrier is incorrect for some IR hardware
> which uses a carrier of 455kHz. With periods that small, rounding errors
> do really matter and rounding down might cause problems.
> 
> A policy of rounding down the carrier is not the right thing to do
> for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> edge cases.

Let me rephrase that.

Changing the division to rounding down will exactly revert the fix I made
in commit 11fc4edc483bea8bf0efa0cc726886d2342f6fa6.

So in the case described in that commit, the requested frequency was 455kHz,
but rounding down resulted in a frequency of 476kHz.

That's totally broken and a bad idea.


Sean
