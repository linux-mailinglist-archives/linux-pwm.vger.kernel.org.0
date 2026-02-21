Return-Path: <linux-pwm+bounces-8140-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPwPFATbmWk/XAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8140-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 17:19:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4B16D40C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F073024A1F
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36392FC007;
	Sat, 21 Feb 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HoJWKSDA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6F2F4A10
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771690745; cv=none; b=IsNyeZZwHS+i3uJ6SegKJBCTRTpZ37A4JZqPtsksIPZmnf+idura23+FL3usZO4GkeuDpQgWoR79QY9zVq7MEvzunuq7eh75P0Mem+AWWE35nSrwAeHZokA57NRehwTE2p07jH2Vfp6udI66uNEaJjVLqGqdpMo8itTuEgyFKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771690745; c=relaxed/simple;
	bh=ZGs8ig7nsH1pei6ajV/Tz6Q/HQJkNsPxLQAVYENsBlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWG5xinJ9PDpkFsz+avG7kk3o0IElc1LuXyZOifTB1wh2GXiHGod7YdpKl51rTzoE8lLIRQ9fdzu0Fl35EUFt7BKwmusLIM7KmWlps4fHz5b1GOBBBUd7PgBUj1clEP6hAK2sDMqDlQUxNyCRwCiBNOGQeZTQR/oelvjyCGaLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HoJWKSDA; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4be94eeacso2664213a34.2
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 08:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771690741; x=1772295541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L++09fqziGb0jz5RsUbVS/myTW1kj7r/wV8SxU0JDaE=;
        b=HoJWKSDAPzs2p5rSGhA6t7xi6Qj/qqJCzbzYpFVQ1BgWIKpHD2gPbN30qhNFxjxm/x
         nWowj7e5njrox1vzH5zNvUpQbxAsNuH+dPe8PFZ46fDxK/HEtJw3aMO/iK/z0crKjB+P
         sPZu7/upycxAIJh4IaRZU7/fT/XwX614V2JRWGbQJmKVYP+OKDIOo7UhLhpngbajzBQR
         gj7hWhC48EnE2CUhpJ0x2q1NE4rzbY9ztjJ2Ebir1+siDiAHvVtggWGxLauCQVILWBwb
         MdPd1/+AnWmG5bFh94NIZR13+55/NfYfpc1+NnXQatSt4Q4f894VrnP204ga0tup1l3E
         TBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771690741; x=1772295541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L++09fqziGb0jz5RsUbVS/myTW1kj7r/wV8SxU0JDaE=;
        b=RmkQCVGDAKMbCSOP2+cUyzq/P6ZLl0IYObHpWN0PqNp/C/wh7ccBhpKzygV3fDwEaM
         jq+FKaI/CDSXbsZceQeUaDFs2dId/czpjNMqVP98RN2g9sQv1CYI2MR0DaH63bR5AaiC
         AkBhmPvr6mGtRiL7zdARS7iJY6HtBm7xePq3GNT5gBwwpfwuv9wLFaElrf0a6nihmBzw
         tgbzWkP1VE+S6Sl6OfH1St162p75IV6ko3ZtGKUhBv39HMZdLIjMLhMUT6Z53605oWOO
         UftdpiI7w2LRbT+aV+0OecM5wketxGZ6+4FhirnaEwjCx8pK80BMME32/uP+flYBJeZW
         iYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW31+AigCeXJn3FpJ4Hoh9NWueG7AnbZiEYvKPoklRKjAJcOQ3aGxD61KwZlr9oYBAFs+/Ewt8ZkXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynw/ScENRjp0UNAj4J1F0uDEg/754t5dncCyUMbGvuSyO+cyN3
	Z3LQ+HesWrHAwXwQTOzCT1FSO/GGDa9wRlCLECPpiFpsuILuNCQ6Lf+tFmIWljCJVtI=
X-Gm-Gg: AZuq6aIrKf3DAzSw8OLZVehh2/acydrZAN4yDnRDeryvZMxD94ZPt9uhCNXrDGCwqcB
	f7DX9CXNCesJzu6cLBjYRX8HSozZdy9yLCvnF8UmkopRuIkJT7Vei58SQAnsMKNyjgjGcAxVFy/
	jn6yCJ8j1bCgOpVTflgFjdxCZBST4ai7ee5VOD2kyUa/Gr33wUSXItBaheRsTBoKsBKGMdkEtSV
	xnCvcAG/MQpMjOBwM7xY5SQlCWsVxsKbnyCcw0bBbg6oHwg3NUW1ZXq4wuoe+6l91brlClVkvC7
	cWxbOjIKA0oux3jR10KtkJQ8dXvniYQLxCZG3jJPVigUtnSwxx0vKMFK9RzBVcIOgwdjU0/K8tf
	MlpQ+FbV4O91nfAPpO6v9dJ8dJTugiXMTF/elh8HXJVRYQnfATriN4kV3e2ggjZ9OZlVfTGKaoe
	LVPiuxJs1bZpkcqa4USCH2bF/HjjXkxJufiuQT2Sjx1kdHw1R4Gd8JavcyNuylKgrfguNHxA==
X-Received: by 2002:a05:6820:16a3:b0:679:94ff:6ea7 with SMTP id 006d021491bc7-679c4251e3dmr1891231eaf.15.1771690741338;
        Sat, 21 Feb 2026 08:19:01 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d34955asm2924971fac.16.2026.02.21.08.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 08:19:00 -0800 (PST)
Message-ID: <71752f14-2c13-496c-8b31-8d612c4a9a1a@baylibre.com>
Date: Sat, 21 Feb 2026 10:19:00 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8140-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20230601.gappssmtp.com:dkim,baylibre.com:mid,analog.com:email]
X-Rspamd-Queue-Id: BFC4B16D40C
X-Rspamd-Action: no action

On 2/20/26 2:02 AM, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  drivers/iio/dac/Kconfig   |   11 +
>  drivers/iio/dac/Makefile  |    1 +
>  drivers/iio/dac/ad5706r.c | 2290 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2302 insertions(+)

This is way too much to try to review in one go. Aim for 500 lines per
patch. If it gets close to 1000, it's time to start thinking about splitting
it up.

And if you can split it up into sepaerate series, you will get even better
reviews. We only have so much time, so the fewer lines sent at a time, the
more time we can spend on each line.

It looks like this has a bunch of unusal features, so I would suggest to
drop all of that for now and just start with a basic driver. Once that
gets merged, we can start looking at the unusual stuff.

> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index db9f5c711b3df90641f017652fbbef594cc1627d..20be74a2933049250bab779d12ecd2b9b1f5a2a7 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -178,6 +178,17 @@ config AD5624R_SPI
>  	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
>  	  AD5664R converters (DAC). This driver uses the common SPI interface.
>  
> +config AD5706R
> +	tristate "Analog Devices AD5706R DAC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices AD5706R 4-channel,
> +	  16-bit current output DAC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5706r.
> +
>  config AD9739A
>  	tristate "Analog Devices AD9739A RF DAC spi driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2a80bbf4e80ad557da79ed916027cedff286984b..0034317984985035f7987a744899924bfd4612e3 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_AD5449) += ad5449.o
>  obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>  obj-$(CONFIG_AD5592R) += ad5592r.o
>  obj-$(CONFIG_AD5593R) += ad5593r.o
> +obj-$(CONFIG_AD5706R) += ad5706r.o
>  obj-$(CONFIG_AD5755) += ad5755.o
>  obj-$(CONFIG_AD5758) += ad5758.o
>  obj-$(CONFIG_AD5761) += ad5761.o
> diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d718cf7300bcd1f599fe715aacb3170f72541af
> --- /dev/null
> +++ b/drivers/iio/dac/ad5706r.c
> @@ -0,0 +1,2290 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5706R 16-bit Current Output Digital to Analog Converter
> + *
> + * Copyright 2026 Analog Devices Inc.
> + *
> + * This driver is designed for use with the AXI SPI Engine and AXI CLKGEN
> + * on Xilinx Zynq platforms. The 'clocks' device tree property references
> + * the AXI CLKGEN output clock, which is used to dynamically control the
> + * SPI clock rate for read and write operations independently.

Normally, we would just use .speed_hz in struct spi_transfer to specify
the speed if we need different speeds for different operations. Any
reason we can't do that here?

If there is a reason, it needs more explanation. In any case, I don't
think that changing the clock rate of the SPI controller like this without
going through the SPI subsystem is going to be acceptble.


