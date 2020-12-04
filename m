Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B202CED47
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgLDLlT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 06:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgLDLlS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 06:41:18 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87151C0613D1;
        Fri,  4 Dec 2020 03:40:38 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 74F6CC63B3; Fri,  4 Dec 2020 11:40:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1607082036; bh=X9lIo10egin06IAG613mKzLT1qTrqN6EI08M7P8iL14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k91fdar8ih3LWqV4ABQ52GXceFOVNux9RtwLETtUZmOZgEWGLQvZHbooqWzFb2OHS
         vh/AORxGLnyumsBW+lAHt/ywhyogH+0jHnb91N1YJQmsxzVoM5g9+v6biDdm9BAdX3
         sU0HthYz+/tj0JOwowyva6yjEaB+7AyhSfovWiP1MQn/e4cpcn6IDg2gafsUdQRz4x
         RO6ALNaTcx1WaMuN60+de9FFKYm0v2e8SuoRPDBWUxfTvJ1ecvCXLy8HBGMgy+34fl
         nmTDz9EbdCwuqqorzgFGbxndfsOXL7ht3MLwkmPweRe2I1EyWDzQMrMvlgvY96Tfq3
         V9QuXxJzIgNig==
Date:   Fri, 4 Dec 2020 11:40:36 +0000
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
Message-ID: <20201204114036.GB6547@gofer.mess.org>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204112115.wopx5p5elgte7gad@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204112115.wopx5p5elgte7gad@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Dec 04, 2020 at 12:21:15PM +0100, Uwe Kleine-König wrote:
> Hello Lino,
> 
> On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > On 29.11.20 at 19:10, Uwe Kleine-König wrote:
> > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > you are sure that this won't discard relevant bits, please explain
> > > this in a comment for the cursory reader.
> > 
> > What about an extra check then to make sure that the period has not been truncated,
> > e.g:
> > 
> > 	value = DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> > 
> > 	/* dont accept a period that is too small or has been truncated */
> > 	if ((value < PERIOD_MIN) ||
> > 	    (value != DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > 		return -EINVAL;
> 
> I'd make value an unsigned long long and check for > 0xffffffff instead
> of repeating the (expensive) division. (Hmm, maybe the compiler is smart
> enough to not actually repeat it, but still.)

I wonder where you got that idea from.


Sean
