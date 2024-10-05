Return-Path: <linux-pwm+bounces-3499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D289918F0
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 19:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9144C1F22327
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF515884D;
	Sat,  5 Oct 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA4Chn6s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7011547FF;
	Sat,  5 Oct 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149863; cv=none; b=pzpm8+chXBSKkxc627+DtUTWsdeKpEoXnC4j+D5zTc5V+vS84YffI4UE1B/Jh6jzDtSBCS+1H9a+QgYTGiUem787pPmmx/jSmxrBYEwvrMXvcplz5+KQdCDywa+Iy3sSrVZeExTRss6xWYl8i4T1ih/OixEa+v7OjDng+IP9I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149863; c=relaxed/simple;
	bh=vjiiFuJu6wOFYX0q5xESLaDhHDPwUR8bj4MRO3SmJ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9FGQeQXqJaUjRWiREuTZ7nESFFmV2v3czrN1XppkvbuEoSQGW/ZJh7L2sNhRW4aVLCUxl36xzKUr96GJIhAiBnSQzp9pUst+B2G+er0VUIob1mN52GGqcObNPCfmYoVnVUqhhtEbIpaPsGIjsvn/L3NvYu81fw6iV/qz48aNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA4Chn6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A17C4CEC2;
	Sat,  5 Oct 2024 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728149862;
	bh=vjiiFuJu6wOFYX0q5xESLaDhHDPwUR8bj4MRO3SmJ9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FA4Chn6s+XGCtBb9qPaJxNo8pi7AhYc43uWXEJTGFWAVdKUXKo8PWdnxulu2Y6Xi1
	 0eozqzR8SVaW3SbBERfusJu/HSncS0OwPhEMrDsPNSsxgcJ0bgzA0x940itkdchPjL
	 93macIIsGQqC9E2HJPTrCzJ4T+CLlLoztTKDkyNYZdWoN6l5t7QNsgXN4YZnfM+1D7
	 huat2SpRJDWuLLKmHGAii2qiuA12dmzqRvE2crHxwBNpOarpmQ9RAjZ7YTLs6VVHFw
	 cXi9tYRZ/RpWcVZb1lnubnqb28zcRX5bS8nZAXGVSQTFDva33podlBzOy3CFRk8cfo
	 VzPqakJCEk+jQ==
Date: Sat, 5 Oct 2024 18:36:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "Mike Looijmans"
 <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] Documentation: ABI: testing: ad485x: add ABI
 docs
Message-ID: <20241005183629.6a9cd4da@jic23-huawei>
In-Reply-To: <20241004140922.233939-7-antoniu.miclaus@analog.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
	<20241004140922.233939-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 17:07:56 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the packet size.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - improve description for packet_format
>  - add kernel version
>  .../ABI/testing/sysfs-bus-iio-adc-ad485x         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> new file mode 100644
> index 000000000000..5d69a8d30383
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/packet_format_available
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Packet sizes on the CMOS or LVDS conversion data output bus.
> +		Reading this returns the valid values that can be written to the
> +		packet_format.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/packet_format
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute configures the frame size on conversion data
> +		output bus. See packet_format_available for available sizes
> +		based on the device used.
> +		Reading returns the actual size used.
This needs to give some guidance to the user on 'why' they might pick a particular
format.

I'm also inclined to suggest that for now we pick a sensible default dependent
on the other options enabled (oversampling etc) and don't expose it to the user.

Eventually it looks like we may have to figure out a solution to describe
metadata packed alongside the channel readings but that may take a while
and I don't want to stall this driver on that discussion.

Thanks,

Jonathan



