Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C422B521
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGWRrF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 13:47:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34953 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRrF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 13:47:05 -0400
Received: by mail-io1-f66.google.com with SMTP id v8so7170525iox.2;
        Thu, 23 Jul 2020 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2u/Rq8wYBFTgkucJTkL8W/WVGPEOien8PbUmbomVeFg=;
        b=P7ZHeLvNieyPL7vvUVb3U2IgtNZA86gmE431OW1NHbTMiy+DsZzmgAh4LBn2Htjg3n
         iHMGIHSoJHJkWNoatAaKVUCVE6vnFvjYkDeJeGtQTtx+ERjb4Dna2zpHEqhcCJje5wpk
         qxq5T8hlCQF4J6ioLynda4Ij4SNbwe0McxhLconbSoCwqAPddXMar63UruhXP0Q5Ko3k
         WEfki2Io8OjElZDmrO2gknfra2BqVG5l0OfIzqTWuM0kf1uInLbeUiLYny/zD/RvPM5J
         yd6X2QGVPOFPWa4ZmCQEVHmZ6V2DTyekzkdwLnVuvWxCKkMZ5DWtvs9lws+Ft9fPM/xr
         Qi7g==
X-Gm-Message-State: AOAM533KFH1kYp4b/nyTS6jiPuw96/F6CUR6iR131Xf6HSXq15x/HmXK
        WfvN5WCe6iiEH2xUC3XCXw==
X-Google-Smtp-Source: ABdhPJx2jePXlL5dDzYzVGWNvECUk7UdkUVtC6VOQEx6cg7dIZEBtv7lp9RU8mpCU2vNcX4K2kMtaQ==
X-Received: by 2002:a05:6602:2555:: with SMTP id j21mr6071654ioe.11.1595526423819;
        Thu, 23 Jul 2020 10:47:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p20sm1460825ili.72.2020.07.23.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:47:03 -0700 (PDT)
Received: (nullmailer pid 595294 invoked by uid 1000);
        Thu, 23 Jul 2020 17:47:01 -0000
Date:   Thu, 23 Jul 2020 11:47:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200723174701.GA584130@bogus>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 18, 2020 at 10:47:08PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,keembay-pwm.yaml | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> new file mode 100644
> index 00000000..e9388a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/intel,keembay-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Keem Bay PWM Device Tree Bindings
> +
> +maintainers:
> +  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,keembay-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> + - compatible
> + - reg
> + - clocks
> + - '#pwm-cells'

Add:

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    #define KEEM_BAY_A53_GPIO
> +
> +    pwm@203200a0 {
> +      compatible = "intel,keembay-pwm";
> +      reg = <0x203200a0 0xe8>;
> +      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
> +      #pwm-cells = <2>;
> +    };
> -- 
> 1.9.1
> 
