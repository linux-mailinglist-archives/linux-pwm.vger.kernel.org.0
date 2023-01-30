Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42162681C92
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 22:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjA3VVY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 16:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjA3VVX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 16:21:23 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291713669A;
        Mon, 30 Jan 2023 13:21:23 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id s41-20020a05683043a900b0068bd63d34d0so808262otv.6;
        Mon, 30 Jan 2023 13:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zpzrKyS9XxSvm98qW4QbIC/Am08CDM2xVesuhLYrLA=;
        b=qd+75EKY6UVFEfycAFGS7FZauAzOdeZIeOvO28ArUcireUbmg6jChRJVBUp07tZsE6
         qBlaU0PN7Z7INZntnlSZdP2KNf2bA8EjVsk2IhBr7y6a+F+/JXwo4+H51QiPcsa7Dk9M
         QyygEvLXCJ+bEVy9TfpBNLMLcz/NOvwGTGPMkXiegIeAiF7CMlf8+rV3g6yu4j1T28Yi
         ek/MH3CJo6/pj7gBOsxN+rkpIBZlJFVoN2fmBCRIDoJgphVLPfoMcb5/KtJOFcFrIPbQ
         hQvmCtmJE2hEBQOzv9LuS/ZNKa2rhlnel90kBFSAE31jaFW5oshS1QEAPsn11zz8YrZp
         e9qg==
X-Gm-Message-State: AFqh2kqGuD9LBlSOTyD4rtNHWh9qLeohU5dCzE6MJOOQm4EhZfDbgLhA
        lZFs2MSgQVJEIA/jzslG5g==
X-Google-Smtp-Source: AMrXdXvJ8iNrfIQAEQZqn76K9ENlbNXf+Q64nNWqXvJpA7MtqgLrP0m1Q+AXwxcjZXO2EcUA4PdOvg==
X-Received: by 2002:a9d:1b6c:0:b0:66c:4d30:b69f with SMTP id l99-20020a9d1b6c000000b0066c4d30b69fmr25099087otl.24.1675113682417;
        Mon, 30 Jan 2023 13:21:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k96-20020a9d19e9000000b0068bb3a9e2b9sm4296762otk.77.2023.01.30.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:21:22 -0800 (PST)
Received: (nullmailer pid 3506884 invoked by uid 1000);
        Mon, 30 Jan 2023 21:21:21 -0000
Date:   Mon, 30 Jan 2023 15:21:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Message-ID: <20230130212121.GA3468100-robh@kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gmail.com>
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

On Mon, Jan 30, 2023 at 09:34:57PM +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.

In the future, don't thread new versions to old versions of 
patches/series.

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - fix clocks and clock-names
> - consider that more than one compatible may be set
> v3:
> - remove minItem/maxItem properties for compatible
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 71 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
>  2 files changed, 71 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

Reviewed-by: Rob Herring <robh@kernel.org>
