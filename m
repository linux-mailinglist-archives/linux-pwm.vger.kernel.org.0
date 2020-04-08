Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542041A1CFF
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2020 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHIA1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Apr 2020 04:00:27 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:52846 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHIA1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Apr 2020 04:00:27 -0400
IronPort-SDR: YZ3oCIIvSezQ2JQprv7PkJSs9xhG+L0gPhn9WtA0MQyxSDcZ6+F/4jpqa7BgGMytfNKrCbfwAk
 8gIP04eZuU4tKjreNARONRLOIWlO2jbspw5GTuOMpGYrHAkF0mGmELcJwBSzv8XjItRx7Pgaxi
 sK+x+Vi22sANcyhu24se/k8ql97mxsakPYO9kasYLJlPgwiSNVe2moN5AeXt+Ww+ZL4OZut4FV
 HnofLVnBSZlwBzrQFyRUqtCiYHEtFmXBiQiKXTx+28MiB9VDDV9XVToYhQk9QvActXuzTLTh2D
 IHU=
X-IronPort-AV: E=Sophos;i="5.72,357,1580770800"; 
   d="scan'208";a="11741655"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Apr 2020 10:00:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Apr 2020 10:00:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Apr 2020 10:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1586332825; x=1617868825;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FM8vvwRPjqfacbSYX2A3Kn495wuAJwFwLmZF56RyzZk=;
  b=SSGl/fKBLQ6zBBQzssjXcmB8EQF14VS/VENDmMtuGFzSGZuNELWw3417
   yr3jV7iUp2tQzDe8hr0iv6V21FDw2B2iXIfjIC6YCT6V49C6JsVi1fHRy
   JQqyBpJPEvCz8SciMnYRFa3lmdH7SaozPUKqr6P6Yb8S3Ltws0xSsOrWQ
   FkhfSfxe7rjx73M9YxhFob/R8haRAMlRW6MnOiaI+qCPP8Yh56cpds8Aq
   Tq+E2HyJ91HUgh2e5xcs3/KGKaihaajhPpGhRyIMLdWs2qToQNF3GJYi+
   SdthFoR12clqj7+uZfpkTpJfB/x0AxPZy99R6Fgh7XFVrYQFeEbU+3qco
   w==;
IronPort-SDR: /L+9vGxeIt5Jv2JplrvfzXRWrsT3Va/pLkDE2tePs1EG/Nah9lvKTPFzxS4rpn+Gf/xHBXJrQV
 tlbj0T7TD5gHwaro9S6UskRPxmQjgiqhquyEsTMc5bSYgu/7GZcqgsH9k8CSERDXBrTqew5h7P
 drrI19g/n1WMkP+YhI4SNyLI/wpQ2KUeFcyNXwtduqFROa25ugR4KcEt2+vJOYe0lZapCq92vF
 prZo/8yA1uTeHVU8TunxvTjncXrc75jSs831Zy7E/7fPJlsLukofq2Rxmvff3KHyojmn3sr/wA
 Z7E=
X-IronPort-AV: E=Sophos;i="5.72,357,1580770800"; 
   d="scan'208";a="11741654"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Apr 2020 10:00:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 45945280065;
        Wed,  8 Apr 2020 10:00:39 +0200 (CEST)
Message-ID: <405fa9612b52ee9a7c550d2ac5a2df86acb223c1.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused
 duty_cycle struct element
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Date:   Wed, 08 Apr 2020 10:00:22 +0200
In-Reply-To: <3ec5c2bd67cd714f86178a1e7143cd247759aaf8.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
         <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
         <CAGngYiUinGeppRdnsWvX4DBLVcHFBSGWamUKdTC+rTY3kpFWcQ@mail.gmail.com>
         <3ec5c2bd67cd714f86178a1e7143cd247759aaf8.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 2020-04-07 at 16:46 +0200, Matthias Schiffer wrote:
> On Fri, 2020-04-03 at 19:47 -0400, Sven Van Asbroeck wrote:
> > On Wed, Feb 26, 2020 at 12:04 PM Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > > 
> > > >  - Is this racy somehow (i.e. can it happen that when going
> > > > from
> > > >    duty_cycle/period = 1000/5000 to duty_cycle/period =
> > > > 4000/10000
> > > > the
> > > >    output is 1000/10000 (or 4000/5000) for one cycle)?
> > > 
> > > It currently is racy. It should be possible to fix that either by
> > > updating all 4 registers in a single I2C write, or by using the
> > > "update
> > > on ACK" mode which requires all 4 registers to be updated before
> > > the
> > > new setting is applied (I'm not sure if this mode would require
> > > using a
> > > single I2C write as well though).
> > 
> > Matthias, did you verify experimentally that changing the period is
> > racy?
> > 
> > Looking at the datasheet and driver code, it shouldn't be. This is
> > because
> > the OFF time is set as a proportion of the counter range. When the
> > period
> > changes from 5000 to 10000, then 5000*20%/5000 and 10000*20%/10000
> > will result in the same 20% ratio (disregarding rounding errors).
> > 
> > This is documented at the beginning of the driver:
> > 
> 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-pca9685.c?h=v5.6#n25
> > 
> > Should we move that comment to pwm_config(), so future versions of
> > ourselves won't overlook it?
> 
> You are right, this results in the same ratio - the absolute on/off
> times may be wrong for a moment though when the period is changed.
> 
> In the attached image, I have changed the period, but kept the
> absolute
> duty cycle fixed (note: this is in inverted mode, so the duty cycle
> controls the low time). It can be seen that after a too long high
> time
> (chip is in sleep mode) one period with too long low time follows
> (new
> period, old relative duty cycle), before the counter is reprogrammed
> to
> match the previous absolute duty cycle.
> 
> I don't care too much about the details of the behaviour, as I only
> control LEDs using this chip and don't need to change the period
> after
> initial setup, but we should accurately document the shortcomings of
> the hardware and the driver (when we have decided how to fix some of
> the driver issues).
> 
> Matthias

And another kind of race condition that should be possible, although I
haven't seen it in practice:

High and low bits of the OFF counter currently aren't programmed
atomically, so with unlucky timing we get a cycle using new lower 8
bits with old upper 4 bits of the duty cycle.


