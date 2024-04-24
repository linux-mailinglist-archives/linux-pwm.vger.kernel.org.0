Return-Path: <linux-pwm+bounces-2092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27498B0F49
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C5298E76
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62416D30D;
	Wed, 24 Apr 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQlk58Ly"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B116C6B7
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974344; cv=none; b=P3ZUn5QuEZP6fgS8bqNP4tztV/KVgCI4kHK8fToVd8EKZdWnaPTBS/yoX9XHUhKITUTDgzxhfsbto9KkOZ/aCSoWEyB34DzWzyo0yqIIbXbo/RBCoEwWk1SKx2F3UX1DReg9S22h1/OAHdbLM/AU9XAz2mimM6WZNgOL0sCTw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974344; c=relaxed/simple;
	bh=HzT5H6GlsHBD/eTzJQNCdlBx4zL1yrnsAZGvhWHeeB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tojEYPEELFNcfboe7FQOP/OTjPHpkk+1aSpngKzkdzFNBI2lpWUHS0QShF5Gu5EQvEU+KPDSTdpk8t5iQg1VYa7oIURhQvhzoNVgNPCN1Gqdy3wC1uOwQvGMh1F8qzhXIfc8TkFy/k5Br3Rh7yKVtP+RuMDWH92ujbpf2TTTi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQlk58Ly; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a524ecaf215so2216166b.2
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713974340; x=1714579140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ64wT6PzFAn8qjBgPSgjNXp6jZV103lzTHcm0eFcDM=;
        b=gQlk58LyUFJsBnZMz0E59N0Qw+5TP2snQgdvM5uoyXJWZCMHb/a9poELwGXVyzmsCy
         kQ/99+/+kRferXEIEBR9f/yQPy59iayQliipBEQUAtiJjwAWcx5c0n7+laZ3p8HlMKAZ
         sWuil3BgVoD8KKQqf61SUEwH6e/SPDnKCIVpkHoISxrQBu2Lw/YFIt7Abi1+4k54hKzL
         0EW8iT4O6we+EFJs/auKlZu66QlvgNov/J7jHEXO/3jwy/wfzofWXFy8Xu3h4e9P1NGF
         2ji3+CSE8CfmSnecB0QerQgzRN7YE4CX7VceDKhILZiKrCbKiRjQu7UOi12LISYOIyTu
         8ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974340; x=1714579140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ64wT6PzFAn8qjBgPSgjNXp6jZV103lzTHcm0eFcDM=;
        b=LBib8hitHvIwTA92zAvmtb4btcfcbPCyE0kqLZaYGIY5Eg9J0lnzUuaGOE7kQq5iwh
         AYTN1RvAj0BRJNvHnX3Hd6Z7pxnS7c02PeNUdeaTZGvWYtWhie8JypVIaysas9j8R6Bb
         dqxjG2C1h35STPQU9owrYdNOYfF8Xsxxq0Lku2BVr3cigg7TmiFj4upY+mTectNQBH1V
         gHLwODYPgmvVAZC48hEPa7dIhgvYZevnTx/+Ylw56SMxSccx9sKvGxSG6BZRTF/zVtYi
         /YcqXzZuMMfOtBCewyK3871NlyLUnsYIf7N8+2tETufta/KuR5g2FfDg3ArpU+nT9zTz
         tpFg==
X-Gm-Message-State: AOJu0YzM04S2rLwvY/3sJZT3g8F8xassp1i5ApSVNyYV6SlwZp5D0BYl
	59JCHUJRrk+O2rO5w5hCWbRzLEnmAJr5yoobDvOuYEjEizZOYOcuDxB2SJDijm0=
X-Google-Smtp-Source: AGHT+IGQsIGDTrEkkFZ0d7BzpTqrals6W9oWwDLo3KADefDZvUVftQF2XJ0m/McclRYDcXaOpGRFfQ==
X-Received: by 2002:a17:906:91c8:b0:a52:58a7:11cf with SMTP id b8-20020a17090691c800b00a5258a711cfmr2030787ejx.2.1713974339977;
        Wed, 24 Apr 2024 08:58:59 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ef15-20020a17090697cf00b00a55a5384f7asm5059033ejb.165.2024.04.24.08.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:58:59 -0700 (PDT)
Message-ID: <c792a2dd-3183-4d39-bda5-4a8c30a476ff@linaro.org>
Date: Wed, 24 Apr 2024 16:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/panel: Add driver for Synaptics TD4328 LCD
 panel
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-4-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240424-ayn-odin2-initial-v1-4-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add support for the 1920x1080 LCD panel driven by the Synaptics
> TD4328 IC, as found on AYN Odin 2.
> 
> Co-developed-by: Junhao Xie <bigfoot@classfun.cn>
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>

checkpatch.pl --strict somepatch

CHECK: Alignment should match open parenthesis
#207: FILE: drivers/gpu/drm/panel/panel-synaptics-td4328.c:150:
+static int td4328_get_modes(struct drm_panel *panel,
+			 struct drm_connector *connector)

total: 0 errors, 2 warnings, 1 checks, 269 lines checked

---
bod

