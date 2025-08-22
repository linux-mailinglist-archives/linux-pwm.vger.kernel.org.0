Return-Path: <linux-pwm+bounces-7143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F56B31851
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BEF624C2B
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D402FD1C8;
	Fri, 22 Aug 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SDESnmyJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65F2FD1C0;
	Fri, 22 Aug 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866971; cv=none; b=pzgYlaxmPv2qaI5EsoZ+sLYYeg5RhdFTTGp2BK/LQf1dvAGI1XeiHGtGl1sSOV//uF+3npzep10YHfd2TvGVhhqYC3//v6q7RLxOzUtEOpK2C9dbdkD8o6B6IkxepJ4OnDqb3RXdchI9LlSVQgpWqfZx+bSVODZzORIhpSQvemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866971; c=relaxed/simple;
	bh=hqPSW8gjRuHQDQ+i6kbMnBBBnlr60fdu7FJ683wtg9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=EdzVhyfLOVGIusZdccc1mmyqc4UkkvTgCeh3InmdCoaO66JUzFYzkbjUd01QgTby4P9krZGgqKxsQyQjaNSqPDWR+vwKjbi30ND3cRIk8cLeYh3+IAkgTDYNjqx3q5cC2AdO7BYL6KoLm6KJ81wMRvhSo8gtAoPgTGaMYwhDPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SDESnmyJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 774161A0D48;
	Fri, 22 Aug 2025 12:49:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45D03604AD;
	Fri, 22 Aug 2025 12:49:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58D961C22DAC7;
	Fri, 22 Aug 2025 14:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755866961; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ua42caSIreMTSgZq76zsnJuAIzw5ug7AfcH2QBcncRU=;
	b=SDESnmyJ/kgcZDMS117RQSYG6rtBD/JCv3cYBZOa9cHLPlLtCFuEa5ocMI/hx9RFSDNbG7
	L2Sewj3/uIebW3MjKm87ZtSWD0uuJ9wy8pyVSDDdmKN2ZOGdHqmEk6CVZbYXeqqGvOXaz3
	VU2ejhHOYZUxXIj2xWhYJOt9atBG7jK/AgR0LKXDK+s1YqGhLKGbb1MojYTW3wmMzNpvGD
	U3I9ZAbTNFdzR6nu9DKlol+72VaLaT5Q5yrJN8plgt7jpNOrZd9DtH4QtId4+zMdz630LJ
	yL3mgzLzGsLAhOKUkLYGGxNtx89sBeu+Mho/QbCpLdG0PBEA/zUVHgA9DRP/xg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 14:49:10 +0200
Message-Id: <DC8YVXKCZAE4.5QJM9MP4HJZ5@bootlin.com>
Subject: Re: [PATCH v13 04/10] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250811-mdb-max7360-support-v13-0-e79fcabff386@bootlin.com>
 <20250811-mdb-max7360-support-v13-4-e79fcabff386@bootlin.com>
 <l5crrk3ugpo2ggjtykcy5eretclgntebyq52xuouekoimbrsvh@u4koyu5z2wwi>
In-Reply-To: <l5crrk3ugpo2ggjtykcy5eretclgntebyq52xuouekoimbrsvh@u4koyu5z2wwi>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Aug 18, 2025 at 11:05 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Mon, Aug 11, 2025 at 12:46:22PM +0200, Mathieu Dubois-Briand wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
>> 8 independent PWM outputs.
>>=20
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.co=
m>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> ...
>> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
>> +					   struct pwm_device *pwm,
>> +					   const struct pwm_waveform *wf,
>> +					   void *_wfhw)
>> +{
>> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +	u64 duty_steps;
>> +
>> +	/*
>> +	 * Ignore user provided values for period_length_ns and duty_offset_ns=
:
>> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of=
 0.
>> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/25=
6
>> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
>> +	 */
>> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
>> +		duty_steps =3D MAX7360_PWM_MAX;
>> +	} else {
>> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_=
PWM_PERIOD_NS;
>> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
>> +			duty_steps =3D MAX7360_PWM_MAX - 1;
>> +	}
>> +
>> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);
>> +	wfhw->enabled =3D !!wf->period_length_ns;
>> +
>> +	if (wf->period_length_ns < MAX7360_PWM_PERIOD_NS)
>
> I know this code was suggested as is by me, but I think we need:
>
> 	if (wf->period_length_ns && wf->period_length_ns < MAX7360_PWM_PERIOD_NS=
)
>
> here to prevent to trigger a PWM_DEBUG warning. Sorry to spot this only
> now.
>

Right, this does make sense. I will send a new version shortly.

>> +		return 1;
>> +	else
>> +		return 0;
>> +}
>
> Best regards
> Uwe

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


