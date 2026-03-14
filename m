Return-Path: <linux-pwm+bounces-8258-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O6tOGUttWkXxQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8258-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 10:41:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 979DF28C707
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AF473011CB7
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Mar 2026 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7F33BBBD;
	Sat, 14 Mar 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXSYI/mQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395048003D;
	Sat, 14 Mar 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481315; cv=none; b=iC1cORSpU6FLHv9ETkmVBoo8kxo4XlZXFse+r2ZHRBD4W528niTAZSS4Txcai+j6Ax7F2/wN8cJ4NxR/Op0cUmDFodEQW5F3fFTsrJSeWtBC+34T/XHNuwPQZfgrYgJalrT78qwtRGzPpQ7t4febxKQ3MvoniOsYdQztUu9nzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481315; c=relaxed/simple;
	bh=kqXr9BArz3PvS0L2GA1uoT9JRBle5Jc4GIpeDAoGZ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQlgoLuQyVCTLPmn1/OPrHZ11d4Dx3d0mw6pfOGqMsSBCS1Gshjsl0d/ZjhIQzM07HqpJT5qfh1l5tzRAigwtIBZr8ImgeHbQddZggKf6gpMH71IOr9y7YxT8R0wW2DcOPFUFQ7eycImOHTqnLm2YgZO0fDZn8MRSYw4rp7/9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXSYI/mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D111C116C6;
	Sat, 14 Mar 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773481314;
	bh=kqXr9BArz3PvS0L2GA1uoT9JRBle5Jc4GIpeDAoGZ7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXSYI/mQErB5npG1bowsFMzGLlblK7qjG69GDv14mjqI2OaMzzsvgpoKRSEVjviYb
	 lZQEvNkdCzV0z8QsUr65WaPkZZRr1JrMoP8hhbGQ3qfbipDP+UoDXRcKTkr8+MQFL3
	 +J/mHwinur5B9kINeaUG+qWuVAf1R/Dv+RjyZhoEseE4zBiwqVRhhMddP2VNwdQkyT
	 f1nRljvlWujAcmw4GFYgQYZbET44FLw9g1EegLo29FUg05JXdclsUalkbiminNadoE
	 F26NiAcJwJEbBOZUAypwBNFjMT5Xnbb9MVrJgG3YHQZS2kFBonNHMj+uzy2anDeQYv
	 7bpsGPn+BnUdg==
Date: Sat, 14 Mar 2026 10:41:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Message-ID: <20260314-resilient-colorful-myna-ecaeda@quoll>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8258-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 979DF28C707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:07:25PM +0200, Radu Sabau wrote:
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).

subject, you did not implement entire feedback. Respond to all the
comments and implement them.

I finish the review here.

Best regards,
Krzysztof


