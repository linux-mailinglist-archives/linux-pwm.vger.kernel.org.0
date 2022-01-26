Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0549C21A
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiAZD3V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 22:29:21 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34731 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiAZD3V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 22:29:21 -0500
Received: by mail-oi1-f175.google.com with SMTP id bb37so35112516oib.1;
        Tue, 25 Jan 2022 19:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1yb1SzZkawQnAeWOCob2jXUUyagIMae11h2jfoANoA0=;
        b=DrQxn9z+VFKXGqAQmxHIHFq2xzGdITCum9TJY3vZ+vs8MMmKAN9EP6gGsQ2nUwatUs
         SWv0nzLcJunjsCuGUOV0mpEM+ZH2orI63cFK5ezL0tt7OJIKYSy7a+i/EatacGRzIuNI
         zm+QrWFbg3HIEoRAnrQwmt7RUjTxY2ShP8bm+a6RNLaVpnBWNTb51YUygheDMzc3bus7
         bkPn1NWGXJH6a9lOpaX2toYHT8B1YrN2HNetF0XTDjJ54yTVOIn5ZNUVwdXGC9Q8u854
         yufQHki9n4002yDHZrhmSUlxivu7Xb28kiIcDgqs2U01+BnOgslU6gtsqzVdea4xIqWd
         /mxw==
X-Gm-Message-State: AOAM530gRlA1sYZv2La0ijifpPpPOCmOFW7C8ikHw5aUU+W5UGGIFNQ7
        3/y8OaHfy8yETQIzhjYNjA==
X-Google-Smtp-Source: ABdhPJwP4tM66M9iDxYnOP75qTdNeHfxBQaB4FW32sVcvKc0AOQ7DeD9lCZvn5l7FWX2DZoS7oNC3A==
X-Received: by 2002:aca:eb53:: with SMTP id j80mr2664122oih.33.1643167760634;
        Tue, 25 Jan 2022 19:29:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q3sm3620121oom.9.2022.01.25.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 19:29:20 -0800 (PST)
Received: (nullmailer pid 3724353 invoked by uid 1000);
        Wed, 26 Jan 2022 03:29:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     dmurphy@ti.com, lee.jones@linaro.org, post@lespocky.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-leds@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, u.kleine-koenig@pengutronix.de,
        thierry.reding@gmail.com
In-Reply-To: <20220125151226.31049-2-sven@svenschwermer.de>
References: <20220125151226.31049-1-sven@svenschwermer.de> <20220125151226.31049-2-sven@svenschwermer.de>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Tue, 25 Jan 2022 21:29:18 -0600
Message-Id: <1643167758.829977.3724352.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Jan 2022 16:12:25 +0100, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/leds-pwm-multicolor.example.dts:24.25-43.15: Warning (unit_address_vs_reg): /example-0/rgb-led/multi-led@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1584106

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

