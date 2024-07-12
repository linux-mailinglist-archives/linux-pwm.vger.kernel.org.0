Return-Path: <linux-pwm+bounces-2777-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E29B92F584
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FA52835F3
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66DE13D50C;
	Fri, 12 Jul 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VvK2WtOX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3B17BBE;
	Fri, 12 Jul 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765595; cv=none; b=OXZM+32B7LTg/jFodhJidOVuoGsenNa7bEMSD66i55IPr5CY9N6Baom0x6lxG6HaRu/56H7EkVv7+/JusqfLY3aou49tTF0XnZykEbxaGpP3kmfLikmvKUP14cYASMSVEvY5jzcXToq5U6evdF9Vf4amUPP16FcDNF+paFYE14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765595; c=relaxed/simple;
	bh=TmSLg3cGo8e+RfLvNoIr5p2SU527l8ZLtxxAgdMewyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVp3qNZZufAMbuHiDnHh9/MzqxbzlXgy5M8ym5TGbCSzFiuxPvgnyN4uXiSzqyJd104WeHwrVuUBBcC8JV6urIokkAN0kXePniUloOrP/4+lj8E/GP/XHbQ4KVL7oDjrQzv7OI7ZIpEA3KKcN61gW4SU2Ni71jhprUaWVeP41jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VvK2WtOX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720765579; x=1721370379; i=wahrenst@gmx.net;
	bh=TmSLg3cGo8e+RfLvNoIr5p2SU527l8ZLtxxAgdMewyo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VvK2WtOXwkIH86PI/FIG6CW9xhznvkL88pY+uoa2fYIlQbF2+44xMrcjKvqKGkMp
	 ZE5TAtEFAW+piTo6mQ7ZcZd7d1Kh2bA8n4tgRpQ24gT48EfeDFoQ1y24DMYQ0Jtm/
	 /G1BmFx6kCiaUYwjr6LmkOWwRytMMNXZ9XCpCBZOd7Zzhtv4vT2X1ST7mvbZBTip2
	 S/tpkZqxAIM6YyH+DcXG0dgv9mFV4CoP2Bzo0E4FGL9e3ofXajzGXlYHi4KfoCORJ
	 ASs1aVp73C1/dnNuz0jKkfNlaCUOO76PX8BrF6Kj5qBMqZ2FdSji8gZYHg7CRKw9c
	 qb4BmBotUhgRvhpAHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1seHDy3ly0-00E9ed; Fri, 12
 Jul 2024 08:26:19 +0200
Message-ID: <78119193-98b7-446f-82d6-37884a5b03ad@gmx.net>
Date: Fri, 12 Jul 2024 08:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>,
 Jun Li <jun.li@nxp.com>, pratikmanvar09@gmail.com
References: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
 <20240711-pwm-v1-3-4d5766f99b8b@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240711-pwm-v1-3-4d5766f99b8b@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lAnRdLo/NzQOq22G2oDt0rwsAIoHHWZflscox3YXMhJtJ1InvcD
 2xDGz3CIruiicfCSBF1XCZ7t7tKw5mVL6BFN1FY8rVtg1/t2fBYsX3ipl9XjbPs+RLAqaUo
 xwao/7pFGcQHOzxxfZQM0gQ4qFidpJ3BGeeqLJSVq5PFR2XQoUPq3B3L/lkFPTzqy5ENLhd
 59jjDy6JPhjZOQm5XYEJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4qvoVPpZ5vg=;CqThS0ovliZ34aePm5IljqA3g7M
 eFJUg+mi1DiRQMo6XQK4zS7G/mDOrh90AxqTHrW5jLGHbk5BUD4SyE64N9qn4ySVW/5kR+YuM
 LMl8jBNel7WhwBkgHJS33MuDGCzgjet8wSjd8fPJMBIAoIQtOTEPytvRqJm17P5Bt4EwRtSo3
 KRH79Id68PWGjYp72gLNmTClEGy57q0dMF5rG3Z76ILcsri6Z/mKLS8H+cRfKm9ZEGdfuRXcF
 Gj/u40Ed4Z5BN/QS6W350veFGHWjYhOYZVrnhd1q47JoS3uC7xMxhtbkSSGBz8o1uksvq/zes
 MmRVfFn2TKoaPcFgdspdykWezoIGDhohm33bxM1pi8ROMfTyQVcDP4fSFvxyTopByos1aVsMO
 jtDnjW9QZc7wIGE80lStJ3FHU2tL3atstd6KxWTy9lcp7dnwo5E8HILBGBFWoJXfuAX9/xcAN
 93UboUEl6F8IE+Su9HPYxdzmJvLawaOZF78y2UHMkCdykbamD0CzJ29x6WH863NI6AsVzfjhi
 /J6XsOG81wTosh3dCvHTd34ym7tOCWb9zUEvdkznYsphzKqMzLPlkSf/U9YhjfrIlL4RCaWuf
 OkI87OTpTM0oyLxP7zh4bipuqhuqNyncOr27ESNuuiU72xCGWL9wcVE0+Z2PlmlYnpGKnNnH9
 tIMSvbcNQZTJ5bdfFoqkepmhQkzEvD07xxM5f9T9TpVaLJwpTLo8CZbpcQDYPIqxxJBhS1z1w
 oR0z5L4Z2pAPdW0FG3i/tTlKgrTMm7Wiu80qxo24pdQrubmPisvw9XSNVmKWPOBJ7xl1gKqtR
 rL1TARzAGofrI7h85VaAte7Q==

Hi Frank,

Am 11.07.24 um 23:08 schrieb Frank Li:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> When the SAR FIFO is empty, the write value is directly applied to SAR e=
ven
> though the current period is not over. If the new SAR value is less than
> the old one and the counter is greater than the new SAR value, the curre=
nt
> period will not flip the level. This result in a pulse with a 100% duty
> cycle.
>
> Write the old SAR value before updating the new duty cycle to SAR. This
> avoids writing the new value into an empty FIFO.
>
> This only resolves the issue when the PWM period is longer than 2us
> (or <500KHz) because write register is not quick enough when PWM period =
is
> very short.
>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
the same patch has been submitted from other people in the past and they
received many review comments [1], [2].

Can you please explain which version of the patch this is and does it
address any review comments?

Best regards

[1] -
https://lore.kernel.org/linux-pwm/20211220073130.1429723-1-xiaoning.wang@n=
xp.com/
[2] -
https://lore.kernel.org/linux-pwm/20231229063013.1786-1-pratikmanvar09@gma=
il.com/

