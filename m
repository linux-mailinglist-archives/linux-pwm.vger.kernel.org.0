Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14681EF5DF
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 08:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfKEHBi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 02:01:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbfKEHBi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 02:01:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1iRsqI-00057P-4n; Tue, 05 Nov 2019 08:01:30 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <pza@pengutronix.de>)
        id 1iRsqG-0008UW-VW; Tue, 05 Nov 2019 08:01:28 +0100
Date:   Tue, 5 Nov 2019 08:01:28 +0100
From:   Philipp Zabel <pza@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 2/7] pwm: sun4i: Add an optional probe for reset line
Message-ID: <20191105070128.ve73ha5ibiymcxnx@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-3-peron.clem@gmail.com>
 <20191104081157.373v22atswsaktbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104081157.373v22atswsaktbe@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:50:49 up 120 days, 13:01, 112 users,  load average: 0.25, 0.17,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 04, 2019 at 09:11:57AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> adding Philipp Zabel (= reset controller maintainer) to Cc: and so I'm
> not stripping the uncommented parts of the patch.
> 
> On Sun, Nov 03, 2019 at 09:33:29PM +0100, Clément Péron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > H6 PWM core needs deasserted reset line in order to work.
> > 
> > Add an optional probe for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..d194b8ebdb00 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/time.h>
> > @@ -78,6 +79,7 @@ struct sun4i_pwm_data {
> >  struct sun4i_pwm_chip {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> > +	struct reset_control *rst;
> >  	void __iomem *base;
> >  	spinlock_t ctrl_lock;
> >  	const struct sun4i_pwm_data *data;
> > @@ -365,6 +367,20 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pwm->clk))
> >  		return PTR_ERR(pwm->clk);
> >  
> > +	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> > +	if (IS_ERR(pwm->rst)) {
> > +		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
> > +			return PTR_ERR(pwm->rst);
> > +		dev_info(&pdev->dev, "no reset control found\n");
> 
> I would degrade this to a dev_dbg. Otherwise this spams the log for all
> unaffected machines.

The _optional variants return NULL if the reset is not specified in the
device tree, so this is not "no reset control found", but a real error
that should be returned.

> devm_reset_control_get_optional() is defined in a section that has a
> comment "These inline function calls will be removed once all
> consumers have been moved over to the new explicit API.", so I guess
> you want devm_reset_control_get_optional_exclusive or even
> devm_reset_control_get_optional_shared here.

Correct. If this driver deasserts in probe() and asserts the reset in
remove(), this can use the refcounting _shared variant.

> @Philipp: maybe a check in checkpatch that warns about introduction of
> such new instances would be good?!

Yes, that would be helpful.

regards
Philipp
