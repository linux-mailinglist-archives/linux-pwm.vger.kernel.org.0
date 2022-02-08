Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59114AD8B7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiBHNPk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 08:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiBHMce (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 07:32:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4FDC03FECF
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 04:32:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h6so11731810wrb.9
        for <linux-pwm@vger.kernel.org>; Tue, 08 Feb 2022 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=SBicExt4GJTldUNDteIIq7T7+TNr7gj099np1oZzyZ0=;
        b=5H3MsgPIhqt39HG1qoEatzD0Vc2QJlQKfqrcrh67yioOodrsd6sq49SPYaA/6sd5Zt
         TOy+pHA35I7ps67O93O29P57x0fxd2LOGb3w32L1+tKcxd39UzblOtVEy/igA0IFquTp
         B9L6yj862CsH3lBhGxDWuzOSXwIkMdBXICIC6RRwev2VRYGuTbAjd9Hipev7lizyO92A
         5G2pXnT9Tca5zRzi3NoFLZma5Vt0wOIExMGFk4ObG3UnLr4zedy+xPDsmOkOg+PupyAj
         gPIOlUvzqYiDccI3Z66cS8rnCdQCTECCDNPGctqOAQXe6KLs4N5xzEta+q+pQjHN329W
         34PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=SBicExt4GJTldUNDteIIq7T7+TNr7gj099np1oZzyZ0=;
        b=qcANuHdl86BPG/q0yg8FFvW4bH0gmPkudE3m+06UnVrR3ybmMnKxNHvRqNKAJ7xiu1
         /R4/R78352IsHFNsAxVeeCdYgrW9P+SJy36KF5p8kGyUENMEz/Y+AJJAWatbXC5sahNM
         Aj1EbWhzZwbbacGIqpWJ8xOmGJusf1lOVhxSgeyqgd+GiL0cq9iGiECSrcIJluVwvKVB
         Exf5DecVYaBEj5l/iN/KslHF5BflTJQMRrBTA6DUjqAp1hlGyJrAmEqGGdpp7gO1mDNO
         EOVbHTBStFlYbR7/ytiHVNMl5AKYMB1KI09cCeJL0Samp/SolB2/KjpyBL4AQHieJAfy
         GIog==
X-Gm-Message-State: AOAM531JnNCi2jOEIK/L14kV72tYmTCh0ecdkaGIjaVz+iVGKYU+us0x
        zm0r7yc+3DFeMsns49TBQ2CHhQ==
X-Google-Smtp-Source: ABdhPJy3fWhX+fR9E4HyMnwmqx7EtColZdvMB80eL5FvssCvOs3KJLS4r509AHx9ak5lZBQdqv+rhQ==
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr3345728wry.130.1644323551043;
        Tue, 08 Feb 2022 04:32:31 -0800 (PST)
Received: from [192.168.2.116] ([109.78.72.167])
        by smtp.gmail.com with ESMTPSA id v9sm1831062wrw.84.2022.02.08.04.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:32:29 -0800 (PST)
Message-ID: <afb346dc-5119-fcf0-d95e-d7e4bd91f92f@conchuod.ie>
Date:   Tue, 8 Feb 2022 12:32:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 03/12] dt-bindings: i2c: add bindings for microchip
 mpfs i2c
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>, conor.dooley@microchip.com
References: <20220207162637.1658677-1-conor.dooley@microchip.com>
 <20220207162637.1658677-4-conor.dooley@microchip.com>
 <YgJfl5CmepRMb5He@ninjato>
Cc:     paul.walmsley@sifive.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, lee.jones@linaro.org,
        heiko@sntech.de, Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, atishp@rivosinc.com,
        ivan.griffin@microchip.com, daire.mcnamara@microchip.com,
        linux-pwm@vger.kernel.org, bin.meng@windriver.com,
        jassisinghbrar@gmail.com, u.kleine-koenig@pengutronix.de,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        geert@linux-m68k.org, thierry.reding@gmail.com,
        linux-rtc@vger.kernel.org, lewis.hanly@microchip.com
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <YgJfl5CmepRMb5He@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/02/2022 12:18, Wolfram Sang wrote:
> On Mon, Feb 07, 2022 at 04:26:29PM +0000, conor.dooley@microchip.com wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> Add device tree bindings for the i2c controller on
>> the Microchip PolarFire SoC.
>>
>> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Shall this go via DT (Rob) or I2C (me) or some riscv tree?
If you could take it, that'd be great. Rob had said via subsystems was 
his preference for the bindings in this series.

Thanks,
Conor.
