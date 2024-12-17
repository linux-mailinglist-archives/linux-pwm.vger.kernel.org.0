Return-Path: <linux-pwm+bounces-4379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158659F4DDE
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138F316FA12
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A701F5402;
	Tue, 17 Dec 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy9ouM1y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BF1F3D50;
	Tue, 17 Dec 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445999; cv=none; b=WRavWU4ucbhhgbCcX0+DkRgENqAAjjaVdiAObzPemjexckBJCFUZWCjQThHQPM0C2QhjLwJIJGjJpRbDDRtTz15ZoSeXYiJ706fIpzfiRek272tH+0a+EzyfJj1koIIpUcI8CCXxyO+9gUuY+uAnFCYYOOJuYKervxV47H82GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445999; c=relaxed/simple;
	bh=T7qgal3YAgYxvdv4wdowLqbXzjVg1bdGafPFLHnupHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itVqza/z+86rnEFFyJ3dz13V9ajJGV6zxJ56SNJjltcE8NHS2O2Dpf+9RIxpP6WyUlC+lJbpzudddg21RxBDjrVnqfOzgtCvEdsniQJ8YR81wHGw5Q5zXdrAtHGQNSydFJ30GG5Du6jJTLZs47k1qNHBshvZWkSUjJ6YayG0MVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy9ouM1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF494C4CED3;
	Tue, 17 Dec 2024 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445998;
	bh=T7qgal3YAgYxvdv4wdowLqbXzjVg1bdGafPFLHnupHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cy9ouM1yGW3hMREEViJa2DLshacyA3d/rjpnnQ+5Aq5n+4VPcfjZUYdl1SsRhinH/
	 GdUXssSOGHNxDEUOQGH+Sv/HaU1a41bY21qlAl8oIUzTrriBf0+ncRqlzD6OgZ2eUL
	 +oU4TJMLRvsXoLEvzF6KayvgZuSKGc2vr/ijiinS2gNsIiOVjfL2iBJ5VDRQZXUJ/7
	 XbXdxk3N8OX1RuQz+6W3HwBqoKfZsp/E0lIlZB6Soy/Y5dEfWi1ggs8bYGUEyrY8e+
	 EaMw2ctQKVOuF65opBqzJILnk1cjT9WIN5r61d1FSwm4/knZbiJ7KaA6j9VmUPEXY/
	 8PDsF8vwuPuzg==
Date: Tue, 17 Dec 2024 08:33:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Martin Sperl <kernel@martin.sperl.org>, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v6 06/17] spi: dt-bindings: axi-spi-engine: add SPI
 offload properties
Message-ID: <173444599609.1628708.4430713259293370272.robh@kernel.org>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-6-88ee574d5d03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-6-88ee574d5d03@baylibre.com>


On Wed, 11 Dec 2024 14:54:43 -0600, David Lechner wrote:
> The AXI SPI Engine has support for hardware offloading capabilities.
> This includes a connection to a DMA controller for streaming RX or TX
> data and a trigger input for starting execution of the SPI message
> programmed in the offload. It is designed to support up to 32 offload
> instances.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v6 changes:
> * Drop type $ref for trigger-sources property since it is defined
>   elsewhere now
> * Undo v5 changes that limited the number of offloads to 1
> 
> v5 changes:
> * Also document offload0-tx DMA names since the hardware can support
>   that now.
> * Limit the number of offloads to 1 for now since it would require
>   significant hardware changes to actually support more than that.
> 
> v4 changes:
> * Dropped #spi-offload-cells property.
> * Changed subject line.
> 
> v3 changes:
> * Added #spi-offload-cells property.
> * Added properties for triggers and RX data stream connected to DMA.
> 
> v2 changes:
> * This is basically a new patch. It partially replaces "dt-bindings:
>   iio: offload: add binding for PWM/DMA triggered buffer".
> * The controller no longer has an offloads object node and the
>   spi-offloads property is now a standard SPI peripheral property.
> ---
>  .../bindings/spi/adi,axi-spi-engine.yaml           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


