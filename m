Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077E27A71A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1FwV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1FwU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 01:52:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64BC0613CE
        for <linux-pwm@vger.kernel.org>; Sun, 27 Sep 2020 22:52:20 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMm58-0006jL-Ml; Mon, 28 Sep 2020 07:52:14 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kMm58-00046a-6l; Mon, 28 Sep 2020 07:52:14 +0200
Date:   Mon, 28 Sep 2020 07:52:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/5] pwm: imx27: enable clock unconditional for
 register access
Message-ID: <20200928055214.GQ29466@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-2-m.felsch@pengutronix.de>
 <20200926134823.zog3722y3l3ti25x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200926134823.zog3722y3l3ti25x@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:50:23 up 219 days, 17:07, 234 users,  load average: 2.56, 3.42,
 4.71
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20-09-26 15:48, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Sep 25, 2020 at 05:53:26PM +0200, Marco Felsch wrote:
> > The current implementation enables the clock if the current PWM state
> > is '!enabled' to ensure the register access and left the clock on if the
> > new state is 'enabled'. Further apply calls don't enable the clock since
> > they relying on the fact the the clock is already running. Change this
> > behaviour since it is not very intuitive.
> > 
> > This commit changes this behaviour. Now the clocks are unconditional
> > enabled/disabled before/after the register access. If the PWM should be
> > turned on (state.enabled) we enable the clock again and vice versa if
> > the PWM should be turned off (!state.enabled).
> > 
> > Therefore I added the enable member to the driver state struct since
> > the usage of cstate and pwm_get_state() is a layer violation. I removed
> > this violation while on it.
> 
> while looking through patch 2 I found something missing here:
> You don't initialize .enabled in .probe().

Arg.. you are right. Thanks for covering this. Didn't recognized it
since I added this in patch 4/5.

Any comments left on this series?

Regards,
  Marco

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
