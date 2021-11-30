Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9991F463F61
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbhK3Ujt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 15:39:49 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42757 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Ujr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 15:39:47 -0500
Received: by mail-oi1-f177.google.com with SMTP id n66so43678710oia.9;
        Tue, 30 Nov 2021 12:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wCtcUYBvlVGHN8xKMzrxRVpeHFGARyrqttFdhRjsOvA=;
        b=Uu/P6vwUbtxSMawffxV9qTTmh5lNzMnEEed9RDeBxndfV33GOPqQeb4S/k9stUT5OZ
         sgaTcOYSDgsN6cCZ72HHnqs9xNLVvpTXolIYtLIsNJyvqDwdFxaF0+vOGGVX3pbE3ua4
         uZl/IuzrDxFXJ2qHfhTg3MEK1weL9mxdlcpWFjuedhAXERAQOFqs8KFru/xv70vD0TkI
         /8TvFKsM5VqxkFgfE9VW8cZnXzR75KOdNjx+XfSGzx0/xeyTAWUb7yPDo+Gr10Vbal0h
         nc6qSiCbWbwTh55nxfF5RaMnnRv6PISsLnXHzPoC29z3JAB/IPbTcUoFl1EcD59Y4gX0
         6LCw==
X-Gm-Message-State: AOAM532wIqNPHI3RYsw4MM7niKC2r1XNAsZliyQbbJLYYtectIPdhF/G
        xjfJDOwDH5aMUvflG0XYyA==
X-Google-Smtp-Source: ABdhPJxo/4waI0WrNmDZV3sNCOgq5ecIj9/zvL/GuYMLUN3eYWl8GiKKQIelYEzNSLor+PR+rcuW3g==
X-Received: by 2002:aca:1202:: with SMTP id 2mr1334978ois.63.1638304587919;
        Tue, 30 Nov 2021 12:36:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm3826169oij.16.2021.11.30.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:36:27 -0800 (PST)
Received: (nullmailer pid 2968347 invoked by uid 1000);
        Tue, 30 Nov 2021 20:36:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree@vger.kernel.org, Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>
In-Reply-To: <62ec6016400e80ee379c07ef2c80abbf7f60bbe2.1638293850.git.baruch@tkos.co.il>
References: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il> <62ec6016400e80ee379c07ef2c80abbf7f60bbe2.1638293850.git.baruch@tkos.co.il>
Subject: Re: [PATCH v9 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Tue, 30 Nov 2021 14:36:26 -0600
Message-Id: <1638304586.245688.2968346.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 30 Nov 2021 19:37:29 +0200, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> 
> v9:
> 
>   Add 'ranges' property to example (Rob)
> 
>   Drop label in example (Rob)
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0: /example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561766

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

