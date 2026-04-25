Return-Path: <linux-pwm+bounces-8693-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLF4GOsJ7WkEegAAu9opvQ
	(envelope-from <linux-pwm+bounces-8693-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:37:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F1467609
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A57E3069639
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D6372689;
	Sat, 25 Apr 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmpgNkeJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8F1A9F8C;
	Sat, 25 Apr 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141927; cv=none; b=rjbhcpQxtzLpOZjOuhlaGURETCfd1A1YUwpT3xEs2e4GyAhIGm2R69fhlsfUT2SgNc1A8gZivP1n+Wa0xNUvb48lj9VAhhJ2m7xyt2BhgMnJrw2k6e1OXEkl4ZwVLPq0rSODm+pR/mAEPDu8HmVZVCh9GJk5NnsUyqbz1hDWLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141927; c=relaxed/simple;
	bh=FLjGSUxfmVrj9s85Y91kN/Rh54l5tbngbBRVZAeMXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuKQVZ5URJgUbf1aafZ/mlqTxidw6Cvn+uOjHHUnCP5xwvJ9MTfrvq+VwV3QN9agU9jEMc2VnavzlxJ8/8uQAQVmOFGR8wiPnrCNX5K3BHaHKezAXE/isaAZL8H+3+TbsV1D4cZt4E+tcDja6cd7kF4W3wv+ShzAD4yU1CNz4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmpgNkeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC239C2BCB0;
	Sat, 25 Apr 2026 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141926;
	bh=FLjGSUxfmVrj9s85Y91kN/Rh54l5tbngbBRVZAeMXLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZmpgNkeJr2QlntRxed9Wzx9+sM6vLXZ1VOI4M15lJq7Wa+ueFM58tml3IcwNgY54A
	 j3rhEo3MPaqtBDPRkScLx13JGB2m3dNYRmOan3qXtd3FS/FGUuFYNYABp2EtP2INrZ
	 af0L5QMjyXsIZ28oiv/TqxFl+Ld4zc+NO9dCMVhJLhX1+9N5XUGXqwYgTvJoVpXMD2
	 YcvI9THChERbyois++w5mFDqLEALKDSAm/fJw21FW8Jt1XZCLtq+NxVGzX3N3YTJVz
	 kbSKhpyRP0VpPjZUchF/BS0FlFEtpp+nkhUOX/kG2aAkpAPU8thPaJ7wSmGtFjLtSC
	 2oGpqTDbCm4Rw==
Date: Sat, 25 Apr 2026 19:31:52 +0100
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
Subject: Re: [PATCH v8 0/6] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Message-ID: <20260425193152.38f80bf1@jic23-huawei>
In-Reply-To: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
References: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BA4F1467609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8693-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:url,analog.com:email]

On Thu, 16 Apr 2026 12:18:45 +0300
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
>                   the previous conversion result and starts the
>                   next (pipelined N+1 scheme)
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
drivers/iio/adc/ad4691.c: note: in included file:                          =
          =20
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsig=
ned long  =20
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsig=
ned long  =20
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsig=
ned long  =20
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsig=
ned long

=46rom sparse.  I think it's a false positive.
It's the bitmap_read() calls - probably the the nbits parameter.
Using bitmap_read() to copy the whole bitmap is unusual so maybe this is a =
corner
case that isn't handled.=20

Any ideas?  I'm going to assume it's a false positive due to the ACCESS_PRI=
VATE()
confusing sparse.

So with that in mind, series applied to the testing branch of iio.git.

thanks,

Jonathan

