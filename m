Return-Path: <linux-pwm+bounces-1661-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91786B6BC
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Feb 2024 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F361F1F2360C
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Feb 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628879B7E;
	Wed, 28 Feb 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ONYp/pfE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3740841;
	Wed, 28 Feb 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143603; cv=none; b=HOstnSCR3C5a1Dd67z8Vl3mvUuFg0mJyfW8Cjkq2S7daj6ro0GeQas9LUEPiaRDawib+oI2i4Pa5+KtgoMc9jzTNVK02XlBk3dM5kz+SGlJXOMIV5Rss1NtWCIcv8IK4BcG/Rp2+J9bprESTt/pWrdxrLZpKRwpOC+nXHcebEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143603; c=relaxed/simple;
	bh=n+EylA3KdC9PfeKTAfdWZ6rV3n1+43owzlt99U79yCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKlsVxYk0rVKBzowwiQcE45nMs5I6R7OLQ81/7hOBT/UW7ep4TKGpyRtOZ8ZB6eh8LpwH1mu9WfVqdCnqQSbbmsEjObNFJwKeGvVOKFi+ZswO8G/nQqG4XhQYOrA0fUhujJhNCaSmFXu18H6roh0DpvZiM1+mDqVyCw8D1DDm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ONYp/pfE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709143592; x=1709748392; i=wahrenst@gmx.net;
	bh=n+EylA3KdC9PfeKTAfdWZ6rV3n1+43owzlt99U79yCs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ONYp/pfEqq5ewd7WjExgOSmmf6DLl0TbRrvYDqs3SN0GeUqZAog1jbaXSBXrqN8X
	 Nqt7TyPwijwAItxVWHycr1STl5RLkIXac8EGcJpYXjTAViqeh5DG3oEPTlaWE/3AV
	 2GSoQ1oufDrOnnYAOnG3iEWEcbg1YFCszHnWMCoDbfCy73FTdWqU3Po8sDrXhDKiK
	 LsH2z02GSguzocopJ4S2ihbB2rYmllTCeI/ROXnsZ6OkUIi/JrcFQl29Dde6FwbXq
	 DT5y4SszvoeCVAegjcB4QqqmP7zSV/UtLqhU7EN/x8dbe98q3F8+/8/ZAFHGojkLB
	 0QH5uW1hvxWgCn4YWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1rEp4521dx-00iTA0; Wed, 28
 Feb 2024 19:06:32 +0100
Message-ID: <1f8e87ab-273e-44bd-9ca5-aa916433023f@gmx.net>
Date: Wed, 28 Feb 2024 19:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <Zd4QpBsyTnuM8hwt@smile.fi.intel.com>
 <4a6d8417-402e-4d40-96c5-15c2f1dba887@gmx.net>
 <CAHp75VdLJi2eiFmwjskMmp2adG8k7zO5aDRb-5=4eQKHhB=PXg@mail.gmail.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAHp75VdLJi2eiFmwjskMmp2adG8k7zO5aDRb-5=4eQKHhB=PXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AAG9V3Skrr5RGVxPXCVk+ys4hfthS7p3z7ViUbe3cSrHydxee2H
 i2JnDubcSH/snSbi8O6wJvWQ78S+n0EAZkwmL6GKiUfMOo5ym8fjy+tDI40NvtlzpBpGm7w
 iN8qDfHnbHUBQ1fzruY1xAoMYMDw8npP0G8p/8ez0DSmiGWSeP/SoGuqES/dQwnvNEgEiqI
 eGmMahjYT8T0ewJYGBjZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:STOObC92ELI=;Uiv/ys5n+G/pu6CQPonI+AUsmSt
 assDuFprHSXFerGyjGx43ciyTaN/mrJVh0hURKDgPXjBP2wYabikwZzHMiSwtUUi+lfSEKA1+
 aCmFRSEqd1WIsiOpso1pwElFb6VoPfQlhWiSkT2t9WsD45SylVxv392ifA5rFzKKuz+dv6zPF
 m8afnbLPMqbcmd2gKThffB7KXlTZuYx7pvX+Rj60ldjo3WglC2OuimchgwSwkaZ0MmMrz/liC
 7d9GdA5SfuCL5SQ67gSPENne9U2ZgMwEEObIc66MoaEL7FBXtW4/LqY5YemB54qU7yZhruWKX
 o6vPzYczasMXPDFUR5txHSsCGrLrdXjK2bwpMyod3GVeU8g7eFYp65WcroLFujZw651hBQdp1
 ixv/5/mluL7Nij71OCu7ApyKPe2VjS26dUJRw64t3xL3dONDbC+mMtiCqfMq5XUvjtX2xNT50
 +5zOD1Uk4jSLNC8WtmS4fqRtH6hm4KPLSbcE2ThXAW2jrOvtfyF9S6cSPKMIm0LXWtoTIyb7R
 c/IRYenom65ztJ4/ji7mvyY49MAWgTD4Rfg6FtngDdiOp/DoEw169mVqFs7Uu5pjq4ZduAntv
 UznYFegfqumJq8Z/USPxptrMnrJ3NPJVBE8Q3+kiLa0ncEVXWKHq9ZpLCkVMgKtzIIFCYnoUs
 2c4njR7rytYM/29BaPW+Ig8GhNHKgziGqLXlESqlX7ottM4F+jOLpQWaSOceNpnNZBhSQDH6M
 YpxsuUA3i+854GMQ5wSUp5HntcAoQqdGsmUxoGUr8LmF7YyyPX1nQVTKDdwWpHkXJqQdUoLwe
 nTBPBDm1/xN986KSwVSRG6DcpAqp8IKQP8AtuscLo25+k=

Am 27.02.24 um 21:47 schrieb Andy Shevchenko:
> On Tue, Feb 27, 2024 at 10:25=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net=
> wrote:
>> Hi,
>>
>> Am 27.02.24 um 17:41 schrieb Andy Shevchenko:
>>> On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
>>> ...
>>>
>>>> +    if (gpiod_cansleep(gpwm->gpio)) {
>>>> +            return dev_err_probe(dev, -EINVAL,
>>>> +                                 "sleeping GPIO %d not supported\n",
>>>> +                                 desc_to_gpio(gpwm->gpio));
>>> Do not use plain GPIO numbers.
>> Uwe already complained this, but i didn't receive a reply on the
>> question how do we provide a useful log message (reference to the
>> affected GPIO) here? AFAIK the GPIO names are optional.
> You have a firmware node path, also you may add a label to GPIO, but
> it's unrelated to the message (as it's constant).
> %pfw
Thanks

