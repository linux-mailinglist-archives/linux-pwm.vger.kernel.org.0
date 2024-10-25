Return-Path: <linux-pwm+bounces-3884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F329B0246
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447F1281B63
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600402036EC;
	Fri, 25 Oct 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw/Pymjt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013702003BC;
	Fri, 25 Oct 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859087; cv=none; b=g3IcHh5zK60dAdILxz5ObH+VJ7BS/eY3mpvKoa0qoSbzCGYCPWq+ZkopOpBed2I+sI8QAYSpMSgNb+d8/tH2YetiVV+dl4sUBh8Kdw7N7XHMRue9qgjQ4mefSe7GdoueSDwYEROU0ajl1hbAUrttcW9ksT6OuPi0Uswq3/XGgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859087; c=relaxed/simple;
	bh=Z5XDBQsaCkyP9D/5Io4jvAUKYDqeuCrR1g54KtPWi7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lYALdBqPtTp+zlRl6qaPJyNaWlNTiv0f0lVLUMQWdtqcxeAJpbVtmXoVIBm1ELlAJndedHFpxNST3Dp638NLUkWpWt8KB7S1tHYUovpo7CY2qC5k6d+DpujHdZoz7FHRQzgCvRMCuxhGEKLjYu9CV5CoStWIbtH34O2gXF1dkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iw/Pymjt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43163667f0eso19617465e9.0;
        Fri, 25 Oct 2024 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729859083; x=1730463883; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYzZ5plZjr/ivbDXkMNCAQd5Ocu3/uICeMDdVH85OAA=;
        b=iw/PymjtRXgeCu3fbwrJx3+d/lykttD4x6MtEy3j6pfLP6FNqpsoW8gqTgAZf6/jOU
         qvL0xOYdJ4jrYoXmRBPaazfOfzYlT+KbsZcApnfaAA1I0b4nK1/rr2ZNEomy/dLCCP2R
         IhwWOXOoJgcPVjTNprkfq7yV72V41qzuS5HVc5cEA2pUpheyxqaBke1F4xVZkt1q8UyW
         9vhhv4ZHR7GxVE7T9vxinV3jAtI8I7bCnQB+CWwPxHm6ogzImPwWZF0Kfac4GxqPCEWD
         gDlnxF3HAFR7sdniUI4n0nRT7UxUaBSkR1+5Igz4VzxULk6tvTW1mkhMceaVVaLArSL+
         +N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729859083; x=1730463883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYzZ5plZjr/ivbDXkMNCAQd5Ocu3/uICeMDdVH85OAA=;
        b=W/d5f5klV+RT0ViKtuu8/WM8q/ibmS4ycrj/I3OaPbpRWSWFbFqSeuIx/vzKnUBOPo
         yy+q033j3Rr6WtVOH/7BwMkLUTfqETLGgMcZlhnZKOMM62S2PMDKJNY0KGPlG/+0BWbG
         H2gXZEOouuz/InQ1pct9kZgBY9YL5Av17ZVJJPyhpBNmSKc5Hu0TUh6oDV0l7E60dYvY
         kSsEsI817qR7S/tKqwprvgeV3mZn063UjNqWLCM2Wb4Sw9/aqewiL9iEoSYmuZUCnges
         u0iHi3gAKETzLSYI1MTe7dxtiwg9H+0XH17A2gQ3itbywFNUtlU9+ZqSE/4R3Qjq+zeb
         ifOw==
X-Forwarded-Encrypted: i=1; AJvYcCUDBEGu6DC513BpKejxw+7aL/XTXW4Wh8PmvmEo1uZxiJiRKsjk1pMetb7JGQzJ7/Spns4Wd7pwBSPh@vger.kernel.org, AJvYcCUWXB11Z2R0hkAWOzG7xOHAiTG84xogAreoUfuy9R9eMNF/G5XMOwmXpURdH6zOb+Q8bc7OEyhny8Q7@vger.kernel.org, AJvYcCVV/+FNdtzuCeImVgxfxAMYxnjQ3hMcIfg++LR+wEfbL2IPGbOVXSeZpdaoLnKkHxNAdGRxUyxK2AjD@vger.kernel.org, AJvYcCVlFEuKkrOtr6c53Lb6CEFO5eCt1Bm5PmYBKmNyWNUUh7UG6arWiffcEGptpT0wyXkMjMfy5ilRTcGcYT1e@vger.kernel.org, AJvYcCWdB8/X/MLoNY9210uuxe/Ek615f9OeJKzeFQ6HUikdq9o0X956Io4+10jtn6+JcAGja2yvoDf/XmWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KwkGT0UYRjAOE+Uf41AROwTn5583WlIfEa6u7q+Iq5eWw90k
	FG/BW3H0CqJFegZKIE845qJck6ZT2rCJ6im6vTg5GHyLTnO58Rf9
X-Google-Smtp-Source: AGHT+IHag4RyX7Vdwg+d8jP6CBWJ1wmfQ0nBOBv+3wACgnWVRKihMStaMnkCocneC8wHwDpop6exXg==
X-Received: by 2002:a05:600c:1c05:b0:431:5bb1:f088 with SMTP id 5b1f17b1804b1-431842460a0mr87195715e9.29.1729859082933;
        Fri, 25 Oct 2024 05:24:42 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f74b6sm16286575e9.33.2024.10.25.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:24:42 -0700 (PDT)
Message-ID: <535af173992948db675029bc33a7877cb9e75275.camel@gmail.com>
Subject: Re: [PATCH RFC v4 07/15] spi: add offload TX/RX streaming APIs
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
Date: Fri, 25 Oct 2024 14:24:42 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-7-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-7-f8125b99f5a1@baylibre.com>
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
> Most configuration of SPI offloads is handled opaquely using the offload
> pointer that is passed to the various offload functions. However, there
> are some offload features that need to be controlled on a per transfer
> basis.
>=20
> This patch adds a flag field to struct spi_transfer to allow specifying
> such features. The first feature to be added is the ability to stream
> data to/from a hardware sink/source rather than using a tx or rx buffer.
> Additional flags can be added in the future as needed.
>=20
> A flags field is also added to the offload struct for providers to
> indicate which flags are supported. This allows for generic checking of
> offload capabilities during __spi_validate() so that each offload
> provider doesn't have to implement their own validation.
>=20
> As a first users of this streaming capability, getter functions are
> added to get a DMA channel that is directly connected to the offload.
> Peripheral drivers will use this to get a DMA channel and configure it
> to suit their needs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes:
> * DMA API's now automatically release DMA channels instead of leaving
> =C2=A0 it up to the caller.
>=20
> v3 changes:
> * Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.
>=20
> v2 changes:
> * This is also split out from "spi: add core support for controllers with
> =C2=A0 offload capabilities".
> * In the previous version, we were using (void *)-1 as a sentinel value
> =C2=A0 that could be assigned, e.g. to rx_buf. But this was naive since t=
here
> =C2=A0 is core code that would try to dereference this pointer. So instea=
d,
> =C2=A0 we've added a new flags field to the spi_transfer structure for th=
is
> =C2=A0 sort of thing. This also has the advantage of being able to be use=
d in
> =C2=A0 the future for other arbitrary features.
> ---
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 76 =
+++++++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++
> =C2=A0include/linux/spi/spi-offload.h | 24 +++++++++++++
> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 ++
> =C2=A04 files changed, 113 insertions(+)
>=20
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index 2a1f9587f27a..dd4cb3c2e985 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -8,6 +8,7 @@
> =C2=A0
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/device.h>
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/export.h>
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/mutex.h>
> @@ -282,6 +283,81 @@ void spi_offload_trigger_disable(struct spi_offload =
*offload,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
> =C2=A0
> +static void spi_offload_release_dma_chan(void *chan)
> +{
> +	dma_release_channel(chan);
> +}
> +
> +/**
> + * spi_offload_tx_stream_request_dma_chan_info - Get the DMA channel inf=
o for the
> TX stream
> + * @spi: SPI device
> + * @id: Function ID if SPI device uses more than one offload or NULL.
> + *
> + * This is the DMA channel that will provide data to transfers that use =
the
> + * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
> + *
> + * The caller is responsible for calling spi_offload_free_dma_chan_info(=
) on the
> + * returned pointer.

I guess the above does not make sense now. But I would still document (just=
 to really
make it explicit) that the lifetime of the DMA channel is effectively being=
 handed
over to the consumer.



- Nuno S=C3=A1

