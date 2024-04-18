Return-Path: <linux-pwm+bounces-2009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2E8A9693
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FFF1C208FC
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EC15AD99;
	Thu, 18 Apr 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yEVy/iks"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50115B105
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433578; cv=none; b=mVhC4MybkVctn6Ftt+Tq3xcHxQz/RTDvsggkvsT7w3bEMgv/pD3IPRp4By2LtrPoyWm/d47MUmN3MD4N0JhmGJps4T9zHXKPaZIbwRB0jVKdmvWQmnr5cQlmTp5SZWoqCDTUUMMuavAFWiurmEYzp+sKgPsYcGenO6dFMaSTRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433578; c=relaxed/simple;
	bh=QR450DPU8OzcEkmYkgjgRjPQF6842rrOEaOvoQ0x5nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOMxFkJxJnpy0E4NfwZ4MzHLoOY+Al1DxdzWJCMydnFEX/wMh8Pq4mH8oI30kdjIktrW5+6jNCeE6eKRG/pR2OMHA5a2VEcsFv1aIhVy90EI8s1tIJuqoNjnCFO0MZftGAikU5tNgPX+akBONESHNqCXvzsJFmRATv0HPJNHngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yEVy/iks; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518e2283bd3so863253e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713433574; x=1714038374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHTQNdaixaJmXmKKuqa6bURMHudpKto3SJOTxQWsB1k=;
        b=yEVy/ikscqdcdfnXKXgDJCcl8t3X4rgcVC9+vfcL4CicX4qkrUshxt7RhSJdVyBCPi
         AmNz3YwTivc0vAO4OU5EMDYg3XuWmOhtQFgGqNIudn+YXYkUuX/nXr4e024bTJGAOfO9
         762mJdUbQ1YQiEGyPqygp2Q02Ktsv/NfTrae729jB+6D0EJhvRhEOCISN/gT9i9mX/s2
         7VSw5sLjRX7gzTyWW5eUwvmrlXGUBeKuXlXrCD6Gdnu9ofp8+1YqiFlVcqLUN+zft0ec
         hDqfg/WHq/bUcl5i+oBBqLpiwE4zC+ZCppJb3W/cD5Sv3Hz5EYpB+ZoCKK80sShyQTA0
         w5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433574; x=1714038374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHTQNdaixaJmXmKKuqa6bURMHudpKto3SJOTxQWsB1k=;
        b=DeEmLocSumvtHEByiNNUTm2VGsvASDdErGRjKvKHnXW6dk93pNzRYFJyLSB2ggwVaI
         xYww/6fUth2/4ztF7ngnmoMSNK/Z2Guhwwk47FVLSY29O7Hzqpz7eGy3ndFJDTxfN4Iv
         Jt5OgLH7/XQObwAId42XAXMjQ2lLkajcy8top0JYWs+1fWf+NBsaa1b0GWyDfw96Y8nt
         9fbjrXKgxshFJWAv7bpN/UnqFAcgKIMgbWjXk4+B2BtqGV3yM71xfe+gtP5KY3pAXNjz
         WTCegivAmBotGUPqhPZjpQB0wCLSdfZowqDV7FzOKjZZ2sOqsHVQXHLjbIsGUfFErPZ+
         /kfw==
X-Forwarded-Encrypted: i=1; AJvYcCW3C9ll0ND9eGBAZOnJ8umwfNKD6wBFACMw0zH1QT8KZuOlnx8xL/fJqIZrchgNcf7jW3G4cIUgrDk5OZUJ8vXS7dbQs9KZG0ni
X-Gm-Message-State: AOJu0Yx0wK+9ETalP1YRr/pRBLJNp1Z3YhZA6pIK1W0HyzLzY8OssD2Z
	Ci2FXdDq100LWD33wvKCG/lO2RZ8znVn3dxnukj1w8eO65skEwsE3QyFVPB8WKc=
X-Google-Smtp-Source: AGHT+IFKKdpyMPlE5wECrwePw/LL4UVvAqkEhlLOtaK+0nLQSsDUk8IMg3W91iM2KaJpK31eRkk28Q==
X-Received: by 2002:a05:6512:ea5:b0:518:e7ed:3c7c with SMTP id bi37-20020a0565120ea500b00518e7ed3c7cmr1799688lfb.14.1713433573769;
        Thu, 18 Apr 2024 02:46:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906388a00b00a46aba003eesm647759ejd.215.2024.04.18.02.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:46:13 -0700 (PDT)
Message-ID: <286945bc-f207-4373-9589-0a9b62df1b36@baylibre.com>
Date: Thu, 18 Apr 2024 11:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
 <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe

On 17/04/2024 10:06, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 16, 2024 at 05:53:13PM +0200, Alexandre Mergnat wrote:
>> Add a compatible string for MediaTek Genio 350 MT8365's display PWM
>> block: this is the same as MT8183.
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> I already asked in reply to v1 what the merge plan is here. There are
> changes in my pwm tree to the mediatek,pwm-disp binding already. I don't
> think they conflict with this patch, but maybe it's still easier to take
> this via pwm?!

Sorry, I though the merge strategy wasn't addressed to me because I'm not a maintainer.
It's fine for me to merge it in the PWM tree.
IMO, this change [1] shouldn't conflict with this patch.

Can you add the "Acked-by: Rob Herring (Arm) <robh@kernel.org>" please if you merge this version ?

Thanks for the review and help.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/commit/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml?h=pwm/for-next&id=fb7c3d8ba039df877886fd457538d8b24ca9c84b

-- 
Regards,
Alexandre

