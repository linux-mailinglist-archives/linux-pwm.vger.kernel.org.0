Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876795FC8E9
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Oct 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJLQKu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Oct 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJLQKt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Oct 2022 12:10:49 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CA5301A;
        Wed, 12 Oct 2022 09:10:48 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id l5so19580941oif.7;
        Wed, 12 Oct 2022 09:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5nfVGttcfS2Qx29EmT7eIAyFp05PRBGUmnlDuw8/8Y=;
        b=sQu8O2WbchnCdDFkCV9LFX5kgS1dHIUvLNRg2CW1Z+H0r8hz9T96Iuw05pAHAALwJV
         Qv1l8lSxh5LS0Ffv7Jl51LOi0cFpN6PQWCOIr0zAivWBxzXYKPcq5X1tnyJ8BS+bLcoK
         suFs4IDqQ7nElvdyNMUWx1jEQah7xArF4nIkYirJi6DwLaywowBiFgeDVWCKNcPFRSzD
         etIsY5onGa5eFzikRg8YI+o7i/33DC33obW/7mc0FnIR8r4Ml2QvhHyyLhuYv1Pxc/JW
         ZwvSQehgjc3V1XIrDeb9K0/xE+nbpJxcydp5rlyPKWrL2aGxVpI/yYptCjwcdiTXI8kc
         nLGw==
X-Gm-Message-State: ACrzQf3ydLuuIQVD6QeHKQYQF4CXvIn2wmBZOkRDHaYztXyEs8I+o3I1
        +eKld0dG76zr4wOSo/wmbw==
X-Google-Smtp-Source: AMsMyM5zySNiT7AeWdpH5HpvgmCX+7J3LX2aiwxqw8PKyFxsH+AFEdoknuBk5bpw4cP5c410opywdg==
X-Received: by 2002:a05:6808:2226:b0:354:ab07:4f12 with SMTP id bd38-20020a056808222600b00354ab074f12mr2463085oib.234.1665591047619;
        Wed, 12 Oct 2022 09:10:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b40-20020a4a98eb000000b00480549b424asm1096201ooj.34.2022.10.12.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:10:47 -0700 (PDT)
Received: (nullmailer pid 2270015 invoked by uid 1000);
        Wed, 12 Oct 2022 16:10:48 -0000
Date:   Wed, 12 Oct 2022 11:10:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <166559104805.2269963.18219742807985150114.robh@kernel.org>
References: <20221011134135.1930260-1-biju.das.jz@bp.renesas.com>
 <20221011134135.1930260-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011134135.1930260-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 11 Oct 2022 14:41:34 +0100, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v7->v8:
>  * Removed Rb tags from Rob and Geert as it modelled as single GPT
>    device handling multiple channels.
>  * Updated description
>  * Updated interrupts and interrupt-names properties
>  * Updated example
> v6->v7:
>  * No change.
> v5->v6:
>  * No change.
> v4->v5:
>  * No change.
> v3->v4:
>  * No change.
> v2->v3:
>  * Added Rb tag from Rob.
> v1->v2:
>  * Added '|' after 'description:' to preserve formatting.
>  * Removed description for pwm_cells as it is common property.
>  * Changed the reg size in example from 0xa4->0x100
>  * Added Rb tag from Geert.
> RFC->v1:
>  * Added Description
>  * Removed comments from reg and clock
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++++++++
>  1 file changed, 378 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
