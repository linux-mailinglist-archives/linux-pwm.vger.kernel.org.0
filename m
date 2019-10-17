Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BFDB61B
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfJQS2l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 14:28:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43467 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfJQS2l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 14:28:41 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLAVs-00086n-1C; Thu, 17 Oct 2019 20:28:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iLAVr-0001DC-0G; Thu, 17 Oct 2019 20:28:39 +0200
Date:   Thu, 17 Oct 2019 20:28:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Jingoo Han <jingoohan1@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Message-ID: <20191017182838.e3mx3vmwqcvb3aco@pengutronix.de>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <20191017131802.defwuzrgq4ai4mud@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017131802.defwuzrgq4ai4mud@holly.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 17, 2019 at 02:18:02PM +0100, Daniel Thompson wrote:
> On Thu, Oct 17, 2019 at 02:19:45PM +0200, Uwe Kleine-König wrote:
> > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-König wrote:
> > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > pwm_get_state() return the last implemented state")) changed the
> > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > problem in lowlevel PWM drivers. By not relying on the period and duty
> > > > cycle being retrievable from a disabled PWM this type of problem is
> > > > worked around.
> > > > 
> > > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > > combo once is also more effective.
> > > 
> > > I'm only interested in the second paragraph here.
> > > 
> > > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > So we make this change because it makes the pwm-bl better... not to
> > > work around bugs ;-).
> > 
> > That's fine, still I think it's fair to explain the motivation of
> > creating this patch.
> 
> Maybe.
> 
> Whether this patch is a workaround or simply an improvement to pwm-bl
> does need to be clear since it affects whether Lee steers it towards
> v5.4-rcX or linux-next .

Given that there will be a a fix in the pwm subsystem I'd say linux-next
sounds right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
