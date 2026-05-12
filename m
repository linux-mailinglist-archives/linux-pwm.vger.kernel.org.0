Return-Path: <linux-pwm+bounces-8872-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B0BDfpNA2pq3AEAu9opvQ
	(envelope-from <linux-pwm+bounces-8872-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 17:57:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0035524339
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BA4930D199C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B53BED43;
	Tue, 12 May 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqe+MtoJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A735F5E0;
	Tue, 12 May 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600996; cv=none; b=oEjaQMW6RolA6k2WiqYAz5tHUtt6hbzsKdDehkO9AAOMNhAEbv3GcUNPpnrYmRbsd1SbbBHQsbHCsoQirovf8kahnqYgjt0zgwYcAqwovj+qNyqHU7KRIrodV+6mJ1764HStP1o8fLZPqsuUi+LsG/2hn69UmY+a+fEmBMNKEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600996; c=relaxed/simple;
	bh=xT04KsS3vdFr5U9rnS1OIQVoQ8mPOcKNw2Vjgn0vL8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0EBCjkHGW2H9mE8pG8HhiOkXoCtONKtvmKWrcnfJC2CP7a5Z2g11pdKhUDuAIAHluP7CEEMEhpLIx7qAFd+AzcuhQvdGy1BWWGuF0CqPMf6ASPN9KiCABfKQvRgsZtLwPB3YSMFNXOpzmoDUfomq/FmZStyyTdISXGcFOUel30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqe+MtoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D79C2BCB0;
	Tue, 12 May 2026 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600996;
	bh=xT04KsS3vdFr5U9rnS1OIQVoQ8mPOcKNw2Vjgn0vL8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqe+MtoJUKckxiSp8SbZEmLkoM0jygdg7+XXnLKdgCwg1KIV1Nj/wxMBj5dqlHWsX
	 Bldeh+G56RqSmhFyUa9n/T1inPZLhq5zSpFCCB91toQamYQm3p1RF+lO43zAmEe+4L
	 R6VLmWQiq76CQAKXvKAPKEiIEToLW04NIEdjqD6DCoszNgKWrU+91AJfmIgnO49Xoo
	 4cy4mvnNPM3SjoiZdvDjbMPnpzfV06cvdahdkeSqyOwfa9N5n52q+/qiED3AHeOqFU
	 Eer19JGdk+JVGp/rsFfyV3Btesq2riF7mMaJ15mdymmKL4/ACEVDBMNOPQvp2iPlFS
	 Z6ArnMfFy13Tw==
Date: Tue, 12 May 2026 16:49:42 +0100
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
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260512164942.6ef07ee9@jic23-huawei>
In-Reply-To: <20260511-ad4692-multichannel-sar-adc-driver-v10-4-e1fbb1744e38@analog.com>
References: <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
	<20260511-ad4692-multichannel-sar-adc-driver-v10-4-e1fbb1744e38@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E0035524339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8872-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Mon, 11 May 2026 14:54:16 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add SPI offload support to enable DMA-based, CPU-independent data
> acquisition using the SPI Engine offload framework.
> 
> When an SPI offload is available (devm_spi_offload_get() succeeds),
> the driver registers a DMA engine IIO buffer and uses dedicated buffer
> setup operations. If no offload is available the existing software
> triggered buffer path is used unchanged.
> 
> Both CNV Burst Mode and Manual Mode support offload, but use different
> trigger mechanisms:
> 
> CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
> signal on the GP pin specified by the trigger-source consumer reference
> in the device tree (one cell = GP pin number 0-3). For this mode the
> driver acts as both an SPI offload consumer (DMA RX stream, message
> optimization) and a trigger source provider: it registers the
> GP/DATA_READY output via devm_spi_offload_trigger_register() so the
> offload framework can match the '#trigger-source-cells' phandle and
> automatically fire the SPI Engine DMA transfer at end-of-conversion.
> 
> Manual Mode: the SPI Engine is triggered by a periodic trigger at
> the configured sampling frequency. The pre-built SPI message uses
> the pipelined CNV-on-CS protocol: N+1 16-bit transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 16-bit frames (bits_per_word=16, len=2).
> The channel scan_type (storagebits=16, shift=0) is shared between the
> software triggered-buffer and offload paths; no separate scan_type or
> channel array is needed for the offload case at this stage. Oversampling
> support and mode-specific channel array distinctions are introduced in
> the following commit.
> 
> IIO_BUFFER_DMAENGINE is selected because the offload path uses
> devm_iio_dmaengine_buffer_setup_with_handle() to allocate and
> attach the DMA RX buffer to the IIO device.

More stuff from sashiko - it also not noticed the BE marking is
in a later patch - but given you are doing 16bit words here likely
the chan spec needs to be different.

Hohum. It then seems to have timed out.  Maybe that should be a new
rule - if your patch set is too big for sashiko it's too big and
complex for reviewers too ;)

> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

I didn't really spot anything myself on this pass so just a question
of analysing the bot output and groaning at what I missed :(

Jonathan

