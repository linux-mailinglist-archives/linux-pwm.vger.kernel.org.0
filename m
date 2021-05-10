Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215B9379042
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhEJOKE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 10:10:04 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44556 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbhEJOC5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 10:02:57 -0400
Received: by mail-ot1-f45.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14477675otp.11;
        Mon, 10 May 2021 07:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JKsO3/Ex9MYUNGYvtUUsilRIUDXYRO1OT6ejMhv7T8k=;
        b=IAZHduJ4ITLsJb1ZPAZwrEwfPXhROp8zcUw7QyqEFNUdO/ESryuNkA+N5UEYXp5GMK
         jwoo8skjwFUhLvoO/Ks1Fe4dS4/6hASWa06xuQlRCvGiNWW8Xe022amps1+JTFaroGHv
         EshcFTUHMorSOhrUv1cCttjyQKN3Vxo9XIclCEF9bkGYS2AXD8HlscbSa9gYZVaefJpx
         xciBmgIjhN5owv3790CMOkPjT9imtk0SsIgilfifRDKlNb6irEg8TyNwN9KEl7EmlGky
         7Qnqmsa7JWlFHd1jCn/gVf0N2vayd9V9ZyswpcYyxveb/QAfEM6UxL4FFYsbIrMFhNsA
         d9Rg==
X-Gm-Message-State: AOAM532Cqf0n+um1U7VtBR1qmWdcH47sBHGZGhBy4fykrpOV6iCBUQ7m
        gSyvUOtL94hLEXaYQbpiUxIhoPI8fA==
X-Google-Smtp-Source: ABdhPJzkMirGR5MPxh2vUgnso6g9WUTGlKFG5pxnf2yqU3vz/35X9pfPvS3TiXp4ftEr9Ospw50ksA==
X-Received: by 2002:a05:6830:17cb:: with SMTP id p11mr22366787ota.283.1620655310131;
        Mon, 10 May 2021 07:01:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm2648753oob.12.2021.05.10.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:01:48 -0700 (PDT)
Received: (nullmailer pid 41441 invoked by uid 1000);
        Mon, 10 May 2021 14:01:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        joel@jms.id.au
In-Reply-To: <20210510073511.7291-2-billy_tsai@aspeedtech.com>
References: <20210510073511.7291-1-billy_tsai@aspeedtech.com> <20210510073511.7291-2-billy_tsai@aspeedtech.com>
Subject: Re: [v4 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Date:   Mon, 10 May 2021 09:01:39 -0500
Message-Id: <1620655299.806171.41440.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 10 May 2021 15:35:10 +0800, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 66 +++++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 82 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 62 ++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml: Additional properties are not allowed ('child-node' was unexpected)
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml: 'child-node' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: Additional properties are not allowed ('child-node' was unexpected)
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: 'child-node' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
schemas/pwm/aspeed,ast2600-pwm.yaml: ignoring, error in schema: 
schemas/hwmon/aspeed,ast2600-tach.yaml: ignoring, error in schema: 
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: Additional properties are not allowed ('child-node' was unexpected)
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: 'child-node' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000: failed to match any schema with compatible: ['aspeed,ast2600-pwm-tach', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000/pwm: failed to match any schema with compatible: ['aspeed,ast2600-pwm']
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dt.yaml:0:0: /example-0/pwm_tach@1e610000/tach: failed to match any schema with compatible: ['aspeed,ast2600-tach']

See https://patchwork.ozlabs.org/patch/1476200

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

