Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434DE545442
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jun 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiFISjS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jun 2022 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiFISjR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jun 2022 14:39:17 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEFB8BE1;
        Thu,  9 Jun 2022 11:39:16 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id h8so4698054iof.11;
        Thu, 09 Jun 2022 11:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vpGjf5f2hCMK/dOd5Ud/UWN4pv1x98Yt51zG6FEFrE=;
        b=VWFMejHyx0ma4xgYF2MKaBYkTZWoccVpYuY1zv7EtV2ozPrWDpTdD7dycl2MuCDTn+
         CBFztDZNzmvzKtP92EYgzLs17hHSkkiQkZFfYbCIQWp9luhV54SC4KneBgUtl4U56skc
         IaPAxSyAhYwS2sA9qlWNwvz8mLbhDMtKrjmQaaiSbCJOhczLJX0KniApGZPmwsX85Q8g
         EA94Xu99i8wecUpxGjs20enRpfSqNWgCGWYazTPoLuqgytWFNTHdbJnn86a3sCmIhZTy
         OsARXbQFVjlo0mI/aYWdozsDi4/4Nq3/XC8JCSZHeTmQZ8pp05yYypk5ZX2xUamVBpMj
         unxg==
X-Gm-Message-State: AOAM5320Fc5If34B0DA7PRFOKIJV3qhVbM3r0rSy/zMGCynMSSRFLW4z
        g8Pc49WqcxcO3z9VFTv3Tw==
X-Google-Smtp-Source: ABdhPJxZ9+SqYHxtLPBH9TYjtcQ7aniemxdDnaQl2V9C86e9xNpwSUF8mIBOq6HuXa4wWu2EuYGXvg==
X-Received: by 2002:a05:6638:3389:b0:331:f5e7:7dda with SMTP id h9-20020a056638338900b00331f5e77ddamr4163700jav.93.1654799955565;
        Thu, 09 Jun 2022 11:39:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b14-20020a05663805ae00b00331d98c9a7fsm3509665jar.40.2022.06.09.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:39:15 -0700 (PDT)
Received: (nullmailer pid 4090610 invoked by uid 1000);
        Thu, 09 Jun 2022 18:39:12 -0000
Date:   Thu, 9 Jun 2022 12:39:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <20220609183912.GA4090532-robh@kernel.org>
References: <20220606160509.250962-1-biju.das.jz@bp.renesas.com>
 <20220606160509.250962-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606160509.250962-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 06 Jun 2022 17:05:08 +0100, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
>  * Added '|' after 'description:' to preserve formatting.
>  * Removed description for pwm_cells as it is common property.
>  * Changed the reg size in example from 0xa4->0x100
>  * Added Rb tag from Geert.
> RFC->v1:
>  * Added Description
>  * Removed comments from reg and clock
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
