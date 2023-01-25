Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0B67BA91
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jan 2023 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjAYTT5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Jan 2023 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAYTTz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Jan 2023 14:19:55 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11350A3;
        Wed, 25 Jan 2023 11:19:54 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id p133so17138334oig.8;
        Wed, 25 Jan 2023 11:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZPukRskp99fuNYff+LVNhQ3Vv98k10meP7w/WAUKYk=;
        b=rKgE+xMahGMtGctPEs6DfqNq48OYso37kBOx2RWuzz3CDs+16be3I37hcxKj985HVU
         ioJM92aRgYMW4MRpAD7vXpuXyg9/bVrT1QntQeDf4NouWyJw22sf8uQJudoS9/cPaYi9
         uRyMiLSlBqHvvPRv5urKuovoDZ8fTTvTkpd8LYfUvfyiOfeCvFgxGJ5ftnPcMLQmGWCT
         qIGl+klW4eHXmKH+/Odj5wYZAbZuXYISpJBZr2t25xXWkqZDjYkDgfNwuN/LcFiFmvL7
         TTPPM6rJw/b9C4me1QC5LtEkEdcskgvhaRxHSi98CwctGZ8Ywx8e0DNPO+Ow4XCPJM5X
         5dKQ==
X-Gm-Message-State: AFqh2kpSxwYZXJPWgNtjGsyjVMAf2Ss1EjnhxKxl9onxBBdam7yq+9OT
        tk+ZQ8gCMysVEN5dwuekcA==
X-Google-Smtp-Source: AMrXdXtpJYBDSpjXNA/NvxappnChwgDMyiCEA6bnsdY2ZTgPxvxKeIkDuuPfOUoF+C3D8F3u31zVsw==
X-Received: by 2002:a05:6808:14c2:b0:36e:a91d:b7ed with SMTP id f2-20020a05680814c200b0036ea91db7edmr15804498oiw.9.1674674393254;
        Wed, 25 Jan 2023 11:19:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x133-20020acae08b000000b003458d346a60sm2619464oig.25.2023.01.25.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:19:52 -0800 (PST)
Received: (nullmailer pid 2713556 invoked by uid 1000);
        Wed, 25 Jan 2023 19:19:51 -0000
Date:   Wed, 25 Jan 2023 13:19:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 5/8] dt-bindings: rtc: Add Amlogic Meson vrtc controller
 binding
Message-ID: <20230125191951.GA2709957-robh@kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <440a7cad-d48f-8975-4dfd-265b235bf629@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440a7cad-d48f-8975-4dfd-265b235bf629@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 23, 2023 at 10:28:49PM +0100, Heiner Kallweit wrote:
> Add Amlogic Meson vrtc controller binding.

You are not adding, you are converting.

> Tested with make targets dt_binding_check and dtbs_check.

That's assumed...

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../bindings/rtc/amlogic,meson-vrtc.yaml      | 50 +++++++++++++++++++
>  .../bindings/rtc/rtc-meson-vrtc.txt           | 22 --------
>  2 files changed, 50 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> new file mode 100644
> index 000000000..26a70b3ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/amlogic,meson-vrtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Virtual RTC (VRTC)
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |
> +  This is a Linux interface to an RTC managed by firmware, hence it's
> +  virtual from a Linux perspective.  The interface is 1 register where
> +  an alarm time (in seconds) is to be written.
> +  The alarm register is a simple scratch register shared between the
> +  application processors (AP) and the secure co-processor (SCP.)  When
> +  the AP suspends, the SCP will use the value of this register to
> +  program an always-on timer before going sleep. When the timer expires,
> +  the SCP will wake up and will then wake the AP.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-vrtc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus@ff800000 {
> +      reg = <0x0 0xff800000 0x0 0x100000>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      rtc@a8 {
> +        compatible = "amlogic,meson-vrtc";
> +        reg = <0x0 0x000a8 0x0 0x4>;

Just use 1 address/size cell here and then you don't need the bus node 
(which has an error in it (no ranges)).

Rob
