Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEF4B94C0
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Feb 2022 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiBPX5F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Feb 2022 18:57:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBPX5F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Feb 2022 18:57:05 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125021409FE;
        Wed, 16 Feb 2022 15:56:51 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id 24so1734325ioe.7;
        Wed, 16 Feb 2022 15:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjf4TuuxXPIxvfDkMwqUajUWR+H2GEmQF/IzXz/JxgM=;
        b=r+43rOD8e2p4FQuP7YUrluT4NtjpT+1wsuqqqOa3M+yCIy/A3XLMk3ICg7rK0TgswJ
         0O2I4rfiOlD9rEEilkRx1hieQVfrk2vlc8+X//QBqzy6OmX5A0jrZW4jl9P5pm8mYZ8P
         2r6J6Uiw8EF+vVY2EEYMYoS6PSpNeSkCGdJPZ5b7y6xZYyxP68sTHDN7ttXCjXt5jBBV
         RmX1nhvFr2w75cvGVuSK2vtLXnMLg7a+yS/KaLu5AjQpLa51fyuokFne4SY7j6td9nkO
         /ha2qnaU45/xDC3IKmUfYkMPVglPdoEebP7mi+JmSiUPgHZ2MImcUMm1hUBoPdOovb6A
         FpVA==
X-Gm-Message-State: AOAM532HAiN5pFF2I21IvbkV5tLdNdVW0b30EM1Bg92fh6uxg6aCGNuL
        wT4Lay/WZtkYhLMtLj/Veg==
X-Google-Smtp-Source: ABdhPJwseFWiKxEklD/ZHy9MSMdAWqthEIKP5m+Bs+e38+VJiB1iS6t2LOBACHwIAHLfsYHYkKWEwQ==
X-Received: by 2002:a05:6638:1453:b0:308:eafa:41c with SMTP id l19-20020a056638145300b00308eafa041cmr228197jad.30.1645055810390;
        Wed, 16 Feb 2022 15:56:50 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r7sm758611ilm.14.2022.02.16.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 15:56:49 -0800 (PST)
Received: (nullmailer pid 1925627 invoked by uid 1000);
        Wed, 16 Feb 2022 23:56:47 -0000
Date:   Wed, 16 Feb 2022 17:56:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     pavel@ucw.cz, devicetree@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org, post@lespocky.de,
        linux-leds@vger.kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v7 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <Yg2PPwXpE9OUd85d@robh.at.kernel.org>
References: <20220210075908.120496-1-sven@svenschwermer.de>
 <20220210075908.120496-2-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210075908.120496-2-sven@svenschwermer.de>
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

On Thu, 10 Feb 2022 08:59:07 +0100, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> 
> Notes:
>     Changes in v7:
>     * Added newlines
>     * Reorder slightly
>     * Rename top-level node in example
> 
>     Changes in v6:
>     * Fix device tree binding schema
> 
>     Changes in v5:
>     * (no changes)
> 
>     Changes in v4:
>     * (no changes)
> 
>     Changes in v3:
>     * Remove multi-led unit name
> 
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
