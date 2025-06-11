Return-Path: <linux-pwm+bounces-6304-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDDAD5CCC
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 19:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7843A70B6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3D205519;
	Wed, 11 Jun 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G68faQTa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8EB5D8F0;
	Wed, 11 Jun 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661383; cv=none; b=T0MFSWnkI412JSXiE4B4oMu8f8ChZvVjZxhbzkXbiZ7oQaGbeoKTBtCVR6+Fzf0a/vE3++yHT0n6U0I5NHuznLSts3lOOW2+ZiPCyRP6X3Pxh4H8bA+V+Ya7t/3h35AFUeuocc8jaO32U68DMAoRPvzO4elkz+/jnRmApdCxbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661383; c=relaxed/simple;
	bh=G0KSz/s71VLYdbW5iDsJv1tB/CxVMgpLlLEVm+oxZo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtkbUvlNNLWAZ1KE5ANhbPnSsP2gcpupxLD0eIYHWg1Es041L9Ddy/HWPXZDbL+rpesq7Bx2a9z+53Z/knpT4Dj6eC8RPxebgHj7dl3CugCd3BWnBMrQPQAkYWE/+yfiGwcrRoO1SOCec5vpTU7GampdR7pMhAbt7OxUuuxeGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G68faQTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20889C4CEEA;
	Wed, 11 Jun 2025 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749661383;
	bh=G0KSz/s71VLYdbW5iDsJv1tB/CxVMgpLlLEVm+oxZo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G68faQTaAJPR3mXFzLQ1rT2HAVnsgMdkgBjJAyyMW6lpqhsJtie4+kEw4sgvFvfux
	 qjeUT8gUsuAjUAKc+HvlqbKAtSZMjeb2dyUSHhHHkTeNUCAuPOSQsRp6LRZDqH5w0O
	 7Qd1D861TWmBtQe+1KzVf10/L3/PSFpg2a0IR3Zl1ywgNXmQ/b1Q4MdIHRaoNq1niN
	 Jn62Rhi8zaNj7WzJtbRk9tIrtSqGEdifX1nkpgqyoXKvvdRmIdMx+sPf38P7uRgHFM
	 wCJyp86dutK8TZAWSDFSvBjqq2ASiHLPyZkGoAboc+61a/PjpPoPcjeMPOoK6MJA3l
	 hGnLI0eL98nHw==
Date: Wed, 11 Jun 2025 18:02:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] Documentation: ABI: add oversampling frequency
 in sysfs-bus-iio
Message-ID: <20250611180252.76f1fe7f@jic23-huawei>
In-Reply-To: <20250610-iio-driver-ad4052-v3-1-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-1-cf1e44c516d4@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 09:34:34 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

Trivial: 
In the patch title use the actual file name of the new ABI.

add oversampling_frequency in sysfs-bus-iio


> Some devices have an internal clock used to space out the conversion
> trigger for the oversampling filter, Consider an ADC with conversion and
> data ready pins topology:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>   ADC data ready      *       *       *       *       *
> 
> With the oversampling frequency, conversions are spaced:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>   ADC data ready         *       *       *       *       *
> 
> In some devices and ranges, this internal clock can be used to evenly
> space the conversions between the sampling edge. In other devices the
> oversampling frequency is fixed or is computed based on the sampling
> frequency parameter, and the parameter is read only.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ef52c427a015cf47bb9847782e13afbee01e9f31..e60367255be89a9acc827ec1a749b729735f60e6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hardware dependent values supported by the oversampling filter.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some devices have internal clocks for oversampling.

Wrapping on each sentence is unusual. David pointed this out in v2.
Wrap at 80 chars as a single paragraph.

> +		Sets the resulting frequency in Hz to trigger a conversion used by
> +		the oversampling filter.
> +		If the device has a fixed internal clock or is computed based on
> +		the sampling frequency parameter, the parameter is read only.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> +KernelVersion:	6.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Hardware dependent values supported by the oversampling
> +		frequency.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> 


