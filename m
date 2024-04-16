Return-Path: <linux-pwm+bounces-1948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B38A6F07
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355241F210C4
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA912EBE8;
	Tue, 16 Apr 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="guJwuaJO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387B12CDB2
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279196; cv=none; b=rZy8fZOSjpA8q6yeCdPw+l7VsBE+q5bVwWmAOEpyC1rLuAmI6NnYlyB161bK4NV8/De5n54Eb1XkQqvX0cplsqcrfEILrn15a5b2oqMoe6kjJhZiPAjeyzjCyPNuifSdXwypor2i64GhU5J5a1z884nwRYHRMC2U4x/3EpLIZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279196; c=relaxed/simple;
	bh=KIC6X+A9AYUCWOuCpVq36IJ1kaFjZbZdLH2BMqqVvzk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A/+NZ+9dvP+8BW5YN/6Dxb5tt8lcrRjoFUi2rXBPW4l0/ox2sKIfnt6lyGQZYHL3Dxmawf2vycOFFbETZlCd27SLkB8K4J00TgrwK1u/r3Zl4R5x3p5BfOWj69TKzu/lSxu5E0mKybpO2z7juaGfrY81xklAIugJZYxBB4qX0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=guJwuaJO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d82713f473so84277001fa.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713279192; x=1713883992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jl7BVtQwBTSlw5Q7jIravMMMPvXbs3wbcyyUN/ZkIBg=;
        b=guJwuaJOpi3G6os/rcCx/qdSQ1olgCH0l2gDfF0IEj+9rEbNuGa/ivpTqZMoHljJtd
         vVhW3NSJXbeWaX9q42VPX66nfX4LVNLbs6FF2CQL0TjFyoeE0i9OIeELfMfVIPHmI687
         v9mNgjwDQNzMF06u5cPeptbXvR6Ga2A43CTXwhoeoisFOfM2orDrI5ttkVw9SAMPWSLF
         aH2iACFL1kKU9mVsnVmo/3LiT76p+W40ccFXi51kQX+HQh4I2Vu/jXHC6zFjlfoK74nR
         5lIgMFgb1xezWgPlvpUK6sLvmXYtBwdBRRJEkxFhdKbh2pOw1/iEtPjoOQI4RrG3kw1K
         oJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279192; x=1713883992;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jl7BVtQwBTSlw5Q7jIravMMMPvXbs3wbcyyUN/ZkIBg=;
        b=WsLWZcRYaAKbknkjDI+myHA7AXDzzZZX0FvoN1/mINqJWl3HeqlNOf+nbjXj7kQlih
         aF4sx7YXsgqTTRA1knzVEtYICRyXeKpRZWRngD+g8oCHNrmQzmAbQAoYhZSj3ZvBSHni
         wqq0hREc6ElGJhbBT8RYoO1GyiDDYKB7mNCEwcqPRR9axuuUCq6Hj82HKcXnTd+jWjem
         ulkypKz8bUbuXLmPjQ/OB7sjA7UXmVfsH6L7NEuxs84Qx5478PaZxbN++13ak0hadCbW
         6WXcTp3whiCU+haTeZbrkIfEDby9SC43QoMV/X4TZUEq5tniPrdt0ZctqugZS/iRoh0L
         Gj0A==
X-Forwarded-Encrypted: i=1; AJvYcCUsEr9aPu7rT09U0eA21Zko68ZL1RbpnwwYiRLBueVDs0SYeQ6g0cbs6in1FpaEFoZkCyjcU3YWmSQQM/SEhmrXZQ/9vTDvw7KB
X-Gm-Message-State: AOJu0YxoTo6fL+393HfBt6X8pxs9O5aQBenLyuLb8TpZTB6Gp9Eh4TcW
	fw+Xyt0TLlcZg7M2O2ACouYCaHiXxCCv6qJBE9gerxGk46fm+cUbu5D+2jeyN3o=
X-Google-Smtp-Source: AGHT+IEBkb7ExU6KDoUwKQB+1TjGigkCAfuqOmSxkIfxlJN0jQEFEyh9q8oXdurLDbr/zM7/PUjBBw==
X-Received: by 2002:a2e:9517:0:b0:2d8:19fe:4863 with SMTP id f23-20020a2e9517000000b002d819fe4863mr10223169ljh.41.1713279189026;
        Tue, 16 Apr 2024 07:53:09 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906529300b00a4da28f42f1sm6995974ejm.177.2024.04.16.07.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:53:08 -0700 (PDT)
Message-ID: <96d90ddd-2910-4419-ba90-64a09a3dbf1e@baylibre.com>
Date: Tue, 16 Apr 2024 16:53:06 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 14/18] drm/mediatek: dpi: add support for dpi clock
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Xinlei Lee <xinlei.lee@mediatek.com>,
 Jitao Shi <jitao.shi@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Fabien Parent <fparent@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-14-5c860ed5c33b@baylibre.com>
 <cf25a3cc-6411-45f5-bc7a-6b69cf28c860@collabora.com>
Content-Language: en-US
In-Reply-To: <cf25a3cc-6411-45f5-bc7a-6b69cf28c860@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/10/2023 11:12, AngeloGioacchino Del Regno wrote:
> Il 23/10/23 16:40, amergnat@baylibre.com ha scritto:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> MT8365 requires an additional clock for DPI. Add support for that
>> additional clock.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> I'm not convinced that this is right... at all.
> 
>  From a fast check of the MT8365 DPI clocks, I can see that the DPI0 
> clock declares
> parent VPLL_DPIX (a fixed clock), but nothing ever has VPLL_DPIX_EN 
> (which is the
> GATE clock, enabling output of DPIx VPLL?).
> 
> But then, there's even more: no clock ever references the 
> CLK_TOP_DPI0_SEL nor the
> CLK_TOP_DPI1_SEL gate, which is a PLL parent selector... in other 
> platforms, that
> is muxing through the TVDPLL, but on MT8365 that is LVDSPLL?!

AFAI see into mt8365 documentation, there is no TVDPLL, only LVDSPLL

> 
> I have many questions now:
> * Two PLLs are apparently brought up, but which one is the right one?!
>    * Is the LVDS PLL really used for DisplayPort? (dpi0_sel)

Seems to be LVDS

                                  enable  prepare  protect                                duty  hardware
    clock                          count    count    count        rate   accuracy phase  cycle    enable
-------------------------------------------------------------------------------------------------------
  clk26m                              18       19        1    26000000          0     0         Y
     vpll_dpix                         1        1        0    75000000          0     0  50000         Y
        mm_flvdstx_pxl                 0        0        0    75000000          0     0  50000         N
        mm_dpi0_dpi0                   1        1        0    75000000          0     0  50000         Y
        vpll_dpix_en                   0        0        0    75000000          0     0  50000         N
     lvdspll                           1        1        0   283999497          0     0  50000         Y
        lvdspll_d16                    0        0        0    17749968          0     0  50000         Y
        lvdspll_d8                     0        0        0    35499937          0     0  50000         Y
        lvdspll_d4                     0        0        0    70999874          0     0  50000         Y
        lvdspll_d2                     1        1        0   141999748          0     0  50000         Y
           dpi0_sel                    1        1        0   141999748          0     0  50000         Y
           dpi1_sel                    0        0        0   141999748          0     0  50000         N
     mmpll                             1        1        0   456999909          0     0  50000         Y
        mmpll_ck                       1        1        0   456999909          0     0  50000         Y
           mm_sel                     15       15        0   456999909          0     0  50000         Y
              mm_dpi0                  1        1        0   456999909          0     0  50000         Y



> * Are you sure that CLK_MM_DPI0_DPI0's parent shouldn't be dpi0_sel 
> instead?

I'm agree with you. After few change, it works.

-       GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+       GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),

-                       clocks = <&topckgen CLK_TOP_DPI0_SEL>,
+                       clocks = <&mmsys CLK_MM_DPI0_DPI0>,


                                  enable  prepare  protect                                duty  hardware
    clock                          count    count    count        rate   accuracy phase  cycle    enable
-------------------------------------------------------------------------------------------------------
     vpll_dpix                        0       0        0        75000000    0          0     50000      Y
        mm_flvdstx_pxl                0       0        0        75000000    0          0     50000      N
        vpll_dpix_en                  0       0        0        75000000    0          0     50000      N

     lvdspll                          1       1        0        283999497   0          0     50000      Y
        lvdspll_d16                   0       0        0        17749968    0          0     50000      Y
        lvdspll_d8                    0       0        0        35499937    0          0     50000      Y
        lvdspll_d4                    0       0        0        70999874    0          0     50000      Y
        lvdspll_d2                    1       1        0        141999748   0          0     50000      Y
           dpi0_sel                   1       1        0        141999748   0          0     50000      Y
              mm_dpi0_dpi0            1       1        0        141999748   0          0     50000      Y
           dpi1_sel                   0       0        0        141999748   0          0     50000      N

     mmpll                            1       1        0        456999909   0          0     50000      Y
        mmpll_d2                      0       0        0        228499954   0          0     50000      Y
        mmpll_ck                      1       1        0        456999909   0          0     50000      Y
           mm_sel                     15      15       0        456999909   0          0     50000      Y
              mm_dpi0                 1       1        0        456999909   0          0     50000      Y


> * Where is DPI1 in this SoC? Why is there a dpi1_sel clock, but no MM clock
>    for the DPI1 controller? Is there any DPI1 controller, even?!

DPI1 isn't documented.

>    * Why is there a DPI1 MUX, if there's no DPI1 controller?!

Good question, I don't know. Legacy of the downstream code.

That will be fixed for the next version.

-- 
Regards,
Alexandre

