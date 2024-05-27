Return-Path: <linux-pwm+bounces-2243-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5108CFC17
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 10:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186181C21DCB
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A013E029;
	Mon, 27 May 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bkMUmjYJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D913DDDA;
	Mon, 27 May 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799467; cv=none; b=BhVOfGcyKajBdDRK3otaxF9xxNi+9+oh19J589boxxohZWDssxSuaZmVAoZrDvGh5VDVhXQiabfVEt1DKI8RrBfbdT20EjfjuL+lZnA4csVljZiC7rkK7JuL2v4T+UC8lzzJAV8XWWnjYqHkykVZKPYUgOvYOcPO+46O9ZaWH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799467; c=relaxed/simple;
	bh=Ukgl75mgGmk6IA6kEl0uX4YlVVB62XIsM+pDa30dGc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTtsZkEgnomXqubkx7SxXYVhKslLVJ6DeEAZPgGQbEU17Z0YYka3DuMOcsAUerGzwkSVkWonHcaJICUMT7nmt+H3pRhfrRpIR8DT2nsblZnEQj1ENpGTsNxxcelLMfmriQTMf6cyS9inweZ9En3pCbX5e/bCAdss+dk+vMrWCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bkMUmjYJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716799455; x=1717404255; i=wahrenst@gmx.net;
	bh=Ukgl75mgGmk6IA6kEl0uX4YlVVB62XIsM+pDa30dGc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bkMUmjYJDfhubujkLlJxNxkdfX+E+JjFzOmAI/a8E7LHnGBrYGcLXIGPEqKqFsca
	 PLCsFUNFcTkdZ3Z16KxUHqnSi6uz7vLcUolnNl/1tzZY2/luvyFQjHTfTEHyde1ie
	 eJtYzhxkIoCyqpd7H0uHHQw2qylQs1JV/6FMXtLE4iq+xeky3hnMHc3dRchUzdY8y
	 YpyzVwvy0IQhVaI5EFPmMo6lhSjbdz/JfDth/Yex1RrRSbvPJNeuRhzKr/a1GWKK5
	 2H59Erum3Gtnt65L6FI7NZM1+aIYp4z9pt+2DJnYMfBzpMYrTrrNZGKDZeQMm6qbR
	 tWLW+ulE42GOHfwgZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1stxOw1lj7-00iPmg; Mon, 27
 May 2024 10:44:15 +0200
Message-ID: <33d009cc-3378-42e0-8d40-a74a0b583a44@gmx.net>
Date: Mon, 27 May 2024 10:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/2] pwm: Add GPIO PWM driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <CACRpkdYmOECdug1g2gYxjHZ-+Y040SR70UtDAgKD8yCb58Ob6Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CACRpkdYmOECdug1g2gYxjHZ-+Y040SR70UtDAgKD8yCb58Ob6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ObUVH9ggdg+OxF4a7t862fLndJew2wtBfm8LG2edmsVR2Fttk5a
 oB4uUeAjU09LlxcWDaoAvfNmpyFTFRl1CUuTYUA9t0Geata4dBbJfZu3mpL3twDlI74fcKy
 NxLaIfgAWhw5xd2Zzb7JJTyMNJenWueAcmU/YrHU29cofdVjLcZCjceZBcUAtMQiWCHms83
 nYiwhZMKjZFN6Z6w81WJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SdY9CAf9CpU=;69R23i35i9bHC15KD2b9tyFvb8r
 /H/Mr3Cb8tA+2wzIZQIjBOs+CC1hPrknatORalm3abQNlUPpzCR+6FFe3qvqXKrnCqzOt3Jok
 9giJFa+lIXS5oJrQecZbXIwuHAUEvf3Hf091ng6ishsLwQ95XX5cxcE2j3f3hRmyX90cjKX7y
 /H1i7mbBOgqFF1xvtALGzf7L36kNEo0MUrySSVUhOLd1GVe9jP6msyQND903SkC0TDTbXcStW
 J+j0mW5E1UYHBTOZBRZk91DjzxBXLiDNx8UuBrRcjGNlmyGtU6CSD8tQO45lKztXfAOfrEvi4
 JnzWn42R5Fjy/YrsSWnkg5x1VGLwvGi2mXO1hA5NeVENq4u9zb2lGRBDCXaxxX9fb3j9cE7zn
 AfNGs3FN4LGt1oJd07Vkgi30Guw3vkcibu1co3A38aZvdtEdpa8OmBa2bTQs2QmKhkiDo0Fla
 z1Vfl2bOZv7dBBgkxCOjGUdPseEpK2l1+mhj+lapLajwS4qc2N4tw6ADPUg1V4BEz7Mjg5YYf
 fkb7mobnZDdXb/igCPJ6dbXE2HBnE2ZSYqA166FuZNgHyMYcYCI1DNi/1+cCdB0giY7AyqH57
 foGgS/L+Fq92wH5kesXu7QLTak9m/KVIwt7zYAr7y74p+seryU/SpFYYFFUq6PB2eqFSOhcED
 spuqujxWLX40zsxuHFPtwyAra+p0KMeRjQ3VWrtedtE4dTCc5b5yo9Kcda5jLbDstC/ovhc3a
 qLvHWNm7UehfzHHRLnfvFkTTeYSGkU/W4Nxte6ez+zx33bBiaQq2CCBUaHMo4InBFK6XgMgCa
 Q6lamLn4wE4Bqd9+rpUQtIzVMey69FCRoUktIBpE+Ba3g=

Hi Linus,

Am 27.05.24 um 10:22 schrieb Linus Walleij:
> On Sun, Feb 4, 2024 at 11:09=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
> Is work still ongoing on this patch series?
i addressed most of the comments of V4 except of the possible interrupt
storm in case the period/duty cycle is set too short (comment by Sean
Young). In the last time i prioritized other things and tbh it's
unlikely i find enough time to finish this within 6.10 cycle.
> I would use the patches and I like them a lot so I'm happy to help if ne=
ed be.
I could rebase my latest work on 6.10-rc1 and send it out as V5. I would
be happy if you want to continue on that driver.

Thanks
>
> Yours,
> Linus Walleij


