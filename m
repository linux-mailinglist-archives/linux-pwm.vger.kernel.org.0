Return-Path: <linux-pwm+bounces-1212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCDD84996C
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 13:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E15280F33
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878A19475;
	Mon,  5 Feb 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VX2X4zNz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EF199B0;
	Mon,  5 Feb 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134343; cv=none; b=AbqIAEfYrzOMhBecIhyHrKGlf7NIVUVVt1FHxyS+e6DnczFFYWt6jbCCD6MDB6rg8T9j0nmNYgD1ldbLdKWK8ykoeuYOGkyP4ODx22fXKHM9iXZYBg8IdBn2NVZmF2nPFdCGeYIorkePBZmejwM0G0IwU/ZYaMDMBZQlFcQ6Q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134343; c=relaxed/simple;
	bh=f/UbavRhjoaVvbmskvWAMvejHYVscy5mA/b9KLY3Y7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRKnFqbU/70K2NhXbgoB0ItDR6VG8cg/mwomJVx8sPYPrljyI44PbdItH5Y7nVGlw9IQNy69/Q7NQ+mf6iEpzgOruQnqqV1e3bgPokazFNOGPX5mYrXSy8Nu1+zyY5gPpOzjMPzzR+QiU4fofiQB8TnmmndfHdzU3uNYoGx9kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VX2X4zNz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707134331; x=1707739131; i=wahrenst@gmx.net;
	bh=f/UbavRhjoaVvbmskvWAMvejHYVscy5mA/b9KLY3Y7s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VX2X4zNzxjHACElSe6clchMA+vG4hC3DJomR17PKChv5zesf/E2nN7hOxMoNM71h
	 cK2RGgISnI/LncBapSJ26pB4r6Hxq2qPBUV/dc7DiCuH4/xgTd56iWpTpugmvtLaP
	 vyJyMcsVFaJBqd03o9zZf1mixtS6cyn0Tz4dk7fY9sfjL2ImUVNPOdONg9kUiQsAw
	 fh6qV/E7QFRUcJPKwnqOkm+MhFt5QeJq09bmzIpXh/tPH80wjOQTeY37KsC1JMbit
	 hvWGDQhThY9StaT4++c/ZcybZk3aq7PW/XEv7qlU3AUCSBFcVKTaWSGfCuCbCjf4o
	 TGtSyQoC5/slVuVXZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1r2JhK28tl-00e8vu; Mon, 05
 Feb 2024 12:58:51 +0100
Message-ID: <e92b9ff8-5486-47bc-828e-c19a7a251d4b@gmx.net>
Date: Mon, 5 Feb 2024 12:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] dt-bindings: pwm: Add pwm-gpio
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 Nicola Di Lieto <nicola.dilieto@gmail.com>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-2-wahrenst@gmx.net>
 <zxzck6nm2xxakobwj4mk4x3vrz76c7dmlwgplhhunuzr25oeok@lc3kngblfmnz>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <zxzck6nm2xxakobwj4mk4x3vrz76c7dmlwgplhhunuzr25oeok@lc3kngblfmnz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IFddr63wFDUAJh89cO1UJ213DGxFVUXLhZqHmgs7pMwEiyuqhYf
 WtbY/dNldTz5gEHQg49JlJBh3DlcDp7v9dRdd4h7UiPIEyuvl47a+uZhdL4Ngm3VegbxzsJ
 0Re0gV37SiOnSLj5o6pW5KxpL6nTLurNb/2a1+nkJ549HQSvf9BPUlpqDTcMz+Py/pMnst0
 ytP7Z9N4vg4FfO+Jltmsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QYLDAQqhya8=;lR/yaYFQgc5bUxt7YOQURUH3wTh
 ScAGBARXwgIJgFPgYCH8vXPePAifhy0/S3j5zqiObM5eIVfmkgbes6GE0I+PFxiX23hpCSh5i
 Ees0Plhyxg9KknZG4QZdVYoXYp/Q0AKrcy8eGxww6JVXAP4GMANwxwcRA30m64U/3IHBHQ/yo
 eHmVKcb40ztiBq60tJzl3nDeEoNHSIum2foRMxAHm8d0JyWnX2iN2JmTkTl5O/mJTOcynS2+Y
 fCA9/WELgekZmXmNfMbpBB/1qtPrT6D47XO+VEKwa20GY+BwziLWjxrvadmHWobQ1JPzNebIX
 ZmhZF+ty9/X/rsl1FS9Rv2+PVIS0Q+NBC/0TajYlF1dcMP483VcaqJ4XGb2LJseAM5NLDG55B
 Uar2U6lrmur45ix5VS+N0xkJXrCoKodgkNTuc8i5UY7W3+onodhwtT5hUKGUzv0wPGnN8XF28
 XBXMKlzjWHY98sviB+lbH5LF5nu7zUlHDV/1W0RIcUbqQBIeFlcrfO6ghiWUcdyT+6OHwjINw
 lRlLJQRwGp99ftl1GEaXX/oqUzqVuOoJNbf1s+5FxuM8B6CypfJo247X4kcGsUk159j3l6dmu
 Az/tZG8+Gn38PD9h8qD5VF4y/COlM1HHfMzDNZwrTsubtwPiCvMr3d5tPyfHsL3PwC86nmE5+
 8AsWg/em0n/7DhI6hIingUTaWu0gvyp+gIegJUble2+VNM3z75iQL7hCeOozBhEHPGLIteVW5
 LKN04YReRAbMe82Hu38bO2F300pdnJSNh9Em1OFX0LbRx8AL2YjywGiVzHVYsWrVi9sF2Co+2
 +z0hoZwi/8gZHSTT7BJTeGZggr8Fv3I/Icvs99hM6bKXw=

Hi Uwe,

Am 05.02.24 um 10:15 schrieb Uwe Kleine-K=C3=B6nig:
> Hello,
>
> On Sun, Feb 04, 2024 at 11:08:50PM +0100, Stefan Wahren wrote:
>> +  "#pwm-cells":
>> +    const: 3
>> +
>> +  gpios:
>> +    description:
>> +      GPIO to be modulated
>> +    maxItems: 1
> Given that we have 3 PWM cells (so there is an u32 that specifies the
> pwm_chip's line number) it would be obvious to allow several GPIOs. But
> I guess we can extend this easily if and when the need arises.
yes this is a limitation in order to keep it simple.

Regards
>
> Otherwise I'm happy with this patch.
>
> Best regards
> Uwe
>


