Return-Path: <linux-pwm+bounces-6003-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E417EAB9CC2
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722F04E76C0
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483F2405E3;
	Fri, 16 May 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XejH1wUs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2F1DFDE;
	Fri, 16 May 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400257; cv=none; b=fREKBLvyN2zEzMO/XlxbQUaTrxIAZ2mbVrbQaJCPmongB68YOFFfYRad3aP3APN/RgZehxL377WY8KI1eeSeWUhtd6jfewnyQtQr8roQeuHRe15kZYgwlD2GYdBWA/eHz1Mnz3bLqraeTAsznq/xm863/Z0aP6mXRwO2Dll9Wfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400257; c=relaxed/simple;
	bh=2Nhkkr+NBSjiX+DhesPVuuxmubLd2IevuaM+ryVlwQk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=mavj7XkrUlhQd9TTKzCDIcrkgMflZZVOvFaju35IzHmAGM6/Uf/GooKZce0cGxxJznsqdbQeGtXxQGGHM7ku/USZNZDGEG2jtpM/SxCXMH6iWkWP3/EENORzinJMxs1znKWs31SfPTGNkzZeKnW8KRLoG3N0tCRqu89CldVaABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XejH1wUs; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 696A843304;
	Fri, 16 May 2025 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747400251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c09Kcb+nc6PjrVGBJxZRFaPWlKLpHHJR4nMu3xnQS8A=;
	b=XejH1wUslvd9ND/yhbTmla3Fld18HuBsHogfyim0s2u6xIJFLLMcM3+HAt4292eDYluH/9
	GsPPmOajrfgdojMTwQQ7O6FoWtHb73bSD/UjPBBwK6kFKok/iJOaQU1VOE17yaaP49Zdhy
	gumqPlshlxErPS+/r/amjFQtCUgLlsuJsDkG/t36MWCgDxu3A6okk+M6ia48ZsJqd94NaM
	pAJlvYpUmgOYD+KHaqStsd6HJihGWutdoVEJbQBtnRpLlvnLqdW055iaeAjJ4gkSFbgW+a
	+7jTPf4jZOJWgJzijfi7unt/oc9t9BVmCnpuxkWcbexNaNmC+neRbE0qiTO8sw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 14:57:29 +0200
Message-Id: <D9XLOWTZPRC4.EHVI8W16H3J9@bootlin.com>
Subject: Re: [PATCH v8 04/11] pwm: max7360: Add MAX7360 PWM support
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
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>
 <5eb7xqo7bfzath3xy7i6v5fep7qwfeg4z3rtzifmgnyvlc3o5b@yi6hzur52hl3>
 <D9WJRVV500O3.GUV0MKHRGTH2@bootlin.com>
In-Reply-To: <D9WJRVV500O3.GUV0MKHRGTH2@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu May 15, 2025 at 9:14 AM CEST, Mathieu Dubois-Briand wrote:
> On Tue May 13, 2025 at 12:08 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> On Fri, May 09, 2025 at 11:14:38AM +0200, mathieu.dubois-briand@bootlin.=
com wrote:
>>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>> ...
>>>
>>> +
>>> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
>>> +{
>>> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
>>> +	int ret;
>>> +
>>> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
>>> +				MAX7360_PORT_CFG_COMMON_PWM, 0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), =
BIT(pwm->hwpwm));
>>
>> What is the effect of these writes? It doesn't need to be undone in a
>> matching .free()?
>>
>
> The first one (MAX7360_PORT_CFG_COMMON_PWM) asks to use a specific duty
> cycle for this PWM output and not a value shared across all PWMs. I
> believe this one have no reason to be ever reverted.
>
> About the second one, it does switch the output value. Reading the
> datasheet, it's not clear if and why setting this here is required. I
> will make some tests on the hardware a bit later this week. Still, I
> believe there is no need to revert it later.
>

I just tested it, I confirm we can remove the second one.

>>> +}
>>>
>>> ...
>>>
>>> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
>>> +				      struct pwm_device *pwm,
>>> +				      const void *_wfhw)
>>> +{
>>> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
>>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>>> +	unsigned int val;
>>> +	int ret;
>>> +
>>> +	val =3D wfhw->enabled ? BIT(pwm->hwpwm) : 0;
>>> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpw=
m), val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (wfhw->duty_steps)
>>> +		return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_=
steps);
>>
>> Would it make sense to first write duty_steps and only then enable?
>> Otherwise it might happen that you enable and still have a wrong duty
>> configuration in the MAX7360_REG_PWM register and emit a wrong period?
>>
>
> Yes, I believe it does make sense: I will try to invert them.
>

Also tested, and everything seems to be working fine: I will go this
way.

>> Do you need to write duty_steps =3D 0 if enabled is false?
>>
>
> No, this is not needed: output will be in hi-Z mode. As we have
> "wfhw->enabled =3D !!wf->duty_length_ns", this should be correct here. Bu=
t
> reading this, I believe I could modify above code to be more clear with:
>
> if (wfhw->enabled)
> 	return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_step=
s);
>
>
>>> +	return 0;
>>> +}
>>
>> Best regards
>> Uwe

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


