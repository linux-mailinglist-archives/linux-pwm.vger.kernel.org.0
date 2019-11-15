Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FBFD6E3
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 08:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKOHZh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 02:25:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOHZh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 02:25:37 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVVyz-000553-Pd; Fri, 15 Nov 2019 08:25:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVVyy-0000MK-4d; Fri, 15 Nov 2019 08:25:28 +0100
Date:   Fri, 15 Nov 2019 08:25:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 3/7] pwm: sun4i: Add an optional probe for bus clock
Message-ID: <20191115072528.7p5ks7xhifjiso2p@pengutronix.de>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-4-peron.clem@gmail.com>
 <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
 <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Clément,

On Thu, Nov 14, 2019 at 11:36:16PM +0100, Clément Péron wrote:
> On Wed, 13 Nov 2019 at 09:35, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 08, 2019 at 09:45:13AM +0100, Clément Péron wrote:
> > > +     /*
> > > +      * Fallback for old dtbs with a single clock and no name.
> > > +      * If a parent has a clock-name called "mod" whereas the
> > > +      * current node is unnamed the clock reference will be
> > > +      * incorrectly obtained and will not go into this fallback.
> >
> > For me "old dtbs" suggests that today a device tree should have a "mod"
> > clock. Is this true also for machines other than H6? And I'd put the
> > comment before the acquisition of the "mod" clock. Something like:
> 
> Agree to remove the "old dtbs" but specifying the SoC instead
> of the reason is less clear for me.
> 
> I would prefer to have something like this:
> 
> A clock is explicitly called "mod" when several clocks are referenced.
> However, when only one clock is declared this one is unamed.
> So we request "mod" first (and ignore the corner case that a parent
> provides a "mod" clock)
> and if this is not found we fall back to the first clock of the PWM.

It gets better. What about also describing shortly the purpose of this
clock (assuming this is the source clock of the PWM that is then
divided):

	All hardware variants need a source clock that is divided and
	then feeds the counter that defines the output wave form. In the
	device tree this clock is either unnamed or called "mod".
	Some variants (e.g. H6) need another clock to access the
	hardware registers; this is called "bus".

	So we request "mod" first (and ignore the corner case that a
	parent provides a "mod" clock while the right one would be the
	unnamed one of the PWM device) and if this is not found we fall
	back to the first clock of the PWM.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
