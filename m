Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63F4292960
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgJSObc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgJSObb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 10:31:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D964C0613CE;
        Mon, 19 Oct 2020 07:31:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so14222334ejg.1;
        Mon, 19 Oct 2020 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MepAw8QikH8iyL9uAquf5YG3tjzob/KKJdUH1sVOBVk=;
        b=k9oWyitnMt++4zrFpLN8CCED218B+biNowtUEWQ/yHYYk6tbQmhfYUreCjx8Y/BDdg
         mpadDWoTL5XY0u4obiWSO0GvJVGjC08Dp7QBm0WQGzcsu5r1LENTEt+91Ntw2X+BoCyG
         8x0jERqmhwrFQatevK1DilPRa2WpDHEtDDMkjzDNMvdCmCtfHB+vLSxssGFFndGQTw/T
         wIaUaIdl/X6xA9IzBGW7Y7lGOF7TBX/UljA/Ny/xri7uR7+SAuxZKCPApYVDyAtn1Dho
         zEb7NZtvClyHS8maqi9pI+UAInbnhzzl53XTMN3Vj768HY4NQ//Rgt+/dXk8dO+5PgPA
         zMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MepAw8QikH8iyL9uAquf5YG3tjzob/KKJdUH1sVOBVk=;
        b=hTlc92jIj8qGKvHuVLDz32z82Ku9Ug05LzVy4tteFbGBmEsb1zVpmNpi8GzEkTFHP7
         qsNYiWL6cGHNkACmhGAfhErUskMC1kLCNIAnplr7BrYVS8GC5YVTNa+0StP8oUxcyWbo
         Ufv6A/xTPe7YgKRjs36Lc7woqrcJ+RC/3zlHI1nMDdmMHwuy4B8vOKqAhj8A5NeGcTCQ
         6Acr/o8Qxnd7wrywi91ZB3s0UuNSYWdoHESEku96g9i71NxLzjxBN/l1ifbCVue5/OGs
         rDWYpYDquUpdPBjmLJF8lvtl7OoiYGI3rEcKXuWI4jcxH5G71tWgigPW6eDUbIDEsf8U
         pbJQ==
X-Gm-Message-State: AOAM533oJ5T/7/XvyOp++AYnpI4qf4zTo/3U3ae3kjA901SOkXhccd62
        IEmLcjv0euF0v3bl5BmxIOc=
X-Google-Smtp-Source: ABdhPJyEYwW4FFKts3BZU6uk4cE13TWT4ciblOSS+iLcXuP/eCaQaDXJIweK/eft7Cpo3P5KX3DWaQ==
X-Received: by 2002:a17:906:1152:: with SMTP id i18mr159113eja.101.1603117888789;
        Mon, 19 Oct 2020 07:31:28 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id k11sm234857eji.72.2020.10.19.07.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:31:28 -0700 (PDT)
Subject: Re: [PATCH 1/5] dt-bindings: pwm: pwm-mediatek: Add documentation for
 MT8183 SoC
To:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com
References: <20201019140705.1518822-1-fparent@baylibre.com>
 <20201019140705.1518822-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <95cbfef2-ef5e-1743-58d4-545ce7d29227@gmail.com>
Date:   Mon, 19 Oct 2020 16:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019140705.1518822-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 19/10/2020 16:07, Fabien Parent wrote:
> Add binding documentation for the MT8183 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 29adff59c479..25ed214473d7 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -7,6 +7,7 @@ Required properties:
>      - "mediatek,mt7623-pwm": found on mt7623 SoC.
>      - "mediatek,mt7628-pwm": found on mt7628 SoC.
>      - "mediatek,mt7629-pwm": found on mt7629 SoC.
> +   - "mediatek,mt8183-pwm": found on mt8183 SoC.
>      - "mediatek,mt8516-pwm": found on mt8516 SoC.
>    - reg: physical base address and length of the controller's registers.
>    - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
> 
