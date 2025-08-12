Return-Path: <linux-pwm+bounces-7024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A3B22B31
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036D17ABBF6
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989722EF662;
	Tue, 12 Aug 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr+95pxJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FB2ED167;
	Tue, 12 Aug 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010700; cv=none; b=RJb4msvbhqbPoN4o/IpGZ++/Q/4/T+yM1Wrex7MKjrTp5Yt+k6QUKZQ/TAVDYEKZK4aVjLamk5CefKhBuuS8a5T6XbcVjdceu/vYVgtSScfz5TlPOZ3Ojs3kgBkR/XGBkvqGWsJTspFVkCHodar0DiosBGjvfD/omB0q6zDg0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010700; c=relaxed/simple;
	bh=Rk2Wv+XIInfRq7CIVjb46iopF138UdtfA0/xltArFE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/3QS+5KnLpkxCi2YL9jukYJtudEIEHS5JuDE1dhJ+MxuLGRrWRezFYP3cIdWl1Hq6Klv/JulR8haciJsRW1e55zKK6gOSvbwygjZvT1MK7gFVMr2QucQd+xUBwBiKmpI9BQPEmVX760Hz9SMgFbZFaOpgiUZBwU8VbT0IBxzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr+95pxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBACEC4CEF0;
	Tue, 12 Aug 2025 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010699;
	bh=Rk2Wv+XIInfRq7CIVjb46iopF138UdtfA0/xltArFE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gr+95pxJS+t0zEZwDxuWO4Zulu5pWboRnBN0sYvpSPCIhgPgcG0CIuNrcuV9cm2iL
	 JXGLEfoNloA76MSb80VjrzdSRHDkajmPjIDikik6T9k4H64EsfgMxesNGkiJr56TsO
	 WDGPche70euE6kocR+2vfFYyOF9rq2nI9lR/rZsImJgRG2CFUhRzuZ4p0A5kvp1nbj
	 M4JC2zibR0HLVtpO8Mv+fQbEvhNLnF7iw0fT8C1synXwh7ip2Pr7da+9FvnOnQF6bR
	 7HI4Qy2k1OknRHYiuqqRJYI+f2alQAoZpQl1cTcxIugkQ57av21FxSTnbcZJuiQqMg
	 JaWM2NsG792xA==
Date: Tue, 12 Aug 2025 09:58:18 -0500
From: Rob Herring <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
	ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 1/8] mfd: dt-bindings: ti,twl4030-audio: convert to DT
 schema
Message-ID: <20250812145818.GB3607226-robh@kernel.org>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811224739.53869-2-jihed.chaibi.dev@gmail.com>

On Tue, Aug 12, 2025 at 12:47:32AM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL4030 audio module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../bindings/mfd/ti,twl4030-audio.yaml        | 91 +++++++++++++++++++
>  .../devicetree/bindings/mfd/twl4030-audio.txt | 46 ----------

Shouldn't this move to bindings/sound/?

>  2 files changed, 91 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml b/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
> new file mode 100644
> index 000000000..16ddcf007
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,twl4030-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL4030-family Audio Module
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The audio module within the TWL4030-family of companion chips consists
> +  of an audio codec and a vibra driver. This binding describes the parent
> +  node for these functions.
> +
> +properties:
> +  compatible:
> +    const: ti,twl4030-audio
> +
> +  codec:
> +    type: object
> +    description: Node containing properties for the audio codec functionality.

       additionalProperties: false

and a blank line here.

> +    properties:
> +      ti,digimic_delay:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Delay in milliseconds after enabling digital microphones to reduce
> +          artifacts.
> +
> +      ti,ramp_delay_value:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Headset ramp delay configuration to reduce pop noise.
> +
> +      ti,hs_extmute:
> +        type: boolean
> +        description:
> +          Enable the use of an external mute for headset pop reduction.
> +
> +      ti,hs_extmute_gpio:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description:
> +          The GPIO specifier for the external mute control.
> +        maxItems: 1
> +
> +      ti,offset_cncl_path:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Offset cancellation path selection. Refer to the Technical
> +          Reference Manual for valid values.

Constraints for any of these properties?

> +
> +    # The 'codec' node itself is optional, but if it exists, it can be empty.
> +    # We don't require any of its sub-properties.
> +
> +  ti,enable-vibra:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Set to 1 to enable the vibra functionality, if missing
> +      or it is 0, the vibra functionality is disabled.

Sounds like constraints. Don't write constraints in prose.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c {
> +
> +      clock-frequency = <2600000>;

Drop. Not relevant to this binding.

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      twl: twl@48 {
> +        reg = <0x48>;
> +        interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +        interrupt-parent = <&intc>;
> +
> +        twl_audio: audio {
> +          compatible = "ti,twl4030-audio";
> +
> +          ti,enable-vibra = <1>;
> +
> +          codec {
> +            ti,ramp_delay_value = <3>;
> +          };
> +
> +        };
> +      };
> +    };

