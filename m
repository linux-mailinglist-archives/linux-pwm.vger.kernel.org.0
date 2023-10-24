Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F87D4CB6
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjJXJlh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjJXJlX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 05:41:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2541739
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 02:40:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so6358224e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698140439; x=1698745239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFZJO3NvFyuTGjb36RJAaXGwhe1Ycdi/eoT9Ykdj5nc=;
        b=fo3Mt5qXHkJmN0GxNHc1PPrFlGSTJIqT1L8gSxQOpIjdtvHvEsIyJFuNkqvvz6j/DW
         MtMcWoAG5902Z1+OkZFOqm6noV4nRmqcmoSIgQk2YPRi8W1X4c/xabcfpGLchD2zBa/G
         y3dMQ3FZSwKt7pImkkE3IblHTRz/jOrlEO3Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140439; x=1698745239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFZJO3NvFyuTGjb36RJAaXGwhe1Ycdi/eoT9Ykdj5nc=;
        b=RDuYMPgRKc5VzfGdowmsS0MBv92W/yzIBfjGNF6hjU9AgTCw/OhSXzZ8utUmlw1kxL
         VnIjv/VHKJFgf665nhz9qbaUZppVtdIzT/uR8DftK5EdXP2R44Ti/qsxGaEKXFMTpRNU
         dHObQJTK5FGw4T5aLXVWoOCp/Y50iy97O9UkCzzx/JIKAArX3Pud9wp7qb1Ha6lPqQti
         PXBLwaG6zdw1JSDjbDqHWQx6yD/f6Dy6sXjqOpossV/DGU3iNgXI2bW7ly+/8L5hksOQ
         VK4938lrYkz+B1gon2ElqDfA011oHCiPyAc2Wcqp6lHXU9gxsq4AKXA4ns/ZrF0FNRJr
         t0yA==
X-Gm-Message-State: AOJu0Yzwt+3iVXinrVLgzTVmsUkC4SLdVK+KjM2eExFxYUuMRaT/1y65
        Lgb3W+HvbGRoAIG1/nWAell5CDORDslKlzUe96YAwg==
X-Google-Smtp-Source: AGHT+IFRZoOVcRS4ZKYarSnzLWrQREggh2jb5IX+ohhI5nUZEVJ5YlSwxKC/Th6J+FUnLbHbkRFl8qn3j0n8dWEz5WA=
X-Received: by 2002:ac2:58e2:0:b0:503:9eb:47f0 with SMTP id
 v2-20020ac258e2000000b0050309eb47f0mr7287602lfo.59.1698140438950; Tue, 24 Oct
 2023 02:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com> <20231023-display-support-v1-3-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-3-5c860ed5c33b@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 Oct 2023 17:40:27 +0800
Message-ID: <CAGXv+5Hwe8jhgthnxwXEPezhwvhfcE=WMp_My3W8FisRagRTKQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] dt-bindings: display: mediatek: color: add binding
 for MT8365 SoC
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 23, 2023 at 10:40=E2=80=AFPM Alexandre Mergnat
<amergnat@baylibre.com> wrote:
>
> Display Color for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

This unfortunately doesn't match what the patch is doing.

ChenYu

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml |=
 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,co=
lor.yaml
> index f21e44092043..fbf15242af52 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> @@ -39,6 +39,7 @@ properties:
>                - mediatek,mt8188-disp-color
>                - mediatek,mt8192-disp-color
>                - mediatek,mt8195-disp-color
> +              - mediatek,mt8365-disp-color
>            - const: mediatek,mt8173-disp-color
>    reg:
>      maxItems: 1
>
> --
> 2.25.1
>
>
