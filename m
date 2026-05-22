Return-Path: <linux-pwm+bounces-9079-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hR1tDMA8EGrzVAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9079-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:23:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C34595B2F15
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E899F300679C
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985123D88E9;
	Fri, 22 May 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVqIVWGS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F311360ED1;
	Fri, 22 May 2026 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449018; cv=none; b=My6zVTLqf0TsAFWCa8ldodyX0TnFe0orY/Y1X3NBrq7h2nxQbU+sYxF4AHPd/oasXKuYv3pHDqD6DEv4FVz/dFOont7gCX5UkyMkir4V5c9PBwEqIAXXeyBtA7chAz0/UA2/iuxvRdufu2rjK05QHwY3WyivLn4+92YV3rt1vvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449018; c=relaxed/simple;
	bh=HFtmXz0PCp2aQpnPMnU3L1VxYRn6d9FRpQD2wRgGSq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW0TE9rnKIAdLC7qwhmNwVePRLYp1Td1/VpidZM671xQJzdvIaCP2SKxGSh1tNfdBgyMgVgKNBgSzJcEGj66YAtpoQJBNEJCulANpjBx8vxLVtSce6Ldw+JZ+YEseemu86fCsEpIwFaTUTNdKwG00z2jXiWRVyFMpmGgJizqLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVqIVWGS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EAE1F000E9;
	Fri, 22 May 2026 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449016;
	bh=g0Tk5SjgRMfO81NIuJvLyIjw5gsTSwcbfmCYhvq+Xsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jVqIVWGSsTzhxLytj8chbFa3NmrX/sPZxrQrnYwbsVTFyitSFbt/3CUFIkk+Ifozu
	 vJZJVlhnKBnP/Uo0dS6fOvwNB4LrIdH2PE3OZmaca1FLV2fQHYeGiPaZr4+SLrHMiP
	 1A0nmndTujTrT9UJnqzHxEvX+085d3mVRZqSznR3ok12fbog1coCUX8NoKG1pNbK7E
	 HK1ri7I81+nAdwn/bOea31fKfVmqIt71ShcZ1oACMetLosYHONUM41PJoGgSwuvQAL
	 wXMlEfW5/ECXfIVH0TAeiAj9R8tVFDKDrKm/YHt3Ox0yDFU7CVbgfzUvCLSX95xvm3
	 PO2G/QuLTWu0Q==
Date: Fri, 22 May 2026 12:23:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v12 1/6] dt-bindings: iio: adc: add AD4691 family
Message-ID: <20260522122322.2cd9d4ae@jic23-huawei>
In-Reply-To: <20260519-ad4692-multichannel-sar-adc-driver-v12-1-5b335162aa51@analog.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-1-5b335162aa51@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9079-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org,microchip.com];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C34595B2F15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 15:20:22 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes the hardware connections:
> 
> - Power domains: avdd-supply (required), vio-supply, ref-supply or
>   refin-supply (external reference; the REFIN path enables the
>   internal reference buffer). Digital core VDD is supplied either
>   externally via vdd-supply, or generated by the on-chip LDO fed
>   from ldo-in-supply; the two are mutually exclusive and one must
>   be present.
> 
> - Optional PWM on the CNV pin selects CNV Burst Mode; when absent,
>   Manual Mode is assumed with CNV tied to SPI CS.
> 
> - An optional reset GPIO (reset-gpios) for hardware reset.
> 
> - Up to four GP pins (gp0..gp3) usable as interrupt sources,
>   identified in firmware via interrupt-names "gp0".."gp3".
> 
> - gpio-controller with #gpio-cells = <2> for GP pin GPIO usage.
> 
> - #trigger-source-cells = <1>: one cell selecting the GP pin number
>   (0-3) used as the SPI offload trigger source.
> 
> Two binding examples are provided: CNV Burst Mode with SPI offload
> (DMA data acquisition driven by DATA_READY on a GP pin), and Manual
> Mode for CPU-driven triggered-buffer or single-shot capture.

Doesn't really matter, but why include so much detail that is easy enough
seen in the binding?  If there is information we need to capture it better
be in the binding!

Not actually worth the effort of changing it though - more something
for future reference (unless someone else is asking for this levle
of detail).

> 
> The four variants are not compatible with each other: AD4691/AD4692 have
> 16 analog input channels while AD4693/AD4694 have 8, and AD4691/AD4693
> top out at 500 kSPS while AD4692/AD4694 reach 1 MSPS. These differences
> in channel count and maximum sample rate require distinct compatible
> strings so the driver can select the correct channel configuration and
> rate limits.
This bit indeed belongs here.

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

