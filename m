Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9836E785EE
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfG2HM1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 03:12:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33889 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfG2HM0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 03:12:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzpU-0002Xc-0g; Mon, 29 Jul 2019 09:12:20 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzpS-0004Zz-OL; Mon, 29 Jul 2019 09:12:18 +0200
Date:   Mon, 29 Jul 2019 09:12:18 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Message-ID: <20190729071218.bukw7vxilqy523k3@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
 <20190729063630.rn325whatfnc3m7n@pengutronix.de>
 <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Jul 29, 2019 at 02:43:23PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> > >       if (IS_ERR(pwm->clk))
> > >               return PTR_ERR(pwm->clk);
> > >
> > > +     if (pwm->data->has_reset) {
> > > +             pwm->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > +             if (IS_ERR(pwm->rst))
> > > +                     return PTR_ERR(pwm->rst);
> > > +
> > > +             reset_control_deassert(pwm->rst);
> > > +     }
> > > +
> >
> > I wonder why there is a need to track if a given chip needs a reset
> > line. I'd just use devm_reset_control_get_optional() and drop the
> > .has_reset member in struct sun4i_pwm_data.
> 
> Because it's not optional for this platform, i.e. it won't work if
> the reset control (or clk, in the next patch) is somehow missing from
> the device tree.

If the device tree is wrong it is considered ok that the driver doesn't
behave correctly. So this is not a problem you need (or should) care
about.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
