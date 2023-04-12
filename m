Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE06DF6C2
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDLNPZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDLNPY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 09:15:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964B975C
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 06:14:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l16so6034534wms.1
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681305238; x=1683897238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxbSg03sNJ6CHBcwBXEqQmDmhcD81dI/Z44z6aEkv9E=;
        b=iqlCaO5Meyq2KhSfObg54+ntFwmYyox7N0vs4ZwWfI0b8iXJr0zQjqeXgKZzI53SNP
         H31oK0eqoOHMwt+5dGPEyyfyj5cCrmT5nybL0zAhK41cdxm7B3v4igvA4k5lkuqtJTW9
         YOk64/8nobsuhdmuQNuTaGP9MgpNq48Y5POxZ1YyebohKwSsby8TdHV0GlDBEww3LEh0
         2eUjyyHh4WW4Z8X5/MZhtfQE/wqsOnwifvlJjM0Xg519oHxY4uFIG921zK58kcuajP3z
         gKHR1kDoH1eyRYuywA/OWUs1WJekpIDISpjEIxG8O9cEx1CttcP/zZFWWWJCQnmYiTzu
         Lgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305238; x=1683897238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxbSg03sNJ6CHBcwBXEqQmDmhcD81dI/Z44z6aEkv9E=;
        b=0tHd5HkS7WatzoF6+swreZr3wtvDGUcRV+DmPNBTVDNHZtPJy3pWX3Ckm97wz2vGkM
         QvIEySTOZv6HxO/64wkwT8CvSTBzejwvcLWjG3gU/f6v0JQOQCzZqj/2plxyd04NjhHt
         T3E1HI8zFDTwQPHmNZWVVvNt8xEqenMyvtsJcBgw+Gchi1lpGnuANuwmljoZFB3rpkpe
         eqNrzKN0inOe55s83OdywmnFU4xfuaRKXYIynAwGU2iWVPzAf9mA953TOipUbSdYs8UL
         Vm55s7I3w8JcPhj0gH+e92gtDBEYqqd1CoSf2r6gq9tXZbF6P8LNpKEC/Icw9iS5OK+G
         qf/Q==
X-Gm-Message-State: AAQBX9cN1/wzQ0kFxEr0YOVh/P0KwOSPrjUwJ+C42McY+Mg+Dz2jcM8J
        SeSL5ZvGxzSmzpZGz+YZmpHCnQ==
X-Google-Smtp-Source: AKy350ZNRAG/3MPGjxbC9J3m06khEHCcasXR6FH61xJ832WlKtAzUSM52+gCptxIy0mOHHJs36cd2w==
X-Received: by 2002:a05:600c:2316:b0:3ea:f75d:4626 with SMTP id 22-20020a05600c231600b003eaf75d4626mr4566131wmo.38.1681305237744;
        Wed, 12 Apr 2023 06:13:57 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b003f09fe8312csm1351510wml.20.2023.04.12.06.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:13:57 -0700 (PDT)
Message-ID: <abc4c188-0ba8-8104-2c1f-39865f01353a@baylibre.com>
Date:   Wed, 12 Apr 2023 15:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MediaTek Helio X10 MT6795 SoC, using
> the same parameters as MT8183.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

