Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345EB3EF749
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 03:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHRBQ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 21:16:56 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40759 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhHRBQp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 21:16:45 -0400
Received: by mail-ot1-f51.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so775646oth.7;
        Tue, 17 Aug 2021 18:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZhI8s0bq6Q/ufRFM0cKz5GDmu8z9ddT9tyGnPEkEkA=;
        b=d3278307lcsucZkWNdOlfjERjWwuRMjd/gB7iiZGC2D/THyhbhoKr1DCAA259mIs2z
         k+Pp6FiruqwzFMPho59THNM6IMPZI6yJ3IUK6nK+RoW+30sB4R1logumfoasRSGWcoAK
         uuZgoUF5hjC5dM6J6OKPCzgVDvtHVb28o6RcLJ4ybniNAwdXQ9i5cGGVNf3CfBmo598M
         d2fCcyBkuxNtqhnQRBwU4Ktb4n6PKnUsSst+1QhJo8fAO/7ArT8yyXfC9flZq9jC+iMK
         t8WFyYaEwmS2ttA3vbs2KCcu+v+gzyIbR22r5zJxV6KF14S4y2OaQ+R27b0YutlDjUV1
         btFw==
X-Gm-Message-State: AOAM5325HZNhrP1WV8UmFc+GWKZQzXh4SRzkV3ZG1wtR+pmzzx5qMw7T
        PNHHFMzg7qZLzpEJrsBZmw==
X-Google-Smtp-Source: ABdhPJygYnXFnxnEh28gqMyYF6NthIHBysWjBhU7p2cYyKWsqAlZXR7MMNfgasUuDyAVpFFwk0mEQg==
X-Received: by 2002:a9d:ecc:: with SMTP id 70mr4970700otj.96.1629249371372;
        Tue, 17 Aug 2021 18:16:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l7sm747356ooq.28.2021.08.17.18.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:16:10 -0700 (PDT)
Received: (nullmailer pid 1176067 invoked by uid 1000);
        Wed, 18 Aug 2021 01:16:08 -0000
Date:   Tue, 17 Aug 2021 20:16:08 -0500
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
Subject: Re: [PATCH v8 09/34] dt-bindings: host1x: Document Memory Client
 resets of Host1x, GR2D and GR3D
Message-ID: <YRxfWJJ6+1GgVs33@robh.at.kernel.org>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817012754.8710-10-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 17, 2021 at 04:27:29AM +0300, Dmitry Osipenko wrote:
> Memory Client should be blocked before hardware reset is asserted in order
> to prevent memory corruption and hanging of memory controller.
> 
> Document Memory Client resets of Host1x, GR2D and GR3D hardware units.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> index 62861a8fb5c6..07a08653798b 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> @@ -18,6 +18,7 @@ Required properties:
>  - resets: Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names: Must include the following entries:
> +  - mc
>    - host1x

New entries should be at the end. Order matters.

>  
>  Optional properties:
> @@ -197,6 +198,7 @@ of the following host1x client modules:
>    - resets: Must contain an entry for each entry in reset-names.
>      See ../reset/reset.txt for details.
>    - reset-names: Must include the following entries:
> +    - mc
>      - 2d
>  
>    Optional properties:
> @@ -222,6 +224,8 @@ of the following host1x client modules:
>    - resets: Must contain an entry for each entry in reset-names.
>      See ../reset/reset.txt for details.
>    - reset-names: Must include the following entries:
> +    - mc
> +    - mc2 (Only required on SoCs with two 3D clocks)
>      - 3d
>      - 3d2 (Only required on SoCs with two 3D clocks)
>  
> -- 
> 2.32.0
> 
> 
