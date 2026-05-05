Return-Path: <linux-pwm+bounces-8786-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOh1MjUB+ml1HAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8786-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:39:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5534CF968
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42163046FDE
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3DB3CE4BF;
	Tue,  5 May 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO+i3xKK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E93E92BD;
	Tue,  5 May 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991724; cv=none; b=YZ5z8kQHdpbOd4Vw+hSnb2oUKTF8k+32E0qm9FQtalfnE6slqzFO8V8A1BTLVnDujkeZT8jgtrxImFPQXIPNRnKgfwRZSbM62RkdD2vJ8QQXojO2ef65b7lVN2X6G01GuRX0KvTmFZU2H2cxBMk3mu6tdU3bwAifWX8UktATZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991724; c=relaxed/simple;
	bh=ii98T0ORWI4eOp0vAtOI8TmApKV+7CPQEZwItTTv1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txJgvuQcvP9AcVHU/i+WC/MDddLQBB5uncA0JBUWv6IJfM/EOWPjQovz1PmfKoZOieB9eWF9J0kTDsoqHK/vluVe5ruti37mlOXspaqYDHX8RiXEoS35z5RULUukZEkXT8+EzfwCNEbWu44pqXiqAuFYMliBAx4xHxHokYU/14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO+i3xKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB646C2BCF4;
	Tue,  5 May 2026 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991723;
	bh=ii98T0ORWI4eOp0vAtOI8TmApKV+7CPQEZwItTTv1Mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KO+i3xKK2+gAmUJCxlumoP2AJBoSkpkqEF1/4M6NHqFMahQs2+lQR/6+GQBqCB4e3
	 0yAeXS+fDmRUDlg3BQkaq6bNywz/lRD6V9nnLtXmbmZtdOPTr8qljP//lQY6zdtf7E
	 mvf96yOlxMF9JjwrQ3BRtxZ4UTj7gp318X5TF2RHNiDT7Ipx1AJy6mK0DQdFmNOhza
	 ev359JLwPcqckx9WfLrwraZVQQKTlaHx/o1djBLRLNq7QaZJq/D7FTpWj6icfjsNsT
	 hTjzspnweHODkSsUTD98gYBlC2AYo0MTv/obk2HI8IddFJyAACteHxpkJX0pfo631c
	 1zLnuFdJyGTfQ==
Date: Tue, 5 May 2026 15:35:10 +0100
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
Subject: Re: [PATCH v9 6/6] docs: iio: adc: ad4691: add driver documentation
Message-ID: <20260505153510.7feea4b0@jic23-huawei>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-6-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-6-33e439e4fb87@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6A5534CF968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8786-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:url,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 13:16:48 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add RST documentation for the AD4691 family ADC driver covering
> supported devices, IIO channels, operating modes, oversampling,
> reference voltage, LDO supply, reset, GP pins, SPI offload support,
> and buffer data format.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

> diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
> new file mode 100644
> index 000000000000..38e2ad28a713
> --- /dev/null
> +++ b/Documentation/iio/ad4691.rst


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24e4502b8292..819d8b6eb6bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1491,6 +1491,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
>  F:	drivers/iio/adc/ad4691.c
> +F:	drivers/iio/adc/ad4691.rst
Not there. (Sashiko got this one)

>  
>  ANALOG DEVICES INC AD4695 DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> 


