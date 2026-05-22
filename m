Return-Path: <linux-pwm+bounces-9083-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN/lE6xDEGrpVQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9083-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:53:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B463E5B346F
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 146923022543
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C73EFD24;
	Fri, 22 May 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPqhBdoc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C163EDE59;
	Fri, 22 May 2026 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450710; cv=none; b=qt8L1rfMgmFy+kthxP6u3XyoqpLi8cK1wnyliiMcp0Ih1RSr6DMqu1yaLbLCpHHwFmyahm5dxoUTN02CYmnjlRrxk7ut/V+p4kJR6TspeqeRskr8v+YD/6Lm7iFgr+NkkVi34uJHjYKcu7Gxk+5dN8tZ+reHWtPltYO1M9LNmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450710; c=relaxed/simple;
	bh=O3mqvPkhqd+GsS4Bpyt7Ogm0/URY4Hj/vfoA2RvW9Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7EPPSsqiYXLTMqmmVzsNz5cZGDRJvBRSzs9hzeDous4rkjdjsbCVwhFhiJCejxA/uD7NgPKM/o/q6p5ivJp2e4zMIf/JdWsOlk/U1IfkN09K1gUpVR63HqCWC8UsJLHMFPpNPXI1dy9cHMISI7mcaM6VZcxezk/KXdxbieYwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPqhBdoc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1F71F000E9;
	Fri, 22 May 2026 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450701;
	bh=wBqHjWiZ3zmMg1tF3GnJt73oO7+ylN0UOYGY3kvTrAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oPqhBdocL3nUrJBHhPMtQ1xcvcRiJ4LjiFEWZXS/7jJA2Oq+Gk0+/o6FUO73KicKB
	 NIlcyJ4SK2Z5WKdjzlkWgb3XuWDkWyIfsQ2UGh+m9kYamXGdM8el/EzRnpU2dJfYYw
	 53K7OfQCOEWvLyk8NNeIah+OUkd5e8llYJXBVs7IK/twofGT4I3Pmy7qy5ypTvyStq
	 5KzQxhxAfgu7E/4bQRe3PLeWAVMId7nBcYZDX87k9hFMp+avjXQHx/MQenZ64tOxQn
	 4Vx2EnhuTc4Y7WKgZsT0b+/xBd6OwGYD5ECcPnDIGWIa4lnffi5deRuD8YzktKlHQ3
	 whDj/IGJJ4aow==
Date: Fri, 22 May 2026 12:51:28 +0100
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
Subject: Re: [PATCH v12 0/6] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Message-ID: <20260522125128.46a9e621@jic23-huawei>
In-Reply-To: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9083-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B463E5B346F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 15:20:21 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series adds support for the Analog Devices AD4691 family of
> high-speed, low-power multichannel successive approximation register
> (SAR) ADCs with an SPI-compatible serial interface.
>=20
> The family includes:
>   - AD4691: 16-channel, 500 kSPS
>   - AD4692: 16-channel, 1 MSPS
>   - AD4693: 8-channel, 500 kSPS
>   - AD4694: 8-channel, 1 MSPS
>=20
> The devices support two operating modes, auto-detected from the device
> tree:
>   - CNV Burst Mode: external PWM drives CNV independently of SPI;
>                     DATA_READY on a GP pin signals end of conversion
>   - Manual Mode: CNV tied to SPI CS; each SPI transfer reads
>                  the previous conversion result and starts the
>                  next (pipelined N+1 scheme)
>=20
> A new driver is warranted rather than extending ad4695: the AD4691
> data path uses an accumulator-register model =E2=80=94 results are read f=
rom
> AVG_IN registers, with ACC_MASK, ADC_SETUP, DEVICE_SETUP, and
> GPIO_MODE registers controlling the sequencer =E2=80=94 none of which exi=
st
> in AD4695. CNV Burst Mode (PWM drives CNV independently of SPI) and
> Manual Mode (pipelined N+1 transfers) also have no equivalent in
> AD4695's command-embedded single-cycle protocol.
>=20
> The series is structured as follows:
>   1/6 - DT bindings (YAML schema) and MAINTAINERS entry
>   2/6 - Initial driver: register map via custom regmap callbacks,
>         IIO read_raw/write_raw, both operating modes, single-channel
>         reads via internal oscillator (Autonomous Mode)
>   3/6 - Triggered buffer support: IRQ-driven (DATA_READY on a GP pin
>         selected via interrupt-names) for CNV Burst Mode; external IIO
>         trigger for Manual Mode to handle the pipelined N+1 SPI protocol
>   4/6 - SPI Engine offload support: DMA-backed high-throughput
>         capture path using the SPI offload subsystem
>   5/6 - Per-channel oversampling ratio support for CNV Burst Mode
>   6/6 - Driver documentation (Documentation/iio/ad4691.rst)
>=20
> Datasheets:
>   https://www.analog.com/en/products/ad4691.html
>   https://www.analog.com/en/products/ad4692.html
>   https://www.analog.com/en/products/ad4693.html
>   https://www.analog.com/en/products/ad4694.html
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

I only plan to check the bit you've called out for v13. Series looks very
nice to me.  Hopefully I'll remember that and not reread the whole thing
again!  FWIW I'll be offline from end of today until Tuesday so it won't
get queued up until then at the earliest.

Jonathan

