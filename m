Return-Path: <linux-pwm+bounces-475-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6980B37C
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6668B20A5C
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F411706;
	Sat,  9 Dec 2023 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ji0yme4w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED210C7;
	Sat,  9 Dec 2023 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702115529; bh=ylrgEA3zbjC4BUaTh9xcfvwH7XspfsRlgzCDfDuD0Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji0yme4wBw9VwSR0+h+ffZxLjj3LK6jkp4/rm+0K39pVYaYYMpMVcTYEj74xUfhfg
	 ET9cjglES2OqhiijJjav7UxIQvVLUFAYSvNRXwK+oxqfh8xTNxqNszVxqYs9tWJ6AJ
	 pnK7Jnyia/WJOrRq179PhiZ6zLIh/dPzuwTKA2qrujCbiYlx7Kx4EcTTVDtrUkN9rl
	 uh91y3c48meztAKYlLdvsL5pThDPl/uZMyVM1iecO4721Uy97/oGFqybVA9mTcmB4+
	 u8k9qDhW7glRaPj2SeLJHvxWVSB/KOTVWM8vte2/PRAUFMAh+1/GuHoMMoEJtq6mL8
	 F0ogWKqRYA0OQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 4D4D1100091; Sat,  9 Dec 2023 09:52:09 +0000 (GMT)
Date: Sat, 9 Dec 2023 09:52:09 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZXQ4yYx8QKu6wWwY@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <88fdb3a200989458c6f95c26fa9bb84c1e864798.1701248996.git.sean@mess.org>
 <ZXNEg3ax4MChSJ5A@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNEg3ax4MChSJ5A@orome.fritz.box>

On Fri, Dec 08, 2023 at 05:29:55PM +0100, Thierry Reding wrote:
> On Wed, Nov 29, 2023 at 09:13:37AM +0000, Sean Young wrote:
> > This makes the generated IR much more precise. Before this change, the
> > driver is unreliable and many users opted to use gpio-ir-tx instead.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 76 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> > index cf51e2760975..8575c4596d7b 100644
> > --- a/drivers/media/rc/pwm-ir-tx.c
> > +++ b/drivers/media/rc/pwm-ir-tx.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/completion.h>
> >  #include <media/rc-core.h>
> >  
> >  #define DRIVER_NAME	"pwm-ir-tx"
> > @@ -17,8 +19,14 @@
> >  
> >  struct pwm_ir {
> >  	struct pwm_device *pwm;
> > -	unsigned int carrier;
> > -	unsigned int duty_cycle;
> > +	struct hrtimer timer;
> > +	struct completion tx_done;
> > +	struct pwm_state *state;
> > +	u32 carrier;
> > +	u32 duty_cycle;
> > +	uint *txbuf;
> 
> Maybe mark this as const to signal that it's not going to get modified?

Ah nice, I usually forget const. 

> > +	uint txbuf_len;
> > +	uint txbuf_index;
> 
> uint is rather rare. Or so I thought. There seem to be quite a few
> occurrences throughout the kernel. I'd still prefer unsigned int over
> this abbreviated form, but ultimately up to you and Mauro to decide.

Yes, unsigned int is used a lot more. Changed.

> >  static int pwm_ir_probe(struct platform_device *pdev)
> >  {
> >  	struct pwm_ir *pwm_ir;
> > @@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
> >  	if (!rcdev)
> >  		return -ENOMEM;
> >  
> > +	if (pwm_is_atomic(pwm_ir->pwm)) {
> > +		init_completion(&pwm_ir->tx_done);
> > +		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +		pwm_ir->timer.function = pwm_ir_timer;
> > +		rcdev->tx_ir = pwm_ir_tx_atomic;
> > +	} else {
> > +		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not support atomic mode");
> 
> s/tx/TX and s/pwm/PWM/? Also, I'm a bit unhappy about "atomic mode" here
> because the term is overloaded in PWM. If you call pwm_appy_*() then by
> definition it's going to be "atomic" in the "atomic state" sense. So
> maybe switch to something like:
> 
> 	"TX will not be accurate as PWM device might sleep"
> 
> ?

Very nice, changed.

Thanks
Sean

