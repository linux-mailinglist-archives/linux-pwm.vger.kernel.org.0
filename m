Return-Path: <linux-pwm+bounces-9078-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAbANcc8EGrUVAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9078-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:23:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D268C5B2F30
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 412523004627
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420413D5C2C;
	Fri, 22 May 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsCm6unA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75F22A817;
	Fri, 22 May 2026 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448603; cv=none; b=dvU60WtyCzDo7k4us6NKE0uSLaGuodY6EADcRao4n5B9XWL/T9GpAckI/IPkhQIFCXRIlgvkwPlbzLz8AEq+J49KEL1JVLpCcGy7nXtiaoRawAWxXbXDV7nYB4B+tahW5K9P26rrYtFxreEuR4WIpJJ/C8W15xltRLHUFv/rTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448603; c=relaxed/simple;
	bh=8ugHOUHLYWtKGmqx00fCrK//fW1pyBRKxLrWD8CptRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg/xAaG8r2f54QS66dwpeayVWALgr3Cq/tCks98L+pB/JSYG8GDcUZI8aZWB13mHI1+7P8xI7M0BHq6KaNeXSNkt0fx9ywBWcALkuCMt1JQMu2tsO+cvCgLC4p7PbMKsSoLx50LCTAh1MOsQl+ex7TtF5k6cQbCtOM9mYKTjY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsCm6unA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A555E1F000E9;
	Fri, 22 May 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779448601;
	bh=swBaYf35HMFLknKWr9J+UQyWk9dTnABHEFKw/ip9L34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MsCm6unAsdZi2fZzylOwnppmL+Za3A7HHBA2z7XrREKg/jXD/frJDVEoUgYeMmlmw
	 V6Rd2liN/yFAQ7GkhWB4u2wAVh4VxALmywgRD6iwmfBQUSByf8rtuNkJFfItGkk6V+
	 fIu+Ys5krtIn/vQwfZOZ6ASzHdkO5eQOxhqaUy52GKTqURrdez5VLSabJylcVhXPUe
	 qXrMsLrn9Mxg44xqotteIV9e6agGXYUQVPCbwy0fe9Xn9Ayrm+cC2i6WxoHgU6cifH
	 gHOPtHy9wSKVmdjqacJUn4muxsU479OlPnzvTZ9u8BfhqeTflMgDXQbtOqW34v3RZu
	 LPcksILNTStYQ==
Date: Fri, 22 May 2026 12:16:28 +0100
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
Subject: Re: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260522121628.21bf03f9@jic23-huawei>
In-Reply-To: <LV9PR03MB8414CA3DB26235605C9323E5F70E2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-5-5b335162aa51@analog.com>
	<LV9PR03MB8414CA3DB26235605C9323E5F70E2@LV9PR03MB8414.namprd03.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9078-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Queue-Id: D268C5B2F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 11:32:42 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > Sent: Tuesday, May 19, 2026 3:20 PM  
> 
> ...
> 
> > 
> > +	iio_for_each_active_channel(indio_dev, bit) {
> > +		ret = regmap_write(st->regmap,
> > AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);  
> 
> Unfortunately enough, I think a v13 will come, too...
> 
> Had a look again on what Sashiko had to say, and seeing the sampling frequency
> shared_by_all comment again made me have a deeper look see how the code could
> be commented so he wouldn't complain about this anymore, and...
> 
> Perhaps he is a bit right after all. I found a section stating that in standard
> sequencer mode (which the driver uses right now), all the channels actually use
> the ACC_DEPTH_IN0 for osr, and so changing ACC_DEPTH_INn for other channels
> doesn't really do much. And so I tested this selecting both voltage0 and voltage1
> for sampling with osr4 for voltage0 and osr1 for voltage1 and with a 100kHz osc freq
> indeed DR fell after approximately 80us which points out both channels were actually
> using OSR of 4. Perhaps the OSR should be shared by all and therefore the
> sampling frequency would also be shared by all, right?

I kind of lost track on the modes. What are the chances we later move to or add
support for a mode where the different OSRs do matter?  If that's a possibility
we should avoid ABI change by allowing for it from the start.

Then if we are in this mode, they'll have separate controls but change any, changes
them all, if we are in a different mode that connection breaks.
If that's the case, just throw in a comment saying something to the effect this
may change.

It's not wrong ABI to do this, it's just less intuitive for users which is why
we prefer the shared_by stuff where there isn't a disadvantage.  That is at most
a hint to what actually happens.   A simple example is where different
channels have one OSR field but they aren't the same - i.e. channel 1 is twice
the OSR of channel 2.  Hence we can't share the attribute but any change effects
both.

Jonathan

> 
> The usage of internal_osc_freq and pre-computed freq values depending on osr would
> stay the same since those are still correct anyway.
> 
> What's your opinion on this?
> Radu
> 


