Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7AB170555
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBZRDH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 12:03:07 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:6694 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgBZRDG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 12:03:06 -0500
IronPort-SDR: 0GDSUvF+XnDP+7GKtqGT1gnbHxthphuI9OWyrhVk9BNg0cKVKfjXd0j4+rZl3Dg50SiQ38iE7w
 LNTnTovt9W3vyCFdr62D1IZRKVOhCqRVPJQYyFQD9U5P93bpQQdF/vatzGtTCjj4CiKYnMyaZ3
 sUxYjhxYlfwg/FFvyPQS0lEdXrvia7XDuXHGSEff/vn6ewfjlHRqdIh+5wswf1mVLlAblCRMfz
 MhSQbxhiMTSbhdWjYNQLXEJaZlKtgGcepO4to2VAb/Sqk7xh/j65I3eG21/09N2IQv2xdz3Lv2
 ZVw=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11124188"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 18:03:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 18:03:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 18:03:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582736585; x=1614272585;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iopQqe1w9oNjhDKgca3TywNl3uZtLLOyAoRRKrLP44=;
  b=YJSPGu9RtF5RUHZND/XtnT2GQve9zxPWxzAzQP97oafoG59KKiRgxnBB
   OHERsqi0KMLzSdxvZ4LmW+KAlVW0ZmVNTlp1ydxQ4+gaLZF8kSrVpxLk9
   PcEKH86ZJHXrUC8tsJ8yf5GtBYar02qPgvxjKqyuyypYJMiek3Z3lakPZ
   +8mSQHZt5zPL2IHO5xEkLkev7r0tLcR0jX9Rm8DiGNzI7cOBzuLz7lquq
   TJUoQhi05gxXeKmitY9HXp5CwKdPRCasRK5hdQcy10634h4MiWGM0BtB/
   f4dwjGbBuJTXaa6kzdDGrjlHujrV+zhUYSW6/HhtLQg9HwRcFHz1ASxs9
   g==;
IronPort-SDR: RBvR5LrHB/fCQ4X8Hg6HMqur6hLH3TWDGF6nCfLJHngrvYJRr8jLPlzJYyFZGpLgBcZN0U8VBy
 cLfvhj+hMRxJHz8RBOVkFOYWxCGbj6zJfoxRg9t3Stqm77goZxTUdCvEgILj0qM+drHpiMXpGy
 UaLq3pcgWZt1/SBt9LQhmKkp/yOab7UFRRRvX5RhjXYT47sn/eLfbLc6hsTnwstNQZu7reNokT
 p4eTGfnbsXKQE1mStIK3Ak7BchxVNHmvfUMAy+YsEh3UxnFSTtMFiRg5UkZ6QdVEF4/6SG2oWG
 ots=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11124187"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 18:03:05 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B59A3280065;
        Wed, 26 Feb 2020 18:03:11 +0100 (CET)
Message-ID: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Feb 2020 18:03:02 +0100
In-Reply-To: <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2020-02-26 at 16:10 +0100, Uwe Kleine-König wrote:
> Hello Matthias,
> 
> as you seem to have this hardware on your desk, it would be great if
> you
> could answer the following questions:
> 
>  - Does the hardware complete the currently running period before
>    applying a new setting?

The datasheet claims:

> Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> I 2 C-bus, and
> asynchronous to the internal oscillator, we want to ensure that we do
> not see any visual
> artifacts of changing the ON and OFF values. This is achieved by
> updating the changes at
> the end of the LOW cycle.

My interpretation is that the hardware will complete its period before
applying the new settings. I might check with a scope tomorrow-ish.


>  - Is this racy somehow (i.e. can it happen that when going from
>    duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000
> the
>    output is 1000/10000 (or 4000/5000) for one cycle)?

It currently is racy. It should be possible to fix that either by
updating all 4 registers in a single I2C write, or by using the "update
on ACK" mode which requires all 4 registers to be updated before the
new setting is applied (I'm not sure if this mode would require using a
single I2C write as well though).


>  - Does the hardware complete the currently running period before
>    .enabled = false is configured?

As my interpretation is that new settings are applied asynchronously, I
assume that the final running period is completed after .enabled is set
to false.

>  - How does the output pin behave on a disabled PWM. (Usual
> candidates
>    are: freeze where is just happens to be, constant inactive and
>    High-Z).

Constant inactive. This is also the case when the chip is put into
sleep mode. Note that the interpretation of "inactive" depends in the
invert flag in the MODE2 register.

As it turns out, this driver is broken in yet another way I didn't find
before: For changing the global prescaler the chip needs to be put into
sleep mode, but the driver doesn't follow the restart sequence
described in the datasheet when waking it back up. In consequence,
changing the period of one PWM does not only modify the period of all
PWMs (which is bad enough, but can't be avoided with this hardware),
but it also leaves all PWMs disabled...

As this hardware only has a single prescaler for all PWMs, should
changing the period for individual PWMs even be allowed at all? Maybe
only when all other PWMs are inactive?

I could imagine setting it in DTS instead (but I'm not sure what to do
about non-OF users of this driver, for example when configured via
ACPI).

Regards,
Matthias



> 
> Best regards
> Uwe
> 

