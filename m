Return-Path: <linux-pwm+bounces-9216-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OwhNlUKHGr4IwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9216-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 12:15:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C105615885
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27CA301CF95
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9702C08DC;
	Sun, 31 May 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQPKatSj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5B367B68;
	Sun, 31 May 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222543; cv=none; b=iufVWmamp6oxh6JTJu7+DtvgBfUDWFyls0VYLPmz29rUOVRvI81L2aaBPJ1reRzuItmQ4YPXv47gD7KHHBB/XO+zdr2YthR68rMDRr7da3N3L7cJgs100HjA1yhEIw29Z+AfNB5CzobP6V3tvGa8Ugd9ofEd08uf7R9q/4JalHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222543; c=relaxed/simple;
	bh=fFfEnenGpqiMy8RY+LmtZSJSbyW0b9y6Cx19k5YA61E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZXlY1c3a2lIR/Ut4ZUicBeNo2rxzWvFw4g7RnG8k6t9CAc+3NVFKY/FJOjES+iVa8RYN8L96P/64COs3LGCdOxa4h8pbs0PRUdnYA2ubVytiDS8YBaal1NZ1iaNd+gPVmfoXDc18us1Qgb1epVb5I+GWPFIAhpO2OV4BT0NZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQPKatSj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2171F00893;
	Sun, 31 May 2026 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222541;
	bh=nZDppJ+4L0BDYGs3LsrW8E/P6Se2lkRuz5HgqiQzPS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OQPKatSjoAOJzIzh3MWkDrzAFv+TPRxCcQq9BVsxlLqgoxiDJxuKA7RSL8qmsyQRd
	 o4thwBMn37smPt2kS2jBUXP3ddTPpEtl0ngyFh5ewXfUBtP7smv8kQiqeSnjwQ2WvT
	 4Almt11Y7It7RTDXyR2pVOoWqfU/H+g9l2wBi9cw0KRj4ngJmqwBSiiwpJ1UHEWJVc
	 zu6La/XgYkCg/ZXqqTeJleo6+Bo8NBzDz2z5FPF5t3khIssFIHHxJlkcxjdMKmYQsy
	 /B2Mfw4YSX0wQ+z9kpKzOPbq8UTpQ47sNQSb7NA+vnR8MOSaRaWCx6QsJkGb3ZCcVm
	 2Wcy2znjCmD2Q==
Date: Sun, 31 May 2026 11:15:28 +0100
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
Subject: Re: [PATCH v14 0/6] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Message-ID: <20260531111528.32697d1f@jic23-huawei>
In-Reply-To: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
References: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9216-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C105615885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:14:59 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series adds support for the Analog Devices AD4691 family of
> high-speed, low-power multichannel successive approximation register
> (SAR) ADCs with an SPI-compatible serial interface.
> 
Unfortunately I failed to notice I'd actually picked up a version
of this about a month ago, but more issues came out after that.

Whilst I don't like doing this, to avoid a messy history I've rebased
the main iio tree to drop that earlier version.  Hopefully not too many
people base their work on the togreg branch of iio.git!

Sparse is giving the same warnings I pointed out on v8, but I still
believe they are false positives. 

drivers/iio/adc/ad4691.c: note: in included file:
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsigned long
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsigned long


Applied with that tweak called out in the earlier patch to the testing
branch of iio.git

Thanks, 
Jonathan

