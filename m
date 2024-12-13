Return-Path: <linux-pwm+bounces-4341-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23649F1999
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 00:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9744A18876A9
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043D1B0F15;
	Fri, 13 Dec 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HprsofZj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA11AF0B8
	for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131262; cv=none; b=SUpEXD8mpurnN/GqYBnK0YDSTPuQOyS4axo2oRO2ryEi6CtZsg3GqBBpY4FM9+pkg2EqWXGVlPHLZHfRnTITwnJqmv3amdC39vT+IKX3MCP1P8r+jOSrI+L8CUDaYagALqajWluExyJRLjngMoKXjpE+FUofZe+yy7rUanouO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131262; c=relaxed/simple;
	bh=9mslOgyODBTk1gIq/svp1Eho6MO7r+sBGLgvaRKv5bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bqip6CjmkCP5AEirCryujAJYxQwE8IMBD49piTxAVBJfrRpYfCSNr2rcCP2yn4ar4GwrJ7Mv/YdUSZObSZ2yCggoIdW6Q0a6vTvRRB5M6YzBdEvbKrAaryO3Oh5Gv7XJX3By1dvi7HLCs8nc+3RJJFoJ1i3h7mmByND59O4fBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HprsofZj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e173ed85bso1059509a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 13 Dec 2024 15:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131259; x=1734736059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klgLq/Z467DJ2pwaIguO5Z6ozZSa43qiYYGkt4Nz62s=;
        b=HprsofZjCe3WnGRsoASnNcT2IDPAeGcGLL3GyBVsZozcgHF3DftrokFLskauyIM0hY
         ICY9cm8PWQG16hiK2WS7dkn5AJ/uh80ByZAKXhobzqomcsjTd2zSJ+3GUL4+5Zs6TPKs
         NUz0jpI5+o/n496Gd8mmbrYtLofzufj8SN1guGvUUzRVOE1FWwNsRyZ2fRZ5yp7tkk9v
         HmuRyJ9PkZfaKW/8sFH7joRitzSvph8oDWy54P8f0F2bykVqiJ0uW0A9b7JpSV4nBzA5
         FUYsp3ltDh6Fm6QXN0g0Tw7bntQOCYeolitbMOxYpV2GEysUKSFoc7Nv0hrW3nEqJDSO
         bbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131259; x=1734736059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klgLq/Z467DJ2pwaIguO5Z6ozZSa43qiYYGkt4Nz62s=;
        b=BmAP6hAWr4QRLfy62ijN0k3vqT/XyHt33V615c8LuHKGtDtMH5KYLJ0twrwnxAjeq4
         WlQ0rEHcMUWnJ71xhD5g4ZSWG1PCLpOpR/EBJB2DW5WbFil/dwpQV+slJ26GSsF1qE7t
         E+ZXTm9hRC5d+VFujVUuOkl9yIYS/CZZGFRaQCx3DnScQj1DAiVFIpzrYVhtic3lROD8
         XVTKw0IfJZNXFmr42c7Cm911wi81gkdOSOjRkATkfhZ8J4RzuaqIKqh1g0iGCmCQlCNi
         2Fr+Q2Fi0dhp2Ii2+gceQmnjneYboBPC+GZuEcOquIeAKDlvH2tMXc5b43qMaUNXU3ME
         WLxg==
X-Forwarded-Encrypted: i=1; AJvYcCWn3IeiJG2+jp/7hM7sx212m5M9FssErdAzIxTS93ntH3Yh97AkFtbYpgpUOHqKyHZzIpftLlh42m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOIEn5M9Hm139U3Q/WB8n19+KIc6V70/TZtaO7cqp8NmWGVVP
	niHKZ2E3E/sgA0SFvsTTabLyIHaREYPKHWMMuCO3ElQV5JO/h9nNQnqzik41LUE=
X-Gm-Gg: ASbGnctlewEUV1Qn1ycJQ+OSzEaSnokREfLuTbxK5wYFePb5+4ntz2gKHgI2pgsXZNF
	AJkyMtSiAunFPeqE6G60XoIx9r31ScRbW+BKq3Quh7L/qRLXb9NcIkHhb8QW5Yeem68LjsyyNmI
	K/al08GoG17Qrwg6Ioj27qmI7udTVBmiD9gGgXczfzckLj72vgis4Ow5ePSqH5Wje63zVnPZvZI
	e9Vo6yvCj+bjYaJjz9XG0LMKqecMjAYf7wNwy4QjMEPguPIO4F6kPumBlALzjNdWL2VsgDehhcE
	0iX//EkHkouoCFSO8w==
X-Google-Smtp-Source: AGHT+IHmfZv5wBeaOl4ud1P2A3V/a0WeB1pp9OjSQUHieAKJdeyUEtdMzYHcVgXeLpNGtrppOhFPdw==
X-Received: by 2002:a05:6830:2108:b0:71d:5336:df72 with SMTP id 46e09a7af769-71e3ba5a2cfmr2058435a34.24.1734131259567;
        Fri, 13 Dec 2024 15:07:39 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f33a6af355sm156304eaf.6.2024.12.13.15.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:07:38 -0800 (PST)
Message-ID: <d2141b9c-33cb-48cf-97fa-49488edd63a0@baylibre.com>
Date: Fri, 13 Dec 2024 17:07:36 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] dt-bindings: iio: adc: add ad4851
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-7-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for ad485x family.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v8:
>  - use "bipolar" property in adc channel definition.

...

> +patternProperties:
> +  "^channel(@[0-7])?$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 7

It looks like the diff-channels property from v7 has gone missing.

We can't know if an input is wired for single-ended or differential
without that.


> +
> +      bipolar: true
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +

