Return-Path: <linux-pwm+bounces-6768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB51AFC9A4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094F65648C9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C662DAFB4;
	Tue,  8 Jul 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kcAJJqIG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EF2D8DD6;
	Tue,  8 Jul 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974286; cv=none; b=Yz+9ul4AxbsZHgo+xLlEVOMbeDiEjs4lmNSzDS9nV/k7K9GMS1x8l7bsVcJr36YEtDscvjSJ8vjy7S0X4Erx33N/IqMob8EpwlsvIynjQwp5DNbdRZlMU/Kq8ZCvIEbearIEYT78gtbyFCJpqfxsH4Z0XOhOyFUhlH4qzQvEgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974286; c=relaxed/simple;
	bh=k6NRDXgZjHB0dbMWOAtajHFgB3DAi0mz4xkaerrE8ho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Aq/TnrG9m42KcJI2Vv21xPz6DIQ3eNaHO/cq2hmR4cx14ig2FNeZiu2fr07U49SyXo5C672+bYF3reIvgFX8w9foFbpbOW3mLf8OHqzuZ6DwCWEH93VgL/NoquxnmO2o/LEYenNESUlK6+zTvbJZRsNA7ee36xhg9OWjuxwJ7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kcAJJqIG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE02C4424F;
	Tue,  8 Jul 2025 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751974280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LSoQx5fTD/38a4GcvM7MJ0lnfSUZP0mXkSlQAQ16fY=;
	b=kcAJJqIGoTN6u8HQpcIa/He+1R90CcM4yzYK5u+GV5EA3rdxyM2k4e3DnyspYG+je4+DLf
	cmyh2XmrXrXmct3O7MKeaHdKf80zmraU6tchGd0W59NOCrptvBSSb/KfpsFPkGRnTGx8Us
	9i49WkZv+ZbpdavADPVS9E0tC4AzawJSmlyzyJKVgCLWtjlz+GNVXLdZgZZt5INeCTS0ek
	MHcaaLb7FxoQmolSENmWj2o06XIqoUPNvzvrAnMw1izZniD7K/TL74CTNxpzLQpf2HDy0z
	iNWsoY2uJSgSKNA+iSavjTbFnVCg//Jiy7oe5UIaeTFw38OuODyVUp8srbuyZA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 13:31:19 +0200
Message-Id: <DB6N1SVPVSQJ.15KQKOBOCHDCQ@bootlin.com>
Subject: Re: [PATCH v10 04/11] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-4-ce3b9e60a588@bootlin.com>
 <amukbuzpu34jbcjhmzmvfgh6eik5isrwcicfmlqmsyibvhij72@nnmhdj3celnt>
In-Reply-To: <amukbuzpu34jbcjhmzmvfgh6eik5isrwcicfmlqmsyibvhij72@nnmhdj3celnt>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Jun 18, 2025 at 8:45 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, May 30, 2025 at 12:00:12PM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ...
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-max7360.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2025 Bootlin
>> + *
>> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
>> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> + *
>> + * Limitations:
>> + * - Only supports normal polarity.
>> + * - The period is fixed to 2 ms.
>> + * - Only the duty cycle can be changed, new values are applied at the =
beginning
>> + *   of the next cycle.
>> + * - When disabled, the output is put in Hi-Z.
>> + */
>> +#include <linux/bits.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/math64.h>
>> +#include <linux/mfd/max7360.h>
>> +#include <linux/minmax.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/time.h>
>> +#include <linux/types.h>
>> +
>> +#define MAX7360_NUM_PWMS			8
>> +#define MAX7360_PWM_MAX_RES			255
>> +#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
>> +
>> +struct max7360_pwm_waveform {
>> +	u8 duty_steps;
>> +	bool enabled;
>> +};
>> +
>> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device=
 *pwm)
>> +{
>> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
>> +
>> +	return regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
>> +				 MAX7360_PORT_CFG_COMMON_PWM, 0);
>> +}
>
> Do you need to undo that in .free()?
>

No, this is just to make sure we use the individual PWM configuration
register and not the global one, so there is no need to revert it later.

I'm adding a comment explaining that.

> ...
>
>> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX_RES, duty_steps);
>> +	wfhw->enabled =3D !!wf->duty_length_ns;
>
> How does the output behave if you clean the respective bit in
> MAX7360_REG_GPIOCTRL? Unless it emits a constant low signal (and not
> e.g. High-Z) you have to do
>
> 	wfhw->enabled =3D !!wf->period_length_ns;
>
> here. Please document the behaviour in a paragraph at the top of
> the driver. Look at other drivers for the right format. The questions to
> answer are:
>
>  - How does the driver behave on disable? (Typical is constant low or
>    High-Z or freezing. Does it stop instantly or does it complete the
>    currently running period?)
>
>  - How does the driver behave on a (non-disabling) reconfiguration? Can
>    it happen that there are glitches? (Consider for example that
>    duty_cycle changes from 0.5 ms to 1.5ms while the hardware is just in
>    the middle of the 2ms period. Does the output go high immediately
>    then producing two 0.5ms pulses during that period?)
>

Ok, I'm fixing the wfhw->enabled value.

About the comment, I believe we already have everything, I'm just adding
that on disable, the output is put in Hi-Z immediately.

>> +	return 0;
>> +}
>> +
>> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>> +					     const void *_wfhw, struct pwm_waveform *wf)
>> +{
>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +
>> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
>> +	wf->duty_offset_ns =3D 0;
>> +	wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PER=
IOD_NS,
>> +					  MAX7360_PWM_MAX_RES);
>
> This should be 0 if !wfhw->enabled to make *wf a valid setting.
>

OK.

> A check for that in the core (with CONFIG_PWM_DEBUG) would be great.
>

I can submit a patch, but I'm not sure what that check should be.

So I believe the check would have to be made in __pwm_set_waveform(),
making sure wf_rounded.duty_length_ns is 0 if the PWM is not enabled or
in other words, if wf->period_length_ns is 0. I believe calling
pwm_wf_valid() on wf_rounded would be enough. Maybe I should add that as
a first check in pwm_check_rounding() to cover all call sites.

We already call pwm_check_rounding() code, so me already make sure that
if wf->period_length_ns is 0, wf_rounded->period_length_ns is 0. And
adding pwm_wf_valid(), would make sure that if
wf_rounded->period_length_ns is 0, wf_rounded->duty_length_ns is also 0.

Any opinion?

> ...
>
> Best regards
> Uwe

OK with all other comments.

Thanks for your review!

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


