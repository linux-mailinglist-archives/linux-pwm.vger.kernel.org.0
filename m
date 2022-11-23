Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66141634DFD
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 03:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiKWCl7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 21:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiKWCl4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 21:41:56 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB824725C9;
        Tue, 22 Nov 2022 18:41:53 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id c7so12291978iof.13;
        Tue, 22 Nov 2022 18:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5YUt7o2Dz6wZvbcvQIlWDT7YLX+pm20m6A83rmPPtk=;
        b=VYaFyen/rusql0TAZ0KJCfKGYo/QbbDiY9+dIqJG+ii43hN6XIfKbtMvo/pOb33tVz
         YvbuRobWiK3sT9UkK1m1hDiw5k+pEVmPZHlOjxdszBpr5lO4cuXJqzZFubBcgaTHCzJ0
         K+4SXHxb/xLXpSfbvTofQZKgnCZewia2kXW5bUcsuQRuDQT+AIB54yJRKSx02rPW2MOV
         oT3JFn6QO++5OfYHS1h9ZMs2wGzuJRnWdrZO1CgyUf06uUjAoLNjNTj+qn2RXrKlbJPq
         Kz8FpzzwSjAZ2ZlRJDXyQSVppAq4l8LhV6hXtXwgy4B3JNnFTByi04Bz/jUDvU8x8VOX
         XN+w==
X-Gm-Message-State: ANoB5pnbIXSaoGeU/DVphDu2iEPXD8MLYmXxP43Wt9l/0B2s3JDhmPbX
        ez+n9jPhv8vXdDpw8BGSNQ==
X-Google-Smtp-Source: AA0mqf7Hg4bf0akf4IkMFS32+TO9adkwf1C7n7XP48c9ETQQ/V4DjIrH0/fwEpPWreJBfO74VtQJlQ==
X-Received: by 2002:a5d:9911:0:b0:6db:1f90:7e62 with SMTP id x17-20020a5d9911000000b006db1f907e62mr3172593iol.107.1669171313126;
        Tue, 22 Nov 2022 18:41:53 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i23-20020a02ca17000000b0035a40af60fcsm5984151jak.86.2022.11.22.18.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 18:41:52 -0800 (PST)
Received: (nullmailer pid 1041085 invoked by uid 1000);
        Wed, 23 Nov 2022 02:41:53 -0000
Date:   Tue, 22 Nov 2022 20:41:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <20221123024153.GB1026269-robh@kernel.org>
References: <20221122123225.59106-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122123225.59106-1-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> Let's allow node numbering in decimal format too.
> 
> Simple human-readable increments/IDs are usually decimal, hex is only for
> addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> 
> Let's use an improved match suggested by Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de>.
> 
> Cc: linux-pwm@vger.kernel.org
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v2:
> 
> - Use pattern suggested by Krzysztof and Uwe
> 
> Changes since v1:
> 
> - New patch added to deal with pwm-omap-dmtimer binding
> 
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -13,7 +13,7 @@ select: false
>  
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@.+|-[0-9a-f]+)?$"

So now pwm-10 could be either?

I'm fine with decimal, but can we do that everywhere we do this -N 
naming?

>  
>    "#pwm-cells":
>      description:
> -- 
> 2.38.1
> 
