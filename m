Return-Path: <linux-pwm+bounces-8557-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FVJEs/Z22lMHgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8557-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:43:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 324453E5246
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC14830058DB
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD43630BF;
	Sun, 12 Apr 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM7PHEJO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F33630A9;
	Sun, 12 Apr 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015794; cv=none; b=HGsRiFokFYoKrRHdl/RfRJXq5kPZA6vMdmAcwqhJwh8UhjO0bBEz0xjGfCSAu6ok0BMS81DeeSmlUR05Y7KpNvFwkK1xFD30fnvY+U7qUU0j5qDqjIRQmUx3HE/zMm8yR0rG0FcB58sISNB6c1DKTu/FZBdQ9hu201Z6yGcbSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015794; c=relaxed/simple;
	bh=oICM/2L/XIa2dpeo8QIMB1FYt+w74TRv/ukrIkGGiLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5VD5/I7ZGP9ONHRp6+o0cXGYET4s5pNcxLbH2V4tD/nXH6F25ywmZ5vfdb5SlKm4015ppg2Xn59FLCEik58bcZMcoGiRYraknU8T+tKE70dJFICCntjC9ZXGcT7Shlkk7cYDUx2Iudoy6ZAomrIFmmwNkcCGxvaSVp4sScnOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM7PHEJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E2C2BCB7;
	Sun, 12 Apr 2026 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776015794;
	bh=oICM/2L/XIa2dpeo8QIMB1FYt+w74TRv/ukrIkGGiLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WM7PHEJOPCQyiMggVds1ZZI5y/1t1jTxW/uUL8k1rPKDzntTEN8nY1f7eCgK/fRzx
	 0ns+0DIHdIK4w+p3gWJEuGd13Y57f0nKA2R200ZySeuyE5RoqAuPOCyB8wo3l8J3Te
	 Eg3xx9jpsHcNT+40MVcCV8pZJAw7mbCsOjuXj3hFNvc0TtB8dgiWykDHm2IvDtTtbx
	 guss+fSuw9QuDQ0tPG+vta6p50rTukP7FkqkPM00gZXyfBwJymYZbaP7YQ2vu1AqeN
	 vdN38bGEC77ZfQJCgRScBn9csrQIT4GIbzn7qc5vnFv+Pd+EWPnEsnj4P4r9U+VYjJ
	 PknZRyCZ431Cw==
Date: Sun, 12 Apr 2026 18:43:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260412184301.05544396@jic23-huawei>
In-Reply-To: <0f05add7-96c0-4eee-b396-d6e1be904c09@baylibre.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
	<0f05add7-96c0-4eee-b396-d6e1be904c09@baylibre.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8557-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 324453E5246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 15:46:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> > 
> > Add buffered capture support using the IIO triggered buffer framework.
> >   
> 
> ...
> 
> > @@ -201,8 +245,45 @@ struct ad4691_state {
> >  	 * atomicity of consecutive SPI operations.
> >  	 */
> >  	struct mutex lock;
> > +	/*
> > +	 * Per-buffer-enable lifetime resources:
> > +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> > +	 *		 transfers in one go.
> > +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> > +	 *		    transfers in one go.
> > +	 */
> > +	struct spi_message scan_msg;
> > +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> > +	struct spi_transfer scan_xfers[34];
> > +	/*
> > +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> > +	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
> > +	 */
> > +	__be16 scan_tx[18];  
> 
> Needs __aligned(IIO_DMA_MINALIGN) since it is used with SPI.
As below.
> 
> > +	/* Scan buffer: one BE16 slot per channel (rx'd directly), plus timestamp */
> > +	struct {
> > +		__be16 vals[16];
> > +		aligned_s64 ts;
> > +	} scan;  
> 
> Unless it is required that all channels are always enabled:
> 
> 	IIO_DECLARE_BUFFER_WITH_TS(__be16, scan_rx, 16);
> 
> In any case, needs to be DMA-safe for SPI.
Custom regmap that uses spi_write_then_read() for all cases so it
should be bounced anyway.

Perhaps a comment to that affect would be useful.

J


