Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B054835F6C9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbhDNOvH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 10:51:07 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34642 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352007AbhDNOu5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 10:50:57 -0400
Received: by mail-ot1-f43.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so19572942otn.1;
        Wed, 14 Apr 2021 07:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=imFjAaiBjLT6LuL67d8A8g+gXv6wR7zTuwnflF5k37w=;
        b=G2+jOiZpR5KmKIliauD7G7JUe+PXdLowMX4PWYOguYOCuplbR5iPtpvdFWzSOJTKkl
         uNF1hsNKF4sz9oICDwZjno6dlG6v4hZ62NTbzKXory66fgPKUiTyKC4La6ThRK8dZzwp
         hN4EYKPICZi+j0rlr1/aeUnt7ImQJwR1m1XKPUepHMbWarUXW2WDnlBsPgDC5WjRiDQl
         jOY2SI7rALynVUXG0+3qcLeSdt9AWkQfcXBmFf1vgxXOuVVzqdeOLAQOpVecItv8uWoE
         GxU5zTEs/6I4kxBjRGEsFSgMbbLKks7etRLNJaDrJBJeGz17VlBMHZ+eM4Edru/l8f3h
         uC0A==
X-Gm-Message-State: AOAM531B6vIl5dDY3vmJmV1EIGIsSO0m3NTcC0XFQ17vIUdM0vJcARys
        1EetIvpba1EnMl8xMGHNdQ==
X-Google-Smtp-Source: ABdhPJx1p2gizTVe4suB3LooLj3w41cuF7yA9Nfe6OWEggQibFEqD0ctuHDjC/AXQoFjiBzMECorGw==
X-Received: by 2002:a9d:7ac6:: with SMTP id m6mr372889otn.350.1618411835755;
        Wed, 14 Apr 2021 07:50:35 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v195sm3653919oia.38.2021.04.14.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 07:50:34 -0700 (PDT)
Received: (nullmailer pid 3605229 invoked by uid 1000);
        Wed, 14 Apr 2021 14:50:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        p.zabel@pengutronix.de, joel@jms.id.au, BMC-SW@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, andrew@aj.id.au
In-Reply-To: <20210414104939.1093-2-billy_tsai@aspeedtech.com>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com> <20210414104939.1093-2-billy_tsai@aspeedtech.com>
Subject: Re: [v2 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Date:   Wed, 14 Apr 2021 09:50:33 -0500
Message-Id: <1618411833.809131.3605228.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 14 Apr 2021 18:49:38 +0800, Billy Tsai wrote:
> This patch adds device bindings for aspeed pwm-tach device which is a
> multi-function device include pwn and tach function and pwm device which
> should be the sub-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: I18d9dea14c3a04e1b7e38ffecd49d45917b9b545
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 60 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 44 ++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000/tach@1: failed to match any schema with compatible: ['aspeed,ast2600-tach']

See https://patchwork.ozlabs.org/patch/1466127

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

