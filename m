Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4DBB007
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfIWIyS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:54:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbfIWIyR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:54:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCK6p-0002FR-FW; Mon, 23 Sep 2019 10:54:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCK6o-0000rV-MN; Mon, 23 Sep 2019 10:54:14 +0200
Date:   Mon, 23 Sep 2019 10:54:14 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] pwm: mxs: add support for inverse polarity
Message-ID: <20190923085414.6d3gbby6gglpjsfe@pengutronix.de>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-4-linux@rasmusvillemoes.dk>
 <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
 <d2b29144-3de8-4561-3292-49db7e697aca@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2b29144-3de8-4561-3292-49db7e697aca@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 23, 2019 at 10:45:56AM +0200, Rasmus Villemoes wrote:
> On 23/09/2019 10.27, Uwe Kleine-König wrote:
> > On Mon, Sep 23, 2019 at 10:13:47AM +0200, Rasmus Villemoes wrote:
> >>
> >>  
> >> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
> >> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
> >> +
> >>  	writel(duty_cycles << 16,
> >>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
> >> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
> >> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
> > 
> > When will this affect the output? Only on the next start of a period, or
> > immediatly? Can it happen that this results in a mixed output (i.e. a
> > period that has already the new duty cycle from the line above but not
> > the new polarity (or period)?
> 
> The data sheet says "Also, when the user reprograms the channel in this
> manner, the new register values will not take effect until the beginning
> of a new output period. This eliminates the potential for output
> glitches that could occur if the registers were updated while the
> channel was enabled and in the middle of a cycle.". So I think this
> should be ok. "this manner" refers to the registers being written in the
> proper order (first ACTIVEn, then PERIODn).

OK. IMHO this is worth a code comment.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
