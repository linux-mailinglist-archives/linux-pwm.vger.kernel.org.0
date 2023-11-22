Return-Path: <linux-pwm+bounces-144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A87F49CC
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6992C1C20C24
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F14F1E4;
	Wed, 22 Nov 2023 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oy4FFEP/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7DB1BE
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 07:06:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d895584f1so4873245f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700665573; x=1701270373; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=qkwTVD62ajzdf7dlWnCdytqfMcFWREUSAZ60OZZcydw=;
        b=oy4FFEP/jGBir6ubPDxDt1USPwx15Rl/xj53lrNEZV0hEZ4RwZCiawHPzcmMz6OQ74
         OC656rcXKFjSOdINEKWfwks4H6/OU3M0Xi1TI4Et94bS6Vp47iripvAKz0KDNxTzcPWk
         K7Ih36BG8nFVizgMzEarqaAUDv/a/sE0DRIxtgaHeroAqno8XN2Olp57iQcI3FCEJrv4
         l3BzXBynlTBzBBZQTSkJ622XrJZhPhyU1koSYcra+zKEwZ/PEkZF7Ea0Z21r/+QUCURn
         wsRLye45IpksIXH1GEr+tmqK7d6Hi8sFfMuPOXVfQjRKoGiw1H16sv0dH1Cs7wFFEf3H
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665573; x=1701270373;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkwTVD62ajzdf7dlWnCdytqfMcFWREUSAZ60OZZcydw=;
        b=UcQbxo8KJkt3fobdYYIpLm7ZumIKpAR2TT39//KrLGQd+3o1BFDHZ5xuJN2CuvYDXc
         In0pePMmfXXOam3KGUxhqbpX/z8J6/lmju4dK1+sAd1ZyCfeWgr5Psv15k1FwmbG7Atw
         UOGko3JQ6unU1dq8HRB+F9i+3ECMPXgAPeryFYrkgl00t1ioheGZcARD2I94lvSyOlmi
         6JHMcvwKi7pCkF7YouSXjkROib2h92fyUycpnmDV/a3NK7Lv6ImIX9F131UReFsg4LN4
         Ev6YwNop5A7zVSoyG1A8n3lJbFSeugZKc7oja9q+y55WcCk/nHFODF3d0wUiym5XODVS
         HW0w==
X-Gm-Message-State: AOJu0YxS+WpMH8EQrcT2wM1cmcfFr8ZO3ItSUjrB1NgYUm71/0iZdTne
	DT+cp4lvIaUsSwyhPWDXbQMRwQ==
X-Google-Smtp-Source: AGHT+IH/8OTT5ueCIR2HxhS3WkKn80oKnhghSf0EXTQrMwFPELramnW4TqYdKKPh+xMmzND5JVWEQw==
X-Received: by 2002:adf:cc82:0:b0:331:6976:c8c7 with SMTP id p2-20020adfcc82000000b003316976c8c7mr1778855wrj.38.1700665573282;
        Wed, 22 Nov 2023 07:06:13 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d0a1:9a3c:4f4b:fa20])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b0032da87e32e2sm17459759wru.4.2023.11.22.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:06:12 -0800 (PST)
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-6-jbrunet@baylibre.com>
 <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding
 <thierry.reding@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v2 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2
 binding
Date: Wed, 22 Nov 2023 15:52:56 +0100
In-reply-to: <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
Message-ID: <1jsf4xeskb.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 22 Nov 2023 at 09:39, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/11/2023 13:59, Jerome Brunet wrote:
>> Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible
>
> Why? Your commit msg must explain this. You break users of this DTS on
> older kernels and also this makes it impossible to apply via different
> branches in the same cycle. All this needs explanation and proper
> justification. Your message tells here nothing, because "what" is quite
> obvious.
>

I provided all the explanation possible through the different commits of
this series. I can re-state here if it helps

>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
>>  arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
>>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
>>  arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
>>  6 files changed, 28 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
>> index 8e3860d5d916..80cc004ad5fe 100644
>> --- a/arch/arm/boot/dts/amlogic/meson.dtsi
>> +++ b/arch/arm/boot/dts/amlogic/meson.dtsi
>> @@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
>>  			};
>>  
>>  			pwm_ab: pwm@8550 {
>> -				compatible = "amlogic,meson-pwm";
>> +				compatible = "amlogic,meson8-pwm-v2";
>
> That's breaking users of this DTS (old kernel, out of tree, other
> projects) for no real reasons without explanation.

"amlogic,meson-pwm" will continue to match, meaning of bindings is unchanged

How do you propose to fix badly designed bindings then ?

if we cant even introduce a new compatible to fix things up. It is supposed to
stay and broken till the end of time ?

>
> Best regards,
> Krzysztof


