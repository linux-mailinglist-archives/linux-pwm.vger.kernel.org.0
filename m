Return-Path: <linux-pwm+bounces-3885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C881C9B024D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591101F21420
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ACB2036E6;
	Fri, 25 Oct 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBKoHR0p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D041D54E1;
	Fri, 25 Oct 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859196; cv=none; b=bieCzQQTvfzV+yweSJo/VkHOWWbfdGkPTQIstRanoPZjt3sxVZlF7UWtUCPZ+wZtiQXY2urXo20PLOYJppbj2WL+aIDBDN4Zbq3zw9+ySaODEBzeRJS5Qculk18BOtiibRbUmx5OxNaAfp6dWJFkGrppKa5ESb6axkYbarULgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859196; c=relaxed/simple;
	bh=D+VAgkI9BdNfweuLoz0KCd0YS+tPrLXCfc3QH8KX4b8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChVMYjaTnguNXBx9pgOUuEJ8u3BpsmfIDU+d8BYMfCuhYb8hDBGGhtaYBrxSXf3R3ek1bo40j9enZV6MowoorVzvnxiqoMlfyRhaRHj8anQaXIUNkiSOsJg3UKe9Pczyk1/vSZ2FfYwNWvKCvUPiJBzm/hEKtjminJQyMhRKjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBKoHR0p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d8901cb98so2038457f8f.0;
        Fri, 25 Oct 2024 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729859192; x=1730463992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+VAgkI9BdNfweuLoz0KCd0YS+tPrLXCfc3QH8KX4b8=;
        b=bBKoHR0pRuDxt7hFJJElhzhOqJ/NpYoFArlNrD0h2ieuDWjtSDW0Ufd0UjAH2OR7wU
         nYM/FicmDZz8p80T2TpBe+aMqyGFxzAGVS/vdNFQk0GsDCDx84VTifRmbEai/QCQ5vy1
         gIf9a9BVevHB6tzWrnxQGpcVM+tdEkPblH6clwhh2bZxjrdVCflTCdKv3ZXgelGpP6gJ
         dd6WxABmovLKNlvdzB6s47vq8/KLaV4rDR2iyKVLl3j/KrtcUG2DRUeeavtQBkE/YZwk
         EWqpJyyerOhKcYXGHXV0YgdQxsIZe2chdrm54sRKp3dhIrIQTFGCGWh60OmRizr9RqBx
         3Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729859192; x=1730463992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+VAgkI9BdNfweuLoz0KCd0YS+tPrLXCfc3QH8KX4b8=;
        b=KrPVTLaYPemn6Vf/FvrOz92ixvanQ2yxXhYaCMUO19kXyU7F1lDH1Fe5RxIwwREV4N
         Ehj54A4sI2C2uMDJYvGzUTymlOSYMyAwOJ/dJXwSIoYN9h50zARx4Ja6MZZ5ubjKZUnd
         KHbO2xfmUMHQHj1Wcb4ptIv4c7M5fiafIimhLgk7Fhp+J8Awo/TBEPzjseJqD4Bo6C2O
         KU+UkqVPga2Fsg6IzMMmPIyL5CrJ9ZHKjrntvncyYSH/dW/D3Wfl1Fx2K4RoUorIfTYA
         6HWQJeEtY8tZW/ROdgcsbd7Vl2OlEox2WQDxGWYemPPde4m87R6wO5mLalctNIAGvXU6
         u4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQIJw9NE8/0PWxLupnc53GYmDJMDd1mzY8z6QnDgQeJLpVUgvzwJv+OInlgc5k++KtQ4fSXWN8ryNO@vger.kernel.org, AJvYcCUZXMwITtbTXhrm9Qvbzq27u2sTboF+W8vw8ET4MdNzdQf5j3ZKJ/P8PUXJ9hdREQ2oU/l/5NXAJXde@vger.kernel.org, AJvYcCUbFXkX0M3ivyjdEgfcxtNWt61HkwppsHJz9ZFkLfUO8Ul7FU/dID+vbiYJmTQV8sVwQ/DYrtPpUm9U@vger.kernel.org, AJvYcCUsT9ZtQRhs4QqwrtqcHcG9eqtA3bH39a9lxP/cuj5OqBYVHRY8+UDipQemqFcXz0w/y4l26A3UM8id@vger.kernel.org, AJvYcCV4x3BvJg/FP6v/YfFVWCrp6+VwSH4SsFqpw27HkXOeWJ7f3bdUCLt9Vj+NJPi3yZ9BOBUsx5x2484YCI0y@vger.kernel.org
X-Gm-Message-State: AOJu0YyOE+wWRWw8FNtMW1XsMage68PWjN2eQfsLRkMZ7OrlHgS7bMkn
	v9Y4kZzXkzM6inGXzTSQz5Hw6rgevF6jtMRsy5hnl2lKACz9tVDP
X-Google-Smtp-Source: AGHT+IE4N4UzSveT9hme0zr2iZUIhTpdyHVDKtIylS7k/09bLcEA2xElCCUaKRYj5M9bCg0Mhc8khg==
X-Received: by 2002:a5d:588a:0:b0:37c:bafd:5624 with SMTP id ffacd0b85a97d-38045883830mr5008361f8f.25.1729859192161;
        Fri, 25 Oct 2024 05:26:32 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bcdsm1394926f8f.82.2024.10.25.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:26:31 -0700 (PDT)
Message-ID: <dbb7a66f236a3cde39acef59cb498b42a6fa9cdd.camel@gmail.com>
Subject: Re: [PATCH RFC v4 08/15] spi: dt-bindings: axi-spi-engine: add SPI
 offload properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 14:26:31 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-8-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-8-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> The AXI SPI Engine has support for hardware offloading capabilities.
> This includes a connection to a DMA controller for streaming RX data
> and a trigger input for starting execution of the SPI message programmed
> in the offload.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v4 changes:
> * Dropped #spi-offload-cells property.
> * Changed subject line.
>=20
> v3 changes:
> * Added #spi-offload-cells property.
> * Added properties for triggers and RX data stream connected to DMA.
>=20
> v2 changes:
>=20
> This is basically a new patch. It partially replaces "dt-bindings: iio:
> offload: add binding for PWM/DMA triggered buffer".
>=20
> The controller no longer has an offloads object node and the
> spi-offloads property is now a standard SPI peripheral property.
> ---
> =C2=A0.../bindings/spi/adi,axi-spi-engine.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
> =C2=A01 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yam=
l
> b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> index d48faa42d025..5281b4871209 100644
> --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> @@ -41,6 +41,24 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s_axi_aclk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: spi_clk
> =C2=A0
> +=C2=A0 trigger-sources:
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An array of trigger source phandles for o=
ffload instances. The index in
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the array corresponds to the offload inst=
ance number.
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +=C2=A0 dmas:
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA channels connected to the output stre=
am interface of an offload
> instance.
> +=C2=A0=C2=A0=C2=A0 minItems: 1
> +=C2=A0=C2=A0=C2=A0 maxItems: 32
> +
> +=C2=A0 dma-names:
> +=C2=A0=C2=A0=C2=A0 minItems: 1
> +=C2=A0=C2=A0=C2=A0 maxItems: 32
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pattern: "^offload(?:[12]?[0-9]|3[01])-rx=
$"

I think the core is already capable of tx offload? If so, we could already =
have that
in the bindings.

- Nuno S=C3=A1



