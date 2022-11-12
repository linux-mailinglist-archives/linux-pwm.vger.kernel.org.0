Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FAC6265D1
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Nov 2022 01:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKLAKJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Nov 2022 19:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKLAKI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Nov 2022 19:10:08 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC437CE1;
        Fri, 11 Nov 2022 16:10:06 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id r76so6292925oie.13;
        Fri, 11 Nov 2022 16:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J/s/8WrMybomH+uSoTBx79E7XvX1snTU0smn6/Ob6qY=;
        b=Pp6wJkNOAp8EnrVSchY9IEqGKmRsS2ME1CU5dzXaDBmqA7/fSxkRR8L9BD5aIR+HX/
         dOGBz7hF9CcuBwJb73SdzF3If2snrOO8rRI8K8539KGQN0YnfikN0HXU77bvxs2jvByj
         QNQ/7hBEsReyZQnInclsHsNWjtnyDUMhfonCx1Q7+VpqzII0OfY/PaF+oswc9xVmeHX0
         HP/VuFHwx9Nl0xMSpFICFpistyiIsxv4ycx3WVt4Ms67fgerR9IuQIu9vxj7iC/TKdBr
         /oHf4x6Aew9qKb8WMEuPGrvVqyErkM9mguSOaNhOCasFPINakq/0qqJcSVTnVJ9onKcw
         hKfQ==
X-Gm-Message-State: ANoB5pnOexBugMgV8BkwKtbPpsMzPS5oSXYF0YM+hCuAvnyOZkblTEdi
        XuX63XdZzIpXo1nf66kXgA==
X-Google-Smtp-Source: AA0mqf4Ep5nf7YszEiII97XrlA5yBV1xgevCzjsoVwBxRXju2usMMGxe5Nno0cyl45VOPX5o6H+XLg==
X-Received: by 2002:a05:6808:1492:b0:359:c597:735f with SMTP id e18-20020a056808149200b00359c597735fmr1900723oiw.206.1668211806151;
        Fri, 11 Nov 2022 16:10:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l37-20020a05687106a500b00131c3d4d38fsm1990406oao.39.2022.11.11.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 16:10:05 -0800 (PST)
Received: (nullmailer pid 299133 invoked by uid 1000);
        Sat, 12 Nov 2022 00:10:07 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Chris Paterson <chris.paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
Message-Id: <166821148218.241040.12720094893409312973.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Date:   Fri, 11 Nov 2022 18:10:07 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 11 Nov 2022 19:29:41 +0000, Biju Das wrote:
> RZ/G2L GPT IP supports output pin disable function by dead time
> error and detecting short-circuits between output pins.
> 
> Add documentation for the optional property renesas,poegs to
> link a pair of GPT IOs with POEG.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * removed quotes from ref
>  * Added maxItems and minItems for renesas,poegs property
>  * Added enums for gpt index
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml: properties:renesas,poegs:items: 'oneOf' conditional failed, one must be fixed:
	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to POEG instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, 5, 6, 7], 'description': 'An index identifying pair of GPT channels.\n  <0> : GPT channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels 4 and 5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> : GPT channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT channels 14 and 15\n'}]} should not be valid under {'required': ['maxItems']}
		hint: "maxItems" is not needed with an "items" list
	{'maxItems': 8, 'minItems': 1, 'items': [{'description': 'phandle to POEG instance that serves the output disable'}, {'enum': [0, 1, 2, 3, 4, 5, 6, 7], 'description': 'An index identifying pair of GPT channels.\n  <0> : GPT channels 0 and 1\n  <1> : GPT channels 2 and 3\n  <2> : GPT channels 4 and 5\n  <3> : GPT channels 6 and 7\n  <4> : GPT channels 8 and 9\n  <5> : GPT channels 10 and 11\n  <6> : GPT channels 12 and 13\n  <7> : GPT channels 14 and 15\n'}]} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

