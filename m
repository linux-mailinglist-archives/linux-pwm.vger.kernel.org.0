Return-Path: <linux-pwm+bounces-3759-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241789AB977
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF9B28468F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE181CC8AA;
	Tue, 22 Oct 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZyexL6t0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD101CCEE7
	for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636132; cv=none; b=bWdL4/7fk4oAa9DMTVexwPQq6cjnpobD0hskbmDResfX+5ZaWyM7nLwFO8IaFQBbhsPfM5bkWiE09Q/w3LNNovYFob4yZsFIiZx5aoH7vlN9HIFyRYKVgsHDnxD7pTHdXmxbaUkeE9Be61Nu6XH3HDO2WTRZZOAA6LvNqABjRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636132; c=relaxed/simple;
	bh=iGY+RCSHBD6wL6JNcYAazeLM4Xjl5L1gAi6U9Jl6vNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXb4afy+p1yYqNQfIKSBLeXxKEFklcp2L84fxqpJy8yjIVBe3LUKISFTZRyLyK1UU+jtROREnOnaDWGLWx6DOpLorZ7tG6kgvL8MiBJ28gGNdWLy1qmTZEC5B0Sa7XrObVcNGD/lAp4tWQPBoeB2/hRijdz93NURqQzVca60CfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZyexL6t0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-715716974baso3620616a34.1
        for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729636129; x=1730240929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFCCeAvPeqUghAEXu6ImvnShl5xo3a21P+QnN+rS1kw=;
        b=ZyexL6t0PYPLWtdnvPtD0ROowY4jZwM0Ezd7BVmOkrKpOvIVz5i1xNLdISGLiAfwaM
         mLC9Rz7A46GhoUUuErQyFDckKWhjLwej/z+Wp1MzoCTkOa7nIcoouRvRrt972zgMmBY8
         m+fn5PELh0AdkaYeEaDcybf7lUduArq64bU/vcfzRDsPhfbRgVenzyaW9kTGJiF7krDl
         P20FH48Wc9yUEpAsENh3xO7Us4vUhI45phKT8GJ3GMTpDdHP/+f1KE3gqqbqk4xpvl3+
         3OyPE+9E+loPk1/FvoFiP9yQASf9k48upRVYaua+dHuDsb+sWwhySJjFAod2ULzixynF
         3KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729636129; x=1730240929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFCCeAvPeqUghAEXu6ImvnShl5xo3a21P+QnN+rS1kw=;
        b=nBLKffU5tSwauWFt9ISGHMKX2tyal966tZnjxcrltC5HzOy6cuJmZIqvikr167rJSB
         1WOvP+CPQqbMdfvK4E8aDBXilQzFsjpfN7Qks08OGUZrZwGi75lySarCJGapESCstikl
         EhQAVu8ueXROHtpxoZLSk3p9sp1tLPLg3iRGdMrNWAPggcCdtVv9F2dNUeoCCYknaBeQ
         wl3u/QrUiHbpOhnlNeH2Xpj/wQOOrIfNSjrROXohzrUb8Hu8SX/plf7regK8PwjXNiSp
         li+MSEPNYpG7QPU8PxlADXdetUW/sskBgFM6FCan753lWrn6HiF+zkUbU1Hjz0+800K1
         k8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWFMK2e9+oYpo//2fB3dVNrGGhOj7C2xUUjxhUDAQs0T8QuhX9nAO6x337BFce4/NDIdX7KwC7sBX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MrqXJ5a+pn848g80D04jXrMdElE4eo7aiqpI9TN/2XaRQnUT
	eVQoZoXQUNZsM1AUdPQBxfWOFGUAtkacfmsOL11SHW1K86fSkUh7SrAP7goFcJc=
X-Google-Smtp-Source: AGHT+IF5mcNdyQFGzKonGK31BzE89ULqNpP3zj6vhFzYDm2khTM1Kxs+zbZJgi/cGr96wp91oL9EFQ==
X-Received: by 2002:a05:6830:6995:b0:710:f3cb:5b9d with SMTP id 46e09a7af769-7184b42bc5bmr812319a34.24.1729636129027;
        Tue, 22 Oct 2024 15:28:49 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb50cd4sm1448774a34.38.2024.10.22.15.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:28:48 -0700 (PDT)
Message-ID: <0b478ed2-dd1e-4014-8501-2e1b50b473e3@baylibre.com>
Date: Tue, 22 Oct 2024 17:28:47 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
 conor+dt@kernel.org, ukleinek@kernel.org, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
 <20241018104210.51659-6-antoniu.miclaus@analog.com>
 <20241019144912.697d9d29@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241019144912.697d9d29@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 8:49 AM, Jonathan Cameron wrote:
> On Fri, 18 Oct 2024 13:42:10 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>> differential, wide common-mode range inputs.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> 
> A few minor things from me that I could fix whilst applying,
> but David gave a much more detailed review of v3, so I'll wait
> for his feedback on this.  I haven't dug into datasheets much and
> may well have missed other things.
> 
Many of my review comments were not addressed at all. :-(

Plus one addressed incorrectly (rounding PWM period down instead
of the suggested rounding up).

I still have major concerns about userspace-facing things like the
questionable use of the offset attribute and fixing how oversampling
interacts with the scan_type.

