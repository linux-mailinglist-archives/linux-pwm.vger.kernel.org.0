Return-Path: <linux-pwm+bounces-1184-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3461847A4B
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Feb 2024 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AD1F2279D
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Feb 2024 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA148062E;
	Fri,  2 Feb 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qjl4aPoF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECD80606;
	Fri,  2 Feb 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904809; cv=none; b=F9u4klJkiiSR08UljMsuClQZza+vtq6PtDTqppAGq0i9dXG95Zx7Q6FR2+gapKCKPTvPEBxHlEyZAvJpMHHqU/KIBDg/CtZGB9bWAIgJJoFnCdIbIBLbY63EvvXS3DphK9wVEaAFApOIfr+UPHI7+ZYUVjiyDKXsjGAsAjQkS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904809; c=relaxed/simple;
	bh=PUv3nFnuJ9zyA1sti9M6oocB0bwJaHp3C7+h3EFz18k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nugEFcMbT/aTSlYJFr2FjbfU7DbaHyK8GsUN+LvXR5g5RXslW2uk5rV2XS/FIVB1AS1OzgXIxy+656OL2VJ4QnMcZaVx1DQCfLRcM2FXqThqYq9w1FYXlt+dl2DWVMxP300wspR7jG8B4H2k1SgkfMhktzxYbywHRYZrWR3dAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qjl4aPoF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706904796; x=1707509596; i=wahrenst@gmx.net;
	bh=PUv3nFnuJ9zyA1sti9M6oocB0bwJaHp3C7+h3EFz18k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qjl4aPoFiMRDfJlpWqFkPm3ACZm/z4ZqmBrhRTMr345CWQd2Jt+VCHHZ16ayXqaP
	 RgZcXj0/oyH2+cpu/VpidzWWEk+O1yQwUUv+JS6meCCp4gvEXb4L2nsaX+pqOuDRd
	 I6+DtGZ2wLIVcmCXgk71M4A+0jXzlNjqhHeTAqbY2Bdu66BnnPPk1UFzTNQvNLDkd
	 DsAm4SxFiqPYcEAlZjNOoG6HOmFIXKy/GRyEbS7Ck2Vgiawb5edDKpUloGqBPHhtQ
	 LjmBA1gEDc2VvFujP+v5bdSCaSW6TrfD4SMElFzaRYzA2PFZQLKa1BXsnD/2lwdys
	 Ot5G7oIaa3S9LyMqeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1qqtj43O1K-00gUOk; Fri, 02
 Feb 2024 21:13:16 +0100
Message-ID: <384a6c41-f29c-4adc-96a2-f72a44d1c718@gmx.net>
Date: Fri, 2 Feb 2024 21:13:16 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] pwm: Add GPIO PWM driver
To: Phil Howard <phil@gadgetoid.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240128163630.104725-1-wahrenst@gmx.net>
 <CA+kSVo88y7n9dyo57fgjybC9=1b_dgTPA3u-_kUH9X_79HF4tA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CA+kSVo88y7n9dyo57fgjybC9=1b_dgTPA3u-_kUH9X_79HF4tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0oChKbxfGdIdXr0N9w8xUKyvCYDidRbih5Ksz0yaBJsqsmkhJxp
 36RAwbAJ32fXLojOHjYvzfK9BOdDdt/KZdYGl+aYkWQS37/WvMtZx0+vBEQHq8PdERQrrtk
 /Tz4K9XyRoZy49MP8Ji8LiY2rmNqNw67kSzy1+7eTgANxXuMm0RJ/R1QgxsGVxKVMOrMySJ
 IJCoC8TO9sbP/pcp83U2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wySiJoXBfxg=;FSC9pA1wm4R0wPy508UHmdafWCV
 JHAyMO+tablNoe3kQ3JbB2HqzQolUMjOndkL5Y4kBZPMU7Z655FW7vLiT51yh+VKcw3sY0AhO
 kl05OKt9NAbGoJbWEizfECi+ahhBNwcnpUe05ka2LqPKTTWY35iH8e9rAwqQTBsGxNole1RDq
 hQIvsY4z3N2eiLcWZiqpPNiU0H/f3uJkVGqOzVcPxodHwab9qYFgn4+lL1Jgbugar5S4Guh0w
 WkRSq9SFKT6yxA7PgiQSjkrJBjv4PrUPYffGVNM4bHyfR8Y2neM7QoDtOAxqciLfBMRDv8iz+
 zPjC8RyqCnaBirBASgacLzx5P5FUzDcE45Pti4kDfhdjmeFds4m4bpDVPbxSeABMR6F7ca5S2
 /DAmvryH57C5EY9uXr61KFTcUo5LMzJvPPhVRlrIXBeROmT2y/wZCb2B7idSlsp2QxybGIu8k
 gfEEnk4Hyogk+7RBzaX4D1SwFsdOfSQ6nePvNCSE2SAowfB/+eQbURykWncD4YODp7axTYohG
 Ow24CJQi97OIO5lcF0sSiC7fndXIgdyYClf9Z6PPROmMFctuJfc2A+T9shzO7vZzfZwky0BR3
 YC/PlPcDVsLXUNjzPaqbweKc944QAxFKEBDdS9VIAd4Q0i7NohELDyi6aXjqfHw5EZsBbMtCx
 rYc5QtwtECCBciVSu32ojXQGCllIC96a+DXdbdm4lsnhARYFuhsJXjvkEj1ZGexdPNfM2PE/3
 KFJude1K6kRU7QUui3yhen7R5prtO923+ke6TvvLUgFpgNtAFKIMujYI6/8pgppfEBwRUAgJQ
 gaM+4bhkuw6PBupyujmDs1PowJ5u8CxEygzn4mQNetiSM=

Hi Phil,

Am 02.02.24 um 14:19 schrieb Phil Howard:
> On Sun, 28 Jan 2024 at 16:37, Stefan Wahren <wahrenst@gmx.net> wrote:
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>
>> Recent discussions in the Raspberry Pi community revealt that a lot
>> of users still use MMIO userspace tools for GPIO access. One argument
>> for this approach is the lack of a GPIO PWM kernel driver. So this
>> series tries to fill this gap.
> *Thank you* for picking this up. I've been stuck down by covid but am ai=
ming
> to build and test this on a Pi 5 (with a gpio chip over PCIe) to see if =
it runs-
> though I am fully expecting a PIO solution (using the Pi 5s RP1) to hand=
le
> PWM in this case, and hope to rely upon this gpio-pwm module for previou=
s
> iterations.
i hope you are doing well.

There will be small functional changes in V4. Since this series based on
Linux 6.8 and there is no RPi 5 mainline support, you will need to apply
it on top of rpi-6.8.y.

Should i wait for your test results (no pressure) before sending V4?
>
>> This continues the work of Vincent Whitchurch [1], which is easier
>> to read and more consequent by rejecting sleeping GPIOs than Nicola's
>> approach [2].
>>
>> The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
>> analyzer.
>>
>> V3:
>>   - rebase on top of v6.8-pwm-next
>>   - cherry-pick improvements from Nicola's series
>>   - try to address Uwe's, Linus' and Andy's comments
>>   - try to avoid GPIO glitches during probe
>>   - fix pwm_gpio_remove()
>>   - some code clean up's and comments
>>
>> V2:
>>   - Rename gpio to gpios in binding
>>   - Calculate next expiry from expected current expiry rather than "now=
"
>>   - Only change configuration after current period ends
>>   - Implement get_state()
>>   - Add error message for probe failures
>>   - Stop PWM before unregister
>>
>> [1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.=
com/T/
>> [2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einst=
ein.dilieto.eu/
>>
>> Nicola Di Lieto (1):
>>    dt-bindings: pwm: Add pwm-gpio
>>
>> Vincent Whitchurch (1):
>>    pwm: Add GPIO PWM driver
>>
>>   .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 ++++
>>   drivers/pwm/Kconfig                           |  11 +
>>   drivers/pwm/Makefile                          |   1 +
>>   drivers/pwm/pwm-gpio.c                        | 221 +++++++++++++++++=
+
>>   4 files changed, 275 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yam=
l
>>   create mode 100644 drivers/pwm/pwm-gpio.c
>>
>> --
>> 2.34.1
>>


