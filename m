Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686D692198
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHSKq2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 06:46:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSKq1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 06:46:27 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzfB4-0008TA-3G; Mon, 19 Aug 2019 12:46:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzfB3-00050a-30; Mon, 19 Aug 2019 12:46:17 +0200
Date:   Mon, 19 Aug 2019 12:46:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Message-ID: <20190819104617.kujgwthxtjy6cssa@pengutronix.de>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
 <0a389abe-15ef-0e63-109f-2db4cb36f4b9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a389abe-15ef-0e63-109f-2db4cb36f4b9@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 09:26:04AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 16.08.2019 12:37, Uwe Kleine-König wrote:
> > External E-Mail
> > 
> > 
> > Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> > ---
> >  drivers/pwm/pwm-atmel.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 42fe7bc043a8..1ddb93db9627 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -7,6 +7,16 @@
> >   *
> >   * Reference manual for "atmel,at91sam9rl-pwm":
> >   *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-bit-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
> > + *
> > + * Limitations:
> > + * - Periods start with the inactive level.
> 
> Are you talking here about the normal polarity (from documentation: By
> definition, normal polarity characterizes a signal starts high for the
> duration of the duty cycle and goes low for the remainder of the period.)

When .polarity = PWM_POLARITY_NORMAL is passed to atmel_pwm_apply() the
drivers sets PWM_CMR_CPOL=0 which according to the datasheet (linked
above) means: "The output waveform starts at a low level."

So maybe just the logic has to be inverted there, but then maybe the
output gets active instead of inactive when the PWM is disabled.
(Which in my book is ok, but it's Thierry's opinion that counts here.)

> If yes, this should be solved by playing with CPOL bit of CMR.
> 
> > + * - Hardware has to be stopped in general to update settings.
> 
> Sama5d2 has duty cycle that could be updated on the fly.

There is some functionality in the 9G25, too. I didn't understand it
completely but maybe it only helps updating one of period or duty cycle.
 
> > + *
> > + * Software bugs/possible improvements:
> > + * - When atmel_pwm_apply() is called with state->enabled=false a change in
> > + *   state->polarity isn't honored.
> 
> I know that when configuring a PWM one should get the current state of the
> PWM, change it, then pass it to the driver via pwm_apply_state().

That seems to be a common pattern at least. IMHO letting the consumer
just configure the state that should be used should be fine, too.

> In case one would call the pwm_apply_state() with state->enabled =
> false the state would be stored in PWM specific object (of type struct
> pwm_device). On the next apply, with enabled = true, all the PWM
> parameters would be actually applied to hardware. So, until
> enable=true the PWM state would only be cached by PWM core specific
> objects (in pwm_apply_state()).

I fail to follow what you mean here. If a PWM runs with (say) normal
polarity and you call pwm_apply_state(mypwm, { .polarity =
PWM_POLARITY_INVERSED, .enabled = false, }); the apply callback of the
lowlevel driver is called and supposed to configure the output to yield
a constant high.

> > + * - Instead of sleeping to wait for a completed period, the interrupt
> > + *   functionality could be used.
> >   */
> >  
> >  #include <linux/clk.h>
> > 

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
