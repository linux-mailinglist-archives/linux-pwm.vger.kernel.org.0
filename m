Return-Path: <linux-pwm+bounces-3359-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749C984DE1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 00:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D181C23EF2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD61494DC;
	Tue, 24 Sep 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUgu8IJr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE90140E30;
	Tue, 24 Sep 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217174; cv=none; b=cRCZo28CJlPjc2+ueQtzwYqv9MKLKp6GeShNqXuEGSC5JRT3oMiQ/0vVN7go5+QkXNxzDw6qFwr9my5nSWUHJTO3alqwZNd2Gl0or+cN5ZViYZSwuAGsTEJ4Rf+UuIhi7B2CGd6vEzPHxhqheRjjWgM76YeUtZc17wbM3GLKTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217174; c=relaxed/simple;
	bh=MMuFHHE8yf0thaTzhn4AnEOYyvt5BjWMgnjwJ6KAB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx8tKoLEzHXdlqZJOqzwkp4nkDG+b9u1Cz/yV+eUSU4jgFBM9EwMTOMoYOyaBPf2vfZtDJqQSJXY2kCwh0EB72c11wYdF+VEk6BC56UhFpBN4GGnM0MUa77DfB5gi+EmHrDx0PgmVKdcnbj8iMFu3TS3WD1ItKdgy52q59PTV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUgu8IJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA66C4CEC4;
	Tue, 24 Sep 2024 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727217174;
	bh=MMuFHHE8yf0thaTzhn4AnEOYyvt5BjWMgnjwJ6KAB1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUgu8IJr+Ekzzbc91nB4TXhAvZHd+gILh+QZALXrs3n7MX83hNy+x1A7twHI4XDr2
	 fqBbeShVgqHMB/Af0g0ANggVirXF6Hak/FrdeXnSgmhzCHXmSoE70zu4CsYS7LwjFi
	 1ySQHpMSHbnCf2C3iPXQ7Wmjb4+9OON4faBN0m1uGsujVZH//y7FLtdEvKsZ8nRBxY
	 VEbzylvY+eToUycMvxIVe+CDiTOi2Kf3TnWGW+53IcxfpxBem+xKPfrZn9icGWvAit
	 sujR8UvklpNmJqROJhlCVrhdEjKFf2hwg6VFg/hwrYnaY+TxWAjbm0Ky+rwwhARgc5
	 Kh2fs75iXpkIw==
Date: Tue, 24 Sep 2024 17:32:53 -0500
From: Rob Herring <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marius Cristea <marius.cristea@microchip.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: iio: adc: add ad458x
Message-ID: <20240924223253.GA408169-robh@kernel.org>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-6-antoniu.miclaus@analog.com>

On Mon, Sep 23, 2024 at 01:10:22PM +0300, Antoniu Miclaus wrote:
> Add devicetree bindings for ad458x DAS family.

typo: ad485x

Subject too.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad485x.yaml          | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> new file mode 100644
> index 000000000000..5f5bdfa9522b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.

It's 2024

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad485x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD485X DAS family device driver

What's DAS?

This is a binding, not 'device driver'. Just drop.

> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices AD485X DAS family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4858.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4858
> +      - adi,ad4857
> +      - adi,ad4856
> +      - adi,ad4855
> +      - adi,ad4854
> +      - adi,ad4853
> +      - adi,ad4852
> +      - adi,ad4851
> +      - adi,ad4858i
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply: true
> +
> +  vdd-supply: true
> +
> +  vddh-supply: true
> +
> +  vio-supply: true
> +
> +  pwms:
> +    maxItems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 100000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - vdd-supply
> +  - vddh-supply
> +  - vio-supply
> +  - pwms
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0{
> +            compatible = "adi,ad4858";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            vcc-supply = <&vcc>;
> +            vdd-supply = <&vdd>;
> +            vddh-supply = <&vddh>;
> +            vio-supply = <&vio>;
> +            pwms = <&pwm_gen 0 0>;
> +            io-backends = <&iio_backend>;
> +        };
> +    };
> +...
> -- 
> 2.46.0
> 

