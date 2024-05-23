Return-Path: <linux-pwm+bounces-2225-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD68CCAED
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 05:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B10B2166F
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C07E765;
	Thu, 23 May 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="FhxcBbdS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC278467
	for <linux-pwm@vger.kernel.org>; Thu, 23 May 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433546; cv=none; b=VF0nLf0ThJ6R8YsgB/bR0RCHFNuHkcd68Fxlh23RwiudVxe+rfP9p+cL3dROsq9lF4toPpPAWyPD9GU+6hrmZre5uMo/i58vDnJVHI0sifMOhuc/De/79Cm11dr0u+3ehAEl3p7P/IAupsh4jmkbhDgGfBKdF9eVJwavdBgG5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433546; c=relaxed/simple;
	bh=7DaPTZBGkttvXDB8AfLhqx6sF7jNWK9QRVpfv2fzxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOrPmzXGZUyHTic+kRNBD4nJ5wr1fdIza1S/9PH9SO+ySX2YgNm7pB+UccZpUz2Ej/S/iPwQz7bFG8A2THomKFOBynPliWU0Jboom+lLnNCD8lrx+3tWTwU6v/TVT6duLtcJAMUb843f26V6I9rh2amRKbtUbKvzOxi/u4u2dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=FhxcBbdS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Envelope-To: kikuchan98@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1716433542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pCVOTMBUtF61UbWtvu2nKJhMTtTjKGnydb/Jdcjr8w=;
	b=FhxcBbdSQ46OFbvgAWdxQJA7GZW9tW+Rqg67JJJviT54ZJTH6ulBW8YIa9jNvxyuDsNw2f
	2M/1OGKt48ujYuqKtg2WOKVbf9LUj5QLVbw/xYFNEUyfmwF6cxVDatxWTSgeHR7Hpj3lwo
	p4TZSrMq25uv13sjXX7HUuRJ+wBZu1717d/7y3dAv8crxXQdQAn4NIQ2pxyxbdK73ytwhD
	CnU1avWfaB1loIYCZTer/ek+TfsfD6DdW2iZ7ZFrVwJf8eiQ0i9voPBMW9Fv0CpU0s6OfJ
	NzE/w7FHeZbUlwG2pXmyhTBWO+UfBPnwD4Mq+W+09cbkaS04YQFNocDyVfIOOg==
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
Date: Thu, 23 May 2024 13:04:11 +1000
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
Message-ID: <Zk6yK3U9tgxOxcBb@titan>
References: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 23, 2024 at 11:26:07AM +0900, きくちゃんさん wrote:
> Hello Aleksandr,
> 
> I had coincidentally developed a PWM driver for the device.
> Based on my experience, I find that dynamically changing the coupled
> DIV_M value is quite complex.
> The current approach has limitations, especially with resolution
> changes, which can be unpredictable for users. For example:
> 
>   1. Enabling channel A automatically selects DIV_M.
>   2. Enabling coupled channel B with a specific period may result in
> poor resolution for channel B, as the DIV_M value depends on the
> period of channel A.
>   3. If channel B is enabled first, channel A may not be enabled if
> its period doesn't fit the DIV_M range selected by channel B.
> 
> Additionally, using APB as a clock source for the channels would
> further complicate the process.
> 
> To simplify this, I suggest (maybe for the future) specifying these
> values directly in the Device Tree like this:
> ```
> allwinner,pwm-coupled-channel-clock-sources="hosc", "apb", "hosc";
> allwinner,pwm-coupled-channel-clock-prescales=<0>, <3>, <8>;
> ```
> This would delegate the complexity to the DT, making the resolution
> predictable for users.
> As a bonus, it introduces a way to select clock sources for each
> coupled channels.
> 
> For the meantime, I think it is enough to use fixed "hosc" and <0> for
> regular use.
> 
> Looking forward to your thoughts.
> 
> Best regards,
> kikuchan.

I have a somewhat opposite opinion. I've developed a driver too and posted it
on the u-boot mailing list that is deterministic and handles both channels:

https://lore.kernel.org/all/20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org/

It does this by remembering the settings for channels and disabling then
setting both channels at once whenever there's an update.

I think this is a decent enough solution to the problem and just works
automatically without people having to micromanage the controller.

John.

