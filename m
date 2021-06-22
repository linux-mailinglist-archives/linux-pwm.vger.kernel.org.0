Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0223B0785
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jun 2021 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhFVOjK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Jun 2021 10:39:10 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:44026 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhFVOjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Jun 2021 10:39:09 -0400
Received: by mail-il1-f179.google.com with SMTP id q18so18610718ile.10;
        Tue, 22 Jun 2021 07:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zOeQKdyOXah3VV0EelxuSLVcqrkzjeqR3cfPi6bJjF4=;
        b=YNAGvnM3IRi+owCXCJxJSopVr9+LOBRn8yN69NQKZa1GAbF9Pvpx/26mks6keoHglm
         Pi1t+TRVxvRUpHLifNdQZUQR8YnG1iMITx1bqxZNSIg60Wc4KevGvNqpdD1MAXf8F5GE
         5wYYJHZRlOeZZc1nlpmiX0nJoRdKqYm3H2ec3XUI5MtwS4hUTq/P9nOUXQmCGyt91doI
         mXRzcLxbDDoY4BZ98JcU4SUiYhmap4//mWo7DIgs+kE/0Px/3UnlerGXdPAW1aXn3I1E
         m+JrunT88FqpuXxPhNSCZwS8c3geHfRj57aUKNWFQqb8C/qu4Jtuoj3iDyla5BAgnHGc
         HlHA==
X-Gm-Message-State: AOAM530crUAi3yctsGpQRy5CoDoEjcAZa5g+kGIUoSXIxoz6ZCxvpXzl
        hdy1kqiMWNKMsK+3oCRqmkvZ8iEroA==
X-Google-Smtp-Source: ABdhPJzEyRd7o5rIAPVeB5UMUP7Zye1uKUBirPzK4G6V5f06Vk/QK1q1b5zdkhzhCFfh6ZnphebibQ==
X-Received: by 2002:a92:8e45:: with SMTP id k5mr3016527ilh.116.1624372611596;
        Tue, 22 Jun 2021 07:36:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x16sm7897382ilq.57.2021.06.22.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:36:50 -0700 (PDT)
Received: (nullmailer pid 3566368 invoked by uid 1000);
        Tue, 22 Jun 2021 14:36:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <bf56a9968149a7a70e6ef747ff054ee3728b467c.1624348502.git.baruch@tkos.co.il>
References: <f97c32aa98c9cdd977fac22cd504ad97448949e9.1624348502.git.baruch@tkos.co.il> <bf56a9968149a7a70e6ef747ff054ee3728b467c.1624348502.git.baruch@tkos.co.il>
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Tue, 22 Jun 2021 08:36:40 -0600
Message-Id: <1624372600.495807.3566367.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 22 Jun 2021 10:55:01 +0300, Baruch Siach wrote:
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
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
Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0: /example-0/soc/pwm@1941010: failed to match any schema with compatible: ['qcom,pwm-ipq6018']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1495481

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

