Return-Path: <linux-pwm+bounces-7091-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35462B2AFE1
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AA52A705B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144825A338;
	Mon, 18 Aug 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx/e4U8D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED62512F1;
	Mon, 18 Aug 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540182; cv=none; b=sy+fH5ODL+HYAOj7N36LqXozQItBleLpImK+yz6GvTsiYMQMObm2bp0naeDDQNmTFj+CaZQF7zmySBdys8WT5K4+Dp7tV+TyMM4n1qBYoHFIXNocWz3DZQkFZmiUkt7LaenMiwbGtw0R8E90Ku44p52pZrjcCgKlZPhv0PiKaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540182; c=relaxed/simple;
	bh=sy2HseQpuY1KFb5MS/LhskQXRTAgmW5ax8h6/mVUC44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKlT5AIa3Ez6sHnkkZZv5z0yT+yhRkhyU1dUQ5NqsngbpKKwcBEqdRFJqWAzyUwyPXctg6CAMJJvyg/tpxdK+9DrTqkKoT92HKDl6JIoIl+1ji8CFSFaZOuNblTGiPES+irrI1uXNiQrbqeY/QVd41yl3uR3RkdhLxmz+8O8WYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx/e4U8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADA7C4CEEB;
	Mon, 18 Aug 2025 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540181;
	bh=sy2HseQpuY1KFb5MS/LhskQXRTAgmW5ax8h6/mVUC44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fx/e4U8DRiek1xCuQytfjVkCExQoQ5udsEcI8KURPt/U3V/7QsGgCjEpAuTRF48dT
	 goX9Coo04WXUy1MDISIQC4TlS44hFVrxyY5SgIShjOIedNnViPNb+GcVrlPFlar4gb
	 1/oDxc/dDnyNUsA7YBihJWqV7rF6SXGlC8uO6RLD54T66Z73chiROy/CfIBhmux3n5
	 THnayOaMD0LdIXoZfCavF+4lf0UxHDdZOPhFBb8uK8KwmIssl0OXo3Oh7jFuYeAsqB
	 tPdhMyHyiJtbGx9PMp6qIcql/6Pnywj49KHYkC2/a4XYmWg/TPOwvJi/2PoYmf085J
	 qsCrmx+bjKDqQ==
Date: Mon, 18 Aug 2025 13:03:00 -0500
From: Rob Herring <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
	ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 7/8] sound: dt-bindings: ti,omap-twl4030: convert to DT
 schema
Message-ID: <20250818180300.GA1668844-robh@kernel.org>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-8-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811224739.53869-8-jihed.chaibi.dev@gmail.com>

On Tue, Aug 12, 2025 at 12:47:38AM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the OMAP TWL4030 sound card
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../bindings/sound/omap-twl4030.txt           |  62 -----------
>  .../bindings/sound/ti,omap-twl4030.yaml       | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> deleted file mode 100644
> index f6a715e4e..000000000
> --- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -* Texas Instruments SoC with twl4030 based audio setups
> -
> -Required properties:
> -- compatible: "ti,omap-twl4030"
> -- ti,model: Name of the sound card (for example "omap3beagle")
> -- ti,mcbsp: phandle for the McBSP node
> -
> -Optional properties:
> -- ti,codec: phandle for the twl4030 audio node
> -- ti,mcbsp-voice: phandle for the McBSP node connected to the voice port of twl
> -- ti, jack-det-gpio: Jack detect GPIO
> -- ti,audio-routing: List of connections between audio components.
> -  Each entry is a pair of strings, the first being the connection's sink,
> -  the second being the connection's source.
> -  If the routing is not provided all possible connection will be available
> -
> -Available audio endpoints for the audio-routing table:
> -
> -Board connectors:
> - * Headset Stereophone
> - * Earpiece Spk
> - * Handsfree Spk
> - * Ext Spk
> - * Main Mic
> - * Sub Mic
> - * Headset Mic
> - * Carkit Mic
> - * Digital0 Mic
> - * Digital1 Mic
> - * Line In
> -
> -twl4030 pins:
> - * HSOL
> - * HSOR
> - * EARPIECE
> - * HFL
> - * HFR
> - * PREDRIVEL
> - * PREDRIVER
> - * CARKITL
> - * CARKITR
> - * MAINMIC
> - * SUBMIC
> - * HSMIC
> - * DIGIMIC0
> - * DIGIMIC1
> - * CARKITMIC
> - * AUXL
> - * AUXR
> -
> - * Headset Mic Bias
> - * Mic Bias 1 /* Used for Main Mic or Digimic0 */
> - * Mic Bias 2 /* Used for Sub Mic or Digimic1 */
> -
> -Example:
> -
> -sound {
> -	compatible = "ti,omap-twl4030";
> -	ti,model = "omap3beagle";
> -
> -	ti,mcbsp = <&mcbsp2>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml b/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
> new file mode 100644
> index 000000000..3124320d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,omap-twl4030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments SoC with twl4030 based audio setups
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description:
> +  Bindings for audio setups on TI OMAP SoCs using TWL4030-family audio codec connected via a McBSP port.

Wrap lines at 80. Drop 'Bindings for'.

> +
> +properties:
> +  compatible:
> +    const: ti,omap-twl4030
> +
> +  ti,model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Name of the sound card (for example "omap3beagle").
> +
> +  ti,mcbsp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle for the McBSP node.
> +
> +  ti,codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle for the twl4030 audio node.
> +
> +  ti,mcbsp-voice:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the McBSP node connected to the voice port.
> +
> +  ti,jack-det-gpio:
> +    description: GPIO specifier for jack detection.
> +    maxItems: 1
> +
> +  ti,audio-routing:
> +    description: |
> +      A list of audio routing connections. Each entry is a pair of strings,
> +      with the first being the connection's sink and the second being the
> +      source. If not provided, all possible connections are available.
> +
> +      Available TWL4030 Pins:  "HFL", "HFR",
> +        "PREDRIVEL", "PREDRIVER", "CARKITL", "CARKITR", "MAINMIC", "SUBMIC",
> +        "HSMIC", "DIGIMIC0", "DIGIMIC1", "CARKITMIC", "AUXL", "AUXR",
> +        "Headset Mic Bias", "Mic Bias 1", "Mic Bias 2"

Is this list supposed to match the below 'CODEC Pins'? If so, then don't 
duplicate it here. If not, then I'm confused.

> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    items:
> +      enum:
> +        # Board Connectors
> +        - Headset Stereophone
> +        - Earpiece Spk
> +        - Handsfree Spk
> +        - Ext Spk
> +        - Main Mic
> +        - Sub Mic
> +        - Headset Mic
> +        - Carkit Mic
> +        - Digital0 Mic
> +        - Digital1 Mic
> +        - Line In
> +
> +        # CODEC Pins
> +        - HSOL
> +        - HSOR
> +        - EARPIECE
> +        - HFL
> +        - HFR
> +        - PREDRIVEL
> +        - PREDRIVER
> +        - CARKITL
> +        - CARKITR
> +        - MAINMIC
> +        - SUBMIC
> +        - HSMIC
> +        - DIGIMIC0
> +        - DIGIMIC1
> +        - CARKITMIC
> +        - AUXL
> +        - AUXR
> +
> +        # Headset Mic Bias
> +        - Mic Bias 1 # Used for Main Mic or Digimic0
> +        - Mic Bias 2 # Used for Sub Mic or Digimic1
> +
> +required:
> +  - compatible
> +  - ti,model
> +  - ti,mcbsp
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "ti,omap-twl4030";
> +        ti,model = "omap3beagle";
> +        ti,mcbsp = <&mcbsp2>;
> +    };
> -- 
> 2.39.5
> 

