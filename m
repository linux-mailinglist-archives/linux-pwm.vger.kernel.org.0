Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A8628F76
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 02:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKOBqO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Nov 2022 20:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiKOBqN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Nov 2022 20:46:13 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D917595;
        Mon, 14 Nov 2022 17:46:12 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so4704967otl.7;
        Mon, 14 Nov 2022 17:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi91ahiQIoGvCZWAUPP5kOHU6v7qaZgEIwBwcjO9saQ=;
        b=NVYDJOdnuzY4CZzJ7B6AfUWAtWBQgpmRUyG7/9u37pOWSeWJGApxehMALLnN0VvoOj
         0/+fzjGVifUa7oESa5kkpDi6cBPosQnKD88xME/NKBNjzLfwA1BmfnV1vsBR4jYuHZO2
         R7ClBn3s3cNf23lzlPjWeqNNyHqtD42nHk5fIjDXvhKYNPV37uOn6rYvnHXVGKOO/HgL
         qBuCZ9+xMKs/mUc6ekefNrDbnzicgPcasMdt/TTOJT12XzKunqRy1Y5k9lY/nzHQWCXS
         4XwATM/bF2vhjKODwfsmtDr8baq64FjDrJ/H1LQmhGw550/luZGr0W5XouLJ8z9t7Kbv
         Gvpw==
X-Gm-Message-State: ANoB5pkrDPG9IcMpeyv9arEgT9ZSNKgda8JWSrQVWeX0Uz5YjRFqN5YN
        FaIeKwy1zDRTqYT2DRAZYg==
X-Google-Smtp-Source: AA0mqf7spjcvTUSXPUDNToQVXF9rEDiP5y6or5HrZEKTrVuQYY62pfquUcj4D0uJ8BEnXoSVOflyVA==
X-Received: by 2002:a05:6830:22d9:b0:661:c09b:ee65 with SMTP id q25-20020a05683022d900b00661c09bee65mr7405930otc.213.1668476771849;
        Mon, 14 Nov 2022 17:46:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 128-20020a4a0d86000000b004805b00b2cdsm4299638oob.28.2022.11.14.17.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:46:11 -0800 (PST)
Received: (nullmailer pid 3961451 invoked by uid 1000);
        Tue, 15 Nov 2022 01:46:13 -0000
Date:   Mon, 14 Nov 2022 19:46:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Message-ID: <20221115014613.GA3959192-robh@kernel.org>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111192942.717137-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Nov 11, 2022 at 07:29:41PM +0000, Biju Das wrote:
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
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> index 620d5ae4ae30..5219032c60ee 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> @@ -245,6 +245,28 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  renesas,poegs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 8
> +      minItems: 1

I think you want these moved up a level with the 1st 'items'. It's 1-8 
tuples, right?

> +      items:
> +        - description: phandle to POEG instance that serves the output disable
> +        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +          description: |
> +            An index identifying pair of GPT channels.
> +              <0> : GPT channels 0 and 1
> +              <1> : GPT channels 2 and 3
> +              <2> : GPT channels 4 and 5
> +              <3> : GPT channels 6 and 7
> +              <4> : GPT channels 8 and 9
> +              <5> : GPT channels 10 and 11
> +              <6> : GPT channels 12 and 13
> +              <7> : GPT channels 14 and 15
> +    description:
> +      A list of phandle and channel index pair tuples to the POEGs that handle the
> +      output disable for the GPT channels.
> +
>  required:
>    - compatible
>    - reg
> @@ -375,4 +397,5 @@ examples:
>          power-domains = <&cpg>;
>          resets = <&cpg R9A07G044_GPT_RST_C>;
>          #pwm-cells = <2>;
> +        renesas,poegs = <&poeggd 4>;
>      };
> -- 
> 2.25.1
> 
> 
