Return-Path: <linux-pwm+bounces-4703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5300A19170
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9831889CA4
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F2212B1D;
	Wed, 22 Jan 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k3inm/AL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357B211492;
	Wed, 22 Jan 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549454; cv=none; b=iZN8FK3RkQy0HOym8+WmN8J+IAmcNmzRvBeRgGygI7Ii7mm2VL07otpwmUrV7dZ8e/8D5ULjpM/Bja1UA+4t4xvNHpKL5vtDgTAkTAbGYQggdOFrITCn3kj7tvo+XlhwFZCZ3q5XQPcTFlecnQxtuBuUfZ9jlifLKEKpihaIrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549454; c=relaxed/simple;
	bh=yw+CkbfuSTyi5N2mW6c4l4yTGpu8cv8oyOlx69RwAvs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=dJ9dlpinDLxfcPQ3+dcvUs7T46CvmqC6C28YP7LkbpQBijF8vEV9O65629wti+aWuhxEV2fJiOB4X+Pl0ew69/JeGDvBRR79EDkuO6rBy6+xn5Il7BdMycAiXUW42U3HBSE1b+enfnTrxDQe60glugdL2s0zvNV/W2eJcer/284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k3inm/AL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 376F81BF208;
	Wed, 22 Jan 2025 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737549449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yw+CkbfuSTyi5N2mW6c4l4yTGpu8cv8oyOlx69RwAvs=;
	b=k3inm/ALBopY8of/E8nd33qIgu6HcNQRrm2s8SQGeRt0YtG79fZ2pL0QF37ewyKfuHPPLG
	mmpEyLMhk+1lRop7FfJlluwKxs2hrEb8YsLulZgaeZKWhxvogpPdXQNQAjS0XN29BIONny
	E4yTX8CH3Lm8Efy7Tj2pJyyvSY7RJA8wchnfVPuDMx/Oo84ZP2uJhsTV7MYsU0KhV34/lL
	+VFXk0tmvD18k+XG9tkVdEQYQxdjBAq1jW//YQgRmf8HAEwgcRYvhjJ01ClT7jsssWxhl/
	9uThq0xhmcpw7aYmwRXbKHaGYRB41gMi6k7qspFr+t/5EItF1pTQeYHWwR0c5w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 13:37:28 +0100
Message-Id: <D78LVHBIKPGH.33YJLSO35BN5Z@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
 <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
 <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>
 <v4bf6bharih6zgz52ya5twfyf47wh3fu56ovic5gjxak2jhufy@q3eudujjwrhm>
 <D74GSFVY17UV.GMN119MAVAK0@bootlin.com>
 <vljrtytihjud6v4xnyolrnbopep45ga2kagygoruryqwvpubmt@s76ht4taazpx>
In-Reply-To: <vljrtytihjud6v4xnyolrnbopep45ga2kagygoruryqwvpubmt@s76ht4taazpx>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Mon Jan 20, 2025 at 3:13 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello Mathieu,
>
> On Fri, Jan 17, 2025 at 04:47:45PM +0100, Mathieu Dubois-Briand wrote:
> > On Fri Jan 17, 2025 at 3:40 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> > > sounds great. Note that the detail in rounding that is different for
> > > waveforms is that a value that cannot be round down to a valid value
> > > (because it's too small) is round up. This is a bit ugly in the drive=
rs
> > > but simplifies usage considerably. So you never return -EINVAL becaus=
e
> > > the values don't fit.
> >=20
> > Sorry, I'm not sure I got it right. Does this affect the three members
> > of pwm_waveform (period_length_ns, duty_offset_ns, duty_length_ns) ? So
> > on this device where the period is fixed and I cannot define an offset,
> > does that mean I will silently accept any value for period_length_ns an=
d
> > duty_offset_ns ?
>
> Yes. The fromhw callback obviously always fills the respective constants
> into .period_length_ns and .duty_offset_ns and the tohw callback
> essentially only looks at .duty_length_ns.
>
> Best regards
> Uwe

Ok, thanks! I will make these changes for the next version.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


