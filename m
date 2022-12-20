Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2819D6525C0
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Dec 2022 18:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiLTRs1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Dec 2022 12:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTRsZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Dec 2022 12:48:25 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF11AA23;
        Tue, 20 Dec 2022 09:48:24 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso16263742fac.4;
        Tue, 20 Dec 2022 09:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oet693/p3sVB8b4DgWDMdR32Ic9LYa+sYOHCBwT9664=;
        b=eUcXVAhLLP7N3Z56OWg2Jfy7PRL/rDrFDwXajjJ3AdAx9LuEJxuDZ9/CvPX+ygRpp0
         +4ZcAo0LLdh6XpAIec1q71+hdGo7LLryqjDw8bHVLkpwn+0HS3A2ARmOzk6E27cLt+q9
         RxNRZRDm8QAIj8VJxoC2yvQBsI+iK1ZVv+lZBhJDp/oUzIT2lnaK1F1vRrPmDYsOL4Ae
         JoeZ2WoCrPgl/WrmCIbMYpO6Y+OBVEabxaRF+o5oJ0A7U7iGukTtoqEU2osnnDB8ddTK
         9IpOAdDy4gApIgs09uDmcKdc5r/PpTwS6ppH3dYwCDxrT9T4Z/ODbGtj+ucxLAAQsJgK
         y3gA==
X-Gm-Message-State: ANoB5pmWXjNzdY4jhbEaxP/b/z7nXxCJRLsvmuSP6etMzZhVv3o24T6d
        JRnDniYeUgAQmc0KKTiViQ==
X-Google-Smtp-Source: AA0mqf7vx88q+cirPS1uYB4/bKHpZxlwmkAwScRaiVwvlw1XzFnNS/j0P0MzgUsW2JcuWo2BEFZh8A==
X-Received: by 2002:a05:6870:b420:b0:13b:aef2:4186 with SMTP id x32-20020a056870b42000b0013baef24186mr23843058oap.51.1671558504031;
        Tue, 20 Dec 2022 09:48:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ej11-20020a056870f70b00b0011f22e74d5fsm6255289oab.20.2022.12.20.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:48:23 -0800 (PST)
Received: (nullmailer pid 807982 invoked by uid 1000);
        Tue, 20 Dec 2022 17:48:22 -0000
Date:   Tue, 20 Dec 2022 11:48:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pwm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chris Paterson <chris.paterson2@renesas.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Message-ID: <167155850158.807889.11454048174067240573.robh@kernel.org>
References: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
 <20221215205843.4074504-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215205843.4074504-3-biju.das.jz@bp.renesas.com>
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


On Thu, 15 Dec 2022 20:58:42 +0000, Biju Das wrote:
> RZ/G2L GPT IP supports output pin disable function by dead time
> error and detecting short-circuits between output pins.
> 
> Add documentation for the optional property renesas,poegs to
> link a pair of GPT IOs with POEG.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Moved minItems/MaxItems one level up.
> v1->v2:
>  * removed quotes from ref
>  * Added maxItems and minItems for renesas,poegs property
>  * Added enums for gpt index
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
