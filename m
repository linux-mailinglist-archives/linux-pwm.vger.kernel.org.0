Return-Path: <linux-pwm+bounces-8839-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKeBBTeh/Gn2SAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8839-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 16:27:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E04EA237
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB343011C69
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791C401A17;
	Thu,  7 May 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqvm6WrF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A831714A;
	Thu,  7 May 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163946; cv=none; b=cX0gcNLNH/5IrPauV3YRNpkIC4Cj7SuuoIPf73aq4kJjQTwDyQu+aY5EhfQnlNBxIeaGXIyOBwFH+G8uDMONl6X+pRBBJHX6heCpCqP+z0VsySqMGxbfCnyLQ5lGPGdh3/sgN2TwViwFOyMmjZmRW19aTTZqo6R3fIfliF0Kguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163946; c=relaxed/simple;
	bh=vlPB5SDuOt75n5oB0tM9u/D39/Xgib3IJQ8fXj5/sdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tw6nBNgaV1aru/0uy/aPTnzOEdGmkWVxm4+LWrpbS5wiuLr0G+2L4SsMtgDaj0m9fhxgHlmODm/7c/otl/t0xd949PvXyzE1fz7hHGLXlA9Y23/WHyOhdzO9a+IKZPvjXN2M4vxJYk3+IgZw+CKkKLWB2OfjSZv5eLt8m4JGEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqvm6WrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92FC2BCC9;
	Thu,  7 May 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778163946;
	bh=vlPB5SDuOt75n5oB0tM9u/D39/Xgib3IJQ8fXj5/sdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kqvm6WrFdsSdlOu0qxKmLBuGM3nxTavGCrP+bpd9SNsH/MKkT+TZHdBUPnl2kAqkF
	 v51j7R3UFIHs+c3I+sXkYCJCY1FldZquy4PhrOiqXsg2ce81bbG9HtXAYTi8MThkSF
	 wqXHOkRa1SbnPp+Mz8ZFNmJfqeA0UGopZMnqSMOx8WVsX5le0XF1K6+FytOc1jzlnp
	 7tZmPKxePPzKCKtKXWfGtGpERz76+TJazibrUPLLnQ/PKvCG2GdO9t6nHyiLlYx2dp
	 VMzkKhZOXH2DHQ6B807kULwijk+ROT2WQCmx8BCuBO5f5Cuu3uPOZpijH9ZKlOYkZ4
	 dyl+aDOe2wM0w==
Date: Thu, 7 May 2026 15:25:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260507152532.09b385eb@jic23-huawei>
In-Reply-To: <LV9PR03MB8414E0FFAD9C9423189117B2F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
	<LV9PR03MB8414E0FFAD9C9423189117B2F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 815E04EA237
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8839-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Thu, 7 May 2026 11:37:25 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> Addressing Sashiko's review for triggered buffer patch.
> 
> > -----Original Message-----
> > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > Sent: Thursday, April 30, 2026 1:17 PM  
> 
> ...
> 
> > +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4691_state *st = iio_priv(indio_dev);
> > +	unsigned int prev_i, k, i;
> > +	bool first;
> > +	int ret;
> > +
> > +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
> > +	memset(st->scan_tx, 0, sizeof(st->scan_tx));
> > +
> > +	spi_message_init(&st->scan_msg);
> > +
> > +	first = true;
> > +	prev_i = 0;
> > +	k = 0;
> > +	iio_for_each_active_channel(indio_dev, i) {
> > +		st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
> > +		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
> > +		/*
> > +		 * The pipeline means xfer[0] receives the residual from the
> > +		 * previous sequence, not a valid sample for channel i. Point
> > +		 * it at vals[i] anyway; xfer[1] (or the NOOP when only one
> > +		 * channel is active) will overwrite that slot with the real
> > +		 * result, so no separate dummy buffer is needed.
> > +		 */
> > +		if (first) {
> > +			st->scan_xfers[k].rx_buf = &st->vals[i];
> > +			first = false;
> > +		} else {
> > +			st->scan_xfers[k].rx_buf = &st->vals[prev_i];
> > +		}  
> 
> 
> "The IIO subsystem expects data pushed to the buffer to be densely packed
> according to the active channels in the scan mask.
> If only a subset of channels are enabled, does assigning the rx_buf pointer
> directly to absolute array indices at &st->vals[i] leave holes in the buffer?
> When iio_push_to_buffers_with_ts() is called, this might cause it to read
> uninitialized memory instead of the expected samples."
> 
> I would say there is no change needed. Writing to &st->vals[scan_index] and
> passing the full array to iio_push_to_buffers_with_ts() is the standard IIO kfifo
> pattern: the core demultiplexes by reading data[scan_index * storagebits/8]
> for each active channel; holes at inactive indices are silently ignored.
> The same pattern is used in ad4695, ad_sigma_delta, and others. The
> pipeline residual in the first manual-mode transfer is overwritten by the
> subsequent transfer before the scan is pushed, as the comment explains.

This looks wrong to me.

What holes?  If available_scan_masks is set we will do a bunch of
demux work - but then this code would see the mask picked from that
list. If it's not then typically we won't (subject to multiple consumers
forcing it - but that still won't close up holes here).

If the active_scan_mask == the one requested, there is no demux at all
and I think that's the case here - the code pushes the data passed in
directly to the kfifo.

Perhaps given an illustration of what the layout of resulting data
is if only even numbered channels are enabled.



> 
> > +		st->scan_xfers[k].len = sizeof(__be16);
> > +		st->scan_xfers[k].cs_change = 1;
> > +		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> > +		prev_i = i;
> > +		k++;
> > +	}
> > +  
> 
>
> > +	st->scan_xfers[2 * k + 1].len = sizeof(__be16);
> > +	st->scan_xfers[2 * k + 1].cs_change = 1;
> > +	spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> > +
> > +	ret = spi_optimize_message(st->spi, &st->scan_msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> > +			   bitmap_read(indio_dev->active_scan_mask, 0,
> > +				       iio_get_masklength(indio_dev)));
> > +	if (ret)
> > +		goto err_unoptimize;
> > +
> > +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> > +			   ~bitmap_read(indio_dev->active_scan_mask, 0,
> > +				iio_get_masklength(indio_dev)) &
> > GENMASK(15, 0));
> > +	if (ret)
> > +		goto err_unoptimize;
> > +
> > +	ret = ad4691_enter_conversion_mode(st);
> > +	if (ret)
> > +		goto err_unoptimize;
> > +
> > +	ret = ad4691_sampling_enable(st, true);
> > +	if (ret)
> > +		goto err_exit_conv;
> > +
> > +	enable_irq(st->irq);
> > +	return 0;  
> 
> "Is there a race condition introduced by enabling the PWM and unmasking the
> IRQ here?
> If a hardware interrupt fires before the IIO core attaches the trigger's poll
> function, iio_trigger_poll() drops the event. Will the IRQ handler then call
> disable_irq_nosync() without ever running the consumer thread to re-enable it?"
> 
> Valid. preenable is called before the IIO core attaches the trigger
> poll function; if a DATA_READY IRQ fires in that window, iio_trigger_poll()
> is dropped, disable_irq_nosync() disables the IRQ, and enable_irq() is
> never called, leaving the IRQ stuck. Although the delay would need to be 
> very great for this to happen, I moved sampling_enable(true) and
> enable_irq() to a new postenable callback which the IIO core calls only
> after the trigger poll function is attached.

Make sure to add a comment on why that is there.
Otherwise makes sense.

> 

Rest look fine to me.


