Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE059BD2C
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfHXK4Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 06:56:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53387 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfHXK4Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 06:56:16 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1TiR-0001bO-Bw; Sat, 24 Aug 2019 12:56:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1TiQ-0003T7-75; Sat, 24 Aug 2019 12:56:14 +0200
Date:   Sat, 24 Aug 2019 12:56:14 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
Message-ID: <20190824105614.wpkvqqxjey6umhrs@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
 <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Stefan,

On Sat, Aug 24, 2019 at 12:05:00PM +0200, Stefan Wahren wrote:
> Am 24.08.19 um 11:25 schrieb Uwe Kleine-König:
> > Hello Stefan,
> >
> > On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
> >> This small patch series contains minor fixes for clock handling and the
> >> period range check.
> >
> > I'd like to understand the various different usecases of PWMs. The
> > in-kernel consumers are kind of obvious, but sysfs users are not. It
> > seems you are one of the latter.
> >
> > Would you mind sharing what you control using the PWM?
> 
> not really a PWM user with BCM2835. It's more the motivation as a
> platform maintainer to keep the drivers in shape. At work we are using
> sysfs interface for user applications to control ventilation (via hwmon
> interface) and EV charging (IEC 61851) with a different SoC.

I don't understand how you use the sysfs interface and still interact
with the hwmon interface. Other than that, thanks for sharing.


> > Assuming you have some interest in this driver: It still uses the legacy
> > stuff implementing .config, .enable, .disable, .set_polarity. Are you
> > willing to test (or even implement) a switch to .apply instead?
> 
> Yes, definitely. This is one of my never ending TODO list [1]. But i
> would be suprised that you wont have access to a Raspberry Pi.

So be surprised :-)

> > Just from a quick lock into the driver I wonder a few things, maybe you
> > can shed some light here. If there is publicly available documenation
> > for this piece of hardware, feel free to point this out, then I might be
> > able to work out some of the answers myself.
> 
> Fortunately yes [2]

Care to add a link to this document in the driver for others to easily
find it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
