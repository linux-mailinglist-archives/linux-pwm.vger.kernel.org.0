Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A75F11AE
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiI3Sfo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiI3Sfm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 14:35:42 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7461C902A;
        Fri, 30 Sep 2022 11:35:39 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13207a86076so2166134fac.3;
        Fri, 30 Sep 2022 11:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ECZe/TgJYJpt5vnmP6vYw9Bl2rC4n8fH5ZjHCSNzUO8=;
        b=V8qV4sNzaCkF9+fmkfPXKYfu8DQ0MTM5AQmWsnhu/41gDLldCeVtzH/JUyMWzrYjJV
         sPYAUnooD5lQZoBWXrmuMRCDglpQQnyq4O3+gsN+uMpL6wOrk8MqyKVhKu6rRybCPoBV
         NcNaoZ25SWhqV+TZ1S8Aiwsv56WzBcaLpKKY9qb+S5pOj1GhC8NiyG6dAOro+v4GXCC8
         VtgHhkdAyp1sXeD5WICvlmg6Maexb9OFBAeCbnEkPxx8PGYxKQgEY4tteRWIOD9DaZvC
         FKYCFx2D9SfWE9a1fDFcpqVKiQKMQ/rRjTF6FQnl2QLerfn8z0+aas5CF1nszMNU3YOB
         bL+A==
X-Gm-Message-State: ACrzQf1Y/99AC8l8oAOdj1VKtUeBZhsSElI/C+r2boOF+VAz4OJ18+aC
        /Pz2ds03E4Xgb17Dwtrgyg==
X-Google-Smtp-Source: AMsMyM7mZiUbIMeui3eIgDHbzEvBTZpt+Nd6ZwuHg9QNdShs1EiseooReo4ahleDYAOtmzwqjR11+g==
X-Received: by 2002:a05:6870:eaaa:b0:12b:85ee:5823 with SMTP id s42-20020a056870eaaa00b0012b85ee5823mr12317069oap.234.1664562938995;
        Fri, 30 Sep 2022 11:35:38 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eq24-20020a056870a91800b0011d02a3fa63sm888445oab.14.2022.09.30.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:35:38 -0700 (PDT)
Received: (nullmailer pid 623088 invoked by uid 1000);
        Fri, 30 Sep 2022 18:35:37 -0000
Date:   Fri, 30 Sep 2022 13:35:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Message-ID: <20220930183537.GB567190-robh@kernel.org>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 29, 2022 at 11:30:39AM +0100, Biju Das wrote:
> Document RZ/G2L MTU3 PWM support. It supports following pwm modes.
> 	1) PWM mode 1
> 	2) PWM mode 2
> 	3) Reset-synchronized PWM mode
> 	4) Complementary PWM mode 1 (transfer at crest)
> 	5) Complementary PWM mode 2 (transfer at trough)
> 	6) Complementary PWM mode 3 (transfer at crest and trough)

What does 'complementary' mean here?

Mode 1, 2, 3 isn't very meaningful. Do other PWMs have similar modes? No 
way to tell without better descriptions.

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> index c4bcf28623d6..362fedf5bedb 100644
> --- a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
> @@ -223,6 +223,50 @@ patternProperties:
>        - compatible
>        - reg
>  
> +  "^pwm@([0-4]|[6-7])+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: renesas,rz-mtu3-pwm
> +
> +      reg:
> +        description: Identify pwm channels.
> +        items:
> +          enum: [ 0, 1, 2, 3, 4, 6, 7 ]

At any given level in DT, there is only 1 address space. You've created 
2 with pwms and counters.

> +
> +      "#pwm-cells":
> +        const: 2
> +
> +      renesas,pwm-mode1:
> +        type: boolean
> +        description: Enable PWM mode 1.
> +
> +      renesas,pwm-mode2:
> +        type: boolean
> +        description: Enable PWM mode 2.
> +
> +      renesas,reset-synchronized-pwm-mode:
> +        type: boolean
> +        description: Enable Reset-synchronized PWM mode.
> +
> +      renesas,complementary-pwm-mode1:
> +        type: boolean
> +        description: Complementary PWM mode 1 (transfer at crest).
> +
> +      renesas,complementary-pwm-mode2:
> +        type: boolean
> +        description: Complementary PWM mode 2 (transfer at trough).
> +
> +      renesas,complementary-pwm-mode3:
> +        type: boolean
> +        description: Complementary PWM mode 3 (transfer at crest and trough).

These all look like client configuration and should be either runtime 
config or part of pwm cells args.

> +
> +    required:
> +      - compatible
> +      - reg
> +      - "#pwm-cells"
> +
>  required:
>    - compatible
>    - reg
> @@ -305,6 +349,12 @@ examples:
>          compatible = "renesas,rzg2l-mtu3-counter";
>          reg = <1>;
>        };
> +      pwm@3 {
> +        compatible = "renesas,rz-mtu3-pwm";
> +        reg = <3>;
> +        #pwm-cells = <2>;
> +        renesas,pwm-mode1;
> +      };
>      };
>  
>  ...
> -- 
> 2.25.1
> 
> 
