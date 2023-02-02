Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A82688B2A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Feb 2023 00:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjBBXy3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Feb 2023 18:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBBXy2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Feb 2023 18:54:28 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CB6B000;
        Thu,  2 Feb 2023 15:54:27 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id h12-20020a4a940c000000b004fa81915b1cso351568ooi.4;
        Thu, 02 Feb 2023 15:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VCS0pNVsYt06k5zDzEs8Faz6RYiYEqDWO9Bf/Yg0I8=;
        b=Bn+Dt83dfXsoHxh8RIUHG5sSci8x15LMlExOxSWVvqOLjo9BpUFSV+rYw9bhg6POZv
         JgnyWerdnFr7NGuIxRizGSgixdwpchu+J67IRHH+4iPfxY54DauZ3pNzk1Z0lmItw/Om
         ECrh+YJNF/L5BdWdyjvnSVIXMiEY83k5a5+oUR7MDOFhOU0J5sSrti6xdAtS+tRbN4/1
         zEQsUV1/b6yneHKWo5Chdr1xt0J21NFBgPG3Leg90upNsVs4PM0cjWLzO1dOQGGKgU8R
         QQYKZvr4dpMSh9pXDS090U5SKxHl/ZLggYWqKtIy161g9ks3LN+Euys8Ifa2yVzQcGhA
         nl3A==
X-Gm-Message-State: AO0yUKXC0974HlEm4tBjgfcadr1cu2Zl6elBm+nQUIOcMcS6GQTwAkHS
        C+ls3Xmhoo/IOcfYkAVCKnpY0RR2Fw==
X-Google-Smtp-Source: AK7set/IDqDAsp6U6ML93g2sfU2nPieiugA5msOO5zUoE4jwCL7JJkY0/XOQ1c4zWBeAr6DVlhzrNg==
X-Received: by 2002:a4a:948e:0:b0:51a:35de:d4c1 with SMTP id k14-20020a4a948e000000b0051a35ded4c1mr1502653ooi.5.1675382067058;
        Thu, 02 Feb 2023 15:54:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i5-20020a4aa6c5000000b004f241603c49sm397199oom.20.2023.02.02.15.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:54:26 -0800 (PST)
Received: (nullmailer pid 2927110 invoked by uid 1000);
        Thu, 02 Feb 2023 23:54:25 -0000
Date:   Thu, 2 Feb 2023 17:54:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: interrupt-controller: Convert Amlogic
 Meson GPIO interrupt controller binding
Message-ID: <167538206470.2927056.7621098912599548470.robh@kernel.org>
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
 <8cae0b08-8040-ef7b-da0e-92d9b3695249@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cae0b08-8040-ef7b-da0e-92d9b3695249@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed, 01 Feb 2023 21:02:02 +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson GPIO interrupt controller binding to yaml.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> - consider that more than one compatible may be set
> - remove bus part from example
> - remove minItem/maxItem properties for compatible
> - reduce compatible fallback complexity
> ---
>  .../amlogic,meson-gpio-intc.txt               | 38 ----------
>  .../amlogic,meson-gpio-intc.yaml              | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

