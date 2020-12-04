Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0792CF710
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 23:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgLDWpl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 17:45:41 -0500
Received: from gofer.mess.org ([88.97.38.141]:41021 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLDWpl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Dec 2020 17:45:41 -0500
X-Greylist: delayed 50438 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 17:45:40 EST
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8F2F8C63F3; Fri,  4 Dec 2020 22:44:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607121898; bh=PYH8ww1xg7JJTR9yV5V04QIPlPtwuoeubNCoR6ffAlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOU4hQfIGHnzuYrHWcRjab1uQ0fVMy/3s/r8IjYVXz2h02cPZUmubrdovi8MbRDlE
         bHb7/3pxfeh7AFUthUsi95Zd9+m5K2YM6qS0cU+b5zQ1oYERTt8r7XZ6GgbZs3ItPS
         M8dM7uJqtyF/XPm2Bcwiz7hvizQTfWFIaOo0osQGKeq3PjntFVXqOpwQXtzwelGpB/
         cS/LvisM55v9yKB4spqMwd7cIdq4EXQg0u5IxnF3rzFfKvLsav9hpY/gLcgcnncPye
         EAQFBXdQVe/da5YPSLpHvavRDJZ/gt42IysVJMORk5tuMWDn6/EMraYCh3YOEZhs9Q
         a2eYr9/zZJ28g==
Date:   Fri, 4 Dec 2020 22:44:58 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204224458.GA15986@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204112115.wopx5p5elgte7gad@pengutronix.de>
 <20201204114036.GB6547@gofer.mess.org>
 <20201204215525.uvjxlebth457aoj5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204215525.uvjxlebth457aoj5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Dec 04, 2020 at 10:55:25PM +0100, Uwe Kleine-König wrote:
> On Fri, Dec 04, 2020 at 11:40:36AM +0000, Sean Young wrote:
> > On Fri, Dec 04, 2020 at 12:21:15PM +0100, Uwe Kleine-König wrote:
> > > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > > On 29.11.20 at 19:10, Uwe Kleine-König wrote:
> > > > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > > > you are sure that this won't discard relevant bits, please explain
> > > > > this in a comment for the cursory reader.
> > > > 
> > > > What about an extra check then to make sure that the period has not been truncated,
> > > > e.g:
> > > > 
> > > > 	value = DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> > > > 
> > > > 	/* dont accept a period that is too small or has been truncated */
> > > > 	if ((value < PERIOD_MIN) ||
> > > > 	    (value != DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > > > 		return -EINVAL;
> > > 
> > > I'd make value an unsigned long long and check for > 0xffffffff instead
> > > of repeating the (expensive) division. (Hmm, maybe the compiler is smart
> > > enough to not actually repeat it, but still.)
> > 
> > I wonder where you got that idea from.
> 
> I don't know how to honestly answer your question.
> Which idea do you mean? That divisions are expensive? Or that compilers
> might be smart? And do you consider it a good idea? Or do you disagree?

I had already made this exact suggestion -- and you had replied to my
email making that suggestion -- before you emailed this. Granted, I said
u64 and U32_MAX rather than unsigned long long and 0xffffffff.

However, I should not have sent that snotty email. It's irrelevant.

My apologies.


Sean
