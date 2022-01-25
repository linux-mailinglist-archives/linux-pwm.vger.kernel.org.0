Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974FD49B674
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 15:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387633AbiAYOgA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 09:36:00 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42736 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456362AbiAYOZ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 09:25:56 -0500
Received: by mail-ot1-f41.google.com with SMTP id z25-20020a0568301db900b005946f536d85so26549331oti.9;
        Tue, 25 Jan 2022 06:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NMoUwM8BBTLBkP04dan9yDTmthaJAHLTUf/g9SYldSI=;
        b=enMUSqCfkA/E/zBBODy6o8IUEol4jV1ZxAoivSJITSRLe0x8oWShxhLmxkIWmdM4W4
         srpwe4/O0ekJ9pIvUYJoJ2XHVff6fC7UX/Li40xOSWRvrUnL3RE0vs43WzgOXUU1kVs5
         JGMbKkmQ2VSk24l5fJZyIZLqpo3hcvwC2nBqFDj5Uhujcn5TVWw7D++xc1W1BZImgZkb
         /F0QBFNBqnlkPsgC/hYV7TTGKyPU3x6qVXjZmldY+hE7kOOPwZ6nDs8UYYxhpKfFhbuJ
         +OAffvASeX66ctJnMYzRAji44jdEfd3v4iiRyem7lb1a/y1u7czAW6hCbnSeo2tbfAnL
         NwIg==
X-Gm-Message-State: AOAM5337PeYgw7Dd7korJxclcl7pHLIvg9ifLlUGZ+3SNDlpzzXNlCHL
        nLGCina++XlNArjGOTomDQsAAlCRtw==
X-Google-Smtp-Source: ABdhPJxveN4LXBKKxibvyNYmSzU78gq0mvteAN1tf7rCNGjcPC2TMHGSYosKrHGixpsyOyIWv1AzSA==
X-Received: by 2002:a05:6830:2b22:: with SMTP id l34mr15697377otv.316.1643120751480;
        Tue, 25 Jan 2022 06:25:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v26sm3536393ooq.20.2022.01.25.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:25:50 -0800 (PST)
Received: (nullmailer pid 2216641 invoked by uid 1000);
        Tue, 25 Jan 2022 14:25:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     devicetree@vger.kernel.org, thierry.reding@gmail.com,
        dmurphy@ti.com,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, pavel@ucw.cz
In-Reply-To: <20220125092239.2006333-2-sven@svenschwermer.de>
References: <20220125092239.2006333-1-sven@svenschwermer.de> <20220125092239.2006333-2-sven@svenschwermer.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Date:   Tue, 25 Jan 2022 08:25:49 -0600
Message-Id: <1643120749.752659.2216640.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Jan 2022 10:22:38 +0100, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml: properties:compatible: 'pwm-leds-multicolor' is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/leds/leds-pwm-multicolor.example.dts:24.25-43.15: Warning (unit_address_vs_reg): /example-0/rgb-led/multi-led@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/leds/leds-pwm-multicolor.example.dt.yaml:0:0: /example-0/rgb-led: failed to match any schema with compatible: ['pwm-leds-multicolor']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1583948

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

