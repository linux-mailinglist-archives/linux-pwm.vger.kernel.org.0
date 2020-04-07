Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E491A0E0D
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgDGNAr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Apr 2020 09:00:47 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:55697 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgDGNAr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 7 Apr 2020 09:00:47 -0400
IronPort-SDR: vX9VCJNXy2/YVgS4o7+c6ZW7Zx+ZX5JTzlyJT/j9Sf+7iyUjSzNyWOwQ+i9XNnB+kmE3u4wMhA
 usH7lOa6FjADv9Bz+xE75uMcTqVtBxGcPNoNlAF57edkUa6F82j/orVFszRYE20j7heDjSo1Gj
 MD6mcePXf3xWpW5L+HGp2+6+DwjNOWE5Fmmi7889n+MBgqCJAIjZVEQGkZXPM1tlyt4tu3aOcy
 6+Of9TUj4/e1+bRZivppD+N8mNn8gygMxqWyCDZQHKBp/hdn36Vt+S6SZo2aF15WHsYt/D5oDi
 vU8=
X-IronPort-AV: E=Sophos;i="5.72,354,1580770800"; 
   d="scan'208";a="11729933"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Apr 2020 15:00:46 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 07 Apr 2020 15:00:46 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 07 Apr 2020 15:00:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1586264446; x=1617800446;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQ3s2zq914H4XFTE/o+/VvV69xX8LMUBVXfoorhVAPs=;
  b=HCmB3RY3+j2HQJeg7sQiFyEm5b5fW2+1UpL3+bD3Svctenu7HafWac9T
   xaZAjOSiqvyyLlP2VCqr3D0MSuim7cJfXkjoYe1YoFgze8flJPpkT7BLR
   X2p+6+QkfZdgO9zVnkLQDFPQ7dWLtYDaIXgcGqGfB0HU3cM2rrI8p8pzv
   qNhPixxhQL2LAlZ40GxRDRIT/BY41rs4rSXWkVQjfhBWDZoPUq1uERgxO
   bDPOlAJ7i1XsGlk3SFFqdY6ieDN+PXhlDrYCz9UUD056oJ0/KjCIYyHb+
   Sj+TXrnW9BL0IE2iFeJBqoMQcuOM/2dmfa0JsVZbPuozRyczq89o8YElB
   g==;
IronPort-SDR: AjznDtyTCMfTD+LjD8ZpyeKRkwSJBQS//2NPJiFSj/7uHyH9AbjOMBqCWdlmqqxCFoJ34Vxrf8
 DB5zrWcU/GD16xG6ERSPvYSAzlKESJ6qbZ4CVFESZ2O8HSbnAu7vZo30BdSpTtRTHtFMAccCWg
 fJA+DMv4ayr/jyXb2Kw/97+FNG1KJx9cju7HljfGtSz2R7rq3QJz8IV2TwySyV/+/sJqPiDrTu
 HdPcrqobJKyfQSkTf1tFYNOvXEGSg3nXzen5xi4v2KlZ+OuQms9pQikL/3NmLFe4wutCIqZE7r
 T7g=
X-IronPort-AV: E=Sophos;i="5.72,354,1580770800"; 
   d="scan'208";a="11729932"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Apr 2020 15:00:45 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B6ED8280065;
        Tue,  7 Apr 2020 15:00:58 +0200 (CEST)
Message-ID: <189a1fb7f7aee153151f46fe3bb0f754160472e7.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused
 duty_cycle struct element
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 07 Apr 2020 15:00:43 +0200
In-Reply-To: <20200406095124.GA475759@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
         <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
         <20200330151231.GA1650@workstation.tuxnet>
         <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
         <20200404173546.GA55833@workstation.tuxnet>
         <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
         <20200406095124.GA475759@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 2020-04-06 at 11:51 +0200, Thierry Reding wrote:
> 
> On Sat, Apr 04, 2020 at 04:17:00PM -0400, Sven Van Asbroeck wrote:
> > 
> > It does look like we have a square peg (this chip) in a round hole
> > (the
> > standard assumptions the pwm core makes) ?
> 
> There are other chips where a single period is shared across multiple
> PWM channels. Typically what we do there is once a period is
> configured
> for a given channel, all subsequent PWM channel configurations must
> use
> the same period, or otherwise the driver will return an error code.
> 
> See for example:
> 
>   - stm32_pwm_config() in drivers/pwm/pwm-stm32.c
>   - lpc18xx_pwm_config() in drivers/pwm/pwm-lpc18xx-sct.c
>   - pwm_imx_tpm_apply_hw() in drivers/pwm/pwm-imx-tpm.c
>   - fsl_pwm_apply_config() in drivers/pwm/pwm-fsl-ftm.c
> 
> The rationale behind that is that we must not change a PWM
> configuration
> without a consumer having explicitly requested it.

These implementations don't deal with the issue in a consistent way
either though:

1) stm32_pwm_config() only checks for channels that are actually
enabled, regardless if they're requested

2) lpc18xx_pwm_config() checks requested channels instead

"2)" seems more correct to me, as the parameters of a requested channel
can't be changed by another user, but it seems to prevent certain
sequences. I don't have a good grasp of the the usual PWM request
control flow - is it correct that the PWM state is not updated with the
PWM args from OF when the PWM is requested? I only see
pwm_adjust_config() doing something like that, which is not used in
many places (and nothing preventing races) - but I might be overlooking
something.

Meaning, is it possible that two drivers request PWMs from the same
pwmchip of type "2)" (or even a single driver using two PWMs) without
configuring them right away may get into a situation where neither can
set up a period at all even when all users want to use the same period?

Matthias

