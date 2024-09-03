Return-Path: <linux-pwm+bounces-3079-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1996A311
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BEF1C20F32
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7D14F9D6;
	Tue,  3 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+zGHBMj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D157CB1;
	Tue,  3 Sep 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378221; cv=none; b=hCz0WKDCdsS7AR3O/SMjum34ix9vUz9cZvSdC76+LFF+hJ0rYrcE99/tRtDQXVR4vRQM17y5L6THMskB1Psirhm99EjGfGHDv0Tqa672sfWq3gayTA989kyfELPxMznm6O6bESQkNIQkhIlqZRUXJLqWrfrmKCZbMTivuFHh2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378221; c=relaxed/simple;
	bh=W2g8RyQFlnvEunaqIfLEMxYWuGWBcrIG3VsTVNdn96k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M04PdpHJQDHQz1CQfM22GCadfEKqBB4nYsdZ1INJbxwFVbFOozQiJ4SjARfIvwvpEORBzZdHaoCaRIQQ6e4RcRlyY+m/RacuOOZRJ1apb+meL9BzNxwh2A6xZa6KDvTsrUlBOcPXXZYeuvsq7U3U4FqxXyLrBKwMcfNi49uvtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+zGHBMj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c5bab490so1616588f8f.1;
        Tue, 03 Sep 2024 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725378218; x=1725983018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FrFjo+tZ1gGYSl0VKH0dOJMvB0CR3MC+AWQeHbPFOtA=;
        b=V+zGHBMjWJ2trvsHPcw8rKSOHExPOP0vFZxscuPFY+JlVy2Fz1ES1KSBvOIgajEYWT
         e9rwDIg2Vqobot028WNDu9wBlUctjpGR0qdt+l7p6aMr238xuLr7Z/r1lP3HZ0itDlu1
         LqJJQJWSRqBWoIN5dYxtazXsnUVfXy5GFuVdBM/kUPVfx4kif3hvSt2oQ+oceEv1Bk7y
         9tdu+hufzUcYSNxKSPr3ER6WH2h33A4l6KdG1X4q7lxrzvhvA4vfCWIQ2O2uGwYDmVHW
         a3w0fsjRPkpDAUD9a+K+5BSWkzlXJEtKGv5Km2DEgtwVA8+Ah9XKf9+nN/sfh4nURY2+
         h0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378218; x=1725983018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrFjo+tZ1gGYSl0VKH0dOJMvB0CR3MC+AWQeHbPFOtA=;
        b=qfUxMdBDlSsKqGqWao0ZNZwt/f5w8dNRZ5N6i3XvczVv68I3ohOdhHozmhF3GvP858
         UYCsmGNryTWModg/QZ/KRifqVmWacXLHtw1tud5PMtCGl9MUqltDzAURlLjvUYn/4Zrk
         sQGumelusI/oOozRw/W/VdbDODg9IIoysQ7HkFtfT5n1e7Jnyc5T3lZ+mchm8FvbBxH+
         DBGhRIAP6n5DZYGF/KtjGrXO5cU5IwaHKfo5GdyaBapUU2Sf48L8fnPkQt3nOlNpxLYs
         ZkGiavQjK36llJtSeU94618AwKFWeuZEML/kUjUXIKxttI4T9VHVy94cS2d7MhnDC1Rm
         OHIA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwzwGgqscux5R0NKlHbDNXcrBNVYjuTiXHQjEC+B5+e5WXh6biqAQr7jLOcXXKfoMUusKcHttyH21@vger.kernel.org, AJvYcCXgRoCGrkLRhqQ8VXvG3dHsyR7gNGc+733Mhx0gmCdJjy0tUbLLrsHHUsXdgZpmFvoUmgE5baYojih5@vger.kernel.org, AJvYcCXv25S3WbClcmyMh3FlSRaWQJw5FNcjUGk1xm0XZI+Jq1xZe7ZFgj4vm7AyJ4eNF34GqUXhHBJDB8yeTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiKx364aCsc/U/qcEuAo5L6Kb8w0w7m4MbnZU4HQICxlO/WAW
	Yh0a2ZtLk9ErvpBOWuBDtyb7/GChaK/HGl6g+nUnncrEVMI4QbXD
X-Google-Smtp-Source: AGHT+IFtKuJTUZtgaXPzWokqyjK7byQvdCebdVWZlVr9CLhhNoaOx7C6+7tzpmCqnew0Tap6TZWaWA==
X-Received: by 2002:a5d:53d2:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-374bd000df0mr6519110f8f.3.1725378217588;
        Tue, 03 Sep 2024 08:43:37 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-16-250-236.retail.telecomitalia.it. [87.16.250.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ca42726fsm6416596f8f.9.2024.09.03.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:43:37 -0700 (PDT)
Message-ID: <66d72ea9.df0a0220.21f5f.029f@mx.google.com>
X-Google-Original-Message-ID: <ZtcWbARp9BITg7QJ@Ansuel-XPS.>
Date: Tue, 3 Sep 2024 16:00:12 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-2-98eebfb4da66@kernel.org>
 <20240903153353.GZ6858@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903153353.GZ6858@google.com>

On Tue, Sep 03, 2024 at 04:33:53PM +0100, Lee Jones wrote:
> On Sat, 31 Aug 2024, Lorenzo Bianconi wrote:
> 
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Add support for Airoha EN7581 GPIO System Controller which provide a
> > register map for controlling the GPIO, pinctrl and PWM of the SoC.
> > 
> > Schema define cells for both gpio/interrupt controller and PWM.
> > Moreover it provides a dedicated pinctrl node for pins and config
> > definitions.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
> >  1 file changed, 433 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > new file mode 100644
> > index 000000000000..a9080c7f50f9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > @@ -0,0 +1,433 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/airoha,en7581-gpio-sysctl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 GPIO System Controller
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +description:
> > +  Airoha EN7581 SoC GPIO system controller which provided a register map
> > +  for controlling the GPIO, pins and PWM of the SoC.
> 
> This whole thing is just about pins.
> 
> The MFD portion of this submission doesn't do anything.
>

Hi Lee,

thanks for the review. I think you missed the other series as it was
requested to use MFD implementation due to shared register map.

> Please rework this to omit the MFD driver.

I'm a bit confused by this you mean in the schema? Putting PWM property
in a pinctrl schema looks wrong to me :(

> 
> After just a glance, it looks like simple-mfd _might_ work.

Simple-mfd works if register map are well defined and you can have
something like
- parent define the whole register
- child can user reg property to register offset and subsection of the
  parent register

Here it's all mixed and scrambled and also it was requested to have a
very simple node that include both pwm and pinctrl property (cause that
is how the HW register block is designed and schema must reflect HW)

Hope you can understand these reasons.

> 
> > +properties:
> > +  compatible:
> > +    const: airoha,en7581-gpio-sysctl
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  pinctrl:
> > +    type: object
> > +
> > +    $ref: /schemas/pinctrl/pinctrl.yaml
> > +
> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +
> > +        patternProperties:
> > +          '^.*mux.*$':
> > +            type: object
> > +
> > +            description:
> > +              pinmux configuration nodes.
> > +
> > +            $ref: /schemas/pinctrl/pinmux-node.yaml
> > +
> > +            properties:
> > +              function:
> > +                description:
> > +                  A string containing the name of the function to mux to the group.
> > +                enum: [pon, tod_1pps, sipo, mdio, uart, i2c, jtag, pcm, spi,
> > +                       pcm_spi, i2s, emmc, pnand, pcie_reset, pwm, phy1_led0,
> > +                       phy2_led0, phy3_led0, phy4_led0, phy1_led1, phy2_led1,
> > +                       phy3_led1, phy4_led1]
> > +
> > +              groups:
> > +                description:
> > +                  An array of strings. Each string contains the name of a group.
> > +
> > +            required:
> > +              - function
> > +              - groups
> > +
> > +            allOf:
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pon
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [pon]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: tod_1pps
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [pon_tod_1pps, gsw_tod_1pps]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: sipo
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [sipo, sipo_rclk]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: mdio
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [mdio]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: uart
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      items:
> > +                        enum: [uart2, uart2_cts_rts, hsuart, hsuart_cts_rts, uart4,
> > +                               uart5]
> > +                      maxItems: 2
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: i2c
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [i2c1]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: jtag
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [jtag_udi, jtag_dfd]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pcm
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [pcm1, pcm2]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: spi
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      items:
> > +                        enum: [spi_quad, spi_cs1]
> > +                      maxItems: 2
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pcm_spi
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      items:
> > +                        enum: [pcm_spi, pcm_spi_int, pcm_spi_rst, pcm_spi_cs1,
> > +                               pcm_spi_cs2_p156, pcm_spi_cs2_p128, pcm_spi_cs3,
> > +                               pcm_spi_cs4]
> > +                      maxItems: 7
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: i2c
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [i2s]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: emmc
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [emmc]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pnand
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [pnand]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pcie_reset
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [pcie_reset0, pcie_reset1, pcie_reset2]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: pwm
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6,
> > +                             gpio7, gpio8, gpio9, gpio10, gpio11, gpio12, gpio13,
> > +                             gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
> > +                             gpio20, gpio21, gpio22, gpio23, gpio24, gpio25,
> > +                             gpio26, gpio27, gpio28, gpio29, gpio30, gpio31,
> > +                             gpio36, gpio37, gpio38, gpio39, gpio40, gpio41,
> > +                             gpio42, gpio43, gpio44, gpio45, gpio46, gpio47]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy1_led0
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio33, gpio34, gpio35, gpio42]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy2_led0
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio33, gpio34, gpio35, gpio42]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy3_led0
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio33, gpio34, gpio35, gpio42]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy4_led0
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio33, gpio34, gpio35, gpio42]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy1_led1
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio43, gpio44, gpio45, gpio46]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy2_led1
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio43, gpio44, gpio45, gpio46]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy3_led1
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio43, gpio44, gpio45, gpio46]
> > +              - if:
> > +                  properties:
> > +                    function:
> > +                      const: phy4_led1
> > +                then:
> > +                  properties:
> > +                    groups:
> > +                      enum: [gpio43, gpio44, gpio45, gpio46]
> > +
> > +            additionalProperties: false
> > +
> > +          '^.*conf.*$':
> > +            type: object
> > +
> > +            description:
> > +              pinconf configuration nodes.
> > +
> > +            $ref: /schemas/pinctrl/pincfg-node.yaml
> > +
> > +            properties:
> > +              pins:
> > +                description:
> > +                  An array of strings. Each string contains the name of a pin.
> > +                items:
> > +                  enum: [uart1_txd, uart1_rxd, i2c_scl, i2c_sda, spi_cs0, spi_clk,
> > +                         spi_mosi, spi_miso, gpio0, gpio1, gpio2, gpio3, gpio4,
> > +                         gpio5, gpio6, gpio7, gpio8, gpio9, gpio10, gpio11, gpio12,
> > +                         gpio13, gpio14, gpio15, gpio16, gpio17, gpio18, gpio19,
> > +                         gpio20, gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
> > +                         gpio27, gpio28, gpio29, gpio30, gpio31, gpio32, gpio33,
> > +                         gpio34, gpio35, gpio36, gpio37, gpio38, gpio39, gpio40,
> > +                         gpio41, gpio42, gpio43, gpio44, gpio45, gpio46,
> > +                         pcie_reset0, pcie_reset1, pcie_reset2]
> > +                minItems: 1
> > +                maxItems: 58
> > +
> > +              bias-disable: true
> > +
> > +              bias-pull-up: true
> > +
> > +              bias-pull-down: true
> > +
> > +              input-enable: true
> > +
> > +              output-enable: true
> > +
> > +              output-low: true
> > +
> > +              output-high: true
> > +
> > +              drive-open-drain: true
> > +
> > +              drive-strength:
> > +                description:
> > +                  Selects the drive strength for MIO pins, in mA.
> > +                enum: [2, 4, 6, 8]
> > +
> > +            required:
> > +              - pins
> > +
> > +            additionalProperties: false
> > +
> > +        additionalProperties: false
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - "#pwm-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    mfd@1fbf0200 {
> > +        compatible = "airoha,en7581-gpio-sysctl";
> > +        reg = <0x1fbf0200 0xc0>;
> > +
> > +        interrupt-parent = <&gic>;
> > +        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +
> > +        interrupt-controller;
> > +        #interrupt-cells = <2>;
> > +
> > +        #pwm-cells = <3>;
> > +
> > +        pinctrl {
> > +            pcie1-rst-pins {
> > +                conf {
> > +                    pins = "pcie_reset1";
> > +                    drive-open-drain = <1>;
> > +                };
> > +            };
> > +
> > +            pwm-pins {
> > +                mux {
> > +                    function = "pwm";
> > +                    groups = "gpio18";
> > +                };
> > +            };
> > +
> > +            spi-pins {
> > +                mux {
> > +                    function = "spi";
> > +                    groups = "spi_quad", "spi_cs1";
> > +                };
> > +            };
> > +
> > +            uart2-pins {
> > +                mux {
> > +                    function = "uart";
> > +                    groups = "uart2", "uart2_cts_rts";
> > +                };
> > +            };
> > +
> > +            uar5-pins {
> > +                mux {
> > +                    function = "uart";
> > +                    groups = "uart5";
> > +                };
> > +            };
> > +
> > +            mmc-pins {
> > +                mux {
> > +                    function = "emmc";
> > +                    groups = "emmc";
> > +                };
> > +            };
> > +
> > +            mdio-pins {
> > +                mux {
> > +                    function = "mdio";
> > +                    groups = "mdio";
> > +                };
> > +
> > +                conf {
> > +                    pins = "gpio2";
> > +                    output-enable;
> > +                };
> > +            };
> > +
> > +            gswp1-led0-pins {
> > +                mux {
> > +                    function = "phy1_led0";
> > +                    groups = "gpio33";
> > +                };
> > +            };
> > +
> > +            gswp2-led1-pins {
> > +                mux {
> > +                    function = "phy2_led1";
> > +                    groups = "gpio44";
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > 
> > -- 
> > 2.46.0
> > 
> 
> -- 
> Lee Jones [李琼斯]

-- 
	Ansuel

