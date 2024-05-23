Return-Path: <linux-pwm+bounces-2228-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA208CCBE9
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 07:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474CF280DD6
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7968005C;
	Thu, 23 May 2024 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="hytQWbFK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A5537F5;
	Thu, 23 May 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443739; cv=none; b=JgnKp+nvryWuzHxodqZkTfZNR5firWO6Set/GaarVODhJMJG8q5DFvJ3SVEY2j58/ZXO4/bHQUjIxnzUnLFa5i9KqpgsnTB2h9tv239AYtBPeuhvV1JvkRSfCkRc70iSGfu1DlE0ZgIUJNfz2fsAHdYOpPkaMLTldHXY4vEQBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443739; c=relaxed/simple;
	bh=SxmqM88Y/QvoBAEDVZtTfuZXc6MFXor/37QPRIkhkfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQepr3TEs2DCHcX8S09pYZKsYLCURah9riQwIQQYvm601TGOcnaa1yt4j0w4IbVARWU++ScZPxiebtVrrSdeWvzoNf7ra3yPbP1cqIdhJjRRQKFSEQGoEsutlCw0CDdT+HiWYub+kIJHfeTNbTzn9Cb7uPGouEjWcIammjgXUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=hytQWbFK; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Envelope-To: kikuchan98@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1716443735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY3OZs3TRZ5fmpHwmF6ZDWmp14tMvpciAkxRyO1/MQo=;
	b=hytQWbFKB3vS3t96pRQn4SK+Ur5QZdeFozP0miOBgRAvWcITv47RA+H3y/L8s41jv2Jvwp
	2V3mqNq/STuUork+Ia76faXDFhZL4ZPVJp4uVFqRYa0t0qWzpkA9rgFdAB+oeV0c72NYxL
	PBbUgqJ5mADP46bcP+qBEZ1ZEOAA+KlwrEcGFSrsbgy2FCZJd+5S03xqmAqedwC1PPR2pc
	H6K1usInzBMeoeP8VMe/OUHo7JdQqZjr1RwS3T5ADMI6Z6G4iS0BOeMVvQ7846Mdwo0MU3
	rQenItiIfmJmr5/f+6MwV4ChKBt6E+oDXNL7sWK6sv2hGNZn32pWDadZJw9llw==
X-Envelope-To: privatesub2@gmail.com
X-Envelope-To: aou@eecs.berkeley.edu
X-Envelope-To: bigunclemax@gmail.com
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: fusibrandon13@gmail.com
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-pwm@vger.kernel.org
X-Envelope-To: linux-riscv@lists.infradead.org
X-Envelope-To: linux-sunxi@lists.linux.dev
X-Envelope-To: mkl@pengutronix.de
X-Envelope-To: p.zabel@pengutronix.de
X-Envelope-To: palmer@dabbelt.com
X-Envelope-To: paul.walmsley@sifive.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: samuel@sholland.org
X-Envelope-To: ukleinek@kernel.org
X-Envelope-To: wens@csie.org
Date: Thu, 23 May 2024 15:54:00 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: =?utf-8?B?44GN44GP44Gh44KD44KT44GV44KT?= <kikuchan98@gmail.com>
Cc: privatesub2@gmail.com, aou@eecs.berkeley.edu, bigunclemax@gmail.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	fusibrandon13@gmail.com, jernej.skrabec@gmail.com,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	mkl@pengutronix.de, p.zabel@pengutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, samuel@sholland.org,
	ukleinek@kernel.org, wens@csie.org
Subject: Re: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
Message-ID: <Zk7Z-MfdF-YKWeJ6@titan>
References: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
 <Zk6yK3U9tgxOxcBb@titan>
 <CAG40kxFxE_Oj+9aCzGku0a3KFHpuW8ai=gEkV9M8==5gwmjdEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG40kxFxE_Oj+9aCzGku0a3KFHpuW8ai=gEkV9M8==5gwmjdEA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 02:30:32PM +0900, きくちゃんさん wrote:
> Hello John,

Hello,

> 
> Your method is quite impressive and challenging.
> 
> I think PWM is not only for LCD backlighting, but also for signal generation.
> For instance, imagine an application software that sends a stream to
> one PWM channel to synthesize sound by changing its period (plays a
> square wave).
> By your method, if the other PWM channel is used for LCD backlighting,
> it may flicker repeatedly on DIV_M changes.
> (Or simply both channels for streo sound synthesize, you may hear lots
> of pop noise)
> 
> It means the setting of one channel can affect the other, which users
> may not anticipate.

Does Linux guarantee a flicker-free experience with setting up PWM
channels, or that it doesn't affect other channels?
How do other drivers handle this situation?

Maybe out-sourcing the clocking to the device tree and letting people set the
clock and common divisor in the DT would be a good idea, with the HOSC and a
common divisor of 1 by default, then error if the value can't be found.

This would work for periods from 41ns up to 687ms by default. Using APB would
give a better resolution as by default it hangs around 5ns which is nice and
divisible by 10.

> 
> Best regards,
> kikuchan.

John.

