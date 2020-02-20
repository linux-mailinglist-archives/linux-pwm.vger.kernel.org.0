Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C6216698F
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2020 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBTVHZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Feb 2020 16:07:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgBTVHZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Feb 2020 16:07:25 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j4t2W-000495-Ch; Thu, 20 Feb 2020 22:07:20 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j4t2V-0002Rs-0N; Thu, 20 Feb 2020 22:07:19 +0100
Date:   Thu, 20 Feb 2020 22:07:18 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Ray Jui <rjui@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
Message-ID: <20200220210718.4vrn6u2c2remeuhm@pengutronix.de>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
 <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
 <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[Dropping Bart Tanghe from recipents as the address bounces]

Hello Thierry,

On Thu, Feb 20, 2020 at 11:14:00AM -0800, Florian Fainelli wrote:
> On 2/4/20 1:17 AM, Nicolas Saenz Julienne wrote:
> > On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
> >> The newer 2711 and 7211 chips have two PWM controllers and failure to
> >> dynamically allocate the PWM base would prevent the second PWM
> >> controller instance being probed for succeeding with an -EEXIST error
> >> from alloc_pwms().
> >>
> >> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> > 
> > Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> Thierry, is there any chance we can get this applied for an upcoming
> 5.6-rcX? Thank you!

to assist you with patch sorting:

# revisions < v6 of "Convert period and duty cycle to u64"
pwclient -s Superseded 1237020 1237019 1229049 1229050 1222396

# most of "Add support for Azoteq IQS620A/621/622/624/625" v5 isn't for pwm
pwclient -s "Not Applicable" 1238908 1238907 1238906 1238904 1238903 1238901

# most of "Add support for Azoteq IQS620A/621/622/624/625" v4 isn't for pwm
pwclient -s "Not Applicable" 1224598 1224597 1224596 1224594 1224593 1224592
pwclient -s "Superseeded" 1224595

# "backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial
# state" already applied by Lee Jones
pwclient -s "Not Applicable" 1031586

# Problem resolved by Michal Vokáč
pwclient -s "Rejected"  1059267

(Not sure "Rejected" is the right state.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
