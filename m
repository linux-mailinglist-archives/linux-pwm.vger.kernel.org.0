Return-Path: <linux-pwm+bounces-4348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F79F1F45
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F3F1888EAF
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162F1922DC;
	Sat, 14 Dec 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQMdx3QM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D27169397;
	Sat, 14 Dec 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186325; cv=none; b=SxGOdTvmAJvGSkIKKdSx8MHOfqHyDTlTbgt9i5FncT2SkTGLEbQ1JZ0HTLTolsdtD/RWr+o5JpI3NdMLBIFyqIiCZ9tNud2nE+c9xhEH3VGF8w/Cb/mfp9UDvwbEeckNKj6F1ipZibfMDhpWM2NcSQlcfEXNldkyShw5QW+G5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186325; c=relaxed/simple;
	bh=uo7FIWAio2B7yGgy0lABEYgsS8AiZPqc79yXVquOkrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuG4HM4HDXRJ2sG4c+RfBG+FSzWRYCm40L8N98naJXYbdA7PL1gzjkZlKGaqlxr7KoRsgLGCz4tEHn5fJcCbdH+HbMWCbJjeRD+KHXGbyUpBkrqG1b6xOx3Cd3aYz8HRrjdpJxWO/yChl6vCX8L42ZHxCBHwjguO9aNIhFSb2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQMdx3QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535BCC4CED1;
	Sat, 14 Dec 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186324;
	bh=uo7FIWAio2B7yGgy0lABEYgsS8AiZPqc79yXVquOkrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQMdx3QMi51nA0Rl1qxkPQMUUHSS697Pm3psyQXjjmxMKhxz2p5cUllCAOYjRo/uK
	 hqOvL59M3JnBgEnw7JjFCnBwyKlvHcN74qaEG60ObQN52nHJF/xKWJfB1bLvvGCsRz
	 q9C7FY921zBAhREk+mfcMbKR8+hLSDg8Hxkqm7gmc7+YjcJGqlU0NIZ6/xHOIAqfrW
	 IDztn4HHHVnH9og37duLJghYDbgWNBQWYfw+vl39kKn2chQWAkiPyXfgxXgeApSSOG
	 zl3wycQQVZy4fjvIDTcAeHPPHARDGYH4W7A/n6eH9q43iqh+42fGK1l96XRaOtiLU5
	 I6kYreyn9XYcg==
Date: Sat, 14 Dec 2024 14:25:11 +0000
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
Subject: Re: [PATCH v6 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Message-ID: <20241214142511.2dcdb5be@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:40 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new binding for using a PWM signal as a trigger source.
> 
> The idea here is similar to e.g. "pwm-clock" to allow a trigger source
> consumer to use a PWM provider as a trigger source.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM. But obviously this is really one for the dt-binding maintainers to look
at. With that in mind.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v6 changes:
> * Moved file from bindings/spi/ to bindings/trigger-source/
> * Updated description to not mention SPI
> * Dropped $ref: /schemas/spi/trigger-source.yaml#
> * Swapped order in name to be consistent with "pwm-clock"
> 
> v5 changes:
> * Add MAINTAINERS entry
> 
> v4 changes: new patch in v4
> ---
>  .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1eac20031dc3cf921aafb8aa37f4e4eca1075835
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/trigger-source/pwm-trigger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic trigger source using PWM
> +
> +description: Remaps a PWM channel as a trigger source.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +properties:
> +  compatible:
> +    const: pwm-trigger
> +
> +  '#trigger-source-cells':
> +    const: 0
> +
> +  pwms:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#trigger-source-cells'
> +  - pwms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    trigger {
> +        compatible = "pwm-trigger";
> +        #trigger-source-cells = <0>;
> +        pwms = <&pwm 0 1000000 0>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9284a257607a740ab7f6fd960c2bcdc34ead7586..b2aa6f37743e48353c60e5973ea8126590c7f6d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23879,6 +23879,11 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> +TRIGGER SOURCE - PWM
> +M:	David Lechner <dlechner@baylibre.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> +
>  TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-coco@lists.linux.dev
> 


