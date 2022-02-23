Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE124C0D17
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Feb 2022 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiBWHNV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Feb 2022 02:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiBWHNU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 02:13:20 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBA59A41
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 23:12:52 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 953563FCA6
        for <linux-pwm@vger.kernel.org>; Wed, 23 Feb 2022 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645600371;
        bh=Yk2F1aFfW1Ld0LeoUO0G0aplUyclczODbC5pm0OWl08=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tuMoEEexilKAJCag4Oa4X7HG4D1gH1YTi2FJ6f95ZPhKrU2Ifoa0gtP4+ZBuBjN4Q
         PUIlmB9lJKj1J4KKmlNDalCxI5Mg5ao5H3KYiHRPXZIJfSmEsaDOClT2HLuGwI9uQl
         gQwT0sKfRL+Fzi35ccMy6QjmlmEnQBlr+BqGFLjAmnQ/2L+5pBl503sXPpgxvzgAiE
         DgTICnktUGpbquVK74lgnbI6EtyXBX0frvKsJEv7SZk1kjWkFWQ6B0jDGFB/DLPcPB
         Y5jncCAcQCvX1pzvGF54IqTxtJNftFRL+Wf9UGC+S/tmpGNtN9iKH4z7Ktru9Y/3qx
         JeS9eHz8lYBEg==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so13160776edw.23
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 23:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yk2F1aFfW1Ld0LeoUO0G0aplUyclczODbC5pm0OWl08=;
        b=EiOHIG7hYqD3GcRF0o8i3w1RrLiIEAFnnw50Aykj9Opty67gjmdusCXfde4cjU45M3
         QQ1qEidxaOQE8o/OZUlDvntOFPzSuPfaI0lLdw7bM8XPeZCmmp9MUrkTPI/U7ck/HOr+
         g+PIC2XiGNt0Ggm9cGw5+YTzKT3+g5IPS3r5aJo+qp7gBUhNOczRDcOBDrci7G3/buOX
         Y/BXNpCXUB8X+2qZljXTr29zU9FPdr5KJl/9fpyx+TWx+iYBu+9kJ5Qh+8n0Qe7EnFJt
         jGMei4b50E78vaa/slI58Dzf0MvgQ4BwPVZFPVrcE76t6+vH9ojz55ID9JRmx5J9sKaA
         XjAQ==
X-Gm-Message-State: AOAM532+6E5uJALH+73ZvmOke/u88DVUu8VJHeadpZ1zfMHCLoI9s5uA
        WsFUH7P5KFsIlhX+CG2EkBXAL9Nlz2vBDU5Rh+cr0oiMloice1dxhNo6N7ZfqeMhaTKsA/PQLyF
        8njGzSsitsHfw435Se2HRXjoVRwY6gicD1yz0yQ==
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id t14-20020a170906064e00b006ce36ae7ab5mr22053166ejb.192.1645600371110;
        Tue, 22 Feb 2022 23:12:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmck5fg5WgUrwFyTS+l2MRKX24yg2vyux+78JbFW201Iyi4ERfI4O0zm2hCcKJyNLWo8yoPA==
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id t14-20020a170906064e00b006ce36ae7ab5mr22053144ejb.192.1645600370934;
        Tue, 22 Feb 2022 23:12:50 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id g16sm6978683ejf.218.2022.02.22.23.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:12:50 -0800 (PST)
Message-ID: <65edc257-82ec-e100-7a44-5c510aba51ce@canonical.com>
Date:   Wed, 23 Feb 2022 08:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        conor.dooley@microchip.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atishp@rivosinc.com,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-6-conor.dooley@microchip.com>
 <20220223062018.nbgidqxgh2soz625@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223062018.nbgidqxgh2soz625@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/02/2022 07:20, Uwe Kleine-König wrote:
> On Mon, Feb 14, 2022 at 01:58:35PM +0000, conor.dooley@microchip.com wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> Add device tree bindings for the Microchip fpga fabric based "core" PWM
>> controller.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I like it:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> nitpick: Put your S-o-b last in the commit log. (This doesn't justify a
> resend IMHO)

It should be the opposite - the first. First author signs the patch,
then comes review and finally an ack. Putting SoB at then suggests that
tags were accumulated before sending patch, out of mailing list.


Best regards,
Krzysztof
