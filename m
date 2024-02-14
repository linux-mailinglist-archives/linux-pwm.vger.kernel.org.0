Return-Path: <linux-pwm+bounces-1495-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225EC854D2A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2F01F21DB8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D35D49E;
	Wed, 14 Feb 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzegrxtf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987385D919
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925466; cv=none; b=cfrwmmfar4QsC8QDu3tMQhfD6/YxldhuDvd36FDhI6DNCcH2AphGOtbjpOYgM7sRkQDWxycfc/50JhcS2Y5Pg1ODbXbnZTaWfBKNbIr8BG0v69+76fXXtX94y+SlhSVQ69XV26Bgisln4L6RFh1JRcbp9xTMEYtId2Iwix3SfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925466; c=relaxed/simple;
	bh=//z7LDYRNR+S7M5sdMmA/yYgCA8SEr+SbUkdFgXhsoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuHIObVK8Aq4y4LLpm3sAjR9XNqnc0bOkdcK6xc2iINH0uJJN9s4BgZs0lelG1Bcv7RH73VHNhQcECWlQZI2A6TCKijWItRCNsD6FOU+PZXOU4bsY0cbkqb4pOVepk55N9hBG2nl0LSXf8/yTCzm6YMlGZvnIE83EcrctVdt5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzegrxtf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d1d085384so163437466b.0
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 07:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707925463; x=1708530263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3DB/4/tXiyTIKZTEdyPuma7zWwJw6PWo/4Ker54APc=;
        b=mzegrxtfUSB3uc/oH4mRcFtqy87RpqvSX6hxXkRK1O/DE/d7LeZIQozCS/I66oi0X6
         LHR2xiFqczxjBP0o/2bsSwRPXd1XvKwfKAX/bj6c7Wj89yB+d/DGBlGYYRtCZrBpV3lI
         5b9Li3MkEQZadw7NMSQl1XMM02YPbm4VlTwcd5yxZ1AsZ+1gVZbNgdzLmR9idCRwMmUg
         AVLNcPbuvQ2+fQbircKm2hErI/y6t8Sns08FRENH5MaUvmcd9Yh8+wDYT77yg7AOEK58
         aVbDL7AXtmemC/iFlLZIvvhCQjR7PYDNmvLF8dsxYFnvTidc41kWpYJtlsdJuIK2MP8C
         InYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925463; x=1708530263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3DB/4/tXiyTIKZTEdyPuma7zWwJw6PWo/4Ker54APc=;
        b=jWB5YkFv41Rukdd2bHOLEmKHXrDm8KWGJy+VUzCC1JAKy4QSoGczaVKDh+YkjQIFMH
         sDqwoxCCEChzTCtuVrl6L/apkNLrYjxb6CWAiLnB2VrDBhC7X69hbwPHJRQVm8kgKhU/
         v4dAtk2GlbfpxU0DOYQe33aLDQ5Iyf7skTZoy7q7J2iQHsLv1xHPOQvFafeghD82Qx8q
         /spalW+2+FjW2BPFBK7Uu/epGObPEf22wwRPzeRHOmdw0YM7MazIbtk8of4lQrlOmIYf
         4L8HS5drvQXLOC7v85fVggdVyotXhufcXvrjVsD+nMlKJSwjY0tk+f/D9grxvHtggwqP
         f3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUSS7XWES9t9Us7cVBTkVurG1LJMOJpc8+TkwHmmAER8cztfsTDAjk4IwsyjqXugW0gWipFg1WKdbQVFkSsmsGKw3esptWbSnDV
X-Gm-Message-State: AOJu0Yw6BlWUi6uXapyW5Ggts/KtbR1VlvkURofFP/SNjcjl6CtXAVD+
	sT7NzKgQSAYUtuF9QM18R4mykOI4S0RF6Nz+cqm+/e/TFRj8JEBRDL2o5d18UjQ=
X-Google-Smtp-Source: AGHT+IHe/8nBMjza99svoj/66tlNJjDBen3KlN1gXPI2Fkm+lKNq9ZDzom3KKF85sCe6dl+DRwan7w==
X-Received: by 2002:a17:906:f158:b0:a3d:1458:5e58 with SMTP id gw24-20020a170906f15800b00a3d14585e58mr2096784ejb.46.1707925462746;
        Wed, 14 Feb 2024 07:44:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVi1iPa7wMM2Qi0EUYKp2Yq96WvRS4szgfEDtlZYuxISSPqR3WQuwyr/tm3wi5M/zDatIq3jtCew500TNVuT9CfofImXfOEyA30tNDkSvpHPp2AbNrzGzPqLyruP1X1n+hutoi+45OWXqUAjhk7MuYT8JLykyMqnAliMAVeCmHH1OCMWf7dVzKtRI6lkm+Fc7ckwTLQZUsPERoWaYtuc+Tlu3R87dfCHNgNHMF+gd9MPJyTi0zjm2ss9xd/T8X4dUqlbLhsowjkonN3GHO/iJ6ovKRRw1tgIUJgHXKe+6ERq+9aGcltGKbuiZfObVWc7qqb+Ke6MGvuD2FxzF3aeRaEXbsWD7HxOEqddbxB5Ph6EPSRSTUx/CIfsmboryaVHGO4LnmpFhDBL+CLU5UoE9G5mcQZPTmfGEdzm7jXUFrZHL/2HqaH4l3BHese6F6tQLYiAbDzbL7D9qEWcGa3FuT6cW9iSNzKusk39Dkris8Z1hUuGqEYwqTeCpJLooKaUNdFdd0=
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a382bcd9943sm2457921ejc.145.2024.02.14.07.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:44:22 -0800 (PST)
Message-ID: <1449b798-1486-47e9-b5fe-cf8e366b2e52@linaro.org>
Date: Wed, 14 Feb 2024 16:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240214140454.6438-1-zajec5@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240214140454.6438-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2024 15:04, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 has on-SoC controller that can control up to 8 PWM interfaces. It
> differs from blocks on other SoCs (amount of PWMs & registers) so it
> needs its own compatible string.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


