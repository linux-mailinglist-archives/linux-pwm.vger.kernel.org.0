Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EE62CAB1
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Nov 2022 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKPUWB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Nov 2022 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiKPUVv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Nov 2022 15:21:51 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638CF391EA;
        Wed, 16 Nov 2022 12:21:50 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13ae8117023so21452670fac.9;
        Wed, 16 Nov 2022 12:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sbkEVOJXoNrlwfCssAqSE8GM9Mgiqfue29uDrX82rI=;
        b=B7/aNm8g3jy5iMNB/gMHng/wjFtQzNsvZbRJpIQnk90B4nQqW75yN1x2DCk+corBdL
         Pj55ywyu4E/I2ziWKMmHFxBifa2nNUDq0iw6ek9CanuxeGXZmDO+d5QcaKAZzUPrxWuC
         DE54NPCbUS/c3D3nb7SKuyaSFbKIRQM9ZLtr1h2MxIy84UobxMb34jr3OQQEtQ/JRvWe
         ufOE04zo197s30e3AVrwSm9dOfuOgmGyOGXvA2JF1qLvghIHkPGid12RBENPFx1zh3Eu
         hhIzTG3vc/ftrxxOj1t3kyoX6YmmjE87QQrf4COInsbGM0cVDGxqrdcqK3wW3/Fvh1K3
         aFdQ==
X-Gm-Message-State: ANoB5pmUHRc+8ZaBlTx0/RNM25EsynOID0oxuO8uUUDOs9yrCMSvemB2
        gjjM98cEKAGENkjrJ3oyWQ==
X-Google-Smtp-Source: AA0mqf5P0fkB9QHFiccqQsvA8l9WjDp/FL7DjSzVhK8k2KuFcXLCCk00ykise5ANniVeO93CgyfaoA==
X-Received: by 2002:a05:6870:b93:b0:136:425a:fd27 with SMTP id lg19-20020a0568700b9300b00136425afd27mr2681340oab.64.1668630109539;
        Wed, 16 Nov 2022 12:21:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m18-20020a056870059200b0013ae5246449sm8555230oap.22.2022.11.16.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:21:49 -0800 (PST)
Received: (nullmailer pid 824637 invoked by uid 1000);
        Wed, 16 Nov 2022 20:21:51 -0000
Date:   Wed, 16 Nov 2022 14:21:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG
 binding
Message-ID: <166863011070.824579.9935152005470545610.robh@kernel.org>
References: <20221111194059.718154-1-biju.das.jz@bp.renesas.com>
 <20221111194059.718154-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111194059.718154-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 11 Nov 2022 19:40:58 +0000, Biju Das wrote:
> Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Replaced companion->renesas,gpt for the phandle to gpt instance
>  * Replaced renesas,id->renesas,poeg-id
>  * Removed default from renesas,poeg-id as default for a required
>    property doesn't make much sense.
>  * Updated the example and required properties with above changes
> v2->v3:
>  * Removed Rb tag from Rob as there are some changes introduced.
>  * Added companion property, so that poeg can link with gpt device
>  * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
>  * Updated the example.
> v1->v2:
>  * Updated the description.
> REF->v1:
>  * Modelled as pincontrol as most of its configuration is intended to be
>    static.
>  * Updated reg size in example.
> ---
>  .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
