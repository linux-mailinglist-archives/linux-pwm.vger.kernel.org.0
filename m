Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248C2F80D2
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 21:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKUJJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 15:09:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40485 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKUJJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 15:09:09 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFzn-0005PY-Gm; Mon, 11 Nov 2019 21:09:07 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFzn-000190-1b; Mon, 11 Nov 2019 21:09:07 +0100
Date:   Mon, 11 Nov 2019 21:09:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pwm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
Message-ID: <20191111200907.vclloogaiu3mqxsn@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
 <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 11, 2019 at 02:41:58PM +0100, Markus Elfring wrote:
> > This was found by coccicheck:
> >
> > 	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
> > 	call of_find_device_by_node on line 255, but without a corresponding
> > 	object release within this function.
> 
> How do you think about to add a wording according to “imperative mood”
> for your change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c#n151

Are you a bot?

> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> …
> > @@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> …
> >  	pdata->free(dm_timer);
> > -put:
> > +err_request_timer:
> > +
> > +err_timer_property:
> > +err_platdata:
> > +
> > +	put_device(&timer_pdev->dev);
> 
> Would the use of the label “put_device” be more appropriate?
> 
> 
> > +err_find_timer_pdev:
> > +
> >  	of_node_put(timer);
> …
> 
> Would the use of the label “put_node” be better here?
> 
> 
> > @@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
> >
> >  	omap->pdata->free(omap->dm_timer);
> >
> > +	put_device(&omap->dm_timer_pdev->dev);
> > +
> >  	mutex_destroy(&omap->mutex);
> >
> >  	return 0;
> 
> I suggest to omit a few blank lines.

And I like it the way it is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
