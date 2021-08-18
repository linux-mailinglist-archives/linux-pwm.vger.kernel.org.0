Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2223EF740
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 03:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhHRBPr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 21:15:47 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35374 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhHRBPo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 21:15:44 -0400
Received: by mail-ot1-f45.google.com with SMTP id f16-20020a056830205000b00519b99d3dcbso807650otp.2;
        Tue, 17 Aug 2021 18:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RM2dmchpI6KmQKuD+RgubJedkIA6WkX9t/jyVLdUt3Q=;
        b=M/yPllpnPj3TZCZVEA18tJCv0QVZrZggPomFdRAhNbq9gQbXUAUdvRZNHsSF36y72M
         0l1ky8wIehQvPxVmUQRU9qtc15Emjy/xV5oExxJN66WqBw0GJHEApsYlg5dBzBXk3NDs
         KFowaVVlsWeFxBGveWZxOTvUPIF+0zd9DRshAjtDwKgO8jjOLAVmpE5HYZbxh/GHDsci
         uxBh9TDdsVuK2eDptDSYiQZZ5W1mHQbxUiCcE/oCOvl8DOpn5zBIr/cT3C6WO+wsYlbs
         FUhROK8iZ8pRq5hIUrvs+0glR2sNsSqhERk9gMQ5GLqjPqZYPpO2OsdkKD7smxvOolln
         435A==
X-Gm-Message-State: AOAM531fxHcv2v3ead0V9UchaMijLKVLlDYc6XB9tIO2P4CvC7scT/mX
        I1AzhmDBH5bmBm25+PiehQ==
X-Google-Smtp-Source: ABdhPJydb95sxSyCE8JTQ37Yp3+d+zCUT2I4Mgdlk82Qz5QqNFm3xA06SoTPwD6X93TSb4zbZLUInw==
X-Received: by 2002:a05:6830:1f54:: with SMTP id u20mr4796930oth.320.1629249309809;
        Tue, 17 Aug 2021 18:15:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o7sm662196oih.34.2021.08.17.18.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:15:08 -0700 (PDT)
Received: (nullmailer pid 1174643 invoked by uid 1000);
        Wed, 18 Aug 2021 01:15:06 -0000
Date:   Tue, 17 Aug 2021 20:15:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
Message-ID: <YRxfGtWPXeSQXuHo@robh.at.kernel.org>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817012754.8710-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 17, 2021 at 04:27:26AM +0300, Dmitry Osipenko wrote:
> Document tegra-clocks sub-node which describes Tegra SoC clocks that
> require a higher voltage of the core power domain in order to operate
> properly on a higher clock rates.  Each node contains a phandle to OPP
> table and power domain.
> 
> The root PLLs and system clocks don't have any specific device dedicated
> to them, clock controller is in charge of managing power for them.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/clock/nvidia,tegra20-car.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> index 459d2a525393..7f5cd27e4ce0 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> @@ -42,6 +42,48 @@ properties:
>    "#reset-cells":
>      const: 1
>  
> +  tegra-clocks:
> +    description: child nodes are the output clocks from the CAR
> +    type: object
> +
> +    patternProperties:
> +      "^[a-z]+[0-9]+$":
> +        type: object
> +        properties:
> +          compatible:
> +            allOf:
> +              - items:
> +                  - enum:
> +                      - nvidia,tegra20-sclk
> +                      - nvidia,tegra30-sclk
> +                      - nvidia,tegra30-pllc
> +                      - nvidia,tegra30-plle
> +                      - nvidia,tegra30-pllm
> +              - const: nvidia,tegra-clock

You are saying the first string must be both one of the enums and 
'nvidia,tegra-clock'. You don't get an error because your pattern 
doesn't match 'sclk'.

> +
> +          operating-points-v2:
> +            $ref: /schemas/types.yaml#/definitions/phandle
> +            description:
> +              Phandle to OPP table that contains frequencies, voltages and
> +              opp-supported-hw property, which is a bitfield indicating
> +              SoC process or speedo ID mask.

Just 'operating-points-v2: true' is enough.

> +
> +          clocks:
> +            items:
> +              - description: node's clock
> +
> +          power-domains:
> +            maxItems: 1
> +            description: phandle to the core SoC power domain
> +
> +        required:
> +          - compatible
> +          - operating-points-v2
> +          - clocks
> +          - power-domains
> +
> +        additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -59,6 +101,15 @@ examples:
>          reg = <0x60006000 0x1000>;
>          #clock-cells = <1>;
>          #reset-cells = <1>;
> +
> +        tegra-clocks {
> +            sclk {
> +                compatible = "nvidia,tegra20-sclk", "nvidia,tegra-clock";
> +                operating-points-v2 = <&opp_table>;
> +                clocks = <&tegra_car TEGRA20_CLK_SCLK>;
> +                power-domains = <&domain>;
> +            };
> +        };
>      };
>  
>      usb-controller@c5004000 {
> -- 
> 2.32.0
> 
> 
