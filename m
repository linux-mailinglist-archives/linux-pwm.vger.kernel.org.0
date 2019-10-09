Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38573D117B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2019 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfJIOki (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Oct 2019 10:40:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49249 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbfJIOki (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Oct 2019 10:40:38 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iID8l-0004Bw-CP; Wed, 09 Oct 2019 16:40:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iID8k-0003B2-8m; Wed, 09 Oct 2019 16:40:34 +0200
Date:   Wed, 9 Oct 2019 16:40:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191009144034.jfgopoxm7lba6an6@pengutronix.de>
References: <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
 <20191009104236.ux23ywnhvsym2qcb@holly.lan>
 <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
 <20191009113540.x6uxo3ryiuf7ql55@holly.lan>
 <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 09, 2019 at 03:47:43PM +0200, Enric Balletbo i Serra wrote:
> Hi Uwe, Daniel,
> 
> On 9/10/19 13:35, Daniel Thompson wrote:
> > On Wed, Oct 09, 2019 at 01:21:26PM +0200, Uwe Kleine-König wrote:
> >> On Wed, Oct 09, 2019 at 11:42:36AM +0100, Daniel Thompson wrote:
> >>> On Wed, Oct 09, 2019 at 12:16:37PM +0200, Uwe Kleine-König wrote:
> >>>> On Wed, Oct 09, 2019 at 10:56:35AM +0100, Daniel Thompson wrote:
> >>>>> On Wed, Oct 09, 2019 at 11:27:13AM +0200, Enric Balletbo i Serra wrote:
> >>>>>> Hi Uwe,
> >>>>>>
> >>>>>> Adding Daniel and Lee to the discussion ...
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>>> On 8/10/19 22:31, Uwe Kleine-König wrote:
> >>>>>>> On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra wrote:
> >>>>>>>>> A few thoughts to your approach here ...:
> >>>>>>>>>
> >>>>>>>>>  - Would it make sense to only store duty_cycle and enabled in the
> >>>>>>>>>    driver struct?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Yes, in fact, my first approach (that I didn't send) was only storing enabled
> >>>>>>>> and duty cycle. For some reason I ended storing the full pwm_state struct, but I
> >>>>>>>> guess is not really needed.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>  - Which driver is the consumer of your pwm? If I understand correctly
> >>>>>>>>>    the following sequence is the bad one:
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The consumer is the pwm_bl driver. Actually I'n trying to identify
> >>>>>>>> other consumers.
> >>>>>>>
> >>>>>>
> >>>>>> So far, the pwm_bl driver is the only consumer of cros-ec-pwm.
> >>>>>>
> >>>>>>> Ah, I see why I missed to identify the problem back when I checked this
> >>>>>>> driver. The problem is not that .duty_cycle isn't set but there .enabled
> >>>>>>> isn't set. So maybe we just want:
> >>>>>>>
> >>>>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> >>>>>>> index 2201b8c78641..0468c6ee4448 100644
> >>>>>>> --- a/drivers/video/backlight/pwm_bl.c
> >>>>>>> +++ b/drivers/video/backlight/pwm_bl.c
> >>>>>>> @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> >>>>>>>         if (brightness > 0) {
> >>>>>>>                 pwm_get_state(pb->pwm, &state);
> >>>>>>>                 state.duty_cycle = compute_duty_cycle(pb, brightness);
> >>>>>>> +               state.enabled = true;
> >>>>>>>                 pwm_apply_state(pb->pwm, &state);
> >>>>>>>                 pwm_backlight_power_on(pb);
> >>>>>>>         } else
> >>>>>>>
> >>>>>>> ? On a side note: It's IMHO strange that pwm_backlight_power_on
> >>>>>>> reconfigures the PWM once more.
> >>>>>>>
> >>>>>>
> >>>>>> Looking again to the pwm_bl code, now, I am not sure this is correct (although
> >>>>>> it probably solves the problem for me).
> >>>>>
> >>>>> Looking at the pwm_bl code I wouldn't accept the above as it is but I'd
> >>>>> almost certainly accept a patch to pwm_bl to move the PWM enable/disable
> >>>>> out of both the power on/off functions so the duty-cycle/enable or
> >>>>> disable can happen in one go within the update_status function. I don't
> >>>>> think such a change would interfere with the power and enable sequencing
> >>>>> needed by panels and it would therefore be a nice continuation of the
> >>>>> work to convert over to the pwm_apply_state() API.
> >>>>
> >>>> OK for me. Enric, do you care enough to come up with a patch for pwm_bl?
> >>>> I'd expect that this alone should already fix your issue.
> >>>>  
> >>>>> None of the above has anything to do with what is right or wrong for
> >>>>> the PWM API evolution. Of course, if this thread does conclude that it
> >>>>> is OK the duty cycle of a disabled PWM to be retained for some drivers
> >>>>> and not others then I'd hope to see some WARN_ON()s added to the PWM
> >>>>> framework to help bring problems to the surface with all drivers.
> >>>>
> >>>> I think it's not possible to add a reliable WARN_ON for that issue. It
> >>>> is quite expected that .get_state returns something that doesn't
> >>>> completely match the requested configuration. So if a consumer requests
> >>>>
> >>>> 	.duty_cycle = 1
> >>>> 	.period = 100000000
> >>>> 	.enabled = false
> >>>>
> >>>> pwm_get_state possibly returns .duty_cycle = 0 even for drivers/hardware
> >>>> that has a concept of duty_cycle for disabled hardware.
> >>>>
> >>>> A bit this is addressed in https://patchwork.ozlabs.org/patch/1147517/.
> >>>
> >>> Isn't that intended to help identify "odd" PWM drivers rather than "odd"
> >>> clients?
> >>>
> >>> Initially I was thinking that a WARN_ON() could be emitted when:
> >>>
> >>> 1. .duty_cycle is non-zero
> >>> 2. .enabled is false
> >>> 3. the PWM is not already enabled
> >>>
> >>> (#3 included to avoid too many false positives when disabling a PWM)
> >>
> >> I think I created a patch for that in the past, don't remember the
> >> details.
> >>
> >>> A poisoning approach might be equally valid. If some drivers are
> >>> permitted to "round" .duty_cycle to 0 when .enabled is false then the
> >>> framework could get *all* drivers to behave in the same way by
> >>> zeroing it out before calling the drivers apply method. It is not that
> >>> big a deal but minimising the difference between driver behaviour should
> >>> automatically reduce the difference in API usage by clients.
> >>
> >> I like it, but that breaks consumers that set .duty_cycle once during
> >> probe and then only do:
> >>
> >> 	pwm_get_state(pwm, &state);
> >> 	state.enabled = ...
> >> 	pwm_apply_state(pwm, &state);
> >>
> >> which is a common idiom.
> > 
> > Sorry I must have missed something. That appears to be identical to
> > what pwm_bl.c currently does, albeit for rather better reasons.
> > 
> > If setting the duty cycle and then separately enabling it is a
> > reasonable idiom then the cros-ec-pwm driver is a broken implementation
> > of the API and needs to be fixed regardless of any changes to pwm_bl.c .
> > 
> 
> I think that Daniel has reason here. Just come to my mind that, if the fix is
> not in the cros-ec-pwm driver we will also have the PWM sysfs user space
> interface broken for that driver, apart from future consumers.
> 
> This turns on to my first approach, this patch. Uwe, You had some complains
> regarding is if I can only store enabled and duty_cycle instead of all the
> pwm_state, that should also work for me. If I solve that concern, might be this
> solution acceptable for you? Do you have more concerns?

In my eyes we need a decision if "loosing" the value of .duty_cycle (and
maybe .period) is considered ok. And if it's not we need to decide if we
catch this in the pwm core or in each driver individually. My preference
would be to not do it in each driver. Probably the best option is to do
it in the core with an expressive code comment and then maybe make
callers aware and issue a warning (if possible).

But it's Thierry who has the last word on this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
