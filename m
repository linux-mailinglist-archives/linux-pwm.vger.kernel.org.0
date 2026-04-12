Return-Path: <linux-pwm+bounces-8561-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIrpMU/d22lMHgkAu9opvQ
	(envelope-from <linux-pwm+bounces-8561-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:58:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE53E5486
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADB133001393
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FA363083;
	Sun, 12 Apr 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL3SZqTm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE632D1931;
	Sun, 12 Apr 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016714; cv=none; b=F4vZYqTiO87+tzPBC6QS47x1+G7sJlz8cEkua7HX1a3QTNjX+TNoI/lbq6eEi5wqZ9pf8hDia5pjNxSLx99VB+1KDaMIKX97w1I33tCekaSy9Ze+Jh9m410P5ipMSEKzbH99+E4h7j/EDtGhfhMe20woZhL6u++MQYljqbko/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016714; c=relaxed/simple;
	bh=4X/ds1i4LVhfsuIlv7LHfB70clIx86rcZI0v0PSPtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWI9ib7sLG42me0ZVmjrCWVjxizfHltBDH8giMyy+KvddQqjZvOcBztc+ZPy0nzGE/sT5tN749Xlx/OwfioE0EHAtdXFKzmNGQwqTgkM/9Frwk/tXPz55tOvIyFvoozLRMsGuJQjeNn6GmEFL3xCfuA0pWgsD+WMeeioTQOwm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL3SZqTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17C8C19424;
	Sun, 12 Apr 2026 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016714;
	bh=4X/ds1i4LVhfsuIlv7LHfB70clIx86rcZI0v0PSPtnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JL3SZqTm1F5W3YkQI0/srNCI4Z90qZG2sJQpH7FJPHtRiDRDayy5peeH1mzGsVIfl
	 2iz0AW5x5OXOQlzfxh33xDhjatUYxWh/+guNNKIn2ipyVXNf0sIAV8F44ETfB/lcEU
	 sCeJLA1LYZI3N+02TPB9nxyy0bPAKYp0Fb5GRfbRNfcl6A2LMLaN+rjWhGZhrIR4ud
	 kN+cziHuHQ9sBQuIa7Z8nrVc2ERyeosOm2O7Gcyjrcbk65gETxw7DspsYv+XALoJmA
	 w2YmIm5Y7Wsru9LUuQ5xTlJCRUhptAwgft6gLTWd1ejKFdrMCynf+CT8WfAwraJOHN
	 gX53kabhDgIcA==
Date: Sun, 12 Apr 2026 18:58:21 +0100
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
Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260412185821.739e477f@jic23-huawei>
In-Reply-To: <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
	<742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8561-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CCEE53E5486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 16:15:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> > 
> > Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> > The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> > selected OSR at buffer enable time and before each single-shot read.
> > 
> > Supported OSR values: 1, 2, 4, 8, 16, 32.
> > 
> > Introduce AD4691_MANUAL_CHANNEL() for manual mode channels, which do
> > not expose the oversampling ratio attribute since OSR is not applicable
> > in that mode. A separate manual_channels array is added to
> > struct ad4691_channel_info and selected at probe time; offload paths
> > reuse the same arrays with num_channels capping access before the soft
> > timestamp entry.
> > 
> > The reported sampling frequency accounts for the active OSR:
> > effective_freq = oscillator_freq / osr  
> 
> Technically, the way this is implemented is fine according to IIO ABI
> rules. Writing any attribute can cause others to change. It does
> introduce a potential pitfall though. Currently, changing the OSR will
> change the sampling frequency, so you have to always write oversampling_ratio
> first, then write sampling_frequency to get what you asked for. If you want
> to change the OSR and keep the same sample rate, you still have to write both
> attributes again.
> 
> In other drivers, I've implemented it so that the requested sampling frequency
> is stored any you always get the closest sampling frequency available based on
> the oversampling ratio. This way, it doesn't matter which order you write
> the attributes. In that case, the actual periodic trigger source isn't set up
> until we actually start sampling.
> 
Agreed. This is more intuitive. Now generally the userspace should
be sanity checking the value anyway as limitations may mean the new
sampling frequency is not particularly close to the original one but
at least it increases the chances of getting the expected value somewhat!

So to me this is a nice useability improvement given the code to implement
it tends not to be too complex.

Thanks,

J


