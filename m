Return-Path: <linux-pwm+bounces-3388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA359890D9
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8713B210F2
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48E13E40F;
	Sat, 28 Sep 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avD62nzb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DB4A1B;
	Sat, 28 Sep 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544769; cv=none; b=Gdb8Ef4Y/+0wZ42Tdn6FucrEZNEXAlqYqDI1aJh5ulklJ2rLb2AHQba+V6kw1jsmBKFsELt9tTs0MAJC3Zysxup9e7PWv8Uj8Dot4UFChHiAF6Jz4TUhQvRJF0mWJVh/8Lgw1V0mQStcbXRySf3w8yRLbC0KZRRO90L3T4myfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544769; c=relaxed/simple;
	bh=bCNr87d8nTJmMd7uX/KhhvvDPdq6d8BT+C3RLl0xdq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9pzppj6Dz2J40fe90mydHo3oLc7BwMn7APg4lorNc0kwY3HQFqpe9EhaqdNHmzwIqFa4Rvov0jU9ODRsx3HtwOJoFWDyMo0CF1yZBEeSxMQ7n44UHNBemk2pXFXv+7dkfQNrPz/FIyfXtI++wWjHSwexgH2k7XktcWBFoGfjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avD62nzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC616C4CEC3;
	Sat, 28 Sep 2024 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544768;
	bh=bCNr87d8nTJmMd7uX/KhhvvDPdq6d8BT+C3RLl0xdq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=avD62nzbRLxgzsLPXGWlLMBj/UklUB8dFnt1hXJRUlA1GhCOrw2MPNIMwqxP/1HgF
	 aRHcfbcRJe/KlEQe8XQHodz2pIUr/PLsRcww+OU2mivCVIatRIA+fmV2IflIaakwyK
	 FW/SfBfFRKGAadOqp2r9v2dKBM2nJyxXPgOkCvbIoIwhgYJSiriPJaweeDhsjSRtO/
	 v62WOZqd2nZcIlVVYad5njB2eeNFwJ3AT9ufOUWJ2aQEDgxPW9SOpY+Fcm9HYNNR5U
	 fLFuG5tBHIcA6O7lez8x6TajWMi+XuzKn5WqUbDiSHe/o/jqJuZ+weQvsPJTCGRgeO
	 hyfyFaalx1kjQ==
Date: Sat, 28 Sep 2024 18:32:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dh?=
 =?UTF-8?B?bHZlcw==?= <joao.goncalves@toradex.com>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 7/7] Documentation: ABI: testing: ad485x: add ABI docs
Message-ID: <20240928183235.6fbc4bd4@jic23-huawei>
In-Reply-To: <20240923101206.3753-8-antoniu.miclaus@analog.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-8-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 13:10:24 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the packet size.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> new file mode 100644
> index 000000000000..80aaef4eb750
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/packet_format_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Packet sizes on the CMOS or LVDS conversion data output bus.
> +		Reading this returns the valid values that can be written to the
> +		packet_format.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/packet_format
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute configures the packet size.
> +		Reading returns the actual size used.
This was touched upon by David's review of the driver.
These docs tell us nothing useful unfortunately so a user would have
no idea how to set them...



