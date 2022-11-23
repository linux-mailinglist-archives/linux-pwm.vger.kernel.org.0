Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDD634DF1
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 03:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiKWCiR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 21:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiKWCiP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 21:38:15 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170596D496;
        Tue, 22 Nov 2022 18:38:15 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id i85so1041168ioa.5;
        Tue, 22 Nov 2022 18:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUCkOlHnbf0RGMMarg0kKY6VYKEKcAOkoBffam39m+E=;
        b=5zaJsbgZIG2pXDvD3xZAl/I13ctGY1/ThShAPA1JXKpuGf8yzz0e2iXfqbbWpzCxor
         zubsB4J02LzFNGNHrE0MWAkqTMbCgYyWamwaI2nUYF6qOoDKgpvp8hRD6AuSnFOfK8MQ
         quv01Z8oRVWG3RCBU2hTlsRRVGK9pS8SirBGNbht8wppcN7vEYmq3fao91fuHPXUVWHN
         XwmgNBnLSuEZB/V6yNHeA90iM1hyO1u5i6223Fz5/g/VusZ4j3nhbqRvAmuHDVGrfzna
         8kpZpPVI4uq3uBct9Nyb/5RSOCHSIvtb+hqF+uUUx150O0Ird6i7F6nJxe3JcBRZ790x
         pJOw==
X-Gm-Message-State: ANoB5pnk9z6lBhhrvsWhmc3tbclshhdfCS63MlyWWP9YmgLJtfTpaUNS
        +A73/y9GbZmY0s5+MBFbQA==
X-Google-Smtp-Source: AA0mqf6qotcHGpq8zIuW2HhoJpNTCHIunf2EygOd6Pv0MUV9RtFYJBFEpPDMOB9tOnvQ8JiY/3VgSw==
X-Received: by 2002:a02:3b2b:0:b0:375:9edc:532d with SMTP id c43-20020a023b2b000000b003759edc532dmr11548887jaa.13.1669171094302;
        Tue, 22 Nov 2022 18:38:14 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y14-20020a927d0e000000b00302b066d502sm1751976ilc.1.2022.11.22.18.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 18:38:13 -0800 (PST)
Received: (nullmailer pid 1036274 invoked by uid 1000);
        Wed, 23 Nov 2022 02:38:14 -0000
Date:   Tue, 22 Nov 2022 20:38:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <20221123023814.GA1026269-robh@kernel.org>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221122133825.d67q4q6k3wkncucj@pengutronix.de>
 <Y3zRpgY1cXCKsJCu@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3zRpgY1cXCKsJCu@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 22, 2022 at 03:41:58PM +0200, Tony Lindgren wrote:
> * Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [221122 13:28]:
> > On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > > Let's allow node numbering in decimal format too.
> > > 
> > > Simple human-readable increments/IDs are usually decimal, hex is only for
> > > addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> > > 
> > > Let's use an improved match suggested by Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de>.
> > > 
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > Which tree should this merged through? The obvious candidates are pwm,
> > dt and omap.
> 
> The dt folks usually queue the binding patches separately.

The default is they go thru the subsystem trees, and I mainly pickup 
what has not after some time (and is standalone binding change).

Rob
