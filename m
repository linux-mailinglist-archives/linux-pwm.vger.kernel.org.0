Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601BF35C76E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhDLNUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:20:30 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37653 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbhDLNU2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 09:20:28 -0400
Received: by mail-oi1-f182.google.com with SMTP id k25so13388248oic.4;
        Mon, 12 Apr 2021 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5n3lwv9EjfPJBx+21UO8C42pguWqHmFLoVLJG4Pmt/8=;
        b=mUO4Tm/BauiG1P7td9TeoY1tkpLhT3ZV9oojGNA5z90atxO4o85V0Dq83FMVWfGPzH
         enHwzcIFwLvYIFOu+ZRUCQ4faOBwuUnefZncZuWd9JDwG4dizIVofNRLyRp8qIroMsys
         BnrqM+hOXeEmxVfVbu26HFJqvf9CSzp3Xc+2wk2w5hdhDOpowjLgaRKO97D346H9WvpR
         KfyzSepG44W/UhOP9uhp1cEWbr4Cnta6xKj7k/o/tQxeoTfcGntPnVjkgFcRXJHGHqz8
         48TMvPs48Qh5dwI+sx+qKtAPRvKrN7YbN3gSAENSrVpik2ErfIVN7QseVyUOGl0hBnL+
         JuMA==
X-Gm-Message-State: AOAM532e8owmAa7UCrmlZGFYibkDGLc1wenKrzSQ7nC57cnoB3CJYoGH
        Z6TfbpMyFtYba9NFGcSkkg==
X-Google-Smtp-Source: ABdhPJxkwQARah6Q/rf1DbNTOAJlUzHL9osoUKpq9VAyJPVrU6baUsVLQdOFRK5Og/wakyM83q8y4Q==
X-Received: by 2002:a05:6808:b09:: with SMTP id s9mr19069272oij.36.1618233610277;
        Mon, 12 Apr 2021 06:20:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm2636995otw.58.2021.04.12.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:20:09 -0700 (PDT)
Received: (nullmailer pid 3757980 invoked by uid 1000);
        Mon, 12 Apr 2021 13:20:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, billy_tasi@aspeedtech.com,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, joel@jms.id.au,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        BMC-SW@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        lee.jones@linaro.org
In-Reply-To: <20210412095457.15095-3-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com> <20210412095457.15095-3-billy_tsai@aspeedtech.com>
Subject: Re: [PATCH 2/4] dt-bindings: Add bindings for aspeed pwm
Date:   Mon, 12 Apr 2021 08:20:00 -0500
Message-Id: <1618233600.223110.3757979.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 12 Apr 2021 17:54:55 +0800, Billy Tsai wrote:
> This patch adds device bindings for aspeed pwm device which should be
> the sub-node of aspeed,ast2600-pwm-tach.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: Additional properties are not allowed ('pwm-cells' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: Additional properties are not allowed ('pwm-cells' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000: failed to match any schema with compatible: ['aspeed,ast2600-pwm-tach', 'simple-mfd', 'syscon']
Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000/pwm@0: failed to match any schema with compatible: ['aspeed,ast2600-pwm']

See https://patchwork.ozlabs.org/patch/1465116

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

