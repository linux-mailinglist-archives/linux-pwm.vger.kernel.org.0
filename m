Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6324B3F076D
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbhHRPFw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbhHRPFu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 11:05:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D8C061764;
        Wed, 18 Aug 2021 08:05:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k5so5327317lfu.4;
        Wed, 18 Aug 2021 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQRno5vnhRrA4KOIe4lh21xpnTcUCE7c8mZkK4K3e/s=;
        b=bctcyrsCVgDi+5GWndAxItidHxjnjBsVRd2v4YKwpkUHVQsHKnjigYdInqM2sgY1jW
         LU4Jh4S1KHwJCYIkKwBJjhzwLsETLbQkJYV1xEK2qpiOA9qIvjGJ85a1PWeULSrkn7ia
         r4YL+HceQmir1Ln3MEYBETrNrkGE0PBwh8aiSMQBVsqOxRDV4MqEJVC2Fc1LaStgvxPt
         W3s2UizOnemCr1DOdNPZ7ESGcn979rYje4A7UuCWFTbZSEZZ9derc8SEFxG1dwb3evmY
         p5hMm0n+7AZq9124uwrFB026HSrZdidoIm/IsypAkwON8b5y75L7iYAKeoihIJ13XqMQ
         VQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQRno5vnhRrA4KOIe4lh21xpnTcUCE7c8mZkK4K3e/s=;
        b=ja/h8JZQhZinPez6/6kULtuPmtff1PvOJbP5tPpcdAiurlH4nB5CJSnWGSaVPpwvmr
         k5vQUdbLsYzHyjTfWzHuT20pbzobdNb/e2Z1RYewUbc2iLujbR7tWy0LLiPgHXCINwBS
         nstXxWXo0YuCc1vg0kb3yxWbXcq/6vP0hu/cFgI44Yu4IGaGAIoPjsnFoyn5fRacAjIx
         Mjpx5fhrkdVmPWt4YMQIyuIioSosSAvvzOshzagK1EJ06/htOynFX9Yzq8k04xvr/Fmp
         NN0R2F/j9EGRNhJHlA3KATykg7RXrXdkqkXl+6ZWBRLzYxcnO8vNsigjfQpa/i4po0Dj
         Nhzw==
X-Gm-Message-State: AOAM533LuWuxveisw4MesjeTnzwqnT83IUJGKUBmfUlEq7TCJ2rXlYAm
        YXW1jOXiJ5M12aiNhTtNpYRAtdzyla0=
X-Google-Smtp-Source: ABdhPJyr5YxrN+b1RGtkQEvSYdwTBm71o8Ulw3lRJisRIIBg/FeSpE62xIZBaNIXj4QafSUTN0OIhA==
X-Received: by 2002:a19:430a:: with SMTP id q10mr6797932lfa.378.1629299113790;
        Wed, 18 Aug 2021 08:05:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id bn16sm12055ljb.74.2021.08.18.08.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 08:05:12 -0700 (PDT)
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-7-digetx@gmail.com> <YR0SSz7KMh7TwaFW@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eff5ef47-e6e0-3e03-cf1a-d931b0f2dc2a@gmail.com>
Date:   Wed, 18 Aug 2021 18:05:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR0SSz7KMh7TwaFW@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 16:59, Thierry Reding пишет:
> On Tue, Aug 17, 2021 at 04:27:26AM +0300, Dmitry Osipenko wrote:
>> Document tegra-clocks sub-node which describes Tegra SoC clocks that
>> require a higher voltage of the core power domain in order to operate
>> properly on a higher clock rates.  Each node contains a phandle to OPP
>> table and power domain.
>>
>> The root PLLs and system clocks don't have any specific device dedicated
>> to them, clock controller is in charge of managing power for them.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/clock/nvidia,tegra20-car.yaml    | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> index 459d2a525393..7f5cd27e4ce0 100644
>> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
>> @@ -42,6 +42,48 @@ properties:
>>    "#reset-cells":
>>      const: 1
>>  
>> +  tegra-clocks:
>> +    description: child nodes are the output clocks from the CAR
>> +    type: object
>> +
>> +    patternProperties:
>> +      "^[a-z]+[0-9]+$":
>> +        type: object
>> +        properties:
>> +          compatible:
>> +            allOf:
>> +              - items:
>> +                  - enum:
>> +                      - nvidia,tegra20-sclk
>> +                      - nvidia,tegra30-sclk
>> +                      - nvidia,tegra30-pllc
>> +                      - nvidia,tegra30-plle
>> +                      - nvidia,tegra30-pllm
>> +              - const: nvidia,tegra-clock
>> +
>> +          operating-points-v2:
>> +            $ref: /schemas/types.yaml#/definitions/phandle
>> +            description:
>> +              Phandle to OPP table that contains frequencies, voltages and
>> +              opp-supported-hw property, which is a bitfield indicating
>> +              SoC process or speedo ID mask.
>> +
>> +          clocks:
>> +            items:
>> +              - description: node's clock
>> +
>> +          power-domains:
>> +            maxItems: 1
>> +            description: phandle to the core SoC power domain
>> +
>> +        required:
>> +          - compatible
>> +          - operating-points-v2
>> +          - clocks
>> +          - power-domains
>> +
>> +        additionalProperties: false
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -59,6 +101,15 @@ examples:
>>          reg = <0x60006000 0x1000>;
>>          #clock-cells = <1>;
>>          #reset-cells = <1>;
>> +
>> +        tegra-clocks {
>> +            sclk {
>> +                compatible = "nvidia,tegra20-sclk", "nvidia,tegra-clock";
>> +                operating-points-v2 = <&opp_table>;
>> +                clocks = <&tegra_car TEGRA20_CLK_SCLK>;
>> +                power-domains = <&domain>;
>> +            };
>> +        };
> 
> I wonder if it'd be better to match on the name of the node rather than
> add an artificial compatible string. We usually use the compatible
> string to match a device, but here you're really trying to add
> information about a resource provided by the CAR controller.
> 
> We do similar things for example in PMIC bindings where the individual
> regulators are represented in the device tree via nodes named after the
> regulator.
> 
> You could then also leave out the clocks property, which is weird as it
> is because it's basically a self-reference. But you don't really need
> the reference here in the first place because the CAR is already the
> parent of SCLK.

We don't have a platform device for CaR. I don't see how it's going to
work. We need to create a platform device for each RPM-capable clock
because that's how RPM works. The compatible string is required for
instantiating OF-devices from a node, otherwise we will have to
re-invent the OF core.

> Also, I don't think the tegra- prefix is necessary here. The parent node
> is already identified as Tegra via the compatible string.
> 
> In the case of CAR, I'd imagine something like:
> 
> 	clocks {
> 		sclk {
> 			operating-points-v2 = <&opp_table>;
> 			power-domains = <&domain>;
> 		};
> 	};
> 
> Now you've only got the bare minimum in here that you actually add. All
> the other data that you used to have is simply derived from the parent.

'clocks' is already a generic keyword in DT. It's probably not okay to
redefine it.
