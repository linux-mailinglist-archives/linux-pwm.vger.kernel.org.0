Return-Path: <linux-pwm+bounces-8551-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJU+Oudh2WnhpAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8551-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 22:47:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE93DC8B7
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 22:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007FE30210EF
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6313A640F;
	Fri, 10 Apr 2026 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SSXXPTeU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857693A6410
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854004; cv=none; b=kLP92+AljTbwLRvg2uflDeoKPskJnQWsgodY1JzIh6bbbRXTshYNOcFIrbJ5RdY9m48gO8keesylZIOIoseZVMffd+dEWNdTatcYvJpS713F579VElqAPXxeVDIjkOAZl354j3cyV+3d9Km1eI6Lju6Ymx+/hDeYQmyH9A2jWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854004; c=relaxed/simple;
	bh=HgJlDciSQOJkjPYMFiEeV5PqKaSjuxwAnLaENFbkQ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQsy6MjiFdIbboQbe5l72LviKI3VzHv0PyX1CGktEnJGRxG/FPBDKAQfDZA+aaj69cZPPkdsIQdNIaWiMTEjtWslgqq0r00qlcPyoZBL+Rq7e7OUZqtS+Oa9ReLa0GqeRuC9PGsEWEtxh9wArY5fsTVdH9+FW4ST2R++HsLB/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SSXXPTeU; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d55b97f358so1537803a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775854000; x=1776458800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBpd+T8YvVMEln4nst2HllR/pz5g067Ap3lkXU/baHU=;
        b=SSXXPTeUQiGcPrLOlslscjIjBqIb/CoeAjzlc8XFGUpaWLHeXIAqj7EjK0KzK+04eh
         NRF9vZxeO79fiozCFkpmFQ+dmv+EQimJ+YWUoHnCiHHhYKssCUFdLccV0F1wCbeWPqdr
         B0+/oYek4duFyafbrOY7PyJocwpKCr2nHXtntjZhoFYH61fhQnAp6RMfPUaL+dMYMwxu
         sDO+hYxUINlRDbGmovVFcKtLPzydclkrIAhw9hZWieKnkzy+fVbO+OsfM+RMVwQS4izp
         tWdITiArNxuW9QChVdfkLpVHiIPAv8InLrhyDYCijkcNf1+Bmkf1nEFl5BUqfYOaG8WU
         HcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854000; x=1776458800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBpd+T8YvVMEln4nst2HllR/pz5g067Ap3lkXU/baHU=;
        b=BJZm1HcVHd7gv7Ena0C5U77VvZx+cUggZKEqZlBBVhCkUs4PpYaQyIqKwBixXXeh14
         37vuL/FRwHML9DuXbsxEPwNaUH+n36TaFq+d77EU9efGGHWrdf/4DxUChVhRtTD0Cu7Y
         Ogca57Bz0uU6FyGIEGjFrCQ/tS2frffem+CF45ccP7NgVq1g+1Yi8A1JxoAhfgJ4RPrY
         4AGlU6gMNP+EqmmoDv3RNyRij25+1xt+Xaa8Whp/DwCyMas23IpA2BQk4TZk9jiwKeIT
         iJMPInVe44ENhp6asKTfH/zr79Eq1fGrkk0OCEJ+CSUFYdg3Rs2bSVBya7QJDszyBHox
         yRog==
X-Forwarded-Encrypted: i=1; AJvYcCXvryxx6LoIuSeeSWBBG+j1HZx9K8gbxsEWrCO6S6rvy6MoAn1Vx2EgXpDHgiC+2BuHYRBKWg0jA9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSzsEmHOKzP7jvYk+sS4I+PxOA49eWoL27u6hQ7K5dtsPmoN7
	GHSaHEQKTATGBhK4m/VNBN6I0RhUI62mINE0nDQI5pmsQGnJvUMWijHFRSxe0wB9W3I=
X-Gm-Gg: AeBDies/DKJYSsN8X2MCyM/m/KQ5u970rSqbervfu50mknkjthuDfkoSkZ1XtL3J5Ni
	+8tHrA0f1T48757/fqVUyAsxPhIiDv9A7XCKeWLC6mY6/MvZJI/rVD++lqJ4RjCRvi56NVQA3ha
	k5Um0YxfZiDM2WW6yOXeMjbBKfG/P2sIBl8kT1wbQVAH7XDdl8m1noJp0kLptw0trxEPCg/GAlJ
	EFl6WDKq7yLWp/PyfOQ6Tz3lgNjAAgYZfGqtM5iXByhBQF0/axOOO8IhVy1ORSTGKdIGnYvJB/9
	MnykEDC9b2U9/Zn8TxjS/zOAXwkqEZ3EvCW5wCSUM9Ke7crjYWSJO2z5i35AyjKb7lrRi9XFmvJ
	b7Z8NRuSW1R0RjpQ6jAaUfG27UCxW/WRDVOS52tNMBFK6QhdXjbEPmbqMyLQRmVIzL8arrkndJR
	Xb5aOrihqDDWYu0g5vDpkz7pj0CYlwUGdS9lkJJu391d7HPearAtgcAEpkazu7bPcxHw84ZfGt+
	hzVhiUMZYRW
X-Received: by 2002:a05:6830:6684:b0:7d7:faa4:6c2b with SMTP id 46e09a7af769-7dc27cc0028mr3047317a34.9.1775854000316;
        Fri, 10 Apr 2026 13:46:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269402b9sm2527358a34.20.2026.04.10.13.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:46:38 -0700 (PDT)
Message-ID: <0f05add7-96c0-4eee-b396-d6e1be904c09@baylibre.com>
Date: Fri, 10 Apr 2026 15:46:36 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] iio: adc: ad4691: add triggered buffer support
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8551-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5AEE93DC8B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture support using the IIO triggered buffer framework.
> 

...

> @@ -201,8 +245,45 @@ struct ad4691_state {
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Per-buffer-enable lifetime resources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	struct spi_message scan_msg;
> +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> +	struct spi_transfer scan_xfers[34];
> +	/*
> +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> +	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
> +	 */
> +	__be16 scan_tx[18];

Needs __aligned(IIO_DMA_MINALIGN) since it is used with SPI.

> +	/* Scan buffer: one BE16 slot per channel (rx'd directly), plus timestamp */
> +	struct {
> +		__be16 vals[16];
> +		aligned_s64 ts;
> +	} scan;

Unless it is required that all channels are always enabled:

	IIO_DECLARE_BUFFER_WITH_TS(__be16, scan_rx, 16);

In any case, needs to be DMA-safe for SPI.

>  };
>  



> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int n_active;
> +	unsigned int k, i;
> +	int ret;
> +
> +	n_active = bitmap_weight(indio_dev->active_scan_mask, iio_get_masklength(indio_dev));
> +
> +	memset(st->scan_xfers, 0, (2 * n_active + 2) * sizeof(st->scan_xfers[0]));
> +	memset(st->scan_tx, 0, (n_active + 2) * sizeof(st->scan_tx[0]));

Maybe simpler to just clear the whole thing? (same with other preenable)

> +
> +	spi_message_init(&st->scan_msg);
> +

