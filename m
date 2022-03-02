Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385D4CAE34
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Mar 2022 20:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiCBTFr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Mar 2022 14:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbiCBTFq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2022 14:05:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524ECFBAA
        for <linux-pwm@vger.kernel.org>; Wed,  2 Mar 2022 11:05:03 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9952D3F612
        for <linux-pwm@vger.kernel.org>; Wed,  2 Mar 2022 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646247901;
        bh=o/gq2zH0XhC0PaitqVD/LagQpkqLCpBFDwRKMGbmd0w=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=paifCzoumozPCgowa7dzMuwXNt5AtzNtgP1WBHuhsti2tBLjMHEHucxawN3B+TM1G
         CNSpca91RncTQM9IVHpW6yxHhnf3udLllgtDWGpZrdaHsT065UmvnI2u6VBN7PXfqh
         5qQUpwt4iy8q/NtXdTd7c8ixPKyJbJ6T10GpkfWmcTMmx9MrCfhWXIh8nwtPrEfWzC
         YVV0F57X64k2qX7a2qac1lmhYralJf9WUxuMllqPvbOVtWTF789iFnzavdIi7r87N8
         oZJElokxFjeHOHq0AuE7vuY9TqjPHL6ZYqMvZ1rt0U4hZUlEeWcSJBMQO+yF1mRh2v
         DXbnwuYGLJGTA==
Received: by mail-lj1-f200.google.com with SMTP id 185-20020a2e05c2000000b002463aff775aso846752ljf.17
        for <linux-pwm@vger.kernel.org>; Wed, 02 Mar 2022 11:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=o/gq2zH0XhC0PaitqVD/LagQpkqLCpBFDwRKMGbmd0w=;
        b=mzSQX1K1t68IqbxsasMhwRnPDGYW5ISFj0Zvs+ZyFYlSErpvhnBVcJshzI3jTIu3R4
         6du8sk/FBW6tKUqRMB/IF3950KdSjjzXXjTgJGb40N/pn3WA0bwkiwMTUA4l9BcRm5Se
         oNG3pOnXf53oelcs+4bIgC1QOafOtMW1vGTSHBBmFNELKAWlsHS5SagVKfRF+knxbe2k
         HLv6x+47n6rIc7hX0cIf+IXiX9aqcp3HvbxwWP9gPwKy0z2WxQVbswvwc/qNXYPEzS/U
         ulXgxBUpNlwIaYMI/otmvculTPuZg9DlYZqRaizG+mqvS4nKd65MuvHFIVxo3DP39LIr
         y9Pg==
X-Gm-Message-State: AOAM532MDkGYvGe0kOPrX6/kr6uNz4jiJo5IPrdVERVDQWmeNWvzDqRs
        Cb0cgWPK1yrBpwm+snhSJA9oGJJcMmtQmL9XuWgzyiuqFyUfYhZEBMApr+zCCXBUNVbULOPp3oq
        9cH6OMvT9pVYnLqF8CCx1Ny6yCD0xCMjyvE/S8A==
X-Received: by 2002:a05:6402:26cb:b0:3fa:3817:1f78 with SMTP id x11-20020a05640226cb00b003fa38171f78mr30654869edd.219.1646247889954;
        Wed, 02 Mar 2022 11:04:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5ud+uzIs5hvG4Gs8CgEyL9Hzob7WkoDzIJWUkIA9MRmpeL5TH6uATTuuggM0eZzWdPfuGEw==
X-Received: by 2002:a05:6402:26cb:b0:3fa:3817:1f78 with SMTP id x11-20020a05640226cb00b003fa38171f78mr30654817edd.219.1646247889629;
        Wed, 02 Mar 2022 11:04:49 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm6630349ejj.74.2022.03.02.11.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:04:46 -0800 (PST)
Message-ID: <211b3d35-1d8d-b71c-996a-b185324815f7@canonical.com>
Date:   Wed, 2 Mar 2022 20:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yash Shah <yash.shah@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-rockchip@lists.infradead.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14/02/2022 22:21, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> 1. Add tags.
> 2. Adjust subject (Uwe).
> 

Hi Thierry, Uwe and Lee,

Any comments here? Rob acked all these, so these are clear to go via PWM
tree.


Best regards,
Krzysztof
