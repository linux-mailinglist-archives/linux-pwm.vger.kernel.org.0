Return-Path: <linux-pwm+bounces-1206-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C8849431
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 08:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB2B283E3B
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC27C133;
	Mon,  5 Feb 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WQvenkna"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46387111BC;
	Mon,  5 Feb 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116932; cv=none; b=twXrQ5z2ncEbhNQkn5QHDfyL1hmPU43l1nQJa9EMXvM1wRLwxwNTYTy4IbkyVY0s9kpnofmTD7yAbmGbvBulQo+EWHy6nxtvOSyc5lXy90dpdAhwfZDsEbf06cwBcISAsBAL/BNVxp0BP0KjaiER8Zxi9vtXoBHLStOr030Ss7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116932; c=relaxed/simple;
	bh=5D6PtR3PJDZbVWih7S47g7THCBU4Tdd43oQC93fiPz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rItyCPrxqLR3ea8RKI6VmKmfEUBCCRuLMHMdsLFWvrCG1rcWFFaLE9KmNwlgOmH3H4om7e6RBrxI7Pk9TXSvVHxUnJPuNhqBckJLLoLutEuQZhKcL86diuo2b0Zi2HrT6NHlnFmmpO/lkrhrX7kiuTx4lSzxYs76cD2Yb87GHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WQvenkna; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707116916; x=1707721716; i=wahrenst@gmx.net;
	bh=5D6PtR3PJDZbVWih7S47g7THCBU4Tdd43oQC93fiPz8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WQvenknafKo3CcXWBx0dsgNVjWyqHdjdRKNjWkeG8+F9vOgvfXOqNgD9zl8/S5xW
	 qtM3qL0zPj/KvP94PqYxie7STbgb40oaFBwTFCvwKWzfGfSmXmaenmkYjRtB4kF8E
	 eupSxKu4t40mN8VsUkTSYrAV+S2RkjhV1BJ+vVuHtWOIXR33papx5EEHeccb2AHux
	 FQGNHBAscswuAJfV0Nv9iMg7DRu81V+4pPkPSFt1gYPeS+1c2jumEUVMU365NUJf6
	 YiSTpGNCxYDJFxH1tmfIJ2cegfm4CC58GvxwG/dyTI5mixz/d5m8UTSNt/R9NX2OR
	 ZpvBNFDIRhe+VxMERg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1roG9z1eF5-00HKm8; Mon, 05
 Feb 2024 08:08:36 +0100
Message-ID: <a074ed96-ca5e-4b6c-9d9f-b13385d60cc6@gmx.net>
Date: Mon, 5 Feb 2024 08:08:35 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/2] pwm: Add GPIO PWM driver
To: Dhruva Gole <d-gole@ti.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240205055514.rox6yd2eenhsngva@dhruva>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240205055514.rox6yd2eenhsngva@dhruva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHZhsobmTrrWP/5xMIm81jeJJO6MCzdgFLH0Ivd2cn2MPrTRd7v
 D5zlbAyhGfc1Ht5zsYFNkZljXrngWCxY3O9G8FcOhOeKQeOmAp7hz0bDs4OtqWnbi5/Fr4p
 rutjaYEKxCbEGy8igrOIrl2LC+HdEWBGDCss/sLp90wXWQFWxwI/KbSvDMvZKEvxOTtt3hK
 9I6b0QtF13RNAFNd+47sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pbrHxWqgucI=;3xkW4gYjLZ2bqxvcBySP1SbCLat
 BSpdDgF5GsO48TyCPP3cvG5VmpSmLxHDgS7+VsVV1gxkMhN8vEAY95l4Gi5YGYYhwtxubcx3s
 bqkMW/0iFpl4dvvhSQo+WANWknaP5X2w8uRUbjls0tXBYptbL6OPNLSXj0wNJFKhrhZVphw/0
 BnQPM5uM8w1aO19whPQmhfErVDs2C09dokwpbMbE3ePYHfebSK1Iv6XSeccAMhY2S1KpKg6js
 vS/xOZ7cOJ7JrjiEurOkM8/fRJnqaok+vtON+DtuSPr+2ixrePC3kla6j++BEbc0OehnAxXRK
 HXq2TSiMmO2mmPSx3475COXaEXkZeO0egqsK+w8iIAM+s7X20H7f1PBuBuMg9VtVo1s/XIRjJ
 ZsL8JuVyv5wBU2izFojON788vvWe+hBYpft44wAiWItq6XQBMlpZSLUmXQUK9IDzZANYf1FqP
 r/KazvuvcZcGSWjlZ6oxPjVx4rS9X33Ckrd+1JA91Vej+ANtx0ckjvrEn9VnwJtxrqUpvSBVY
 /Ms34AT2ZrCKYgIpVVSIu744qeMquthSErUnCVN/w/KPDeXsybXvf/YeHho7Yp4pJ7JLMkJEY
 cE5ZCbpYj8VLgOI4VUDbRotfxkFKQA0uC4VOnkFbANMuSpyZgrDsyfELSQ1vEk0Q38N0Z6g8s
 zPWGoYpPjIHvkIdVHVY+sN7v7YURwvngoJkX5Ylzfe3KOPzdcVAzkVUHZsvf3ziahTGW+pzvG
 4LPxaTbAFAp2Xymem0Xc/iIkLTBdQX5pGVu0Gdp3si0p9VI2ctBf6ZARU3ydeRJB/yu3to99/
 DXxDsqSncEogJ9qVlYJrBn6tB+/1Eqxa/nM++IxIjRZVw=

Hi Dhruva,

Am 05.02.24 um 06:55 schrieb Dhruva Gole:
> Hi,
>
> On Feb 04, 2024 at 23:08:49 +0100, Stefan Wahren wrote:
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>
>> Recent discussions in the Raspberry Pi community revealt that a lot
>> of users still use MMIO userspace tools for GPIO access. One argument
>> for this approach is the lack of a GPIO PWM kernel driver. So this
>> series tries to fill this gap.
>>
>> This continues the work of Vincent Whitchurch [1], which is easier
>> to read and more consequent by rejecting sleeping GPIOs than Nicola's
>> approach [2].
>>
>> The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
>> analyzer.
> I recently came across this series and I have to say that it will sure b=
e
> a nice to have feature to be able to use any GPIO as a PWM.
>
> However, just a minor suggestion is that we should make sure it's well
> documented how to actually use this. It would be much appreciated if you
> could include some basic documentation of a few sysfs commands or any
> userspace library that you used to test what you've mentioned above.
i used the PWM sysfs for testing and this PWM driver doesn't change
anything on this well known interface.

Sorry, i don't understand what needs to be documented additionally?
>
> Maybe add another patch for this page?
> https://docs.kernel.org/driver-api/pwm.html#using-pwms-with-the-sysfs-in=
terface
>
> This will ensure people know about this feature and will actually be
> able to use it.
>


