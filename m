Return-Path: <linux-pwm+bounces-1975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D734D8A7DBE
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9499028220E
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46847CF18;
	Wed, 17 Apr 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mCTbDA02"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F907D40B
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341219; cv=none; b=Ajh8UUh/eB3WOdkRBaYTNksyBdCfyuT4xb+UKsXWgV/uKuhFN4pK8q59QbLj2jZsrDXa671mJJb7pcdnx/qi9eU6uvjcw3G91082wOJmpMnyF5GzounxUcs4XsBB4an6InKPpSADdqh0uf8zyXnaNVE6LfEjBqJxy6n3MMjRYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341219; c=relaxed/simple;
	bh=m4cgksIDbGLFKOwBZjchQTOmi+eWGpVLDvkruMW0wGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhtkPyKYlT+b2Rbuq/VxXfOvdZ0IpuVpqnVljrqLuMXSWXSqPKaBJQELiNmlip96ek1IBZbcOWvEjhvGlDM6TlyAATzNeXqkDTG6sl4JZUhK84XeYaNjAnVTEMb4gtHx/gnbePmv/vGLnW3awrkjeYWCTWXasMTgmn6u6Jy19Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mCTbDA02; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so7693366a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713341215; x=1713946015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuvMTKrS538OQBDa2jdh/t6qnPEHbqMc8PN+mILzuvs=;
        b=mCTbDA021uI/MpaphPimUOaSUMI10XU7fzUrzzLzWW3EAiQ46UAr2WtON7Wq7tuq5i
         BmtBrqwm50lUt0uHoy7C/UkOeEe70nMkia7H7tXWQTkJW/KqVIi6U2meDGJqzVAeXJux
         QIIGJBmAn9WvgeQj1WBWzxsPD29S2mNWZYGbqGxkz5GiNut7Vfrs5QcKlZ9VTrfnIJbW
         coplHmF2SwOY3LUJRwYdJo/1rPoIbvvLyN59ABi/JY10mbQu8fYZlumDObRtna1g+LXV
         /Nno5lHWxvnZho1OyHsqY8McErp35fmvKUbHSJewxENZDov5Cf1IPIuRTdZIT2jlUw6E
         htAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341215; x=1713946015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuvMTKrS538OQBDa2jdh/t6qnPEHbqMc8PN+mILzuvs=;
        b=rFR3P0AgEPsCOHEjz8rHEBLu4He24zpAJvNS6ulnScm0qb8syBCGxmlKnYU3zq+dXd
         ciS132YEl2LArNtr7E30qv+tDJQzJX2ZT5DpwBGughcqWcS2rMsu6eMUKbOyiZyTqIJw
         YChzxdonYTTfC/7VUtxFsaIxgOq449bHCNpWrydLBjvzHjAukdRpF98/O+Awqq7U27jR
         6XJMul/0WRYf90PgSJrgrC6sK3awop6PFvmxMPzf7NIFlX72z8RXP6Ddj1iLgPOnyQkS
         HrFFARFaXWRGhR/SyzrK/24Pf7nUiyAFw/UqKQS5EMVwvQYDRHdxnhRy3zPRj2kTcT28
         gwVA==
X-Forwarded-Encrypted: i=1; AJvYcCUL8+Q0NIutAGhKlxW93dVpsHYbdVcYZGiBPNa6yAgpnJPZ91ZHuLUQjOtKBxRgt6OT1R5qaTdo4oBpIf9dKEVULp2oSpDQYxTT
X-Gm-Message-State: AOJu0YzgAi88KIIUR9U8qhlDKnuKZmtMvEvKdt6UvLDrp6oaFzexEEWh
	iuQS7x1SOJsEAhZmeZPnw1cvZMfNNr3127erVhthmQ4Rc5btptTls/p9ZwYxB20=
X-Google-Smtp-Source: AGHT+IF9QNj2+LEOTDvCsMmUjHTc38pjE+FDvplPR3KiswRdx9pL2ELeUrxLu0thmtQsPq4SfA0PEQ==
X-Received: by 2002:a17:906:a016:b0:a52:4d96:85e with SMTP id p22-20020a170906a01600b00a524d96085emr6795036ejy.53.1713341214788;
        Wed, 17 Apr 2024 01:06:54 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170906c80a00b00a51b5282837sm7852622ejb.15.2024.04.17.01.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:06:54 -0700 (PDT)
Message-ID: <cd5dcc90-bd34-40d5-af79-4943883411ad@baylibre.com>
Date: Wed, 17 Apr 2024 10:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
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
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
 <22yeoik77sdhmg43odjftzjn2douq74zhxwy6qx3hsrvr53r5e@7w3f3zbgxult>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <22yeoik77sdhmg43odjftzjn2douq74zhxwy6qx3hsrvr53r5e@7w3f3zbgxult>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/04/2024 10:01, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 16, 2024 at 05:53:12PM +0200, Alexandre Mergnat wrote:
>> According to the Mediatek MT8365 datasheet, the display PWM block has
>> a power domain.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> I already pointed that out in reply to the cover letter, so just to make
> it more easily to spot for people considering to apply this patch:
> 
> This is already fixed in next.
> 

Hello,
Sorry I've misunderstood the previous message.
I will remove this patch for the next revision and notify it in the cover letter.

Thanks

> Best regards
> Uwe
> 

-- 
Regards,
Alexandre

