Return-Path: <linux-pwm+bounces-1129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454278422DD
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jan 2024 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B8428E33A
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jan 2024 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BE66B34;
	Tue, 30 Jan 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="olrhRy+w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C7664B9;
	Tue, 30 Jan 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613707; cv=none; b=ty/9sIaU4O7lNjY/4YltvaMFA1fkeHnJ8qVd7Y6rQhLTP1222WEz6nb56+aXSTOK/rx1aheqXj3961/RlxztC31OzxVBJ4Ps5BTfrXIeC2q0hWItgp57gYRUZz0qCwAoDF7Saj2JVaMdl6uXRPPUgtePaHv860di9yBRHBENCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613707; c=relaxed/simple;
	bh=EwpwEAFcgdaFtY+FEAqTu9ABrpy5x9wRRWMSF5IyDAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1QI2h2cniICoyrQBTRZVrsVtnMw2mD6gFL04QvYK2DHlhXjZZ3bMwA5EM7Ri0YufDGJHBwylicWVrfqbLxTucGxYPnmFlDzqB3zwedhj7+uw+6zV+lKGAt+wXZ1AKn7rtOsqoFOqCXkwuTr1LE+C/ZcnZ88N9CBOUescBFf79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=olrhRy+w; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706613692; x=1707218492; i=wahrenst@gmx.net;
	bh=EwpwEAFcgdaFtY+FEAqTu9ABrpy5x9wRRWMSF5IyDAY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=olrhRy+wCNRimiiIbtUZr6jFhOhA8NOCLDDApDEECeyuZSg3QBCKgWq74a/AQHie
	 bO29Sjaubh6pkklwD+Lan9CY3pzS+C226SnAGHfFyTNam8n+ewGYQJNv3AtGeWFbk
	 /aa86bYrxuIPIU+ErILnHMkFClEjP3+R60THXzLwTRs/ykYE0QeidUpgFeQdrDxlm
	 bfDb4Akg/sPOt/1aZoFUL80lybfw90X+ZCXECksqyVNoSWeqKmARHFehbND0iMjQg
	 lQbEI6AgRs1HQdLk7DycTqwyJUzru0vff4zjKJkOrG39rtGJSfElNI15z4/lHrmUS
	 YqU4I8r0f56D4vUr7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1qnmNk2JUa-00jKJq; Tue, 30
 Jan 2024 12:21:32 +0100
Message-ID: <c6180cc2-8912-4cd0-82f9-4428df84db6b@gmx.net>
Date: Tue, 30 Jan 2024 12:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] pwm: Add GPIO PWM driver
To: Sean Young <sean@mess.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20240128163630.104725-1-wahrenst@gmx.net>
 <20240128163630.104725-3-wahrenst@gmx.net> <Zbi8pbT7N0vKUgmx@gofer.mess.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <Zbi8pbT7N0vKUgmx@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XYhn+3g0/rkEOk+zto8O/wQhE/DK5f71Z8wuB0Am0M7rVDN+J9O
 X+IY6Lc+9ux7Az6WsklITM2i/DfXCqS4WpB9v9mWwkyQw8yDPOLHGMyn41rP9X5wuj+PoQg
 kJ9w+7GIuwANKw/BJ9xAiSCMCgnldO2J4CFgxzzWkOu/htV4iOzIoVcNRJlbH2hZIn58dCf
 qacMtOu32Evm8jizmv8Qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GjddKZsctQw=;gih3enDrJiu/pSbRO35Rnbi4EVn
 z9cmxYlolg1YTjZiwLzF3dpBbfvgpY8aBzWM6uNwvX4dwZed+wh/7mp5JggAVAflHTmiTkDA/
 AL0qJnVoEyH7o17JotQ5XKuNaEh8nBp4OUlv8ITBXeAEqARYhKwTvpSU92BqKBf6gCvVZ1T4Z
 YkXNlhi70cYxnasRY/aGJWlCyZcA4twb9NGSsyV30ijdLJpnNzg+5MFoZ88zyIH2n1qcoOJSH
 Mw4H9+6I1LpS6ot4ztQCC3ljG9SnRH+wBa3f4uy0FpxCtcbqhBYaZyJ2NjGUrw2dK/PP/uB/J
 o8/c/6IP9QoH0mNyIj6GLimWCVmduuCAIzib8ofn+il/rSSmdf3Wpejxjkc4pMOn34z0V+cZf
 gz8WzKfkQfIoyS3NyinLlOKki5vaJuhegkWjZzG6FuBA7p+XjY4+IpVpSuAwI9TIiAFGx27dr
 FpcnVAIfaLzzXpSIcpMAW938MGJjfVhFBjNCJ59kc+mzNCCGXrTIYM/GlvSgKU++jdSOJtYj7
 REEubbgGSAPF44Tg4xYNR5aQvPfXAktchpMMkKFqOLET+PXb3/ZFIGPNLTxK1vppa1kisk3uF
 rtRU5jHT170vCa2A5pKtCbpZq9kz0w9st4ONR3VQ+ACRV9NVxfz11hrA854YybgCqYR1ajX+N
 Pa0oJfxnBjB+MmlpRPOv3JB2irZTZxS5ziPDcgjbXzoAeSjG+DMy+1BJRz9sWKqicM2ZlSgkI
 Io/Qx0GSnQGmOXjM1nv0DprIlSiGIkc0cJvKsrcJhmFEP7hVtF5UrX7vEVHpjYr2acXfMUSyG
 LJuqUj/eRX0wD5bewRKmjgVxWDuZNLop7U0NTJvqFq9Ih6lrf8Irq3HTylJ7+8CPCG9TjxE+L
 72V7WG5yHvXTcprb49hsveMExYb3fKPDARsh4tGL8qD2m5CSY3UMyj36//wBIidCUnq9yCyDY
 do7OsbLGm5WwKpTP8hYayai8qdA=

Hi Sean,

Am 30.01.24 um 10:08 schrieb Sean Young:
> On Sun, Jan 28, 2024 at 05:36:30PM +0100, Stefan Wahren wrote:
>> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>
>> This will naturally not be as accurate or as efficient as a hardware
>> PWM, but it is useful in some cases.  I have for example used it for
>> evaluating LED brightness handling (via leds-pwm) on a board where the
>> LED was just hooked up to a GPIO, and for a simple verification of the
>> timer frequency on another platform.
>>
>> Since high-resolution timers are used, sleeping gpio chips are not
>> supported and are rejected in the probe function.
>>
>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
...
>> +
>> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>> +			  const struct pwm_state *state)
>> +{
>> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
>> +	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
>> +	unsigned long flags;
> Not sure this is necessary but how about:
>
> 	if (state->duty_cycle < hrtimer_resolution ||
> 	    state->period - state->duty_cycle < hrtimer_resolution)
> 		return -EINVAL;
>
i think i get the idea, but we need to care about corner cases like
duty_cycle =3D 0

