Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B385A474C6D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Dec 2021 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhLNUEw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Dec 2021 15:04:52 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34727 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLNUEw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Dec 2021 15:04:52 -0500
Received: by mail-oi1-f181.google.com with SMTP id t19so28720262oij.1;
        Tue, 14 Dec 2021 12:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=RJqjtodrdvg+GjFlTR3WmiDMbCMbLHzHFKDDXT45/9Q=;
        b=k+3fC2Ntwd3C0FvFBVgzKsyLANZeLh5chw1XUFCk4atO2wnl64KlbYh79kUANZ7BQ/
         L0REUVqYwiLgxY+LMtULc+x8iTP2CzHWdhzY/z1YqxnZE2stvM5Pk5ca86wzD5ObmOA2
         IcurzyEFMxj9uSazgS+AhZmpJZRmHfhohlFHEp2tPRIuBoCqa7I3ytb/htnMi8y/0FzY
         zdqX0Vyd5JcRbvAQiRydpJFSXLASfdjoHmnNBTpUPV1HcjglpwMZha5Hy9wqwbUN3FkQ
         aY5xrtNt50vV/PYWHLPrQON1HDdPkZTV1bOXEEId/6oo8MD5nSJ3LiIlmuKT1Xyi0Qab
         /OdA==
X-Gm-Message-State: AOAM532Fd1fzkDk3hj2WuunQyb+OZNJt6Vnrsy8NSCisNcTeyFC1f2tV
        UGmZybSpx5QAyD9fVXmUyg==
X-Google-Smtp-Source: ABdhPJxyuWusHlo7VZe3TYTWV8m+4S+pvP/3wRQxB6XqQu8wB10s/8LoKvS0LuyEz0e6B3WOTMaVxg==
X-Received: by 2002:a05:6808:158d:: with SMTP id t13mr6133558oiw.31.1639512291886;
        Tue, 14 Dec 2021 12:04:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s1sm158309ooo.11.2021.12.14.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:04:51 -0800 (PST)
Received: (nullmailer pid 3819894 invoked by uid 1000);
        Tue, 14 Dec 2021 20:04:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Baruch Siach <baruch.siach@siklu.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <b5053b42f73e574f48cf860a8e225d6b1939d216.1639499239.git.baruch@tkos.co.il>
References: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il> <b5053b42f73e574f48cf860a8e225d6b1939d216.1639499239.git.baruch@tkos.co.il>
Subject: Re: [PATCH v10 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Tue, 14 Dec 2021 14:04:50 -0600
Message-Id: <1639512290.319512.3819893.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 14 Dec 2021 18:27:18 +0200, Baruch Siach wrote:
> From: Baruch Siach <baruch.siach@siklu.com>
> 
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> ---
> This series does not convert the TCSR binding documentation to YAML. As
> a result, this commit adds new a dt_binding_check warning:
> 
> /example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']
> 
> If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
> for someone else to push them further.
> 
> v10:
> 
>   No change
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

See https://patchwork.ozlabs.org/patch/1567793

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

