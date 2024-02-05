Return-Path: <linux-pwm+bounces-1213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89729849A01
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419502838E4
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE37D1B968;
	Mon,  5 Feb 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KLjB/MFW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB731B95C;
	Mon,  5 Feb 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135717; cv=none; b=AzKSNaB3wl/VKh6Ig13frQPFcyTbsACzyyhVUTn4Z81KYBTTUUgfmenPL6QY0Yu5j9k+1PWRziTdUECcXJmPpFhi/9nEen/hn6F/4ijob30QnAeAiu3YZ/pivESgbmMQ4X4RE5XDbzTS1is934LUEC4UHMXB8SuwhqZNywU6OSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135717; c=relaxed/simple;
	bh=4+L+wNFmeBIceFORKmB6j1KUwbZpGuVuGSnVbLyj5eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9gIptMiwAJ/HD/v46Jqf8bEXl9+/8h0ibsRzrWdFfCgNGgGzI+4uIkVTfa+J5GlhaogK0Z7MThCHSL8f0nmR1hVIwN0FUn92acevh2mSDKJjVFUJEIQk147H7ehJvYRX84w9SqXWKAzJWc+VMpPUapMLg82PzsRBGuPBG2aLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KLjB/MFW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707135699; x=1707740499; i=wahrenst@gmx.net;
	bh=4+L+wNFmeBIceFORKmB6j1KUwbZpGuVuGSnVbLyj5eU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KLjB/MFWD+I6f9HuIUN31VPvyJTdBJdNgQSpGnRa690xTLb5tV1C456rN0c6uOK5
	 9Zdi6aBIpnDfEwQEP5l+X66Nq2rTQvf2NvAmjd5RLwU2YmWHBwPfYb9pg1scF+yul
	 /AU3INydkNjSxLgbFx9Z3UIV8kYp24ZmzRXE3Ko02iF0SQ5520dUBBvgKB+oIkHDK
	 sIYCRof/eUR4CFTyGpasz8uaYXyrUdEEdBZjL4dw3D/Xq2Tw5tWAwiNOlBLIov4E2
	 mC7kwFxSseIb4TfC1pTFDorh0x1g9YYs3rmuji5/koxONY91T/cFQJsjkeN2oTn8g
	 fNeg47N6gFvUi4DMNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1rI3Sb2518-00KO37; Mon, 05
 Feb 2024 13:21:39 +0100
Message-ID: <06e166f0-b6ac-4ffd-b194-a2ba0031605f@gmx.net>
Date: Mon, 5 Feb 2024 13:21:36 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <b3bh4srxjc5s5yrceugn2bry4j7srvuyyc2zc7uorynn3esbbq@xtpfu3xnsi3q>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <b3bh4srxjc5s5yrceugn2bry4j7srvuyyc2zc7uorynn3esbbq@xtpfu3xnsi3q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K5kix2xLmiOuuljpWVQ4ZlNETG7gXkwoYSRA1ekmuhi5BGJqNqX
 smW5BgQ7ZHZOTfvr4AMm2ET7eMox1tsMgXHOuZNmytNMQ+G7IABaOFJ3tqoMhhvkvlTA4c+
 e5vSJXqzjtHWy+NsL/9oD9cj8Yov96eSVYNX/0deUQGXQYBGenecZQRVcU+uDjTKCovij0q
 HGTS5CsYCLsGaw1A9VAsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HOvm5Kv5JUY=;ZHarOy1rGIDmsPqxHhmTCmybMQT
 vQ8K2IAgbAJWtTxK4jyuFXjo8PNc99Vh1/TQqBltctaQbRQzRpkY6BjqUquxcmVOIOLcFo8cl
 zAzHcdZsUwAa/qcWYG0bx5N7QYmE2EkCttRFoG8WGWvCcFNMFRYtf5UxX4DeJRQCM0KwhAT+s
 WX1kUKUUyfUmXRA2Naib5mgJsZzgmIUbl1M88fITKigwUpjmuRucSQIF/zlgRPRmcO8Xv6QTH
 zeTlsVUUoM6MsuqGq9SmX3Cm33MSfM3Pi9+BptpGU642XjpTj4Ftfi3fTjsQy9GrfkFJuaeXy
 +9Zol1YQtWEDj16jezpwfGuSK6BcvUztbZEpAqiMfSygkGvHespBIO1TltWwFeQupu1/QjduH
 /tKrIBiMGYon3tp+7fgAEAJj62Lzhhj+pwGidZk7A3mE3mpxpNkpMRn/2kynCHveaDdNYjOTD
 bZj40U8IuT12yET8LwilNBqn3EJfYYSk2Uut+4W0tofFvyQoj0PehKRS9QFWs3StW3RS5F3/N
 iyNWn3ykgIFzxRnn29wLpYATFQhNdKslQe0SNSEsd8Y75q2noWcuW9YLARTPPWzSH7UIterWW
 BOIjy5qogvwnB1CrKP2wn3IvwmyIVb2bym00awjdB6Sp93giymGZ+AcHKucOJrKk4L+kcgS95
 T3MYtiGZ+j7hY/DFowUZLVdK3gSTTzNxBiaeJ9h+67MrRJgwSQ6OKx8UyYQJ+fMmnw7a31wkZ
 TPvdWHMQxZ2ycS2eSrWbmcvUZr46bLuiIO3523S8chqIuPAlmfZ8NsaL3m+nhRk4tVkuZ019e
 zsYAkKV1KvoZjzyqf8XXlud+ZmjUj/ek0VOmDn1/95zH0=

Hi Uwe,

Am 05.02.24 um 11:09 schrieb Uwe Kleine-K=C3=B6nig:
> Hello,
>
> On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
>> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
>> +{
>> +	struct pwm_gpio *gpwm =3D container_of(gpio_timer, struct pwm_gpio,
>> +					     gpio_timer);
>> +	unsigned long next_toggle;
>> +	unsigned long flags;
>> +	bool new_level;
>> +
>> +	spin_lock_irqsave(&gpwm->lock, flags);
>> +
>> +	/* Apply new state at end of current period */
>> +	if (!gpwm->level && gpwm->changing) {
>> +		gpwm->changing =3D false;
>> +		gpwm->state =3D gpwm->next_state;
>> +		new_level =3D !!gpwm->state.duty_cycle;
>> +	} else {
>> +		new_level =3D !gpwm->level;
>> +	}
>> +
>> +	next_toggle =3D pwm_gpio_toggle(gpwm, new_level);
>> +	if (next_toggle) {
>> +		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
>> +				ns_to_ktime(next_toggle));
> How does this work in relation to hrtimer_resolution? If the resolution
> is (say) 300 and next_toggle is 2000. Does the trigger trigger at
> hrtimer_get_expires(...) + 1800, or at ... + 2100?
>
> If you assume we have period =3D 6000 and duty_cycle =3D 2000, the delta=
 to
> forward the driver alternates between 1800 and 3900 (if rounding down)
> or between 2100 and 4200 if rounding up. Both is not optimal.
>
> Ideally you'd round down the active phase (i.e. pick 1800) and for the
> inactive phase you'd use rounddown(period) - rounddown(duty_cycle) which
> gives 4200 here. Does this make sense?
oh dear, looks like a can of worms. I will look into it. Btw according
to multi_v7_defconfig the hrtimer_resolution on the Pi is 1 ns.

Does it make sense to log the hrtimer_resolution e.g. at probe?
>
>> +	}
>> +
>> +	spin_unlock_irqrestore(&gpwm->lock, flags);
>> +
>> +	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
>> +}
>> +
>> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>> +			  const struct pwm_state *state)
>> +{
>> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
>> +	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
>> +	unsigned long flags;
>> +
>> +	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
>> +		return -EINVAL;
>> +
>> +	if (state->duty_cycle !=3D state->period &&
>> +	    (state->period - state->duty_cycle < hrtimer_resolution))
>> +		return -EINVAL;
> If you assume that hrtimer_resolution =3D 300 again, you don't want to
> refuse
>
> 	.duty_cycle =3D 200
> 	.period =3D 200
>
> do you?
Actually i had rejected it. Yes, this specific corner case does work
with such a resolution. But if the user want a steady level, the user
would use a plain GPIO not a PWM. As soon the duty cycle get lower this
would be rejected and as a user i would be confused.

Another issue here, is that we don't have a good interface to tell the
limitations.
> I think you want:
>
> 	mininterval =3D min(state->duty_cycle, state->period - state->duty_cycl=
e);
> 	if (mininterval && mininterval < hrtimer_resolution)
> 		return -EINVAL;
>
> to catch both cases in a single check.
>
>> +	if (!state->enabled) {
>> +		hrtimer_cancel(&gpwm->gpio_timer);
>> +	} else if (!gpwm->running) {
>> +		/*
>> +		 * This just enables the output, but pwm_gpio_toggle()
>> +		 * really starts the duty cycle.
>> +		 */
>> +		int ret =3D gpiod_direction_output(gpwm->gpio, invert);
>> +
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	spin_lock_irqsave(&gpwm->lock, flags);
>> +
>> +	if (!state->enabled) {
>> +		gpwm->state =3D *state;
>> +		gpwm->running =3D false;
>> +		gpwm->changing =3D false;
>> +
>> +		gpiod_set_value(gpwm->gpio, invert);
>> +	} else if (gpwm->running) {
>> +		gpwm->next_state =3D *state;
>> +		gpwm->changing =3D true;
>> +	} else {
>> +		unsigned long next_toggle;
>> +
>> +		gpwm->state =3D *state;
>> +		gpwm->changing =3D false;
>> +
>> +		next_toggle =3D pwm_gpio_toggle(gpwm, !!state->duty_cycle);
>> +		if (next_toggle) {
>> +			hrtimer_start(&gpwm->gpio_timer, next_toggle,
>> +				      HRTIMER_MODE_REL);
>> +		}
> The curly braces can be dropped here and in a few more locations.
>
>> +	}
>> +
>> +	spin_unlock_irqrestore(&gpwm->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&gpwm->lock, flags);
>> +
>> +	if (gpwm->changing)
>> +		*state =3D gpwm->next_state;
>> +	else
>> +		*state =3D gpwm->state;
>> +
>> +	spin_unlock_irqrestore(&gpwm->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops pwm_gpio_ops =3D {
>> +	.apply =3D pwm_gpio_apply,
>> +	.get_state =3D pwm_gpio_get_state,
>> +};
>> +
>> +static int pwm_gpio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct pwm_gpio *gpwm;
>> +	int ret;
>> +
>> +	gpwm =3D devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
>> +	if (!gpwm)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&gpwm->lock);
>> +
>> +	gpwm->gpio =3D devm_gpiod_get(dev, NULL, GPIOD_ASIS);
>> +	if (IS_ERR(gpwm->gpio)) {
>> +		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
>> +				     "could not get gpio\n");
>> +	}
>> +
>> +	if (gpiod_cansleep(gpwm->gpio)) {
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "sleeping GPIO %d not supported\n",
>> +				     desc_to_gpio(gpwm->gpio));
>> +	}
> Is it still state of the art to add gpio numbers to error messages?
I was unsure how to handle this user-friendly. Just simply logging
"sleeping GPIO not supported" doesn't provide a reference on the
affected GPIO. GPIO names are optional, so maybe empty.

I'm open to suggestions :-)

Best regards
>
>> +	gpwm->chip.dev =3D dev;
>> +	gpwm->chip.ops =3D &pwm_gpio_ops;
>> +	gpwm->chip.npwm =3D 1;
>> +	gpwm->chip.atomic =3D true;
>> +
>> +	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	gpwm->gpio_timer.function =3D pwm_gpio_timer;
>> +
>> +	ret =3D pwmchip_add(&gpwm->chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "could not add pwmchip\n");
>> +
>> +	platform_set_drvdata(pdev, gpwm);
>> +
>> +	return 0;
>> +}
> Best regards
> Uwe
>


