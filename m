Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BE616AA9
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Nov 2022 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKBR2F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Nov 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKBR2F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Nov 2022 13:28:05 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2956275F8;
        Wed,  2 Nov 2022 10:28:03 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id p127so19863190oih.9;
        Wed, 02 Nov 2022 10:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D8SiG5TcQnszkkwqkS3LMwkL+ZjCwfDNZ1qFEK6yjg=;
        b=H6s0N3FL4cqPExR/YFKCrmOqB0+921vS/rjinrfyEpitHoS1o/w+c0fSpeRbu6Cyl3
         uUvCM7KkyzrxneWx+yvS1osmpliXcCpof17Jmfb1ksshvdpZUYLt6599wxSz525xLXlh
         VTRaPOiRw4l7Ar/umdL9IDu2LA8PQPrU7yMWq2D7tC/JvhW3nnTDCf2eemVMR7pILoo2
         bYdhWC6lURZYMybeRQAbOHloNVBjp32oQ+tXcR7ASMBETa+3Bnj1FW20VZ2vNnIUWQpw
         Fn1o8BTnT6P+WcNoOv5i9cSHCll3rc1k072iyHpoyVHibE4JmHShcOVgkCiOfnnmXpYu
         6Y+A==
X-Gm-Message-State: ACrzQf1j5DU4Xme5BXlhN2iLJ0TdptS/xeSuHZDHUXY11TKw0n8hbAyX
        V6tgYwgGi2fku3ARGhA0SA==
X-Google-Smtp-Source: AMsMyM5Zb0nqzUSL+OiOqnhYmm+D+xeeNv4x3t6TI4qedCEV1bzv/+KONGXCMaT35MJUJzuaW+t1mg==
X-Received: by 2002:a54:4d94:0:b0:359:dbb7:8afa with SMTP id y20-20020a544d94000000b00359dbb78afamr14412245oix.65.1667410082879;
        Wed, 02 Nov 2022 10:28:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v21-20020acaac15000000b0035763a9a36csm4708031oie.44.2022.11.02.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:28:02 -0700 (PDT)
Received: (nullmailer pid 4191007 invoked by uid 1000);
        Wed, 02 Nov 2022 17:28:04 -0000
Date:   Wed, 2 Nov 2022 12:28:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH 1/9] dt-bindings: pwm: allwinner,sun4i-a10: Add F1C100s
 compatible
Message-ID: <166741008369.4190953.4583115054033536886.robh@kernel.org>
References: <20221101141658.3631342-1-andre.przywara@arm.com>
 <20221101141658.3631342-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101141658.3631342-2-andre.przywara@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Tue, 01 Nov 2022 14:16:50 +0000, Andre Przywara wrote:
> The PWM controller in the Allwinner F1C100s series of SoCs is the same
> as in the A20 SoCs, so allow using that as the fallback name.
> 
> Join the V3s compatible string in an enum on the way.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
