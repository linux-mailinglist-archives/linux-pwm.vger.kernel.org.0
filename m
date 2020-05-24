Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736A61E018D
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbgEXS4e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbgEXS4e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 14:56:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D026C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 11:56:34 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcvnS-0006jB-Hi; Sun, 24 May 2020 20:56:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcvnQ-00054U-E9; Sun, 24 May 2020 20:56:28 +0200
Date:   Sun, 24 May 2020 20:56:28 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20200524185628.bfx4qefdr3eet22r@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
 <20200413121445.72996-3-paul@crapouillou.net>
 <20200524173711.ofprgoueyimhkowj@pengutronix.de>
 <N9KUAQ.VPI8V42FNJQU@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <N9KUAQ.VPI8V42FNJQU@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Paul,

On Sun, May 24, 2020 at 07:51:23PM +0200, Paul Cercueil wrote:
> Le dim. 24 mai 2020 à 19:37, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Mon, Apr 13, 2020 at 02:14:45PM +0200, Paul Cercueil wrote:
> > >  @@ -214,6 +218,7 @@ static int jz4740_pwm_probe(struct
> > > platform_device *pdev)
> > >   {
> > >   	struct device *dev = &pdev->dev;
> > >   	struct jz4740_pwm_chip *jz4740;
> > >  +	const struct soc_info *info = device_get_match_data(dev);
> > > 
> > >   	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
> > >   	if (!jz4740)
> > >  @@ -227,8 +232,8 @@ static int jz4740_pwm_probe(struct
> > > platform_device *pdev)
> > > 
> > >   	jz4740->chip.dev = dev;
> > >   	jz4740->chip.ops = &jz4740_pwm_ops;
> > >  -	jz4740->chip.npwm = NUM_PWM;
> > >   	jz4740->chip.base = -1;
> > >  +	jz4740->chip.npwm = info ? info->num_pwms : NUM_PWM;
> > 
> > Can info be actually NULL? I don't think so, so you can just use
> > info->num_pwms here and drop the definition of NUM_PWM.
> 
> In *theory* it can be NULL if the kernel is configured without CONFIG_OF,
> which will never happen on any board supported by this driver. I can add a
> dependency on CONFIG_OF in V2, then use info->num_pwms there.

I'd prefer just something like:

	if (!info)
		return -EINVAL;

instead of a dependency on CONFIG_OF.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
