Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A935F330
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbhDNMJj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbhDNMJj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 08:09:39 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D9C061574;
        Wed, 14 Apr 2021 05:09:17 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id C0EE9C725D8;
        Wed, 14 Apr 2021 14:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618402156;
        bh=jzfesz/tc5g4uK9XizjG/xFnmqTcGzY409QvJU0he+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyNBklIMXpBtSyuPKntfpU+A7XXA1KHMgtJ8q25632tHenrfXFNbVyZ9tUdCfSaIx
         yfWaN0cmtJsGGNluR2rx6OaPfT1ktYXpIqt0hMZZCsreEmVFmcQLYUzjV0XzltbKps
         MRje6pZI1ykWXXaBdPHahB83LCgRhLQhsrF4OFx4=
Date:   Wed, 14 Apr 2021 14:09:14 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHbbaiwK9Tasb7NF@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
 <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Apr 13, 2021 at 09:38:18PM +0200, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> > On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-König wrote:
> > > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > > On Mon, Apr 12, 2021 at 06:18:08PM +0200, Uwe Kleine-König wrote:
> > > > > On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > > > > > The switch to the atomic API goes hand in hand with a few fixes to
> > > > > > previously experienced issues:
> > > > > > - The duty cycle is no longer lost after disable/enable (previously the
> > > > > >   OFF registers were cleared in disable and the user was required to
> > > > > >   call config to restore the duty cycle settings)
> > > > > > - If one sets a period resulting in the same prescale register value,
> > > > > >   the sleep and write to the register is now skipped
> > > > > > - Previously, only the full ON bit was toggled in GPIO mode (and full
> > > > > >   OFF cleared if set to high), which could result in both full OFF and
> > > > > >   full ON not being set and on=0, off=0, which is not allowed according
> > > > > >   to the datasheet
> > > > > > - The OFF registers were reset to 0 in probe, which could lead to the
> > > > > >   forbidden on=0, off=0. Fixed by resetting to POR default (full OFF)
> > > > > > 
> > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > > ---
> > > > > > Changes since v7:
> > > > > > - Moved check for !state->enabled before prescaler configuration
> > > > > > - Removed unnecessary cast
> > > > > > - Use DIV_ROUND_DOWN in .apply
> > > > > > 
> > > > > > Changes since v6:
> > > > > > - Order of a comparison switched for improved readability
> > > > > > 
> > > > > > Changes since v5:
> > > > > > - Function documentation for set_duty
> > > > > > - Variable initializations
> > > > > > - Print warning if all LEDs channel
> > > > > > - Changed EOPNOTSUPP to EINVAL
> > > > > > - Improved error messages
> > > > > > - Register reset corrections moved to this patch
> > > > > > 
> > > > > > Changes since v4:
> > > > > > - Patches split up
> > > > > > - Use a single set_duty function
> > > > > > - Improve readability / new macros
> > > > > > - Added a patch to restrict prescale changes to the first user
> > > > > > 
> > > > > > Changes since v3:
> > > > > > - Refactoring: Extracted common functions
> > > > > > - Read prescale register value instead of caching it
> > > > > > - Return all zeros and disabled for "all LEDs" channel state
> > > > > > - Improved duty calculation / mapping to 0..4096
> > > > > > 
> > > > > > Changes since v2:
> > > > > > - Always set default prescale value in probe
> > > > > > - Simplified probe code
> > > > > > - Inlined functions with one callsite
> > > > > > 
> > > > > > Changes since v1:
> > > > > > - Fixed a logic error
> > > > > > - Impoved PM runtime handling and fixed !CONFIG_PM
> > > > > > - Write default prescale reg value if invalid in probe
> > > > > > - Reuse full_off/_on functions throughout driver
> > > > > > - Use cached prescale value whenever possible
> > > > > > 
> > > > > >  drivers/pwm/pwm-pca9685.c | 259 +++++++++++++-------------------------
> > > > > >  1 file changed, 89 insertions(+), 170 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > > > > index 4a55dc18656c..827b57ced3c2 100644
> > > > > > --- a/drivers/pwm/pwm-pca9685.c
> > > > > > +++ b/drivers/pwm/pwm-pca9685.c
> > > > > > @@ -51,7 +51,6 @@
> > > > > >  #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
> > > > > >  
> > > > > >  #define PCA9685_COUNTER_RANGE	4096
> > > > > > -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns = 1/200 Hz */
> > > > > >  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
> > > > > >  
> > > > > >  #define PCA9685_NUMREGS		0xFF
> > > > > > @@ -71,10 +70,14 @@
> > > > > >  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
> > > > > >  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> > > > > >  
> > > > > > +#define REG_ON_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_H : LED_N_ON_H((C)))
> > > > > > +#define REG_ON_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_L : LED_N_ON_L((C)))
> > > > > > +#define REG_OFF_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H : LED_N_OFF_H((C)))
> > > > > > +#define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
> > > > > 
> > > > > I'd like to see these named PCA9685_REG_ON_H etc.
> > > > 
> > > > I did not use the prefix because the existing LED_N_ON/OFF_H/L also do
> > > > not have a prefix. If the prefix is mandatory, I think LED_N_.. should
> > > > also be prefixed, right?
> > > 
> > > I'd like to seem the prefixed (and assume that Thierry doesn't agree).
> > > IMHO it's good style and even though it yields longer name usually it
> > > yields easier understandable code. (But this seems to be subjective.)
> > 
> > I am not sure I want to also rename the existing LED_N_OFF stuff in this
> > patch. Maybe we can discuss unifying the macros (either with or without
> > prefix) in a later patch and I keep the REG_ON_ stuff for now without to
> > match the LED_N_ stuff?
> 
> While consistency is fine I agree that this patch is already big and
> letting it do the things similar to other stuff in this driver is ok.
> 
> > > > > Consider the following request: state->period = 4177921 [ns] +
> > > > > state->duty_cycle = 100000 [ns], then we get
> > > > > PRESCALE = round(25 * state->period / 4096000) - 1 = 25 and so an actual
> > > > > period of 4096000 / 25 * (25 + 1) = 4259840 [ns]. If you now calculate
> > > > > the duty using 4096 * 100000 / 4177920 = 98, this corresponds to an
> > > > > actual duty cycle of 98 * 4259840 / 4096 = 101920 ns while you should
> > > > > actually configure 96 to get 99840 ns.
> > > > > 
> > > > > So in the end I'd like to have the following:
> > > > > 
> > > > > 	PRESCALE = round-down(25 * state->period / 4096000) - 1
> > > > > 
> > > > > (to get the biggest period not bigger than state->period) and
> > > > > 
> > > > > 	duty = round-down(state->duty_cycle * 25 / ((PRESCALE + 1) * 1000))
> > > > > 
> > > > > (to get the biggest duty cycle not bigger than state->duty_cycle). With
> > > > > the example above this yields
> > > > > 
> > > > > 	PRESCALE = 24
> > > > > 	duty = 100
> > > > > 
> > > > > which results in
> > > > > 
> > > > > 	.period = 4096000 / 25 * 25 = 4096000 [ns]
> > > > > 	.duty_cycle = 100000 [ns]
> > > > > 	
> > > > > Now you have a mixture of old and new with no consistent behaviour. So
> > > > > please either stick to the old behaviour or do it right immediately.
> > > > 
> > > > I avoided rounding down the prescale value because the datasheet has an
> > > > example where a round-closest is used, see page 25.
> > > 
> > > The hardware guy who wrote this data sheet wasn't aware of the rounding
> > > rules for Linux PWM drivers :-)
> > > 
> > > > With your suggested round-down, the example with frequency of 200 Hz
> > > > would no longer result in 30 but 29 and that contradicts the datasheet.
> > > 
> > > Well, with PRESCALE = 30 we get a frequency of 196.88 Hz and with
> > > PRESCALE = 29 we get a frequency of 203.45 Hz. So no matter if you pick
> > > 29 or 30, you don't get 200 Hz. And which of the two possible values is
> > > the better one depends on the consumer, no matter what rounding
> > > algorithm the data sheet suggests. Also note that the math here contains
> > > surprises you don't expect at first. For example, what PRESCALE value
> > > would you pick to get 284 Hz? [If my mail was a video, I'd suggest to
> > > press Space now to pause and let you think first :-)] The data sheet's
> > > formula suggests:
> > > 
> > > 	round(25 MHz / (4096 * 284)) - 1 = 20
> > > 
> > > The resulting frequency when picking PRESCALE = 20 is 290.644 Hz (so an
> > > error of 6.644 Hz). If instead you pick PRESCALE = 21 you get 277.433 Hz
> > > (error = 6.567 Hz), so 21 is the better choice.
> > > 
> > > Exercise for the reader:
> > >  What is the correct formula to really determine the PRESCALE value that
> > >  yields the best approximation (i.e. minimizing
> > >  abs(real_freq - target_freq)) for a given target_freq?
> 
> I wonder if you tried this.

We could calculate both round-up and round-down and decide which one is
closer to "real freq" (even though that is not the actual frequency but
just our backwards-calculated frequency).

But I can't give you a formula with minimized abs(real_freq-target_freq)
Is it a different round point than 0.5 and maybe relative to f ?

Please enlighten us :-)

> 
> > > These things don't happen when you round down only.
> > 
> > Sure, but it might also be counterintuitive that the Linux driver does
> > not use the same formula as the datasheet. And when using 200 Hz, 29 is
> > a little closer than 30.
> 
> First let me state that I consider keeping the math as is in this patch
> a good idea. So to argue already for the future:
> 
> I value consistency among the various pwm lowlevel drivers higher than
> what an individual hardware engineer happened to write in a data sheet.
> That engineer was successful in describing the functionality of the chip
> and that's where her/his job ends. How a driver should behave is to be
> decided by us.
> 
> > I once measured the actual frequency and the internal oscillator is not
> > very accurate, so even if you think you should get 196.88 Hz, the actual
> > frequency measured with a decent scope is about 206 Hz and varies from
> > chip to chip (~ 205-207 Hz).
> 
> Huh. Did you do further measurements that suggest that the oscillator
> doesn't run at 25 MHz but maybe at 26 MHz (which would yield 204.7552
> Hz)? (Assume this is true, what do you think: Should be use the formula
> that matches reality, or should we stick to the formula defined in the
> data sheet?)

No, I just tested this for 3-4 chips and for them I measured these
errors, but that's just a small sample.
Maybe the next few measurements would indicate that it runs at 24 MHz
and it evens out at 25 MHz for all produced chips, but we just have
enough information imho.

Clemens
