Return-Path: <linux-pwm+bounces-4139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8F9D76C9
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B862838C3
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABF76026;
	Sun, 24 Nov 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktZ/kAV1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E622500C7;
	Sun, 24 Nov 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469909; cv=none; b=GNlFpVpOkkl7shoOvfWE8QQTVW8OjTG93ZtFOAPSnuHsB3oppfV0Jir9NS0fMry+P6O++IRvIsdQogOfMcNJgVu1W4Qy/9dD3OAHX22/4Zsvytn8hksXOJ05ap/4oo1aM2HTXkhHmK3mZ/lyy2fjUHfMFFcHWNjx8d+QNUsjtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469909; c=relaxed/simple;
	bh=2u13NQ7J6VXWBF2VazhwstoZDCg5yJnOa4ZwoATCQ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfOwGvkoeekxlSxwJAhAg+zEh72bpPBHcXideINClzHRBtpLI9EZDUgFcxIvhOWWc6LXSZV1HbEr3n7TRB3QeEIEljPWvocSbIhYSpMSkME0bG/UaOy/jrvlRgbaKPecE64fVAD17iot5b9GAiN7GFzbl4PH+TEvDSEDL7cXvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktZ/kAV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3175C4CECC;
	Sun, 24 Nov 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469908;
	bh=2u13NQ7J6VXWBF2VazhwstoZDCg5yJnOa4ZwoATCQ4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ktZ/kAV1WydFWue7C2v0tHKXMIUBS7MwUSYXNxe4s2uOkWCXALQzt59tRhAa8brK2
	 12VK4z/Q+EbiiP/4XbiprwqZeSR+LmGBMjF+PnUsFNqZR3GoHrPe9DJ8BG4qt7SFlY
	 NHBHUjUVIhTUiEMkoEZtxiR6Iobgn1Ff+KFqQB79YnuDhTUxe0XMp4G6pu09LVhLvB
	 cZ+7QaTC8bkNirKNrDLMhzj9A2Z05LmqHZOA3B3xDpmSqP6lTibOCA3hE+0gh9E4dH
	 SvGl7x9I8E8OkZyNo2O5sxojRA8WCjozb17CNBQ6+rPOFVYeI6I6drnP7wFXLrX0aM
	 IDrCaIqb0y1OQ==
Date: Sun, 24 Nov 2024 17:38:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 16/16] doc: iio: ad4695: add SPI offload support
Message-ID: <20241124173819.224b5940@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-16-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-16-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:55 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Document SPI offload support for the ad4695 driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes: new patch in v5
> ---
>  Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
> index 9ec8bf466c15..8009a0c272bc 100644
> --- a/Documentation/iio/ad4695.rst
> +++ b/Documentation/iio/ad4695.rst
> @@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
>  To use this mode, in the device tree, omit the ``cnv-gpios`` and
>  ``spi-rx-bus-width`` properties.
>  
> +SPI offload wiring
> +^^^^^^^^^^^^^^^^^^
> +
> +When used with a SPI offload, the supported wiring configuration is:
> +
> +.. code-block::
> +
> +    +-------------+         +-------------+
> +    |    GP0/BUSY |-------->| TRIGGER     |
> +    |          CS |<--------| CS          |
> +    |             |         |             |
> +    |     ADC     |         |     SPI     |
> +    |             |         |             |
> +    |         SDI |<--------| SDO         |
> +    |         SDO |-------->| SDI         |
> +    |        SCLK |<--------| SCLK        |
> +    |             |         |             |
> +    |             |         +-------------+
> +    |         CNV |<-----+--| PWM         |
> +    |             |      +--| GPIO        |
> +    +-------------+         +-------------+
> +
> +In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
> +The ``#trigger-source-cells = <2>`` property is also required to connect back
> +to the SPI offload. The SPI offload will have ``trigger-sources`` property
> +with cells to indicate the busy signal and which GPx pin is used, e.g
> +``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
> +
> +.. seealso:: `SPI offload support`_
> +
>  Channel configuration
>  ---------------------
>  
> @@ -158,6 +188,27 @@ Unimplemented features
>  - GPIO support
>  - CRC support
>  
> +SPI offload support
> +===================
> +
> +To be able to achieve the maximum sample rate, the driver can be used with the
> +`AXI SPI Engine`_ to provide SPI offload support.
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> +
> +.. seealso:: `SPI offload wiring`_
> +
> +When SPI offload is being used, some attributes will be different.
> +
> +* ``trigger`` directory is removed.
> +* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
> +  rate.
> +* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
> +  the max sample rate.
> +* ``timestamp`` channel is removed.
> +* Buffer data format may be different compared to when offload is not used,
> +  e.g. the ``in_voltage0_type`` attribute.
> +
>  Device buffers
>  ==============
>  
> @@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
>  sequencer" feature of the chip to trigger a burst of conversions.
>  
>  Also see :doc:`iio_devbuf` for more general information.
> +
> +Effective sample rate for buffered reads
> +----------------------------------------
> +
> +When SPI offload is not used, the sample rate is determined by the trigger that
> +is manually configured in userspace. All enabled channels will be read in a
> +burst when the trigger is received.
> +
> +When SPI offload is used, the sample rate is configured per channel. All
> +all channels will have the same rate, so only one ``sampling_frequency``
Double all.
> +attribute needs to be set. Since this rate determines the delay between each
> +individual conversion, the effective sample rate for each sample is actually
> +the sum of the periods of each enabled channel in a buffered read. In other
> +words, it is the value of the ``sampling_frequency`` attribute divided by the
> +number of enabled channels. So if 4 channels are enabled, with the
> +``sampling_frequency`` attributes set to 1 MHz, the effective sample rate is
> +250 kHz.
If you are exposing that as a single sampling_frequency I think we should be
adjusting the frequency so it represents the same thing in both modes.

So divide by the number of channels (conversely run faster if more channels
enabled).

Jonathan
> 


