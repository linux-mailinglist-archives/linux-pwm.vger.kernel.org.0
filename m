Return-Path: <linux-pwm+bounces-2055-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3B8AF5C6
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867F3B22703
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EEC13E051;
	Tue, 23 Apr 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gLy76zbx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6B13CA8A
	for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894225; cv=none; b=i3MpxMD1Lbw3UGBooKzzigf5MAHKUeGsHGRcJ6nr4eZ1rROU2JwqUaPFL/QDNMF7aGb/z9KSOhqyZqvfPjViVfTedZ7/xhBu7Qy5jqLPfYyEaSsqM1EHBSIDAgFFjXcnvl0YusyOvcmyf1exB1fzUC4FDfHQq+DNB3slaNdNE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894225; c=relaxed/simple;
	bh=85djGqYP8/Kxapd6Cnll00IPvOM6JcnPhWbUX2qZEms=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=nVpOq4URCaG3Ti/BUd4gXWqHSxDNeEnLj9+OO233y0w35ZrOuPt+Hr7BC+12lN+/cnZgoDO4swGD/C0sd3FOoILwEOE2KmT0wyPcGD/n/1+PYZvORTaGuu8M+aIm8HSYafM68htLV7YUU9kpryg+psEceOk9wpRcmO18jS+nPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gLy76zbx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a5b68ed85so543975e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713894221; x=1714499021; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=xP/dSnA767BtvZjFr+UbEirp9Ik35vqXQ9msNy380rM=;
        b=gLy76zbxbs1t8TrfeJDNVYCcxDHDyGOjf/YBqdH/fKQVQYcL6uPAfCV5uJ3aJlhIAI
         UhUVYzuKK+B7tSYJ9z2HKzI3h9rw/qd/yJtuWH4cblrTfN8KIxjq3ZPKl9W6TmBT5cz8
         noCigHkhwASubuqwnvnUSLCNIpkFbGQix+IhofRXDIt/W120RHIPbC7nox9zts6WlW4k
         VlacDpooQDnL3K/0bf9c9z4D/2u0vXFXbfP3xKjpbSPQ9ZX/DDC/ZiZ4lb7BO52K3S5D
         uo0klgOVjJVlpy7Z7O4MFfpboRPu52q7onbRHqePUAbrLlDz53/EsQbLVW76dWaNPtyf
         Astg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713894221; x=1714499021;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP/dSnA767BtvZjFr+UbEirp9Ik35vqXQ9msNy380rM=;
        b=sfXHVlNUYDodJBRgSnOPdyzqNYXyqLXRyhLP/OS0QrN2aPrgSYCFaSJnaLw7ZAWYqh
         uhzc8t206qOuFKWThdFRD0AylAWjqhcQESXAFE8B+ZjX3i2iA4QSVnPtAeTAkoK3FqU7
         aBOeFt3X33xKMKFinavWvk+qYFbJ4FZ7in5CHFnBgzv6pCPGcimcUZuDig+NRoOJt9mz
         PWN8vm5kA0v+8vFA0OTVaMsmvE4m2ymFqSjgZrTcU7FwVFRviDwrOk3cpbEGnKg6dL30
         TsVGoD4g/7U9Fs5jcsafKQXRtNp+t5lDZcOJvU19WOazI3T6vA4m+lO211skVzBFl41O
         itZg==
X-Forwarded-Encrypted: i=1; AJvYcCX96jUM+rz6yciAmw666nqNVU+Jo00gAJAiDwlkXm1bq0UqOmArUe5b1rVceLT61gE+z152pb9aGUgWej6wlGt/5Augz0iVPQtD
X-Gm-Message-State: AOJu0YwRrx4DEXF+480KJvotmn/dIbiYrtaNHQ8v2eiY5KsO7KMms/5y
	uArarvAicGaZulSPQ0rKKGEyfCrI7nwWiXSE5MBwb1jvOpJAUIui+4+EYJuDTW4=
X-Google-Smtp-Source: AGHT+IFN3sKGf0QLUl/rmcrF/MIEa7ILZ5sxMGe+vffDzMV1NNJqknbDpN+wCiQiguhfqPPiAmgxhg==
X-Received: by 2002:a05:600c:1988:b0:418:f219:6f64 with SMTP id t8-20020a05600c198800b00418f2196f64mr2738580wmq.4.1713894221268;
        Tue, 23 Apr 2024 10:43:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:aa38:830e:cbbf:591])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm15078195wrw.26.2024.04.23.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:43:40 -0700 (PDT)
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-3-gnstark@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
 hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com, George Stark
 <gnstark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 2/2] pwm: meson: support meson A1 SoC family
Date: Tue, 23 Apr 2024 19:35:15 +0200
In-reply-to: <20240423161006.2522351-3-gnstark@salutedevices.com>
Message-ID: <1jv848ezzo.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 23 Apr 2024 at 19:10, George Stark <gnstark@salutedevices.com> wrote:

> From: George Stark <gnstark@sberdevices.ru>
>
> Add a compatible string and configuration for the meson A1 SoC family
> PWM. Additionally, provide an external clock initialization helper
> specifically designed for these PWM IPs.
>
> Signed-off-by: George Stark <gnstark@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/pwm/pwm-meson.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index ea96c5973488..529a541ba7b6 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -462,6 +462,33 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>  	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>  }
>  
> +static int meson_pwm_init_channels_ext_clock(struct pwm_chip *chip)

That kind on naming (ext) is almost sure to clash with whatever comes next.
Just use the name of the first SoC using the method, a1 for instance.

> +{
> +	struct device *dev = pwmchip_parent(chip);
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	struct meson_pwm_channel *channels = meson->channels;
> +	struct clk_bulk_data *clks = NULL;
> +	unsigned int i;
> +	int res;
> +
> +	res = devm_clk_bulk_get_all(dev, &clks);
> +	if (res < 0) {
> +		dev_err(dev, "can't get device clocks\n");
> +		return res;
> +	}

I don't think allocating the 'clk_bulk_data *clks' is necessary or safe.
We know exactly how many clocks we expect, there is no need for a get all.

> +
> +	if (res != MESON_NUM_PWMS) {
> +		dev_err(dev, "clock count must be %d, got %d\n",
> +			MESON_NUM_PWMS, res);
> +		return -EINVAL;
> +	}

... and this only catches the problem after the fact.

It is probably convinient but not necessary.

> +
> +	for (i = 0; i < MESON_NUM_PWMS; i++)
> +		channels[i].clk = clks[i].clk;

channels[i].clk could be assigned directly of_clk_get() using clock
indexes. No extra allocation needed.

> +
> +	return 0;
> +}
> +
>  static const struct meson_pwm_data pwm_meson8b_data = {
>  	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>  	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -500,11 +527,19 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>  	.channels_init = meson_pwm_init_channels_meson8b_v2,
>  };
>  
> +static const struct meson_pwm_data pwm_meson_ext_clock_data = {
> +	.channels_init = meson_pwm_init_channels_ext_clock,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>  	{
>  		.compatible = "amlogic,meson8-pwm-v2",
>  		.data = &pwm_meson8_v2_data
>  	},
> +	{
> +		.compatible = "amlogic,meson-a1-pwm",
> +		.data = &pwm_meson_ext_clock_data
> +	},
>  	/* The following compatibles are obsolete */
>  	{
>  		.compatible = "amlogic,meson8b-pwm",


-- 
Jerome

