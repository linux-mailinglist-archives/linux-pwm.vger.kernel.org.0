Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E24B8593
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Feb 2022 11:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiBPKYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Feb 2022 05:24:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiBPKYv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Feb 2022 05:24:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533AA206DD6
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:24:39 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A25F407F2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645007078;
        bh=qXI75zjxBTeJPXxSNeUlZDMty7S4WiqV/haz2dU/d9I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PecQq3tejtp5Jau67bo4UcH1/xWqLKGIaCxj45Za9OsRjTsZYh4jBAKs3mfGCaad1
         KYfdS3py5kfawShnF8DdS1V+YZrrWYjMka3rc8Nbys6n8CwMwRHtvmrQdV+K9aJY6Z
         9ynjEirNI1CLoFkdY32U1iLTeOEFjvw7g5c0bMsNhaNdo7Bg2sE9ZaFEOoaDS0KDkU
         r041vpZ5gTXR49mAtz5uzresSC9NmuajfRiGBR9i0WpVLZbz9Q4w1a6GAg0JoGXoE0
         JLdCWVzsu+Q50uugl63USdWuk/bAoZQ9T3JkBPmLHyPLGabKi4H0BMiusb8fAeLRly
         UrtSxecSp+FCw==
Received: by mail-wm1-f72.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so292480wmi.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qXI75zjxBTeJPXxSNeUlZDMty7S4WiqV/haz2dU/d9I=;
        b=zJ8aQgRNVJaDSpvd/j9n8sMyU93FGZJIfOTSuFK7OTLhqtqTRLw1XLyniCFsNP0tWL
         98roFT8vFZ9gxqQnvJ3Td88Vo/n0pwjOgu1Giqp3sFMfzqb1hXF2TAwzyrADdqIRPTCA
         hUQOLe8btW5BLkcfELDACoyBPUVwn4xoKJn1DB9K9fTjwVANkMXGNVqstyOpx+vwJibk
         UfPJ5EwH7/WwNcmVnBJ7fQAiIAsZYiMmy1IkZA83OXWmcTmIo2uDlk3IvBWbgf4F2CjE
         HIO/cMydm1BxMbUgfL2uuYW0J1u25rXxesFRmtTOOWaxojmGIsbsfpllfZ/JAjbHObvA
         5LIw==
X-Gm-Message-State: AOAM530b4zvEUeCDvHk2H+t9pxB3uWsFWXGJYcybnzG9v5hUMJuHD+T/
        OFjZY2hStleueV2geq1GuGwJaQSoqlu41KK98YAU/3OjR9+IP/2dxXOTHr3IwXTG3MKiJc7HaJC
        SriMtiN7P4pQT5aNQCVQlvUDWcCBFEmdjpWu6WQ==
X-Received: by 2002:a5d:644b:0:b0:1e3:6a41:d2f4 with SMTP id d11-20020a5d644b000000b001e36a41d2f4mr1739104wrw.356.1645007077751;
        Wed, 16 Feb 2022 02:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWwVSVkA73YJkXT0kBUhoy4TKJmeRjjeKYqoW7WsaeJTgwFiRf0g49sq90wFOpXdDBBG2d1A==
X-Received: by 2002:a5d:644b:0:b0:1e3:6a41:d2f4 with SMTP id d11-20020a5d644b000000b001e36a41d2f4mr1739092wrw.356.1645007077612;
        Wed, 16 Feb 2022 02:24:37 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h2sm1635791wmm.27.2022.02.16.02.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:24:37 -0800 (PST)
Message-ID: <435f7269-7f34-ba6a-0219-abcc01ffef88@canonical.com>
Date:   Wed, 16 Feb 2022 11:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2,0/4] Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
 format
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
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
> Changes since v1:
> 1. Fixed formatting issues mentioned in the v1.
> 2. Delete pwm-mtk-disp.txt.
> 3. Add mtk_pwm dt_maintainers.
> 4. Add "#pwm-cells" & power-domains properties.
> 5. Make dt_checking successful.

Any reason in changing your email address in all patches? Maybe some
mail client misconfiguration?


Best regards,
Krzysztof
