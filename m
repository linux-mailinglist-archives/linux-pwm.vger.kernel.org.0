Return-Path: <linux-pwm+bounces-3078-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F7F96A2D2
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 17:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECD9B203B4
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA313E41A;
	Tue,  3 Sep 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRnJd7Zs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76412B94;
	Tue,  3 Sep 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377640; cv=none; b=j3c//DyihdRRPrsb7WuOqRBKAfEIN/Ec3XHqFjmlTowS2kxCteoShl9rZjqcSZGpYUnPYVXjOpm0OJFfuxq/eSg156Nsd952mMlN3lnK02RD+LJqmJSAb0wKX2VDMxPodQdD/Em3bp2qliO2ThtoqZMcAhH8bSDAVV/oXa+DqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377640; c=relaxed/simple;
	bh=ACsj0l+2UVfRxDV7jR+nkjUSIPe5eAHlHqzxtK9MgxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ2XegHowzagBuB8tlzbVbLvFCk3ZGnckBCpJysh9xmssX2allRCyx5XZ/g0+HI6Mkl8xoSrNAL0TqNcK18+0A9TIzWm9xjRVWkUjdatf6P8KFdN/K5c565+y8V0OvxIwxRvxHemC0UJL6w693c6mkJCIWIBdp8pvBBGDEymRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRnJd7Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911FDC4CEC4;
	Tue,  3 Sep 2024 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377639;
	bh=ACsj0l+2UVfRxDV7jR+nkjUSIPe5eAHlHqzxtK9MgxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRnJd7ZsCHhZ63y8ffut2gcmMjzeajaOqH/t/PDG6bPBtnvtSgg+rIt7UV07jcOhm
	 SewvAgJ947ex5ehM9SbRMgWHUTCXTVF4kwkY0RUCGGpN4CV0NS2fhMYcKQn5aOcNgx
	 h7SXR6COZ9zZWAwpTBKYumWci4Of+u0W+efk6YBuS3ldEVnCw5gxNN6yx3vq8nREN7
	 JpUs1Xo4dMXQog8ZTUpI9v37gI4f6EnA+QIxrLeBEfcOuFrE5z1T6Kg6iUvxVPnk/Y
	 U1FhdefJJO9qddqA9j7FXcHuNy2RGGMAeJddyw7UYNmVw8MKI+VOiwohtdaZWAoxS0
	 jisQ/QS2r2VsQ==
Date: Tue, 3 Sep 2024 16:33:53 +0100
From: Lee Jones <lee@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Message-ID: <20240903153353.GZ6858@google.com>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-2-98eebfb4da66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831-en7581-pinctrl-v3-2-98eebfb4da66@kernel.org>

On Sat, 31 Aug 2024, Lorenzo Bianconi wrote:

> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC.
> 
> Schema define cells for both gpio/interrupt controller and PWM.
> Moreover it provides a dedicated pinctrl node for pins and config
> definitions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
>  1 file changed, 433 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> new file mode 100644
> index 000000000000..a9080c7f50f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> @@ -0,0 +1,433 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/airoha,en7581-gpio-sysctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 GPIO System Controller
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  Airoha EN7581 SoC GPIO system controller which provided a register map
> +  for controlling the GPIO, pins and PWM of the SoC.

This whole thing is just about pins.

The MFD portion of this submission doesn't do anything.

Please rework this to omit the MFD driver.

After just a glance, it looks like simple-mfd _might_ work.

> +properties:
> +  compatible:
> +    const: airoha,en7581-gpio-sysctl
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  pinctrl:
> +    type: object
> +
> +    $ref: /schemas/pinctrl/pinctrl.yaml
> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +
> +        patternProperties:
> +          '^.*mux.*$':
> +            type: object
> +
> +            description:
> +              pinmux configuration nodes.
> +
> +            $ref: /schemas/pinctrl/pinmux-node.yaml
> +
> +            properties:
> +              function:
> +                description:
> +                  A string containing the name of the function to mux to the group.
> +                enum: [pon, tod_1pps, sipo, mdio, uart, i2c, jtag, pcm, spi,
> +                       pcm_spi, i2s, emmc, pnand, pcie_reset, pwm, phy1_led0,
> +                       phy2_led0, phy3_led0, phy4_led0, phy1_led1, phy2_led1,
> +                       phy3_led1, phy4_led1]
> +
> +              groups:
> +                description:
> +                  An array of strings. Each string contains the name of a group.
> +
> +            required:
> +              - function
> +              - groups
> +
> +            allOf:
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pon
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [pon]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: tod_1pps
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [pon_tod_1pps, gsw_tod_1pps]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: sipo
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [sipo, sipo_rclk]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: mdio
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [mdio]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: uart
> +                then:
> +                  properties:
> +                    groups:
> +                      items:
> +                        enum: [uart2, uart2_cts_rts, hsuart, hsuart_cts_rts, uart4,
> +                               uart5]
> +                      maxItems: 2
> +              - if:
> +                  properties:
> +                    function:
> +                      const: i2c
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [i2c1]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: jtag
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [jtag_udi, jtag_dfd]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pcm
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [pcm1, pcm2]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: spi
> +                then:
> +                  properties:
> +                    groups:
> +                      items:
> +                        enum: [spi_quad, spi_cs1]
> +                      maxItems: 2
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pcm_spi
> +                then:
> +                  properties:
> +                    groups:
> +                      items:
> +                        enum: [pcm_spi, pcm_spi_int, pcm_spi_rst, pcm_spi_cs1,
> +                               pcm_spi_cs2_p156, pcm_spi_cs2_p128, pcm_spi_cs3,
> +                               pcm_spi_cs4]
> +                      maxItems: 7
> +              - if:
> +                  properties:
> +                    function:
> +                      const: i2c
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [i2s]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: emmc
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [emmc]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pnand
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [pnand]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pcie_reset
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [pcie_reset0, pcie_reset1, pcie_reset2]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: pwm
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6,
> +                             gpio7, gpio8, gpio9, gpio10, gpio11, gpio12, gpio13,
> +                             gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
> +                             gpio20, gpio21, gpio22, gpio23, gpio24, gpio25,
> +                             gpio26, gpio27, gpio28, gpio29, gpio30, gpio31,
> +                             gpio36, gpio37, gpio38, gpio39, gpio40, gpio41,
> +                             gpio42, gpio43, gpio44, gpio45, gpio46, gpio47]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy1_led0
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio33, gpio34, gpio35, gpio42]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy2_led0
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio33, gpio34, gpio35, gpio42]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy3_led0
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio33, gpio34, gpio35, gpio42]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy4_led0
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio33, gpio34, gpio35, gpio42]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy1_led1
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio43, gpio44, gpio45, gpio46]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy2_led1
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio43, gpio44, gpio45, gpio46]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy3_led1
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio43, gpio44, gpio45, gpio46]
> +              - if:
> +                  properties:
> +                    function:
> +                      const: phy4_led1
> +                then:
> +                  properties:
> +                    groups:
> +                      enum: [gpio43, gpio44, gpio45, gpio46]
> +
> +            additionalProperties: false
> +
> +          '^.*conf.*$':
> +            type: object
> +
> +            description:
> +              pinconf configuration nodes.
> +
> +            $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +            properties:
> +              pins:
> +                description:
> +                  An array of strings. Each string contains the name of a pin.
> +                items:
> +                  enum: [uart1_txd, uart1_rxd, i2c_scl, i2c_sda, spi_cs0, spi_clk,
> +                         spi_mosi, spi_miso, gpio0, gpio1, gpio2, gpio3, gpio4,
> +                         gpio5, gpio6, gpio7, gpio8, gpio9, gpio10, gpio11, gpio12,
> +                         gpio13, gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
> +                         gpio20, gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
> +                         gpio27, gpio28, gpio29, gpio30, gpio31, gpio32, gpio33,
> +                         gpio34, gpio35, gpio36, gpio37, gpio38, gpio39, gpio40,
> +                         gpio41, gpio42, gpio43, gpio44, gpio45, gpio46,
> +                         pcie_reset0, pcie_reset1, pcie_reset2]
> +                minItems: 1
> +                maxItems: 58
> +
> +              bias-disable: true
> +
> +              bias-pull-up: true
> +
> +              bias-pull-down: true
> +
> +              input-enable: true
> +
> +              output-enable: true
> +
> +              output-low: true
> +
> +              output-high: true
> +
> +              drive-open-drain: true
> +
> +              drive-strength:
> +                description:
> +                  Selects the drive strength for MIO pins, in mA.
> +                enum: [2, 4, 6, 8]
> +
> +            required:
> +              - pins
> +
> +            additionalProperties: false
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mfd@1fbf0200 {
> +        compatible = "airoha,en7581-gpio-sysctl";
> +        reg = <0x1fbf0200 0xc0>;
> +
> +        interrupt-parent = <&gic>;
> +        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        #pwm-cells = <3>;
> +
> +        pinctrl {
> +            pcie1-rst-pins {
> +                conf {
> +                    pins = "pcie_reset1";
> +                    drive-open-drain = <1>;
> +                };
> +            };
> +
> +            pwm-pins {
> +                mux {
> +                    function = "pwm";
> +                    groups = "gpio18";
> +                };
> +            };
> +
> +            spi-pins {
> +                mux {
> +                    function = "spi";
> +                    groups = "spi_quad", "spi_cs1";
> +                };
> +            };
> +
> +            uart2-pins {
> +                mux {
> +                    function = "uart";
> +                    groups = "uart2", "uart2_cts_rts";
> +                };
> +            };
> +
> +            uar5-pins {
> +                mux {
> +                    function = "uart";
> +                    groups = "uart5";
> +                };
> +            };
> +
> +            mmc-pins {
> +                mux {
> +                    function = "emmc";
> +                    groups = "emmc";
> +                };
> +            };
> +
> +            mdio-pins {
> +                mux {
> +                    function = "mdio";
> +                    groups = "mdio";
> +                };
> +
> +                conf {
> +                    pins = "gpio2";
> +                    output-enable;
> +                };
> +            };
> +
> +            gswp1-led0-pins {
> +                mux {
> +                    function = "phy1_led0";
> +                    groups = "gpio33";
> +                };
> +            };
> +
> +            gswp2-led1-pins {
> +                mux {
> +                    function = "phy2_led1";
> +                    groups = "gpio44";
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.46.0
> 

-- 
Lee Jones [李琼斯]

