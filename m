Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9529572873
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jul 2019 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGXGry (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Jul 2019 02:47:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXGry (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Jul 2019 02:47:54 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqB41-0006XM-CV; Wed, 24 Jul 2019 08:47:49 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hqB3x-0004ZG-Mb; Wed, 24 Jul 2019 08:47:45 +0200
Date:   Wed, 24 Jul 2019 08:47:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/6] pwm: jz4740: Apply configuration atomically
Message-ID: <20190724064745.7ghecdpg3gmxsiim@pengutronix.de>
References: <20190607154410.10633-1-paul@crapouillou.net>
 <20190607154410.10633-4-paul@crapouillou.net>
 <20190722193456.h4hfte5cczucermd@pengutronix.de>
 <1563914800.1918.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563914800.1918.0@crapouillou.net>
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

On Tue, Jul 23, 2019 at 04:46:40PM -0400, Paul Cercueil wrote:
> Le lun. 22 juil. 2019 à 15:34, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Fri, Jun 07, 2019 at 05:44:07PM +0200, Paul Cercueil wrote:
> > >  -	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
> > >  -	if (is_enabled)
> > >  -		jz4740_pwm_disable(chip, pwm);
> > >  +	jz4740_pwm_disable(chip, pwm);
> > 
> > I assume this stops the PWM. Does this complete the currently running
> > period? How does the PWM behave then? (Does it still drive the output?
> > If so, on which level?)
> 
> Some PWM channels work in one mode "TCU1" and others work in "TCU2". The
> mode in which channels work depends on the version of the SoC.
> 
> When stopped, the pins of TCU1 channels will be driven to the inactive
> level (which depends on the polarity). It is unknown whether or not the
> currently running period is completed. We set a bit to configure for
> "abrupt shutdown", so I expect that it's not, but somebody would need
> to hook up a logic analyzer to see what's the exact behaviour with
> and without that bit.

This might be done even without a logic analyzer. Just do something
like:

	pwm_apply_state(pwm, { .enabled = 1, .period = 5s })
	pwm_apply_state(pwm, { .enabled = 1, .period = 5s, .duty = 5s })

and if that takes less then 5s the period is not completed.

And note that "abrupt shutdown" is a bug.

> TCU2 channels on the other hand will stop in the middle of a period,
> leaving the pin hanging at whatever level it was before the stop.
> That's the rationale behind the trick in commit 6580fd173070 ("pwm:
> jz4740: Force TCU2 channels to return to their init level").

Strange, but ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
