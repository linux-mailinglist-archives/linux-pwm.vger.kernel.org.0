Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DED6DF660
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjDLND1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDLNDT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 09:03:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAFF4C1F
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 06:03:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q5so6470618wmo.4
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681304594; x=1683896594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjIdUq4Jsx9/GasEwdm41tjYbvcUo9h/pUwit0AG0qw=;
        b=I+U9p2RUdQ0jma7vWiMjgOivywGBJsk9WNavQzLUEh/9XwD46/PWdCmz2jtHMZlyPh
         IJR47kFbuS2krTR8D8TwAoya05XsgHSzcDXHIKFJzmddiFLXTOi+ZU/7tUJOrDz/yILl
         SIXsvKy2gl0NfWrtKgHqPiamvl5ngUisfT9GXgEKfhhEJvyICrgLJbZ3lPLJT7BHpfo+
         OSGfbwxEm0Np0ji7Ls9mAhsRxdI+nrPhkMNNSp2Nx/v3JKn9KszmNHXabkT74hCnStwN
         NBB9zEfXfbjr1st9ZZsooom9HhGVRXK1j0XWYSO1zD6vifKgxUFKlHowMFXVEnUTh0NE
         pq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681304594; x=1683896594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjIdUq4Jsx9/GasEwdm41tjYbvcUo9h/pUwit0AG0qw=;
        b=2E2KUydkHShsvDmW4Gj2VFtOkZ5yUQrraASzLRGIUcjKbC5eOAw+uuRIg/lx22sHgJ
         P7Pnwa86+DAcmj2oEeekZW1eZw8o3WOsFZmyR6EIybYaXboeEKyeFIogj3HEjVYDKTp5
         zgwzU9aal3QBi8O817TbvNUQy1c0zN9aV4TASTSw1mFysoKQAqIyN/SCWiJVcCdrpo5E
         zmYVS1aER2GxDWQQffgrZ6AllLFbRCpbxi1CsAoMNCZE4oAFV6aAWcV6qVEGY8Ejx7xd
         Pbr6hYBKtdFipbvq8U4AHB+q0924hw+mDqy7m/WECbQGLyEONopEjNOlnCV845vRKUwN
         S3hA==
X-Gm-Message-State: AAQBX9eOgzXYBg0xsfwl07h4/l3iwBwELvhNc6aEaHbNusKLdTPP/Mcb
        diKTVbT8MxvdyS4qrvBbaxfXPg==
X-Google-Smtp-Source: AKy350bDmpM+Lm/AqJiXBxAL4RoNuLKnffa2b9rPXFmlseSpOQ7ouXWDEFlId84sgS3bp9uw+f9nsQ==
X-Received: by 2002:a05:600c:292:b0:3f0:a137:90d9 with SMTP id 18-20020a05600c029200b003f0a13790d9mr218544wmk.3.1681304594013;
        Wed, 12 Apr 2023 06:03:14 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003ee9f396dcesm2439248wmq.30.2023.04.12.06.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:03:13 -0700 (PDT)
Message-ID: <c2b4cc90-9dd7-60b5-66f0-56a4d19d63e3@baylibre.com>
Date:   Wed, 12 Apr 2023 15:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/27] dt-bindings: display: mediatek: aal: Add compatible
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
 <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795: similarly to
> MT8173, this SoC has the gamma LUT registers in DISP_AAL.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

