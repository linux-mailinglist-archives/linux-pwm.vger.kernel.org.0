Return-Path: <linux-pwm+bounces-3495-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7B9918B2
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A71C2117E
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3843A158A26;
	Sat,  5 Oct 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubiCVxUB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03648158853;
	Sat,  5 Oct 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148110; cv=none; b=C6WFtdWdkmsMYTYSJVABb4FGt4X4Vqzz+xNIBir9VpuJdOxL4Crr0jsJaKDZ4B5zx6daV7ixxNZMYV9ekiptp1h/2t8cTU4X6RkJpd836BUhiitHs2uwJjJOgpUIvjdykbrmDfLm3t0EfunsdhejKmYOt8YXM+G6aVJgceF6rUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148110; c=relaxed/simple;
	bh=lsB2/Q+JVrRpb67mW4wDQ6vGMOMp9q70CnIF94930KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZriLPkBoq/3ow5jEFPrdHxbA0O5gtoCJ0p8JaNTooBsKSIc68g1BoJ1aLZ6aMvO9NEvDkB7KYFrSnro/Zf1aSrFcVRwXPiRHKY8dKbajwxOOCUHkMQqoQg+q6NQwVZHnYnyQJ5gxVyW1gfFUb0pHfz5FjzqlcB4Z9HhuMEshWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubiCVxUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C729FC4CEC2;
	Sat,  5 Oct 2024 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728148109;
	bh=lsB2/Q+JVrRpb67mW4wDQ6vGMOMp9q70CnIF94930KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ubiCVxUBFDJtPtRKJEXC3Lve8z/P9JB4jc7O65Iw7ATvad5I2W5oRhJEMv70IQaRA
	 xQPhv+H9MKnPud+y4X83QeFfI9gfQQCEwnOr6CmhK+8/3Xt9IddIHUqZ0QxvFAcl2E
	 x6w370oeeuOKTbC9BExsdsKYFLl1MAUFQCLNXZE1VwruqJ6uWFIDTdpveXQuwp0ZHd
	 QQd0WfcLMQrQP/KPmPvhMA6KK1v2xCbQzVd8hVblRiBRPDPsVoeZp1t8Fz2wyy9nU+
	 vzKvP8GkGXRvK/UaGIBRklrlJi6Tg1zNAb2ZUova9H/HALXCUlyOPuo0M6bnqgsK9I
	 KXLte205iuasQ==
Date: Sat, 5 Oct 2024 18:07:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: adc: add ad485x
Message-ID: <20241005180717.345257e4@jic23-huawei>
In-Reply-To: <20241004140922.233939-5-antoniu.miclaus@analog.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
	<20241004140922.233939-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 17:07:54 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings for ad485x family.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

Trivial stuff inline to add to David's review.

Jonathan

> ---
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> new file mode 100644
> index 000000000000..899a65504f12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad485x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD485X family
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices AD485X family

Give us some more idea of what these are.  Brief paragraph or two is fine giving
some key characteristics of these ADCs.  Whilst we know they are ADCs from
the path, maybe good to mention that :)


> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4858.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4857.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4856.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4855.pdf
Numeric order probably better than the reverse.

> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#


