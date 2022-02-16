Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58324B8586
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Feb 2022 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiBPKZO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Feb 2022 05:25:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiBPKZN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Feb 2022 05:25:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877120A884
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:25:00 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93B7D4081F
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645007099;
        bh=YSlDRmR6HZ9aZKr/Lcfq0977piYhJk2IERAtVdzaOd4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PxUTowp2/V4QZLg6Qk2tohPasx4HqRBl6J1bDLZqOt9MBt3wQzTwm+Yg8agyMvdGE
         Jh9CGvKYvnvXctYT5vRZyTTwQT0KK8J8oUkZg6SK6Y4gWWmkdSWolV6W5XcohFZSIR
         mmiPWvv+HHXY719q1o9aV6rclaRjx+wyujJOMSbm0Slm4PHY9eyxpULd7IIAftsaVd
         hcJ6+OesiNyBeE1lCc/ShOLk+8Kshha+B+ZcFWcrgW70PlV6yI4/ZMZNLLijm5t8mj
         d6Wd6pOstsZCTkZocVAN0JNZ4ph+H0c/cdyu920okrBUFBT3YISPhD95j+c/1VeBuA
         +yCW3d8iZXnlw==
Received: by mail-ed1-f71.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so1295461edb.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YSlDRmR6HZ9aZKr/Lcfq0977piYhJk2IERAtVdzaOd4=;
        b=mOe+AVx1ZqOBziwX2pPZxGGcMSuNf030AtDhfdry6LYPg+qLhd9RQDzgU9h1n09cNr
         ywwXDcnELFV0SHcFK8V30M2nS6MnFaL8FdhHHYnChBTbSog7VRIk91FQOuQnknRb2boa
         cw+uD7CSLf5t1Se1EhsAvVoCobrVcbctqZ9O9x74i3/xbh2cQHNDvuOz8xT3DrqlbzYR
         CbCPuzVMTH1WDKm9Lbn21HUa4IrQmED/UcYTHNr4XqLwvE6QoNxV+azaEcyB8f9WtyDj
         wzJD+QnS6oIrJFZiAitoW54UIC0f8U/ikD0gQ8unqIKrRd/3WA/wC/Yi4WYeZB+PQlM/
         Bayg==
X-Gm-Message-State: AOAM531GDRUCpgoinscCR9HksAWbSJdTGZMCQWD2qfnyl+J5meLBKvzU
        UElLhYNXDHQyVZXPN/xxSLQhpThQUbxMZEk+NZRi7LU+o4toMIVCkcnpb0d0/IE48K9eCR1panW
        mHlNFtGejEImRbzgqTP8PY+hLuPOZjC6VIielhQ==
X-Received: by 2002:a05:6402:27d0:b0:410:b9d9:207b with SMTP id c16-20020a05640227d000b00410b9d9207bmr2244802ede.208.1645007099134;
        Wed, 16 Feb 2022 02:24:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDh5xpNIVzVrjUqlDP7kPcm5NQeqk5G2s8lLOf/pc//q9vQC4/dfHu3xfES8jYs8Ppso/IYw==
X-Received: by 2002:a05:6402:27d0:b0:410:b9d9:207b with SMTP id c16-20020a05640227d000b00410b9d9207bmr2244780ede.208.1645007098993;
        Wed, 16 Feb 2022 02:24:58 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t4sm1473803edd.7.2022.02.16.02.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:24:58 -0800 (PST)
Message-ID: <6807587c-7135-855b-a9b3-26a55f2125d1@canonical.com>
Date:   Wed, 16 Feb 2022 11:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2,3/4] dt-bindings: pwm: Add compatible for MediaTek MT8195
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     allen-kh.cheng@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-4-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1645003971-16908-4-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 16/02/2022 10:32, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8195 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
