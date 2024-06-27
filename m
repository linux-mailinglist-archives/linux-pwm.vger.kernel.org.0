Return-Path: <linux-pwm+bounces-2629-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA791A31B
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058DF283EB1
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AA13C820;
	Thu, 27 Jun 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="C+wJ9AO2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1113C3C2;
	Thu, 27 Jun 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482068; cv=none; b=jqaUBk9yLgFpYORy2oOoQuIXbC7YFa+Jh6A/QpNamjT+2pYHyPG9wAbla66MxeGoBA9nwPqhdpNder0kUj2ywpGyCotO6NaI5S0/+OrC1EK4u5xPJXeb6orYDe6MxZdMJi5abPy1GGep5FG/hAdYDKq/9TGXJh5e85mCZqkj35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482068; c=relaxed/simple;
	bh=ds5qgnPrb2bN+kFBGjS/sc0PxsC5dx7vPl8UC1KzFmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWNSt5zXMNG3+F1DqmW9hSkNYsq9nmPQCYdYkBL/WLcqOSBhuA3xpUd+NlOpfvggKv8Tj6gpgfvdI3ILjKWGHEXrQbdukyUS3iXgPMSnQpdlHXOzHDtrCalHW+V1V3YdB8m8RIUVmvGqEprb+gu+CZxycP4TVozM3yZmp9xhBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=C+wJ9AO2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719482049; x=1720086849; i=wahrenst@gmx.net;
	bh=qe5FDI+md3Pge9LtwMQZf8FokKyoNNSJDrbmKAhp1tY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C+wJ9AO2f72MXxZw6oTrZHYZPBDf1f5r9nmClivCv6w5OeIXYnCzm/zsQiv2ZOuU
	 GJFkpvn8xoF+Y0ywOsg4egdgjNAvcfq5Ui0t8NHfAkFUX0VcyRuQzHvMa2g3Ko63C
	 TlLAkY0GI7xtnAj4IaQtTO4Xjc4Fm0Bk5qtd3NN/UX4TIHZIYa7ivYSMHG0nQeA4K
	 BbqfUWrreBk81h7LwjzOlBvmOQ1bfF4qqdZRly0iHMFMqbXqM49IH1fF7vk3CF1kB
	 EM2mBs6/B6kA6df2gLL1x0ur0TPpM0nyOsq5lW7HqjsXKoe34DBiWIDU5BdpLofo3
	 x9tD+LUrjYIxMg0Lfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1sUuWs0y3z-00yzZ8; Thu, 27
 Jun 2024 11:54:09 +0200
Message-ID: <964072fc-1aa9-4d4e-955f-8777e2692346@gmx.net>
Date: Thu, 27 Jun 2024 11:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] pwm: Add GPIO PWM driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Chris Morgan <macromorgan@hotmail.com>, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Nicola Di Lieto <nicola.dilieto@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Dhruva Gole <d-gole@ti.com>, Vincent Whitchurch
 <vincent.whitchurch@axis.com>, Andy Shevchenko <andy@kernel.org>
References: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
 <oytpr6q3rmyj4n6ufktl5okg7ugusks5csgkg3zvs32b4jqh24@lmfovdemzi4y>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <oytpr6q3rmyj4n6ufktl5okg7ugusks5csgkg3zvs32b4jqh24@lmfovdemzi4y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GsRmZwGIvZ7DCjXsgmLZHA3JY0bbTTqncYRKHdX4LgqHeSr7LsJ
 ksd46B0pIsXtEbHZb2D+DmW4k+jwXSWG6Fd5oy8OoILvnGnlu1yJwGI+arSglVl1yTUDJLW
 uErzWFWchsnWPMj0r2VLFA5sFS4Kdr1uFh/MnyXPqMLPDftmamY9BBcrPSESqt2M8KEcA2R
 /VZgsSYw4Z/6vocebkVsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:26aPyoLUc1o=;dvfuFXGeATA9mtObEvreSzN9uJB
 +fXEQOUoMRn44xph2lQst/l9biO/VDikJ2dZrO4dQR/n50URJnSlIrsvxvnoTp6g/YGCoaAZh
 nRMiNWKM+znz5NRlx99T6oZD/Hs/FfLQTkTZP44GRxra0pBFiT+4Phy+bRmzhrjdhwagLRELy
 Jrv0QehrVTktMXj11Bm5olrzY935xxWmZWY2Lq4gyV1ab5rrN3ryB7knxwLopS6GLmSIT908y
 nsod2YE5IJNxG3CIhOyHmju6vZT8EuIZ3KqdWQESpSPutKxc0l4rR91YBQ8KVLhWFyiohCB86
 KNh128w+87xdVhJp/OIJwo36UANpwABb2hshX0EudXtHkiBqJ1rYGt9aTMwXXFY/FixmXPBKD
 Kq37IdMEt18YxtMiA8m22U6GG1lwHzaH/BIEBwfs24t9tZDn68cVKxK8ygUOscog2yAt87Txd
 LBBIaRLO7GVchvy7enMe/TR6JPIRw7db8diUoUL8m4vukqrvLkvaeu9S66JwehVZjy8caSH9A
 vOwP/cXY7GX2c/GQoubJCLGj+bIYShDRIpa1Wu9hJQk/uxLGrdE9hEitbTMHqqnp2DCmdlqqk
 /RK7rp/fKNctzGFMiuQ989u+bfr0xeSKPZmmD3YrOHfweDgPDmUQ2ChfEu6j2vOkXcWJsOMLU
 U8yZE7mqHowjGYTSS4547aQ9NvNJuUYXmSTWw1m2tME0BASjzlm/8ZcMUYEfkJ51g+xgkPx3a
 JhgJEFydFu3t14ngb09Gtz0JKYihjxCZL8FDqK22N/WeOIh4mmKBoOC7M5TsoQxv3XA3zjhUH
 OpebLZZ0RCNDaLQgf3tVuD2eKkXeEE8D6KM71sVzeG1mI=

Am 27.06.24 um 08:52 schrieb Uwe Kleine-K=C3=B6nig:
> Hello,
>
> On Tue, Jun 04, 2024 at 11:00:39PM +0200, Linus Walleij wrote:
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>
>> Recent discussions in the Raspberry Pi community revealt that a lot
>> of users still use MMIO userspace tools for GPIO access. One argument
>> for this approach is the lack of a GPIO PWM kernel driver. So this
>> series tries to fill this gap.
>>
>> This continues the work of Vincent Whitchurch [1], which is easier
>> to read and more consequent by rejecting sleeping GPIOs than Nicola's
>> approach [2]. It further takes over where Stefan Wahren left off.
>>
>> I have not looked into the interrupt storm problem mentioned in [3]
>> but instead focused on some real-life tests:
>>
>> The IXP4xx NSLU2 has a speaker connected directly to a GPIO, and I
>> wanted to use this patch to provide a proper beeper for the machine
>> and not have to rely on custom hacks.
>>
>> I added a DTS patch like this:
>>
>> gpio_pwm: pwm {
>>          #pwm-cells =3D <3>;
>>          compatible =3D "pwm-gpio";
>>          gpios =3D <&gpio0 4 GPIO_ACTIVE_HIGH>;
>> };
>>
>> beeper {
>>          compatible =3D "pwm-beeper";
>>          pwms =3D <&gpio_pwm 0 1 0>;
>>          beeper-hz =3D <1000>;
>> };
> Applied both patches to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/f=
or-next
\o/

Thanks
>
> Thanks
> Uwe


