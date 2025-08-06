Return-Path: <linux-pwm+bounces-6970-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D78B1C58E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738743AC4A8
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAD246BBB;
	Wed,  6 Aug 2025 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dvGZB10n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F31241686;
	Wed,  6 Aug 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482043; cv=none; b=n+fGw4XPZGBrtvPckUP/3Pi0G2ani6TwJERbxGscPt6IMfvhxa6ZVSZjmyGJe4LGSEl1reD+B8F9emYcBPWIBRx2ykC+jS0Xv3u0H+rWDzyuwlflUzV21HlM0GQBg06jYdUvfqfRJM1sCYnCEstmDiTP/+Av7W9Kx3H7Z5+iqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482043; c=relaxed/simple;
	bh=uMLS3kl181+zJ2KZz7stLl3uqTez7wEpxx0Rw9KU3xo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=q95M2JEnqogJTQGH4bqMi4ba3F57YH10paUmEXnLNDycMbJqhiIy/akoGHqSrbbvCGbHAi2AdqIEkqV1mIhiZN0mWC5PG5YTjFo0MyXNA9W1YieOCmkYgGpaEG/TbzRwkEVAwZfARu8W1ftlBsTD0i3b/s5M1lRzweDghpvM2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dvGZB10n; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0707543192;
	Wed,  6 Aug 2025 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754482037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ieCQkax/o1sbLwS9rDmJAq1iaG9KJ313X0JbnZ9CIE=;
	b=dvGZB10nvi0gl9A/a/kN6PwObcOU/1bqsnUaMHFRuTpsuFjXnJNJk45EH+a47K3cUNGIWF
	S4oBeVvM3ki78LOIrCg7Ph70Bhb4FLE5rYyPssuGr36qGfzpUpBF+hXbNvSf5P0qF/mIZk
	HxSD2YWXAzNH+DCh0/Lj1ihPE64IJkmKIwSomK/RPrCf4wV4OKnb2ZSyU0jszFHVqOEjc/
	GjmqfrUKUXPvm+hf2zKpAVQ3gKQuNKDpiPAV33fj2YnaL/rtGYaZXQAuw4EBFODdyDLWuL
	ylQ4FU1NNPQ5sjVgkY+20oTNJE8VA7RMJBYUXufJ1Ts1vIcq5meGpk7c1dccpQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 14:07:15 +0200
Message-Id: <DBVBZ48R7DNR.850O5X7MLMEF@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
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
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
 <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>
 <2msg7e7q42ocjewv35rytdtxwrfqrndpm2y5ustqeaeodencsd@nfdufgtevxte>
In-Reply-To: <2msg7e7q42ocjewv35rytdtxwrfqrndpm2y5ustqeaeodencsd@nfdufgtevxte>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehvedtkeffueelheektddvjefhiefhgedtudevgeehvdevlefgveetkeevleelteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Aug 1, 2025 at 12:11 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jul 22, 2025 at 06:23:48PM +0200, Mathieu Dubois-Briand wrote:
>> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
>> +					   struct pwm_device *pwm,
>> +					   const struct pwm_waveform *wf,
>> +					   void *_wfhw)
>> +{
>> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +	u64 duty_steps;
>> +
>> +	/*
>> +	 * Ignore user provided values for period_length_ns and duty_offset_ns=
:
>> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of=
 0.
>> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/25=
6
>> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
>> +	 */
>> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
>> +		duty_steps =3D MAX7360_PWM_MAX;
>> +	} else {
>> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_=
PWM_PERIOD_NS;
>> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
>> +			duty_steps =3D MAX7360_PWM_MAX - 1;
>> +	}
>> +
>> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);
>> +	wfhw->enabled =3D !!wf->period_length_ns;
>> +
>> +	return 0;
>
> The unconditional return 0 is wrong and testing with PWM_DEBUG enabled
> should tell you that.
>

When you say should, does that mean the current version of PWM core will
tell me that with PWM_DEBUG enabled, or does that mean we should modify
the code so it does show a warning? As I did not see any warning when
specifying a wf->period_length_ns > MAX7360_PWM_PERIOD_NS, even with
PWM_DEBUG enabled.

On the other hand, if I specify a wf->period_length_ns value below
MAX7360_PWM_PERIOD_NS, I indeed get an error:
pwm pwmchip0: Wrong rounding: requested 1000000/1000000 [+0], result 100000=
0/2000000 [+0]

> I think the right thing to do here is:
>
> 	if (wf->period_length_ns > MAX7360_PWM_PERIOD_NS)
> 		return 1;
> 	else
> 		return 0;

I can definitely do that, but now I'm a bit confused by the meaning of
this return value: is it 0 on success, 1 if some rounding was made,
-errno on error? So I believe I should only return 0 if
wf->period_length_ns =3D=3D MAX7360_PWM_PERIOD_NS, no?

Or reading this comment on pwm_round_waveform_might_sleep(), maybe we
only have to return 1 if some value is rounded UP. So I believe the test
should be (wf->period_length_ns < MAX7360_PWM_PERIOD_NS).

>  * Returns: 0 on success, 1 if at least one value had to be rounded up or=
 a
>  * negative errno.

This is kinda confirmed by this other comment, in the code checking the
above returned value in __pwm_apply(), even its just typical examples:

> if (err > 0)
> 	/*
> 	 * This signals an invalid request, typically
> 	 * the requested period (or duty_offset) is
> 	 * smaller than possible with the hardware.
> 	 */
> 	return -EINVAL;

So, yeah, sorry, but I'm really confused about what is the correct
return value here.

>
> Otherwise looks fine.
>
> Best regards
> Uwe

Thanks again for your time.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


