Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1073F76EB
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhHYOLq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 10:11:46 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43658 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOLq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Aug 2021 10:11:46 -0400
Received: by mail-oi1-f177.google.com with SMTP id w19so933699oik.10;
        Wed, 25 Aug 2021 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ae6tzqkTqYhXXLFz/45g2hcXJMbI6ZYjt4sYjcfQmZ4=;
        b=mduBfrUe5izQEsq9JrF3UHzDK1UitzWFO9kypLoQe2NWMZGneXTaVOmP1FScq7q+VM
         qcfSlCJ0K8ccxl9EarrH0nTJu/jrDSWaiqhdDW0JZG/QWtFr+crUV5TBtjausPxCT5m1
         5slb2b/T6jiHDYwvsRd5DbDG4QXnHUyzJglMmLzkuOHjQcHDGY/GlXhkEAxpKXnqzVQn
         TO71BaIWC/qyEpH7eztdkVAobIeMsge6V3Jdn41yYE8ezhuhxdN5eKb3bKkPmbHRGtb/
         XxTFgXVNaV5xnY8fm1APGLSKHp+uh2/J0jDpwoQKl0AC5tduodsxAZdhsgVg2F/2u8zz
         5TuA==
X-Gm-Message-State: AOAM531jUbdkyvieAD6crRYBMt3i3LRwX6O4oqe9aKjghzvkLPPg0Yzu
        GzWWzsspPJcLOjxDPWEeXRE4ISI14g==
X-Google-Smtp-Source: ABdhPJyIBRLRakUPng4izpT886WMSVH6PSY8Vio9ic7QPmSzexWwZCd8E3/ssDFo/Y3Be/PHzuYuUg==
X-Received: by 2002:a05:6808:2002:: with SMTP id q2mr7010329oiw.1.1629900660071;
        Wed, 25 Aug 2021 07:11:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm4081429oiy.25.2021.08.25.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:10:59 -0700 (PDT)
Received: (nullmailer pid 2719823 invoked by uid 1000);
        Wed, 25 Aug 2021 14:10:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kathiravan T <kathirav@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
In-Reply-To: <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il> <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
Subject: Re: [PATCH v7 3/4] dt-bindings: pwm: add IPQ6018 binding
Date:   Wed, 25 Aug 2021 09:10:58 -0500
Message-Id: <1629900658.219829.2719822.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 25 Aug 2021 12:48:26 +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
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
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0: /example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1520591

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

