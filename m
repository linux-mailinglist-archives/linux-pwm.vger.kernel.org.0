Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB7F80CD
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 21:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKKUID (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 15:08:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKKUID (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 15:08:03 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFyi-0005JH-Jj; Mon, 11 Nov 2019 21:08:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFyi-00018m-3O; Mon, 11 Nov 2019 21:08:00 +0100
Date:   Mon, 11 Nov 2019 21:08:00 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pwm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
Message-ID: <20191111200800.7njfdz7w3offt6we@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
 <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 11, 2019 at 02:32:30PM +0100, Markus Elfring wrote:
> > Implementation note: The put: label was never reached without a goto and
> > ret being unequal to 0, so the removed return statement is fine.
> 
> This can look fine (in principle) because the label was repositioned here.
> Do you really want to call the function “of_node_put” at two places now?

Yes, this is in my eyes more sensible. Either you have the expected path
and the error path interwinded, or you have to duplicate some cleanup.
IMHO the latter variant is the one that is easier to understand and the
one where it's less likely to oversee a needed cleanup.

> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> …
> >  	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
> >  	if (!omap) {
> > -		pdata->free(dm_timer);
> > -		return -ENOMEM;
> > +		ret = -ENOMEM;
> > +		goto err_alloc_omap;
> >  	}
> …
> 
> I suggest to reconsider your label name selection according to
> the Linux coding style.

Documentation/process/coding-style.rst states: "Choose label names which
say what the goto does or why the goto exists." So I'd say my names are
perfectly fine.

> > @@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> …
> > +err_pwmchip_add:
> > +
> > +	/*
> > +	 * *omap is allocated using devm_kzalloc,
> > +	 * so no free necessary here
> > +	 */
> > +err_alloc_omap:
> > +
> > +	pdata->free(dm_timer);
> 
> Would the use of the label “free_dm_timer” be more appropriate?

Either you name your labels after what the code at the label does (then
"free_dm_timer" is good) or you name it after why you are here (and then
err_alloc_omap is fine). I prefer the latter style and then the label
name always has to correspond to the action just above it (if any).
That's why I grouped the "err_alloc_omap" label to a comment saying that
*omap doesn't need to be freed.

> > +put:
> > +	of_node_put(timer);
> …
> 
> Can the label “put_node” be nicer?

I agree that the label name is bad. I kept the name here and after the
3rd patch the label names are consistent. 

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
