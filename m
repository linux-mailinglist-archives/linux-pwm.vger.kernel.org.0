Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E054D58B4
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Mar 2022 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbiCKDPu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Mar 2022 22:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiCKDPs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Mar 2022 22:15:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104A1A2717
        for <linux-pwm@vger.kernel.org>; Thu, 10 Mar 2022 19:14:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so3705400pjb.3
        for <linux-pwm@vger.kernel.org>; Thu, 10 Mar 2022 19:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=k2icY+6tCwcqgzMbjLM+IMtOMr7cxOX9RXwF/4WbIuE=;
        b=J3JwssbcL91tpuNT7fB9AVcoTviOQtRwAaCe9iUYL5OxfAk9+y02r+gp7oXfhuwg81
         2qZbPheJlEQPpBKKhVsq8mte8hVVChgRP0B6I7mKXu1DYlneO/v/zulCcuhzuQCWcckc
         L3Bx/6f6c2L1qtCazJhLaxvtkk6cBBtphYkOw6XvT14qWlJUwqhXUkaDewhc+9626ynK
         lx2AAuA8aAAciwgkWY4L6PcPkcbaKiX5vnnOH+egphv+Bd/F6euavBUticf6UU2NKLmC
         8b1Mfn5s4sJiuqEGBGI53M5/NTBZ3SHpiiQ1n8bkfqWxmKLWrjwKjYa1Fg9Wx18YfOOr
         vg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=k2icY+6tCwcqgzMbjLM+IMtOMr7cxOX9RXwF/4WbIuE=;
        b=rOauzyegBrJD2cjrCJ5f8mkfmEymq3dAh7ZUvUuW6f0HWQRIiUrW2JcY+Hb0jqU+aZ
         B0FdK2FY4/LgxSQzHwdEFQH28R6AgJKo4xbIuTuKllBW1O0TLrqkbRosvhoKLpuM8HHd
         if3KdFiwv8/V9n3jrMvv0WfbGjZT6voXjgMUn/UetHbLrk0SNGfo3NWCUpv/joe739re
         lyFAvB0EU1Sz0uhVEfOZ/UbC4keviDd9ZTu64edFDV++FeVG6ea2rsXqV3Ts/de7dfDm
         l0xdjvwtpZ7E0L20FaHSQi3kUDL2aVqby4pR/MbkkrsZ4BTtwa6ObfBf0TWGODPuEUuA
         EShg==
X-Gm-Message-State: AOAM530ZKb7lGnFH1o0jp4qSAcbzh/OC/w3HxGwMEPNzwrZQrMUJnfgN
        vvbmeCuCrZ+at8FI3qPNezcAPg==
X-Google-Smtp-Source: ABdhPJy4fvYld+2wi2QVybUrJQ6b31jsGkwcRrlP9HfNyDkH0uCBxKsrzbz1rkxbCv0nElwZJQHYdA==
X-Received: by 2002:a17:902:e94f:b0:14f:1636:c8a8 with SMTP id b15-20020a170902e94f00b0014f1636c8a8mr8257065pll.130.1646968485668;
        Thu, 10 Mar 2022 19:14:45 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g18-20020a056a000b9200b004f783f5e890sm2149999pfj.156.2022.03.10.19.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:14:44 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:14:44 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 15:52:57 PST (-0800)
Subject:     Re: [PATCH 07/15] dt-bindings: pwm: sifive: include generic pwm schema
In-Reply-To: <20220214081605.161394-7-krzysztof.kozlowski@canonical.com>
CC:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        nobuhiro1.iwamatsu@toshiba.co.jp, p.zabel@pengutronix.de,
        anson.huang@nxp.com, vijayakannan.ayyathurai@intel.com,
        rtanwar@maxlinear.com, jeff@labundy.com, yash.shah@sifive.com,
        sagar.kadam@sifive.com, vigneshr@ti.com,
        yoshihiro.shimoda.uh@renesas.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@canonical.com
Message-ID: <mhng-7a872d06-a00d-49eb-bf67-68ad634e9985@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 14 Feb 2022 00:15:57 PST (-0800), krzysztof.kozlowski@canonical.com wrote:
> Include generic pwm.yaml schema, which enforces PWM node naming and
> brings pwm-cells requirement.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> index 84e66913d042..676b2160bada 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> @@ -22,6 +22,9 @@ description:
>
>    https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
>
> +allOf:
> +  - $ref: pwm.yaml#
> +
>  properties:
>    compatible:
>      items:
> @@ -55,7 +58,6 @@ required:
>    - compatible
>    - reg
>    - clocks
> -  - "#pwm-cells"
>    - interrupts
>
>  additionalProperties: false

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
