Return-Path: <linux-pwm+bounces-3392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFD98955E
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AF128477C
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42D176FA4;
	Sun, 29 Sep 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdAUGoPy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C111F60A;
	Sun, 29 Sep 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613239; cv=none; b=ceEsb+cD9vWr6SUm8ye9VuNWSe4M2jRmRugZE8gFlXf9bTcVIQe5xgq3AaDTvQIxrmUU+2LD5S5yfboaPNkvU9VlNwaoyC/Z3AdbCMT+2IqYRxjHLxfKHyUufreC4iVlktCn+RuGPs4BIBldfSsen86F0jjLc590nJtRkW3k7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613239; c=relaxed/simple;
	bh=m9jug3OP8l8FVECXIbmoVaRIsoH8SM7c/hUNLwCBhS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDse/IAysDCPsmt/TqYDatIbXPSArFA12VXUJ0jgaCH6JG8DsCCE3Q82BKD1p1dh3adMgz+9Xl1WYz658xLezEo3z4uWTjMMCLCaz9mAvAK2ZLnmhXmUp9CXFO49PZVa87bKFYYgT8NX3ZAwTZaxA4E7m0JPo6GOPVfCXRnqhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdAUGoPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76671C4CEC5;
	Sun, 29 Sep 2024 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727613239;
	bh=m9jug3OP8l8FVECXIbmoVaRIsoH8SM7c/hUNLwCBhS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdAUGoPyH+WJvp4wtNTy6q0GbC364GEhuh5C5Rjq2TjKZhJraVPPT87aqhnfm6rb4
	 x46mmQ979OvJVFFNmeLnyLHfLLylpohdPtBm/eNfhMpzdRzhnNAWnmUa7G0Onw0Hue
	 QyPtUpqUsxtlX4XM7E1FkVdWAC8ZVHHM6og7fGEOF5dR2CfR4qW912oSaYsETAZk4d
	 yytYS6x2PbWNPjKVOCs5yT1UNS9P1hX2hL1FoasEHqSNBwb00wdl+V2PBAamnjEZ12
	 w/G/MtbLb7+zIkNIPCEAHtSO2zBCQqb7NihbVPTpYmDUsVsM9kmRoCJQzdTHZlBAu7
	 5d2O/nVrvd6fg==
Date: Sun, 29 Sep 2024 13:33:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek
 <mmarek@suse.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 04/10] Documentation: iio: Document ad7606 driver
Message-ID: <20240929133349.50f7f510@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-4-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-4-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:24 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The Analog Devices Inc. AD7606 (and similar chips) are complex ADCs that
> will benefit from a detailed driver documentation.
> 
> This documents the current features supported by the driver.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  Documentation/iio/ad7606.rst | 143 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/Documentation/iio/ad7606.rst b/Documentation/iio/ad7606.rst
> new file mode 100644
> index 000000000000..270a49aae685
> --- /dev/null
> +++ b/Documentation/iio/ad7606.rst
> @@ -0,0 +1,143 @@
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

If intent here is AD7606 and AD7606B only as covered by that wildcard, then
I'd just state them both explicitly.  If the others are intended that wildcard
is wrong.  If it's all of them, just say These ADCs

> +to 8 in byte mode). The parallel interface is selected by declaring the device
> +as platform in the device tree (with no io-backends node defined, see below).
> +
> +IIO-backend mode
> +----------------
> +
> +This mode allows to reach the best sample rates, but it requires an external
> +hardware (eg HDL or APU) to handle the low level communication.
> +The backend mode is enabled when through the definition of the "io-backends"
> +property in the device tree.
> +
> +The reference configuration for the current implementation of IIO-backend mode
> +is the HDL reference provided by ADI:
> +https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl
> +
> +This implementation embeds an IIO-backend compatible IP (adi-axi-adc) and a PWM
> +connected to the conversion trigger pin.
> +
> ++---+                                       +----------------------------
> +|   |               +-------+               |AD76xx
> +| A |  controls     |       |               |
> +| D |-------------->|  PWM  |-------------->| cnvst
> +| 7 |               |       |               |
> +| 6 |               +-------+               |
> +| 0 | controls  +-----------+-----------+   |
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

I think we should introduce an annual award for best kernel ASCII art.
This one is nice.

> +IIO backend buffer
> +------------------
> +
> +When IIO backend is used, the trigger is not needed, and the sample rate is
> +considered as stable, hence there is no timestamp channel. 

That's a dodge I think.  There is no timestamp because we have no way to insert
one into the DMA buffer!  I'd drop the hence
"stable.  There is no timestamp channel."


> The communication is
> +delegated to an external logic, called a backend, and the backend's driver
> +handles the buffer. When this mode is enabled, the driver cannot control the
> +conversion pin, because the busy pin is bound to the backend.
> +

Nice docs in general.

Jonathan



