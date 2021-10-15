Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F042E521
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhJOASz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Oct 2021 20:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhJOASy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Oct 2021 20:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8CD660FDC;
        Fri, 15 Oct 2021 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634257009;
        bh=y921IoviWP7ArGzf/NBOMznO7PDvJ8OxA3PyazLbsOc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pCi7obhE30Iv7WDLzDrA4nCqMpadPw7MZJ4gYnNOHFAEalPk0tCfXZ+HvEgIia54U
         k5+ll1GaVAyg84eUhAyLwhqHOdQKc5j/bZAGSbmkH6qti6sgp8m0qd4S+tgooJBsvi
         Bfo88sZs4vrSNE0j56eripPvUMf3IBWonfEc+HLOFZ9sxVGaJL8DzHHzYEXwRxWl0r
         A4rwIYS+vtYWACJUmQ03lxppfSC74ZnEnhHDw/NZDVscNhabCkz2muTRcVOXPhQEjA
         PJXP+VLbj7pUdDQo23ONQeh2EGBx+EfEgtxggBF7Ue2zJiXRQWWbLOdD60/739HnJ8
         A6nKTZXjxBrOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210920181145.19543-6-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com> <20210920181145.19543-6-digetx@gmail.com>
Subject: Re: [PATCH v12 05/35] dt-bindings: clock: tegra-car: Document new clock sub-nodes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Viresh Kumar <vireshk@kernel.org>
Date:   Thu, 14 Oct 2021 17:16:47 -0700
Message-ID: <163425700766.1688384.4481739110941660602@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Dmitry Osipenko (2021-09-20 11:11:15)
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.y=
aml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> index 459d2a525393..f832abb7f11a 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> @@ -42,6 +42,36 @@ properties:
>    "#reset-cells":
>      const: 1
> =20
> +patternProperties:
> +  "^(sclk)|(pll-[cem])$":
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - nvidia,tegra20-sclk
> +          - nvidia,tegra30-sclk
> +          - nvidia,tegra30-pllc
> +          - nvidia,tegra30-plle
> +          - nvidia,tegra30-pllm
> +
> +      operating-points-v2: true
> +
> +      clocks:
> +        items:
> +          - description: node's clock
> +
> +      power-domains:
> +        maxItems: 1
> +        description: phandle to the core SoC power domain

Is this done to associate the power domain with a particular clk? And an
OPP table with a particular clk?

> +
> +    required:
> +      - compatible
> +      - operating-points-v2
> +      - clocks
> +      - power-domains
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
