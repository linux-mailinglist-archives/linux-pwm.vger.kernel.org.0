Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6505EFC4E
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiI2Rwc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiI2Rwa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 13:52:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE714C046;
        Thu, 29 Sep 2022 10:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56850B81CFA;
        Thu, 29 Sep 2022 17:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FD7C433C1;
        Thu, 29 Sep 2022 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664473945;
        bh=8OMSC9E250QQJouigNTXLBFo+krYl2W3+szwFr+DihE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yxu5Y+Z1mRu85qYMgKYqX+ge3XgC4pdQc+BxVHmLnhlM6IQHbyOZiePOQj3nbMQS6
         UganQobYur/c7jghCelRBgOLOVxkSWxdhSY7bEcsvvVJM1e68sv/FyvNrTRkcRokAs
         K/+XQHGGabeg2Y5rJGSxlffwzchWJUrMj9hOr9dA4kV9y6b0OP2nAzbD0+jUEWlg2e
         mpusRM40cHQJMC+2ZZn9ESJU/rA3yjEoY0RuES7GCW0MxSPuHXJ3Yb5Hh+jPzPd+yI
         TDiqThWtZT2Fpdx6BcpPbFDW11vF2Y6NTgmLsigeMvvEF2hqU2nR0YMXZW51uUdt3h
         5VvjFr4ouNxdg==
Date:   Thu, 29 Sep 2022 18:52:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <YzXbU69imBM5aKwn@google.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 29 Sep 2022, Biju Das wrote:

> Document RZ/G2L MTU3 PWM support. It supports following pwm modes.
> 	1) PWM mode 1
> 	2) PWM mode 2
> 	3) Reset-synchronized PWM mode
> 	4) Complementary PWM mode 1 (transfer at crest)
> 	5) Complementary PWM mode 2 (transfer at trough)
> 	6) Complementary PWM mode 3 (transfer at crest and trough)

Shouldn't all this go in the PWM driver binding?

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

-- 
Lee Jones [李琼斯]
