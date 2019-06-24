Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16F50EB3
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 16:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFXOj4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 10:39:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38916 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfFXOjz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 10:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561387193; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QvYrE3ls/QXOBjihXF5hG/izh16IQcN2h5MrNGxNC8=;
        b=Bhigd78ANkGaYmYI+0oAYzU8YmsKJKpGucWHCgAFcpgfWaU3meL5LseFh10NK0JeR5KmaM
        12aEdcqwu8iiOZlWEOUx6HTENsi+bWOCqdoD7FO+fT75BOEoG6IBkftSspiT9/Scfd69v3
        BqpepJB6H/+J64wFIT4/1DgXmX4rXVg=
Date:   Mon, 24 Jun 2019 16:39:46 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1561387186.20436.1@crapouillou.net>
In-Reply-To: <20190621135608.GB11839@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
        <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
        <20190621135608.GB11839@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le ven. 21 juin 2019 =E0 15:56, Thierry Reding=20
<thierry.reding@gmail.com> a =E9crit :
> On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
>>  On 22/05/2019 17:34, Paul Cercueil wrote:
>>  > When the driver probes, the PWM pin is automatically configured=20
>> to its
>>  > default state, which should be the "pwm" function.
>>=20
>>  At which point in the probe... and by who?
>=20
> The driver core will select the "default" state of a device right=20
> before
> calling the driver's probe, see:
>=20
> 	drivers/base/pinctrl.c: pinctrl_bind_pins()
>=20
> which is called from:
>=20
> 	drivers/base/dd.c: really_probe()
>=20
>>  > However, at this
>>  > point we don't know the actual level of the pin, which may be=20
>> active or
>>  > inactive. As a result, if the driver probes without enabling the
>>  > backlight, the PWM pin might be active, and the backlight would be
>>  > lit way before being officially enabled.
>>  >
>>  > To work around this, if the probe function doesn't enable the=20
>> backlight,
>>  > the pin is set to its sleep state instead of the default one,=20
>> until the
>>  > backlight is enabled. Whenk the backlight is disabled, the pin is=20
>> reset
>>  > to its sleep state.
>>  Doesn't this workaround result in a backlight flash between=20
>> whatever enables
>>  it and the new code turning it off again?
>=20
> Yeah, I think it would. I guess if you're very careful on how you set=20
> up
> the device tree you might be able to work around it. Besides the=20
> default
> and idle standard pinctrl states, there's also the "init" state. The
> core will select that instead of the default state if available.=20
> However
> there's also pinctrl_init_done() which will try again to switch to the
> default state after probe has finished and the driver didn't switch=20
> away
> from the init state.
>=20
> So you could presumably set up the device tree such that you have=20
> three
> states defined: "default" would be the one where the PWM pin is=20
> active,
> "idle" would be used when backlight is off (PWM pin inactive) and then
> another "init" state that would be the same as "idle" to be used=20
> during
> probe. During probe the driver could then switch to the "idle" state=20
> so
> that the pin shouldn't glitch.

That's exactly what I'm doing, yes (with the minor difference that your
"idle" state is my "sleep" state).

> I'm not sure this would actually work because I think the way that
> pinctrl handles states both "init" and "idle" would be the same=20
> pointer
> values and therefore pinctrl_init_done() would think the driver didn't
> change away from the "init" state because it is the same pointer value
> as the "idle" state that the driver selected. One way to work around
> that would be to duplicate the "idle" state definition and associate=20
> one
> instance of it with the "idle" state and the other with the "init"
> state. At that point both states should be different (different=20
> pointer
> values) and we'd get the init state selected automatically before=20
> probe,
> select "idle" during probe and then the core will leave it alone.=20
> That's
> of course ugly because we duplicate the pinctrl state in DT, but=20
> perhaps
> it's the least ugly solution.

That works perfectly on my side. I didn't have to duplicate the states=20
in DT.

> Adding Linus for visibility. Perhaps he can share some insight.
>=20
> On that note, I'm wondering if perhaps it'd make sense for pinctrl to
> support some mode where a device would start out in idle mode. That=20
> is,
> where pinctrl_bind_pins() would select the "idle" mode as the default
> before probe. With something like that we could easily support this
> use-case without glitching.

You'd still need the driver to switch back between "default" and "idle"
states, and switching to the "idle" state in the probe is a one-liner,
so probably not worth the trouble, unless I don't understand the whole
picture.

Thanks,
-Paul

> I suppose yet another variant would be for the PWM backlight to not=20
> use
> any of the standard pinctrl states at all. Instead it could just=20
> define
> custom states, say "active" and "inactive". Looking at the code that
> would prevent pinctrl_bind_pins() from doing anything with pinctrl
> states and given the driver exact control over when each of the states
> will be selected. That's somewhat suboptimal because we can't make use
> of the pinctrl PM helpers and it'd require more boilerplate.
>=20
> Thierry
>=20
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
>>  >   drivers/video/backlight/pwm_bl.c | 9 +++++++++
>>  >   1 file changed, 9 insertions(+)
>>  >
>>  > diff --git a/drivers/video/backlight/pwm_bl.c=20
>> b/drivers/video/backlight/pwm_bl.c
>>  > index fb45f866b923..422f7903b382 100644
>>  > --- a/drivers/video/backlight/pwm_bl.c
>>  > +++ b/drivers/video/backlight/pwm_bl.c
>>  > @@ -16,6 +16,7 @@
>>  >   #include <linux/module.h>
>>  >   #include <linux/kernel.h>
>>  >   #include <linux/init.h>
>>  > +#include <linux/pinctrl/consumer.h>
>>  >   #include <linux/platform_device.h>
>>  >   #include <linux/fb.h>
>>  >   #include <linux/backlight.h>
>>  > @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct=20
>> pwm_bl_data *pb)
>>  >   	struct pwm_state state;
>>  >   	int err;
>>  > +	pinctrl_pm_select_default_state(pb->dev);
>>  > +
>>  >   	pwm_get_state(pb->pwm, &state);
>>  >   	if (pb->enabled)
>>  >   		return;
>>  > @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct=20
>> pwm_bl_data *pb)
>>  >   	regulator_disable(pb->power_supply);
>>  >   	pb->enabled =3D false;
>>  > +
>>  > +	pinctrl_pm_select_sleep_state(pb->dev);
>>  >   }
>>  >   static int compute_duty_cycle(struct pwm_bl_data *pb, int=20
>> brightness)
>>  > @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct=20
>> platform_device *pdev)
>>  >   	backlight_update_status(bl);
>>  >   	platform_set_drvdata(pdev, bl);
>>  > +
>>  > +	if (bl->props.power =3D=3D FB_BLANK_POWERDOWN)
>>  > +		pinctrl_pm_select_sleep_state(&pdev->dev);
>>=20
>>  Didn't backlight_update_status(bl) already do this?
>>=20
>>=20
>>  Daniel.
>>=20
>>=20
>>  > +
>>  >   	return 0;
>>  >   err_alloc:
>>  >
>>=20

=

