Return-Path: <linux-pwm+bounces-9185-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBMrKoo3F2os9gcAu9opvQ
	(envelope-from <linux-pwm+bounces-9185-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 20:27:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA6F5E8FD3
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 20:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15E5430B5330
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C40477E32;
	Wed, 27 May 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JovogSyJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FE4779B9;
	Wed, 27 May 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905828; cv=none; b=UpsAFQ1AYvwRhsxidUm8lpBrMbgwDDSlLZiYLZ79cKeg49E0Nlg4Ol3QuJmcqzwKe1fRWuSkL3xcUdKtaqzi7Kwo9LHBATT1FgvWwSl+TLMwE2vmk9hEQUrZMZh4t0lc6/sUq8OZoPUF4lUZdBhZyzxirVGuyounaW434lYTjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905828; c=relaxed/simple;
	bh=Nsk+GVLQ3mIBG4ZEiIFRLZZ3GB9aWQKBr/9/euxOoow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cweaISweUPPXDLiYCTXXclAkLpGuD899RABEz6yIO+2U1WU/kNnUbW1u/rvop+PGVE+sQtBPXWnALTfflCX7GyCiZVFbxFUA95ZWmbUPf7lX67xwZD3AY4H03OUh7eslNG1k4vFW+QyLtKuaxIUKK7JOvpBwJCw9x1grZ4jli/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JovogSyJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B981F000E9;
	Wed, 27 May 2026 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905826;
	bh=CjilvsEVVaEMT/HbkP0oG5Yhwf69K/WazrffahsS7BE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JovogSyJMi3D37m9DdgkgJ8rKdkQNYDj9Jbh4B/JIb6vLvbrdoYuTEmdYQB4C5bCj
	 JQxBklvTeAZTFeLUbDvDvTHx2MXO4xBiCtCtt8LeoZ1smfdCZGJYsS1tBAxfhttGl4
	 xkYGHyrMvEMUCPIkSlRPDZYt1QGzYqQPy1x3hvAqqSQFT9Vycp58rLE7r6xp4+l8GD
	 kYuruqSezkS+X5E10na5EBup9ZL/3T2VgJaOfZ7LNfrMZVlfeuV1DDQW76lp2H888U
	 FCL/VDRySZniT/LnunznTRV/d3zkBcTwvCH3kCcWJaO3uYfMfSlM3FZXj/stKsBOhH
	 /SUWIEX+Ggt+A==
Date: Wed, 27 May 2026 19:16:52 +0100
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
Subject: Re: [PATCH v13 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260527191652.33041b88@jic23-huawei>
In-Reply-To: <20260525-ad4692-multichannel-sar-adc-driver-v13-5-1b7626d3b35c@analog.com>
References: <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
	<20260525-ad4692-multichannel-sar-adc-driver-v13-5-1b7626d3b35c@analog.com>
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
	TAGGED_FROM(0.00)[bounces-9185-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BA6F5E8FD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 13:10:14 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> selected OSR at buffer enable time and before each single-shot read.
> 
> Supported OSR values: 1, 2, 4, 8, 16, 32.
> 
> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
> not expose the oversampling_ratio attribute since OSR is not applicable
> in that mode. A separate manual_channels array is added to
> struct ad4691_channel_info and selected at probe time.
> 
> in_voltageN_sampling_frequency represents the effective output rate for
> channel N, defined as osc_freq / osr[N]. The chip has one internal
> oscillator shared by all channels; each channel independently
> accumulates osr[N] oscillator cycles before producing a result.

Sashiko notes this probably needs updating for moving to single osr.

> 
> Writing sampling_frequency computes needed_osc = freq * osr[N] and
> snaps down to the largest oscillator table entry that satisfies both
> osc <= needed_osc and osc % osr[N] == 0, guaranteeing an exact integer
> read-back. The result is stored in target_osc_freq_Hz and written to
> OSC_FREQ_REG at buffer enable and single-shot time, so sampling_frequency
> and oversampling_ratio can be set in any order.
> 
> in_voltageN_sampling_frequency_available is precomputed at probe for
> each OSR value, listing only oscillator table entries that divide
> evenly by that OSR, expressed as effective rates (osc_freq / osr[N]).
> The list becomes sparser as OSR increases, capping at max_rate / osr[N].
> read_avail picks the precomputed list for the channel's current OSR,
> making the returned pointer stable and race-free.
> 
> Writing oversampling_ratio stores the new OSR for that channel and snaps
> target_osc_freq_Hz to the largest oscillator table entry that is both
> <= old_effective_rate * new_osr and evenly divisible by new_osr. This
> preserves an integer read-back of in_voltageN_sampling_frequency after
> the OSR change while keeping the oscillator as close as possible to the
> previous effective rate.
> 
> OSR defaults to 1 (no accumulation) for all channels.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
I didn't find anything else to comment on. LGTM

Thanks,

Jonathan

