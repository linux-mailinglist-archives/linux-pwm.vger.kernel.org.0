Return-Path: <linux-pwm+bounces-3755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA19AB861
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B7F1C23D67
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF561CCEE9;
	Tue, 22 Oct 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2aLN3mJf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC71CBEA6
	for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632022; cv=none; b=uZlQ0878XFneknl/jmdEAqlbiiWuyTSay78r/R3wrcP3P1hxSjev8JOazKNrvGnvdyml5HtED+fkzC3k1Licwyc48J4gvEQLpDuo7jhQQTJGO/N2GCfE8SyUxB2h7RbW+08+0pMb8z9ZiwKiYwUrVRUG/2XSCrVkrLeRWrCnXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632022; c=relaxed/simple;
	bh=ZhxVS2REzAmANbrZ9nSRuAbyeGAVAMksIebOeLoogO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIRr7XYxwmm3QlpbK30gtaw/Jw0oGD4kMrYJACZxopDWDmBQgIOw3LkEV+uZHBtA94HxOyHZHWKG1BZYrjp+Pr4YZmLKodd25Sh3TL9bSSsHv8QuieiqNTr658kbsD/6Oje9ZEL92TXtehycai5gpGdmnZpNEEjoKIedpVxH7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2aLN3mJf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-717fd68fe33so3234781a34.1
        for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729632018; x=1730236818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJnpg9g6r2pW20CfWdE7jCUk/9u5wbr1trHPxKu6nHY=;
        b=2aLN3mJfMZP6cW9G0tGJpdS8LkrApG+IN6Tjq3Qv97GEIsQB7Unx1zTQRQRrK9YOzL
         6XAbYP1Q7woKtcYedRC8apdAaFw6t7Rt4gZHD+V9k0NxcumGNhU95nhJ9kEq2w6TDblt
         ziLOJvzwlSAd76xBZ5qyysnM/o2aa172G9iiWQ+jqu1uN7XzQD32cIng/h45oOR8+X0l
         KEgYnmF039g2oXPvrz6xO4+I6EB8snF3UgX2aPMZgeb3xycrffnB7kgAU8XR4UAaOQyY
         E5HTrlsSKzlf6XaS2MMpxyZBmzmT+31U6fzgpdGwHlqOCrxudkWXvIkWn9WKVQA/ZasC
         010w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632018; x=1730236818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJnpg9g6r2pW20CfWdE7jCUk/9u5wbr1trHPxKu6nHY=;
        b=xBKZThx5JXKGoBSq+7FbNuKSTS344l6kd1fwdjTdsjcy9z08UiSwK3J02YAAjh846W
         erWUePcEzefVuyCGtG5rGFdX2wujbr6z/MAl/gYMO8L/hnRO0Vx05SGMyN2oM0lKeb3x
         B28bgtY1l8NqTDN/MDt4tof7PTNOa2a6lU6vcMv83LZjFWFTNinpXVvrZnqnHe15TYMU
         AM1wSqHR1QRLC76hChuP88DCVwKDYuSKTLwrkRnvhu6xkgSHL9bBWf2mWIqOAd4Os4pR
         WMwZuCc9vzGsjf2okD6KEW3JuXrosHdTVcafilHcvG1duw5FKysfYh7cq1N/yfLaJEFY
         cing==
X-Forwarded-Encrypted: i=1; AJvYcCVg+D3Qcd0JZ0pgpEmlhRKEDgm3N8oyjjIME27eanesI5nx2DvKjmOMqFuEcodMHC40OZNkO3Y0neA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSpeNhRDJUTeNk5wC+w1dADS0KRQxMeX+M8Y5g0euM3C8wn8B
	Oi/cMTxdwdGej27kFwRbNfyVaQBrQ5rO3LNHA4o+0nTQCZPjLJSAdGLnN8gPk+fM9qqAgH8ie8j
	W
X-Google-Smtp-Source: AGHT+IFsMwsPsTvpCwDmnZIxOfs4K2TEZ8wjRPWKgUsV3+xu7SPPImS6MoMNi6W3AR8/WuPjLaRHCw==
X-Received: by 2002:a05:6830:91a:b0:718:109c:b733 with SMTP id 46e09a7af769-7184b4494fcmr574446a34.29.1729632018318;
        Tue, 22 Oct 2024 14:20:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ebb7afb9c9sm1491261eaf.46.2024.10.22.14.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 14:20:16 -0700 (PDT)
Message-ID: <aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@baylibre.com>
Date: Tue, 22 Oct 2024 16:20:14 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
 conor+dt@kernel.org, ukleinek@kernel.org, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 5:42 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..ad9fa0ada9b2 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -63,6 +63,14 @@ enum iio_backend_sample_trigger {
>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>  
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_LVDS,
> +	IIO_BACKEND_INTERFACE_CMOS,

I think IIO_BACKEND_INTERFACE_LVDS and IIO_BACKEND_INTERFACE_CMOS should
be removed. They are ambiguous and overlap with the SERIAL_ versions.

> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
> +	IIO_BACKEND_INTERFACE_MAX
> +};
> +	 struct iio_chan_spec *chan);


