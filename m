Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0817041F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 17:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBZQSF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 11:18:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54277 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgBZQSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 11:18:03 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zNm-0004jT-CN; Wed, 26 Feb 2020 17:17:58 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zNl-0001DH-Qq; Wed, 26 Feb 2020 17:17:57 +0100
Date:   Wed, 26 Feb 2020 17:17:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224165859.GJ6215@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:
> On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> > Deferred probe is an expected return value for devm_pwm_get(). Given
> > that the driver deals with it properly, there's no need to output a
> > warning that may potentially confuse users.
> 
> >  		ret = PTR_ERR(drvdata->pwm);
> > -		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> 
> This then means that there's no way for users to determine why the
> driver has failed to instantiate which can be frustrating.  It'd be
> better to at least have some dev_dbg() output when deferring so that
> there's something for people to go on without having to instrument the
> code.

Not printing an error message is quite usual however. I think a generic
approach that for example makes the list of devices that should be
retried to probe on the next opportunity inspectable would be nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
