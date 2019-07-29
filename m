Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF979389
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 21:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfG2TEK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 15:04:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37903 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfG2TEJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 15:04:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAwI-00078Z-O8; Mon, 29 Jul 2019 21:04:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAwG-0002rt-PT; Mon, 29 Jul 2019 21:04:04 +0200
Date:   Mon, 29 Jul 2019 21:04:04 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Message-ID: <20190729190404.rnxw2aihmciafy6c@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
 <20190729063825.wxfky6nswcru26g7@pengutronix.de>
 <4022372.WfP88Fa4Lu@jernej-laptop>
 <20190729161435.5bnj3ikocsyep4dd@pengutronix.de>
 <20190729164516.yxfgj2zd3d5ii4c4@flea.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729164516.yxfgj2zd3d5ii4c4@flea.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Maxime,

On Mon, Jul 29, 2019 at 06:45:16PM +0200, Maxime Ripard wrote:
> On Mon, Jul 29, 2019 at 06:14:35PM +0200, Uwe Kleine-König wrote:
> > Then maybe something like the following?:
> >
> > 	busclk = devm_clk_get_optional(..., "bus");
> > 	modclk = devm_clk_get_optional(..., "mod");
> >
> > 	/*
> > 	 * old dtbs might have a single clock but no clock names. Fall
> > 	 * back to this for compatibility reasons.
> > 	 */
> > 	if (!modclk) {
> > 		modclk = devm_clk_get(..., NULL);
> > 	}
> 
> Again, there's nothing optional about these clocks. You need a
> particular set of clocks for a given generation, and a separate set of
> them on another generation of SoCs.

It depends on the way how "optional" is understood. The semantic of
"optional" as it is used and implemented by devm_clk_get_optional (and
gpiod_get_optional and devm_reset_control_get_optional) is different
than yours when saying "on H6 the clock is not optional". If it was
about the "it doesn't matter if it's taken care of or not" semantic you
seem to mean the function would be useless and no driver would need to
actually use it. In the sense of the functions listed above "optional"
means: Some devices need it, others don't. Using this semantic the "bus"
clock is optional.

> It really isn't about DT validation. We're really making sure that the
> device can be operational. It's as much of a validation step than
> making sure we have mapped registers (reg), or an interrupt if we had
> any.

Do you agree with Jernej in the other end of this thread? If so I don't
think that repeating the same arguments here is sensible. Please read
what I wrote there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
