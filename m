Return-Path: <linux-pwm+bounces-1650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFD86A0C3
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 21:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DC3B21D88
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B914A4DD;
	Tue, 27 Feb 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LkpJNRrq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2C14A0A8;
	Tue, 27 Feb 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065509; cv=none; b=QzGf5yxxfk1USZsqPvQsOKC6fGh8AaV1RzH77QxL8+buReIxcID4xT4EPpf67DaaS91aQgRVLK6Ht/VpHAbno+xB4mf4RuAmpJDl6zsjtl7DWDL9GZFRWUhBpksBPYZ3w+8ethg4xQ9LNmmeQrQ99gqMzC0ZmtPFrjf9jRcCQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065509; c=relaxed/simple;
	bh=QlldwMLwOW74fFoo88HpUsMovahMXXcN3ifnw6M7myg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSKyN8F62JywcpHh4VoxFIk6sQ6tSGiNgaY/Hqv5O/1Ta+kWp6SgDF++M1ZDkpH++mC3/0aNCPm9ySGt03vEqbqGWgGuYcHuUdvB0faij41eqDXqBZfPoDRmqA/yKyPgRTyHoMzyAjVCL7+1ehQKSTpRGQsQENGXDsXW0UbcM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LkpJNRrq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709065495; x=1709670295; i=wahrenst@gmx.net;
	bh=QlldwMLwOW74fFoo88HpUsMovahMXXcN3ifnw6M7myg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LkpJNRrq0xZHILd1uISQbvkAVqHXQJ+NeOlLRpUB+MbAPtYQUCqBzodV38Q/qf7K
	 pJqSBtNIZc5jbHywm/oW04z0neRfu29g5NmPBHYGLFmhXYe9N5anji7utgyJCFNAN
	 QT8COUHOXMKzIlzBixjmU9IqXSgQaCI1lW/4WPXraiOdG18wgx3b9zeMlUjTzjuDF
	 5QfwfUkBBTssrpv9PTXxLQ2fkDOARiCcdAgDNN3fGZovUKuCKTK5URJIaZCnly3QV
	 OWj/wJ91995uWrYRY2FZFYkV7BQJpqBx0tBHBSj3qgtH6uhyn+rELglNBzOOYMTx0
	 mfLq2ifiVKAcNjMggw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1rigVe0mA9-00EbTg; Tue, 27
 Feb 2024 21:24:55 +0100
Message-ID: <4a6d8417-402e-4d40-96c5-15c2f1dba887@gmx.net>
Date: Tue, 27 Feb 2024 21:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <Zd4QpBsyTnuM8hwt@smile.fi.intel.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <Zd4QpBsyTnuM8hwt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qVU2pmcVHsR3ZW1kuL3vrRc5LFwcOI+o7oPIiLakc/nN/bC7FdV
 ca+MQ4i3L88RZ8283jxwIfEteJW1e+suEK3vFz+cuHtVUR/fpoO34zTpWydDJIwdk+pV2RV
 wuRdDVibKzY9s12pDRVsYWDa0061KKwc3rq3Z0UnNychp3YB6KvQ70V7kHO2/AtWEI/J3eL
 Z2qvOavZOBdcZRKjrOTtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VbaKCe+hc3Y=;D7+MejBhXmbJlVTbNVbw6hwla1d
 /gec2hFfHAWF3JRG/rLrNVqhJ4Sxan3AIiXCkrREvtnqa12Lf9H+pIVuJ7oGvF07I520sYnWt
 uGYMJFUq1ejL7EEowH33vw6TzL5de/uhycCpfu3gOphQ6FB6BS7qq0gYTnWIy1bt+swaV6gF9
 8aSEajM2cy+or5x+k3VTGRzLtAILvAi/Lihc5eqtQrDtropqEocD0CQsR4wachdZeV39tsAiE
 mMEYtZmv/Wi/1dITPxJvCSa73QcziLxQPYo3H6t/8encBQs+p3i/toLXu+IsHLzqqwre4agVI
 trTdxX/oSu7VMmL0UgnYolx0SOVp+lr4Qut6COn4yG+TP95pGY5R1HiJEnrLwLv6d4h4GsoeV
 JFhzOuImTLLPOr3ngtRidw4pULtmLNz0HZqMzKTC6L3ZB2a7sIOOWTTRD/w2RCAx7usvimLdJ
 OiT+z2SrLPsf7l1svrHSVTIfs2o+yQ9vEN+AKLEvQguaZUA3f0aB1SkUF1sefZsn61i7Q2HLQ
 IrQ+Ty7yMDQ6tbevRtr3pc8FOaRk8XFzw0aW2FsUhcersiTqVxg26D1BUblqCzoI5c2XO6Z+s
 7NdHyiwl5Pc0jAb48q5o8O4i0TfyuJ282KKgivZSbmuT4SH+4PjRSkPR2bpYTrUCbAPB7Im1f
 jXvH5k7mWHuCrvKS3RIf4Wqpk3jospGpdGZIvUXvAUr0xUY7r5HPFoloWAo7aflCFeYzEJMW4
 KvZwroQ1cXL2+ku1wS+VRMNL7WHzfcU/gvV2j4yvUPRVLv4bgMTy1mSTEbg/HmybArBmkT2ba
 Mb/yi6/ryWHiPQ/pha8oCbOw5ic0C9f37MSiyNBADWqnA=

Hi,

Am 27.02.24 um 17:41 schrieb Andy Shevchenko:
> On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
> ...
>
>> +	if (gpiod_cansleep(gpwm->gpio)) {
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "sleeping GPIO %d not supported\n",
>> +				     desc_to_gpio(gpwm->gpio));
> Do not use plain GPIO numbers.
Uwe already complained this, but i didn't receive a reply on the
question how do we provide a useful log message (reference to the
affected GPIO) here? AFAIK the GPIO names are optional.

Regards


