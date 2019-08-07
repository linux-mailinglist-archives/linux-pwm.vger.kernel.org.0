Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0554384DDA
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfHGNtQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 09:49:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38329 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbfHGNtQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 09:49:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvMJX-0005mP-Jo; Wed, 07 Aug 2019 15:49:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hvMJX-0005Nl-2x; Wed, 07 Aug 2019 15:49:15 +0200
Date:   Wed, 7 Aug 2019 15:49:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: jz4740: document known limitations
Message-ID: <20190807134915.njgbpbfsy44aqba6@pengutronix.de>
References: <1564435163.6633.4@crapouillou.net>
 <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
 <1565185351.1834.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565185351.1834.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 07, 2019 at 03:42:31PM +0200, Paul Cercueil wrote:
> 
> 
> Le mar. 30 juil. 2019 à 14:32, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > The jz4740 PMW implementation doesn't fulfill the (up to now
> > insufficiently documented) requirements of the PWM API. At least
> > document them in the driver.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > I intended to also add a Link to the reference manual, Paul suggested to
> > use https://zcrc.me/~paul/jz_docs/ in December last year, but this
> > stopped to work.
> > 
> > The second item is something I noticed when reading through the manual,
> > but it's not confirmed in practise. A test that this is indeed the case
> > could be done by configuring a long period (say 5s) and a (in
> > comparison) small duty-cycle (say 1s). If the pwm output isn't active
> > when the call returns I'd consider this proven.
> > 
> > @Paul: would you mind doing this test?
> 
> You're correct. I configured it for 4s period and 2s duty. After enabling
> the
> PWM, it stays LOW for two seconds then switches HIGH for two seconds.
> 
> That can be corrected, though, by inverting the configured polarity when the
> PWM is running and set "period - duty" as the duty value. I can make a patch
> for that.

OK. Do you care for documenting the first limitation then, too?

Or should we apply my patch as is and you remote the second item when
you fix it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
