Return-Path: <linux-pwm+bounces-4239-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E009E4B61
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 01:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FDE282670
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2B14293;
	Thu,  5 Dec 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CgL5lU4P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E90101DE
	for <linux-pwm@vger.kernel.org>; Thu,  5 Dec 2024 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359482; cv=none; b=HqM0Jtapb+czwl6oiuWfw6nAlPztIzKc8KHMU0U0RcLL6h2JZnKESRYzqKjL0e0zWPF5UVMDl3xGf4Yyw3MxfwJQmThpepe15HHnBEgGd+yyPvJ/mThjCcu0u5xtZ8Jdq87QA8IBHyxcyCNHjhtBNi7ig4QEpqIPE9FJytClaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359482; c=relaxed/simple;
	bh=RfWODQeCQ92PKzUdEskZeQY10PlkpbDGFWN1YWWpNow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O5PLP6nf+b1ccuiyPzNTJ7c+QBH+jow9TXM9vnB8wvmYGNFhnKd6pE2aDsTjyhp3WcO1vNCr1gCRzwLFuSgSVTp4rfdVAhldfq/qcrW5FjpvOscy761rjrIYm9w4xgiJONQvEIWwNthWUyKsRo+mdxbLKS9qyOYu2Qr5oESXEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CgL5lU4P; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ea55e95d0fso130540b6e.2
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2024 16:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359478; x=1733964278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZU+yuC4IUNNrcZsdQdOWRd6MVYrt80tZt42Hj7Odpo=;
        b=CgL5lU4PiFH3Zh26mHpXbCWV5ZZSDsnjORx5YEo+8k2N6k9OsjCNHSvqy1c1oONKNc
         jKW7Gur/n4/TqbytgUX7dJ5PTLUtIzI0GLYJWJkpTevZsz9X+01/+yeZesMkmiyf+Uph
         JXWXpQMzOabtoRCIQabrIXeT8DGG6uTJGZpLuwkFlCPzWiZb1yozEtAGg67efINQ/cUT
         fgIokJKF9jK8SZVDw/gIffl+0TaySIYZiGHQ3gZzAhGrNOAqd5WzwdrdcY5/Gk1vlFDP
         e+4SbMkopRQxKVNEdkfDjoWktt/hKfzNYW5LwGKnhcfG4HW0I2EU/mEXEQ+lFX9mLpMV
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359478; x=1733964278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZU+yuC4IUNNrcZsdQdOWRd6MVYrt80tZt42Hj7Odpo=;
        b=s1eHA8fECW+XFfP/rVUuZTjyNtgYCIoMlFh+veh3KCvuymNjI6O4Ee6wYg9xsyQhPx
         xIgfERQyseW5zsLu6vUj/ryy90K25myQVtBWS69ondR/5a0h2HgAm8ATI3zABJvZfT89
         F8A7z5YKdlfoYdE1iVtRr/PVRvByd4B9IIrc89C70WsI5B6B2HVVn+liRrKBywtZeILQ
         mzmARSMfGPT1mnHZJPEWKcIvDNactQoMBJ/QZR/8M0n9d1rQyxAf0fQmJsNRSxqYSiBs
         icGBsuOmyf6D3WHJkSXPYXkckN5OJ78p7QmS9f+VYkC3Ceenu0evZxIar78raCEvDs2Q
         Po/g==
X-Forwarded-Encrypted: i=1; AJvYcCXr5EV6E4SjJxSPO0oo9ggInBpv6m0e6N06//qECNG+MRdnzWJvNb80wJjZmyHCfHDbZm6NVanVkpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgFtHXx6J0qHJqDauYM2ogmHCfgj790QZRxXc+mZSmENyDXBt
	Aa1is8kr1W+tnUDsI99o9G9pikFgDRlRpiFLKACOyQQtPvl2lqtVc6W5/Pj/++GoQK5fXY28fYV
	v
X-Gm-Gg: ASbGnctIyeVtTzBpXVR9O0De6ak/zb3FGnwBujJE/JoIlGC6+mPE9Eio++P5atlrCue
	PsxXpU9r5O161wUuBI1Rbu+KMxVz4V1n+xDt3/PWoN+wBv4nlTlesRaNSJQ92sABTYST/3kep/h
	WtbgAiUBPxtI0OTY0JSRL2JFdlBUrEl4wJAgmnZzNIfHxsonD2FZM+ZNGUQcPLicKkysNAwuxXY
	HDxHRVlAQfSABlrMQnxqiF1UVRiG2io38CdvlJboa9DXrnN0UpAe8NEYjGnqcaXbvJUPGgJdpx6
	T6z97Y67D1Y=
X-Google-Smtp-Source: AGHT+IHaFElNJBo9YhzTZTzxYaqVWuPDKa7rUFNx4+15yLQ0Bvjs2W04jhZERCIQ6ow85bmA48lGYg==
X-Received: by 2002:a05:6830:6516:b0:718:16c8:3c02 with SMTP id 46e09a7af769-71dad6f0756mr5814100a34.29.1733359478045;
        Wed, 04 Dec 2024 16:44:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f56945d20sm104623fac.35.2024.12.04.16.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:44:36 -0800 (PST)
Message-ID: <4795d5b2-2d6d-4d81-a57b-dc28d217aacf@baylibre.com>
Date: Wed, 4 Dec 2024 18:44:34 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] iio: backend: add API for oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add backend support for enabling/disabling oversampling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - implement 2 callbacks
> 	iio_backend_oversampling_enable()
> 	iio_backend_oversampling_disable()

I think Jonathan's suggestion from a previous review to pass the
oversampling ratio instead of enable/disable seems like a good idea
for making this more generic.

int iio_backend_set_oversampling_ratio(struct iio_backend *back, u32 ratio);

To answer Jonathan's question [1] about why does the backend need to
know if oversampling is enabled or not... In this case, it looks
like it changes some timing (the conversion quiet time) on the LVDS/CMOS
serial data lines depending on if oversampling is enabled or not.

[1]: https://lore.kernel.org/linux-iio/20241123160559.56c57fc7@jic23-huawei/


