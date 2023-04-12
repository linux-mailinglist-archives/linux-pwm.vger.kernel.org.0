Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3A6DF597
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDLMjL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDLMjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 08:39:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DA86AD;
        Wed, 12 Apr 2023 05:38:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e22so10656641wra.6;
        Wed, 12 Apr 2023 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303128; x=1683895128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PreNljsPNXQDvE1E1wr7W6K5Jt99wws/S4uxWLaHCsE=;
        b=FTjQk+3/hvIcMr5M+P2Q4srew4KUce++fUNzrFv0vpLpqo/IpSERCtHo96VjsIAXM1
         b16q8nV5cyxQLNyMgivAHAA+J0SeKltSJSijt/sS0dyPetAu8hlCCeMCCCb8Sx4pAJ8d
         D4eDYcuc2Mm7SrJOpBmqXj1XF2gVJwe9z1h1cpaA6/kBWPRlHzkWy57HNd1/QwxnSFr9
         0Fb43XLUPw+IuWZF2F02LqSKTp0O+kTPegeEjcULB1roXPs+obA18L9a3eYqxLbsSKZk
         JH/hlDTII9dXw8i8EZrC4ea3oNvphpxHOEPNUn5eIG5zwXwj4eb27T/ZlYOQAVZlJKyh
         DvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303128; x=1683895128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PreNljsPNXQDvE1E1wr7W6K5Jt99wws/S4uxWLaHCsE=;
        b=YQNZn8y7pr3WQbKoAENYmWNKP70z+d72EaVckInAzKHHmYO5vWDi8mklv0VPx6/gnd
         HLgWK29R8g5v6RLMkFzX9fd+9tJkXf4iijbu8+MK1eiOGRlgnJnxOlGEBPQoN5+3laHW
         eOZa+9HtbHr4fy5nkXPnTpzVVyVHabl8QDNhPY3s5j5zgC5qjb+EfnrF+m3mCzc01CXv
         Syy8ituLZHZH0EluyC2NPpyGbdRw5viwEwW9mehioOb32vK1SArL8/LIuHpodMh8UEoD
         ifgZn3hfOlKbvg6+o9Cn4m92lgba1hVdRtGIT4CnhMDScZ6/y8Vfezb1xXyEsa7CJQbV
         a1oA==
X-Gm-Message-State: AAQBX9cJajhFaxF4moGyCAx2Q4fXn/Wu2hD7pu58K/fWnFNG7FJ1316K
        qPPYKpIjQ8wPZ1HYpaUyKfA=
X-Google-Smtp-Source: AKy350ZMDEAz6WeHEq+goUHZnVLfPA/3GWKa3RR20ZAR/34TP+dIRIMFzmPIChMnOPItSd+YECzuGw==
X-Received: by 2002:adf:d4c8:0:b0:2f0:91c3:16e7 with SMTP id w8-20020adfd4c8000000b002f091c316e7mr1962606wrk.28.1681303128200;
        Wed, 12 Apr 2023 05:38:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a16-20020adffad0000000b002efb2d861dasm13813042wrs.77.2023.04.12.05.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:38:47 -0700 (PDT)
Message-ID: <2efc95c3-4f46-6256-af54-c29deef252d3@gmail.com>
Date:   Wed, 12 Apr 2023 14:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 15/27] dt-bindings: mailbox: mediatek,gce-mailbox: Add
 support for MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-16-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-16-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MT6795 Helio X10 SoC using MT8173
> binding and add a header for the MT6795's GCE mailbox.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../mailbox/mediatek,gce-mailbox.yaml         |  20 +--
>   include/dt-bindings/gce/mediatek,mt6795-gce.h | 123 ++++++++++++++++++
>   2 files changed, 135 insertions(+), 8 deletions(-)
>   create mode 100644 include/dt-bindings/gce/mediatek,mt6795-gce.h
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> index d383b2ab3ce8..cef9d7601398 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -16,14 +16,18 @@ description:
>   
>   properties:
>     compatible:
> -    enum:
> -      - mediatek,mt6779-gce
> -      - mediatek,mt8173-gce
> -      - mediatek,mt8183-gce
> -      - mediatek,mt8186-gce
> -      - mediatek,mt8188-gce
> -      - mediatek,mt8192-gce
> -      - mediatek,mt8195-gce
> +    oneOf:
> +      - enum:
> +          - mediatek,mt6779-gce
> +          - mediatek,mt8173-gce
> +          - mediatek,mt8183-gce
> +          - mediatek,mt8186-gce
> +          - mediatek,mt8188-gce
> +          - mediatek,mt8192-gce
> +          - mediatek,mt8195-gce
> +      - items:
> +          - const: mediatek,mt6795-gce
> +          - const: mediatek,mt8173-gce
>   
>     "#mbox-cells":
>       const: 2
> diff --git a/include/dt-bindings/gce/mediatek,mt6795-gce.h b/include/dt-bindings/gce/mediatek,mt6795-gce.h
> new file mode 100644
> index 000000000000..97d5ba2d2b44
> --- /dev/null
> +++ b/include/dt-bindings/gce/mediatek,mt6795-gce.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +#ifndef _DT_BINDINGS_GCE_MT6795_H
> +#define _DT_BINDINGS_GCE_MT6795_H
> +
> +/* GCE HW thread priority */
> +#define CMDQ_THR_PRIO_LOWEST			0
> +#define CMDQ_THR_PRIO_NORMAL			1
> +#define CMDQ_THR_PRIO_NORMAL_2			2
> +#define CMDQ_THR_PRIO_MEDIUM			3
> +#define CMDQ_THR_PRIO_MEDIUM_2			4
> +#define CMDQ_THR_PRIO_HIGH			5
> +#define CMDQ_THR_PRIO_HIGHER			6
> +#define CMDQ_THR_PRIO_HIGHEST			7
> +
> +/* GCE SUBSYS */
> +#define SUBSYS_1300XXXX				0
> +#define SUBSYS_1400XXXX				1
> +#define SUBSYS_1401XXXX				2
> +#define SUBSYS_1402XXXX				3
> +#define SUBSYS_1500XXXX				4
> +#define SUBSYS_1600XXXX				5
> +#define SUBSYS_1700XXXX				6
> +#define SUBSYS_1800XXXX				7
> +#define SUBSYS_1000XXXX				8
> +#define SUBSYS_1001XXXX				9
> +#define SUBSYS_1002XXXX				10
> +#define SUBSYS_1003XXXX				11
> +#define SUBSYS_1004XXXX				12
> +#define SUBSYS_1005XXXX				13
> +#define SUBSYS_1020XXXX				14
> +#define SUBSYS_1021XXXX				15
> +#define SUBSYS_1120XXXX				16
> +#define SUBSYS_1121XXXX				17
> +#define SUBSYS_1122XXXX				18
> +#define SUBSYS_1123XXXX				19
> +#define SUBSYS_1124XXXX				20
> +#define SUBSYS_1125XXXX				21
> +#define SUBSYS_1126XXXX				22
> +
> +/* GCE HW EVENT */
> +#define CMDQ_EVENT_MDP_RDMA0_SOF		0
> +#define CMDQ_EVENT_MDP_RDMA1_SOF		1
> +#define CMDQ_EVENT_MDP_DSI0_TE_SOF		2
> +#define CMDQ_EVENT_MDP_DSI1_TE_SOF		3
> +#define CMDQ_EVENT_MDP_MVW_SOF			4
> +#define CMDQ_EVENT_MDP_TDSHP0_SOF		5
> +#define CMDQ_EVENT_MDP_TDSHP1_SOF		6
> +#define CMDQ_EVENT_MDP_WDMA_SOF			7
> +#define CMDQ_EVENT_MDP_WROT0_SOF		8
> +#define CMDQ_EVENT_MDP_WROT1_SOF		9
> +#define CMDQ_EVENT_MDP_CROP_SOF			10
> +#define CMDQ_EVENT_DISP_OVL0_SOF		11
> +#define CMDQ_EVENT_DISP_OVL1_SOF		12
> +#define CMDQ_EVENT_DISP_RDMA0_SOF		13
> +#define CMDQ_EVENT_DISP_RDMA1_SOF		14
> +#define CMDQ_EVENT_DISP_RDMA2_SOF		15
> +#define CMDQ_EVENT_DISP_WDMA0_SOF		16
> +#define CMDQ_EVENT_DISP_WDMA1_SOF		17
> +#define CMDQ_EVENT_DISP_COLOR0_SOF		18
> +#define CMDQ_EVENT_DISP_COLOR1_SOF		19
> +#define CMDQ_EVENT_DISP_AAL_SOF			20
> +#define CMDQ_EVENT_DISP_GAMMA_SOF		21
> +#define CMDQ_EVENT_DISP_UFOE_SOF		22
> +#define CMDQ_EVENT_DISP_PWM0_SOF		23
> +#define CMDQ_EVENT_DISP_PWM1_SOF		24
> +#define CMDQ_EVENT_DISP_OD_SOF			25
> +#define CMDQ_EVENT_MDP_RDMA0_EOF		26
> +#define CMDQ_EVENT_MDP_RDMA1_EOF		27
> +#define CMDQ_EVENT_MDP_RSZ0_EOF			28
> +#define CMDQ_EVENT_MDP_RSZ1_EOF			29
> +#define CMDQ_EVENT_MDP_RSZ2_EOF			30
> +#define CMDQ_EVENT_MDP_TDSHP0_EOF		31
> +#define CMDQ_EVENT_MDP_TDSHP1_EOF		32
> +#define CMDQ_EVENT_MDP_WDMA_EOF			33
> +#define CMDQ_EVENT_MDP_WROT0_WRITE_EOF		34
> +#define CMDQ_EVENT_MDP_WROT0_READ_EOF		35
> +#define CMDQ_EVENT_MDP_WROT1_WRITE_EOF		36
> +#define CMDQ_EVENT_MDP_WROT1_READ_EOF		37
> +#define CMDQ_EVENT_MDP_CROP_EOF			38
> +#define CMDQ_EVENT_DISP_OVL0_EOF		39
> +#define CMDQ_EVENT_DISP_OVL1_EOF		40
> +#define CMDQ_EVENT_DISP_RDMA0_EOF		41
> +#define CMDQ_EVENT_DISP_RDMA1_EOF		42
> +#define CMDQ_EVENT_DISP_RDMA2_EOF		43
> +#define CMDQ_EVENT_DISP_WDMA0_EOF		44
> +#define CMDQ_EVENT_DISP_WDMA1_EOF		45
> +#define CMDQ_EVENT_DISP_COLOR0_EOF		46
> +#define CMDQ_EVENT_DISP_COLOR1_EOF		47
> +#define CMDQ_EVENT_DISP_AAL_EOF			48
> +#define CMDQ_EVENT_DISP_GAMMA_EOF		49
> +#define CMDQ_EVENT_DISP_UFOE_EOF		50
> +#define CMDQ_EVENT_DISP_DPI0_EOF		51
> +#define CMDQ_EVENT_MUTEX0_STREAM_EOF		52
> +#define CMDQ_EVENT_MUTEX1_STREAM_EOF		53
> +#define CMDQ_EVENT_MUTEX2_STREAM_EOF		54
> +#define CMDQ_EVENT_MUTEX3_STREAM_EOF		55
> +#define CMDQ_EVENT_MUTEX4_STREAM_EOF		56
> +#define CMDQ_EVENT_MUTEX5_STREAM_EOF		57
> +#define CMDQ_EVENT_MUTEX6_STREAM_EOF		58
> +#define CMDQ_EVENT_MUTEX7_STREAM_EOF		59
> +#define CMDQ_EVENT_MUTEX8_STREAM_EOF		60
> +#define CMDQ_EVENT_MUTEX9_STREAM_EOF		61
> +#define CMDQ_EVENT_DISP_RDMA0_UNDERRUN		62
> +#define CMDQ_EVENT_DISP_RDMA1_UNDERRUN		63
> +#define CMDQ_EVENT_DISP_RDMA2_UNDERRUN		64
> +#define CMDQ_EVENT_ISP_PASS2_2_EOF		129
> +#define CMDQ_EVENT_ISP_PASS2_1_EOF		130
> +#define CMDQ_EVENT_ISP_PASS2_0_EOF		131
> +#define CMDQ_EVENT_ISP_PASS1_1_EOF		132
> +#define CMDQ_EVENT_ISP_PASS1_0_EOF		133
> +#define CMDQ_EVENT_CAMSV_2_PASS1_EOF		134
> +#define CMDQ_EVENT_CAMSV_1_PASS1_EOF		135
> +#define CMDQ_EVENT_SENINF_CAM1_2_3_FIFO_FULL	136
> +#define CMDQ_EVENT_SENINF_CAM0_FIFO_FULL	137
> +#define CMDQ_EVENT_JPGENC_PASS2_EOF		257
> +#define CMDQ_EVENT_JPGENC_PASS1_EOF		258
> +#define CMDQ_EVENT_JPGDEC_EOF			259
> +
> +#endif
