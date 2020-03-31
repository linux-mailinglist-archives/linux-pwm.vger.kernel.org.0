Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE22199600
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCaMJr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 08:09:47 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:25824 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbgCaMJr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:47 -0400
IronPort-SDR: 1pLPeIUbqBFv7uwxcgU4lJyyXcYPe7/Z16YlrzKeHrUV02t77tWrd+NzFIkFWLGg2/IpRHTU4H
 KE6JyyYFt3dPHA6h/JXdUMF5EiK9O96Ze0NdOQmoklMURYjTUERllmiZ8M/PLDDbvpOf6l+swP
 LqRXSI4uURXxFSmUD/2ZZtJ6kYdtNeU3kQw5SC4glFbnOAx1OBNx3YKrfOhcjm2r1dcvfUGBsg
 EeMqAU+JwXg6zu2gfa00OU6sP/ZN2x6eTsjOAc5L6E2pAcZKG9m9J5jDKKMJ5Gk217MottZzwm
 2x8=
X-IronPort-AV: E=Sophos;i="5.72,327,1580770800"; 
   d="scan'208";a="11625427"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Mar 2020 14:09:43 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Mar 2020 14:09:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Mar 2020 14:09:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1585656585; x=1617192585;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWZtlXFyUVM3l9pC7BDSnjkXf8d1ZwKzD62ozOGuHJE=;
  b=Eke2raKekaNAckmG0HJN3BvvW2+qF+fxF66X7cu2/EBlA/1K0XVK+UX1
   44Yz+Eb1RkCLc0RGgnp4+yCiYIKig0e6ntZG1erPBGFhTUa3zMFZKM3TG
   o/0awDCPBrHo7Xi7HcBAJkvye4yGweYEdDrUVgMzULB/mo+2Z7wxIb1cQ
   OZvjgyynR2aoiBQt94L4UhhMdoQZXnSqYkAHqBsNhoVzRX22j/hWPEI5I
   RVkPlSHl34g3zOBkKoD9/SN7zW27D0RTqneIPI6sRzGtsxPKh9t+DedB+
   rtD8ZBVP8NbN7KMiKL2TAeIUrg3x4KwQ7xx1tu+5GMm+jS8OX7+ITQXRP
   Q==;
IronPort-SDR: gX7kQwZcW1p2k+24lCrPRn4wR3Jl2W7uEkPj8s33I57W5c93GMldJ1GXNc7t7d6zREng24Bi6L
 2+eoNBJy6MjmBqP/3516TpjDVEV74OqTQU5aIbKXx5qzv01xI3weiEXuUlkXhz3vT5858nHvR/
 xcuUbweecQXU8+SmY8IXKIaDxwmSFTZ311A/Bgq7Zu5VvGRh6pUU1Dlz97nIzewl5EmU/rb1kW
 Ot9lZw8QlO4OXyIlc82MmlkC51EtwsMH88lVSS2w2ZFDZaFnch3e0mRY7acYKxmnW8gIltfcNq
 /KE=
X-IronPort-AV: E=Sophos;i="5.72,327,1580770800"; 
   d="scan'208";a="11625426"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Mar 2020 14:09:42 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 78071280065;
        Tue, 31 Mar 2020 14:09:45 +0200 (CEST)
Message-ID: <452f4e03cc2a998c7a903251f99931935b1f872f.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Date:   Tue, 31 Mar 2020 14:09:37 +0200
In-Reply-To: <20200330160744.GA777@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
         <20200330130757.GC2431644@ulmo> <20200330133450.GA1530@workstation.tuxnet>
         <20200330154036.GB2817345@ulmo> <20200330160744.GA777@workstation.tuxnet>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 2020-03-30 at 18:07 +0200, Clemens Gruber wrote:
> On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> > On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > > Hi,
> > > 
> > > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer
> > > > wrote:
> > > > > The interaction of the ALL_LED PWM channel with the other
> > > > > channels was
> > > > > not well-defined. As the ALL_LED feature does not seem very
> > > > > useful and
> > > > > it was making the code significantly more complex, simply
> > > > > remove it.
> > > > > 
> > > > > Signed-off-by: Matthias Schiffer <
> > > > > matthias.schiffer@ew.tq-group.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------
> > > > > ------------
> > > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > > > 
> > > > Applied, thanks.
> > > > 
> > > > Thierry
> > > 
> > > I was not reading the mailing list in the last weeks, so I only
> > > saw the
> > > patch today.
> > > 
> > > We are using the ALL_LED channel in production to reduce the
> > > delay when
> > > all 16 PWM outputs need to be set to the same duty cycle.
> > > 
> > > I am not sure it is a good idea to remove this feature.
> > 
> > Can you specify what platform this is and where the code is that
> > does
> > this. I can't really find any device tree users of this and I don't
> > know
> > if there's a good way to find out what other users there are, but
> > this
> > isn't the first time this driver has created confusion, so please
> > help
> > collect some more information about it's use so we can avoid this
> > in the
> > future.
> 
> The platform is ARM, it's a custom board with an NXP i.MX6. The
> device
> tree is not upstreamed. As there are multiple companies involved
> in changes to this driver, I assume that it is in use, even though
> there
> are no in-tree users.
> Also: As you can set the ALL channel from userspace, it will be very
> difficult to find out how often the ALL feature is being used
> somewhere.
> 
> > 
> > I'll back out this particular patch since you're using it. Can you
> > give
> > the other three patches a try to see if they work for you?
> 
> Thanks! I saw your other mail. Patch 1 looks good to me. I will look
> at
> the new version of patches 3 and 4 and test them when they appear on
> the
> list.
> 
> Clemens

Thanks for the feedback, I'll have to respin my cleanup patches without
removing this feature.

I wonder if we can come up with a sane semantics of how ALL_LED is
supposed to interact with the individual channels? Optimally, changes
made via ALL_LED should be reflected in the state of the other channels
including their sysfs files, but I'm not sure if current APIs can
support this cleanly. It might make sense to make requesting/exporting
individual channels and ALL_LED mutually exclusive, so the state of a
requested PWM can't change when it's supposed to be under exclusive
control of one user. Of course, such a change can break existing users
as well...

And what about state propagation in the other direction - how should
the ALL_LED state reflect changes made to the other channels' settings?
On the hardware side, the ALL_LED registers are write-only, as there
aren't any sane values that could be returned.

Matthias



