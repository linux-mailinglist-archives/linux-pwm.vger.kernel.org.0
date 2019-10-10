Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E4D30EC
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2019 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfJJSyh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Oct 2019 14:54:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41812 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJJSyh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Oct 2019 14:54:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so5810790otp.8;
        Thu, 10 Oct 2019 11:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+zin2bL1A/EltcDjtt8OSEY4VLYK08n8Dj1hQ6Wf2k=;
        b=NK80gRkKNwDHsBMg0GSP1e/bG/pYjwQZzjy3vZyMSsay1NN3FQ3YnrTF4bNz6+HKeg
         aYvQPqsSIvhPPRpEj0bk0phRBT1Jnl9xoKTx39tlTM3vqrXGLNrJUkCUoIB0z5xsSYb7
         A6v+gL4GrW2lCYvNVSUVDrqDAIYUam92A0FacTSuD8R0p3DK49Yot3owk3nDgYpkbZ9B
         aPwlnHEhuT4IK5ablxSTCoiFLqhhMAHHeRNsJi3Uf9sq1g8S7lPFV9uJAxFuF4mX7Sl6
         FD4DN3F6DvwYygZT/HEinr0QCbg93tKWwoHOaxXiKKAUPBj2Im5bkwUmGAQVoYotT+Jt
         8big==
X-Gm-Message-State: APjAAAV2Ci4ZiTprfbwQ4kK9Koc7wkjQEUv7w0/p+j8So0hGa4Qi4L7j
        FYH7YuujYOaPx0k7MKy7Jg==
X-Google-Smtp-Source: APXvYqxQEXGO9Uc01zKUGpeB8t0R+xv3eN1jyvC9TPfe47vyIsyRP58qHhRhPLQG1SNW3RGl2mO7pw==
X-Received: by 2002:a9d:73d8:: with SMTP id m24mr8810042otk.227.1570733674052;
        Thu, 10 Oct 2019 11:54:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r19sm1846829ota.79.2019.10.10.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:54:33 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:54:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Convert PWM bindings to
 json-schema
Message-ID: <20191010185432.GA17457@bogus>
References: <20191002164047.14499-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002164047.14499-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 02, 2019 at 06:40:46PM +0200, Krzysztof Kozlowski wrote:
> Convert generic PWM bindings to DT schema format using json-schema.  The
> consumer bindings are split to separate file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Change also pwm-sprd.txt
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Change pattern for pwm nodes,
> 3. Remove $ref from #cells.
> ---


> diff --git a/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
> new file mode 100644
> index 000000000000..39c844fe6338
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-consumers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Specifying PWM information for devices
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  PWM properties should be named "pwms". The exact meaning of each pwms
> +  property must be documented in the device tree binding for each device.
> +  An optional property "pwm-names" may contain a list of strings to label
> +  each of the PWM devices listed in the "pwms" property. If no "pwm-names"
> +  property is given, the name of the user node will be used as fallback.
> +
> +  Drivers for devices that use more than a single PWM device can use the
> +  "pwm-names" property to map the name of the PWM device requested by the
> +  pwm_get() call to an index into the list given by the "pwms" property.
> +
> +properties:
> +  pwms:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Phandle to PWM controller node and pwm-specifier (controller specific).
> +      pwm-specifier typically encodes the chip-relative PWM number and the PWM
> +      period in nanoseconds.
> +      Optionally, the pwm-specifier can encode a number of flags (defined in
> +      <dt-bindings/pwm/pwm.h>) in a third cell:
> +        - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> +
> +  pwm-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      A list of strings to label each of the PWM devices listed in the "pwms"
> +      property. If no "pwm-names" property is given, the name of the user node
> +      will be used as fallback.
> +
> +required:
> +  - pwms

This schema is never applied because it has no 'select' which is only 
automatic for $nodename or compatible. You could include this from other 
schemas, but why? Any consumer still has to list these properties to 
define their specific constraints.

We already have a schema in dtschema for consumer side. It's just 
missing descriptions which needs relicensing from this.

> +
> +dependencies:
> +  pwm-names: [ pwms ]
