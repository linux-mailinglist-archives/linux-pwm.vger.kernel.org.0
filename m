Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB69317B7BD
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 08:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFHvg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 02:51:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43007 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgCFHvf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 02:51:35 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7lZ-0001YG-Vh; Fri, 06 Mar 2020 08:51:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7lZ-0004WQ-EO; Fri, 06 Mar 2020 08:51:29 +0100
Date:   Fri, 6 Mar 2020 08:51:29 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200306075129.mzs22yjitkmgrthh@pengutronix.de>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
 <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
 <20200226163905.GH4136@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226163905.GH4136@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Feb 26, 2020 at 04:39:05PM +0000, Mark Brown wrote:
> On Wed, Feb 26, 2020 at 05:17:57PM +0100, Uwe Kleine-König wrote:
> > On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:
> 
> > > This then means that there's no way for users to determine why the
> > > driver has failed to instantiate which can be frustrating.  It'd be
> > > better to at least have some dev_dbg() output when deferring so that
> > > there's something for people to go on without having to instrument the
> > > code.
> 
> > Not printing an error message is quite usual however. I think a generic
> 
> Usual yet also frustraing.
> 
> > approach that for example makes the list of devices that should be
> > retried to probe on the next opportunity inspectable would be nice.
> 
> That's not really the issue, the bigger issue is trying to figure out
> why things are stuck - what exactly caused things to fail to
> instantiate.

I wonder if we should do something like:

	ret = some_call(some, args);
	if (ret) {
		if (emit_errmsg_for_err(ret))
			dev_err(dev, "some_call failed: %pE\n", ERR_PTR(ret));
		return ret;
	}

and have emit_errmsg_for_err return true if ret != -EPROBE_DEFER or some
kernel parameter is given.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
