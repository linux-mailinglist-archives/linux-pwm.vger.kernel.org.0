Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71894617CA6
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKCMfq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiKCMfp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 08:35:45 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6ACE05;
        Thu,  3 Nov 2022 05:35:44 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id l127so1760266oia.8;
        Thu, 03 Nov 2022 05:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctEEsQads5CkLo5mL4IgkHvsmT6QfdTNkCjoMhVmie4=;
        b=QjpOKStMUxMEPjzKdWTTqrLV6m2OEDoINzaeXZ4vc6i89R4CDocTjyK/U8ciAJaM78
         XYntS/qoNXvtCFwG1+ctbWQDR30Hn7OMtKMZ0pp/hZ+eafRMP8SbmnrxbcMii2W0489E
         UVr6yPaHztLCnUtM7Z8dBuLTMQDMPTJlU2GkHIrYzJOqensREk2mASchV4ZXuY+bNB8/
         6Uapl1tuEheSSjJLNvGophvA803hsxNyKIt2w98syXNY1Hc9UQAVthHqNazqXCrtSNfH
         Hj58E3snLzfDDyD0LbhB69vV/UZ/vs0X7KFa0w9aQLhS7EyXlOgsT1VdbLpOG2KtTMFj
         AXTQ==
X-Gm-Message-State: ACrzQf3ZJrW8OWh6jPBBIK8d9+JMbLvAK9N/XWNCsZt8DvJ/U1BwjgDp
        W3IM7ZN7WmHd5WPwOv/oeQ==
X-Google-Smtp-Source: AMsMyM4xY/9BuzTrmryi5ty1sqLwq35btnBjzkYxON4t40SWLzFPD+VKjWKbsuflHqiB8xaJJr8VKA==
X-Received: by 2002:a05:6808:1186:b0:351:99bf:876c with SMTP id j6-20020a056808118600b0035199bf876cmr16166187oil.54.1667478943209;
        Thu, 03 Nov 2022 05:35:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a44-20020a056870d62c00b00130e66a7644sm296445oaq.25.2022.11.03.05.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:35:42 -0700 (PDT)
Received: (nullmailer pid 2140216 invoked by uid 1000);
        Thu, 03 Nov 2022 12:35:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221103120137.1467905-1-thierry.reding@gmail.com>
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
Message-Id: <166747792400.2122024.7504112765764946849.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Date:   Thu, 03 Nov 2022 07:35:43 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Thu, 03 Nov 2022 13:01:37 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra PWFM bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
>  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
>  2 files changed, 144 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.example.dtb:0:0: /example-1/pinmux@700008d4: failed to match any schema with compatible: ['nvidia,tegra210-pinmux']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

