Return-Path: <linux-pwm+bounces-3030-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E66955895
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8618C282631
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2B1509A5;
	Sat, 17 Aug 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6Wa0RzT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1181494DC;
	Sat, 17 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907641; cv=none; b=FRWRS0uJVE570whBrL26aQejq3BP2HcwaxwcBA21fqqFraoFhjXy6iSh+bMLB57zih6sIWtJpoBfgl48IE0hShjP/x+mj/EaZse0OMcBSs21KQ2Xml3b7FKgUxF8SJS5fbYsaPxQ8w/HdCtk461UKrYZbyk+/QsmfRTWLgjsFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907641; c=relaxed/simple;
	bh=jlh8YQOzcxvQeTjYCF15meBYhlr8C79cP3mOrCILxTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdyVjwQz2L3EJMBZSrVnGK5CqmxPxZsgp5WrGIma2O+Z1/imdP7QC98bb4pSQQfuGq4zs8X4z/6Jf9pJfSc2fiEmbDbu3jWudNER1TifSOwWO6UOGYlzi3uVmodG8xH3VQdn2pX/YSimY+H06IkhYkLqfnBpWPJJ9LGWbs0S96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6Wa0RzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A67C4AF0D;
	Sat, 17 Aug 2024 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723907641;
	bh=jlh8YQOzcxvQeTjYCF15meBYhlr8C79cP3mOrCILxTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o6Wa0RzTpG0OPlZryM9o6iYr22P5kQkxjHGSb21jVtkugSC7trOnSi3A0TU85UmNa
	 FOCK7Gk020NdnNsUNqY7VHC6nNh7hRCDj+5Ohv8YLIVosNhDbCgfJLuDfe7xE99aR2
	 ruc3H74tigFtomGAUlYbP2uyC429rKgM82EJVHeKSk/3bAdRxTC7gpzQ6j0uGcH0fu
	 +cu2banvmG4Mdywkb+Ri+S/YcFP3sz2zUOWls75tpQsXasbtVzwUPYVzqskXTsNM4O
	 KLT6afmm7P3jD9WXV0/fD8i6/LES5Wf4r2vv7l/1TyrHaX1gpADvChwi0n3ltUqefw
	 7DF9Sy8tKIzcQ==
Date: Sat, 17 Aug 2024 16:13:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 3/8] Documentation: iio: Document ad7606 driver
Message-ID: <20240817161352.61661418@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-3-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-3-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:11:57 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The Analog Devices Inc. AD7606 (and similar chips) are complex ADCs that
> will benefit from a detailed driver documentation.
> 
> This documents the current features supported by the driver.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
A few typos that I spotted, but other than that lgtm
> ---
>  Documentation/iio/ad7606.rst | 142 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/Documentation/iio/ad7606.rst b/Documentation/iio/ad7606.rst
> new file mode 100644
> index 000000000000..e9578399e80d
> --- /dev/null
> +++ b/Documentation/iio/ad7606.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD7606 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD7606 and similar devices. The module name
> +is ``ad7606``.
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD7605 <https://www.analog.com/en/products/ad7605.html>`_
> +* `AD7606 <https://www.analog.com/en/products/ad7606.html>`_
> +* `AD7606B <https://www.analog.com/en/products/ad7606b.html>`_
> +* `AD7616 <https://www.analog.com/en/products/ad7616.html>`_
> +
> +Supported features
> +==================
> +
> +SPI wiring modes
> +----------------
> +
> +ad7606x ADCs can output data on several SDO lines (1/2/4/8). The driver
> +currently supports only 1 SDO line.
> +
> +Parallel wiring mode
> +--------------------
> +
> +AD7606x ADC have also a parallel interface, with 16 lines (that can be reduced
> +to 8 in byte mode). The parallel interface is selected by declaring the device
> +as platform in the device tree (with no io-backends node defined, see below).
> +
> +IIO-backend mode
> +----------------
> +
> +This mode allows to reach the best sample rates, but it requires an external
> +hardware (eg HDL or APU) to handle the low level communication.
> +The backend mode is enabled when trough the definition of the "io-backends"

through.  Spell check in general as I'm bad at spotting these.

> +property in the device tree.
> +The reference configuration for the current implementation of IIO-backend mode
> +is the HDL reference provided by ADI:
> +https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl
> +This implementation embeds an IIO-backend compatible IP (adi-axi-adc) and a PWM
> +connected to the conversion trigger pin.
> +
> ++---+                                       +----------------------------
> +|   |               +-------+               |AD76xx
> +| A |  controls     |       |               |
> +| D |-------------->|  PWM  |-------------->| cnvst
> +| 7 |               |       |               |
> +| 6 |               +-------+               |
> +| 0 | controls  +-----------+------------   |
> +| 6 |---------->|           |           |<--| frstdata
> +|   |           | Backend   |  Backend  |<--| busy
> +| D |           | Driver    |           |   |
> +| R |           |           |           |-->| clk
> +| I |  requests |+---------+| DMA       |   |
> +| V |----------->|  Buffer ||<----      |<=>| DATA
> +| E |           |+---------+|           |   |
> +| R |           +-----------+-----------+   |
> +|   |-------------------------------------->| reset/configuration gpios
> ++---+                                       +-----------------------------
> +
> +
> +Software and hardware modes
> +---------------------------
> +
> +While all the AD7606 series parts can be configured using GPIOs, some of them
> +can be configured using register.

I'd add blank lines between paragraphs as makes it easier to read as text

> +The chip that support software mode have more values avalaible for configuring

available

> +the device, as well as more settings, and allow to control the range and
> +calibration per channel.
> +The following settings are available per channel in software mode:
> + - Scale
> +Also, there is a broader choice of oversampling ratios in software mode.
> +
> +Conversion triggering
> +---------------------
> +
> +The conversion can be triggered by two distinct ways:
> +
> + - A GPIO is connected to the conversion trigger pin, and this GPIO is controlled
> +   by the driver directly.  In this configuration, the driver set back the
the driver sets back

> +   conversion trigger pin to high as soon as it has read all the conversions.
> +
> + - An external source is connected to the conversion trigger pin. In the
> +   current implementation, it must be a PWM. In this configuration, the driver
> +   does not control directly the conversion trigger pin. Instead, it can
> +   control the PWM's frequency. This trigger is enabled only for iio-backend.
> +
> +Reference voltage
> +-----------------
> +
> +2 possible reference voltage sources are supported:
> +
> + - Internal reference (2.5V)
> + - External reference (2.5V)
> +
> +The source is determined by the device tree. If ``refin-supply`` is present,
> +then the external reference is used, else the internal reference is used.
> +
> +Oversampling
> +------------
> +
> +This family supports oversampling to improve SNR.
> +In software mode, the following ratios are available:
> +1 (oversampling disabled)/2/4/8/16/32/64/128/256.
> +
> +Unimplemented features
> +----------------------
> +
> +- 2/4/8 SDO lines
> +- CRC indication
> +- Calibration
> +
> +Device buffers
> +==============
> +
> +IIO triggered buffer
> +--------------------
> +
> +This driver supports IIO triggered buffers, with a "built in" trigger, i.e the
> +trigger is allocated and linked by the driver, and a new conversion is triggered
> +as soon as the samples are transferred, and a timestamp channel is added to make
> +up for the potential jitter induced by the delays in the interrupt handling.
> +
> +IIO backend buffer
> +------------------
> +
> +When IIO backend is used, the trigger is not needed, and the sample rate is
> +considered as stable, hence there is no timestamp channel. The communication is
> +delegated to an external logic, called a backend, and the backend's driver
> +handles the buffer. When this mode is enabled, the driver cannot control the
> +conversion pin, because the busy pin is bound to the backend.
> +
> +
> +
> +
> +
Drop this trailing whitespace.

> 


