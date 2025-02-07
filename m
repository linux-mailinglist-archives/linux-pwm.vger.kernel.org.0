Return-Path: <linux-pwm+bounces-4825-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9248A2CE78
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 21:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618CF7A3933
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152A1B042E;
	Fri,  7 Feb 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KJUJr+IH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76C71747
	for <linux-pwm@vger.kernel.org>; Fri,  7 Feb 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961517; cv=none; b=stSeC/CkQSkW6T1xeqSW+Xb/hhT5CPC3ShMQ9nDCnvBxfJ1WqJo5E1Fklpbiga1WhE8k8jsEprKdDQqyvajpqbvxeCCAd4Hb72aGwZDkRqrM0ZSy5PT/yrNvOgH8IeodlH9RRFSwavJrA+k935HIiGzAzcPulktmbyqsJzgS9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961517; c=relaxed/simple;
	bh=RQC+JVcE7oBPPVf6dUb0HAwFqj0zvfI+bVN0sQy4rEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ+VpTBn5sEgBr/SKWS6KJ9Mwc/txErMOpUg1b6rBhVHzKUXBTT0MS5L2tDdCu42s+kLhzeU9YK8jl0bbQaH9KOBz8qYIFy/bzWdMkkcwJv22n/ixF8tnLt570aqFoPtEPopbtiYLTXnHzYxlLNQ0l373z4K5puNLQPRzsPN+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KJUJr+IH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb880e5ac2so1347382b6e.2
        for <linux-pwm@vger.kernel.org>; Fri, 07 Feb 2025 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738961513; x=1739566313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnjFJvm/loBhaRB23FVz9WTUd+LVkhO9DwWGD+NvqBM=;
        b=KJUJr+IHYSyQoTrXN/ahoQLMNW/lUDwT83LNjzSswRucUk4U5R71qrUbkT/eJ3THYy
         1FbKrGgZ1KNhDHhUD/oV/cydm4vX6Ti9v7Kn0Sk7IUh/dWih17kTtZiGZudvkrMS/+Qr
         gl31efUR/MI2Tlz71qgF0xvPFHjMJJdqZhtDvY0/JetsJOE9jWK0zV15G3xyuXJ3PwGp
         ptzExX/sUyA5FMz8Q0clV1R/w8bL4XNmSfSIpPPSemkAOH3UEoCvWW7UVyRmlKk3oJIu
         Tgw/PdDZv+6EDD8/io4j7+C9kCutAGm2d++jfIjhvtmkUL1Ltgd999qEHm0tk4nc6Szb
         8dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738961513; x=1739566313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnjFJvm/loBhaRB23FVz9WTUd+LVkhO9DwWGD+NvqBM=;
        b=JxXkb8WfCMwDrV3ge0T7mCdkTOfNKlTNeqR65JE40w0ojsg1ePPbBy0d+ZGwQpEPv1
         fluWlAeaOsZBMjPqKIbIxJ+ZURkYdhC+I+0rOZuKuaHCkkZMCccCRrytYhTIB3xwsbnX
         I+pIpEj4XaLPb5EtoKRblKLUFNoLFm2U/HbXQPsjczzYCZbo5n9zYUV/MhDvtd1KGDqU
         7WJ+uwKJlOkvUL/ZTbFDrM6lq1DfNZSlx6IffSql0bUxIXDBvBLE842/SGMOYWsnNHub
         6BjAUNT0z2ui8xmE0UgE8BWn7VGAqpWIwGbuyWkNRQ0JEpQM+7G9W3QPoJruK8YzVBQG
         6p2A==
X-Forwarded-Encrypted: i=1; AJvYcCU4clGjZEFD23AodH3VBaN5a2aUBaFIS09zeXo/aLa967AzCgOTgTdsbxere1yXojtKVzuqHbWLMAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvjEr0Q/qwYW2K+mVtaeo4flb4hRyiBsUG253ZvGnlV8Vg9Mv
	ZCziRbLsMEiRMYJMyIIQboHuToMcyRO7L0cWab//GVtDi5/raY1CTwSQuewLsdA=
X-Gm-Gg: ASbGncuBRFqTB8YRFXGfSHeiincX1VtGmshBano4miNKH30W9PX6UtFHG6E+XzKNZg7
	iY/J41VqPMFc2ChvTartRDGcmAyNlP9Nzfttd5sx6BZoL9VrPCx4O0lf878cwCht1Gav/hu1ijQ
	ts32rotsZ4+zxE7QV//a+LdiXKX/3R+mqc5Wv3PYE6RF7VY1cJMZcJqsWKI2PcM2KJLRNNA8r5N
	lDVZeyMaelQY+kHudzKGGhuUOx7xNcHeRbnsqHIGpvBsoNmZ8HrwIYa5ZU/7nl+RFAsYN9l1ozl
	oH4iWOAJjI3uXXo4BLzWfS00mkfDjLDeO9eYKdof80jMJSHXXcys
X-Google-Smtp-Source: AGHT+IGpl71KycImgNCiKqZctD01j5FGAIb/sziDZ4/boUvxRYPV9jOBLrmQqlA8Jq9Uj/SLiNYj8A==
X-Received: by 2002:a05:6808:2024:b0:3f1:ccc5:26cc with SMTP id 5614622812f47-3f3921e8390mr2962591b6e.6.1738961513542;
        Fri, 07 Feb 2025 12:51:53 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af94ec7esm992605a34.31.2025.02.07.12.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 12:51:53 -0800 (PST)
Message-ID: <e30305b0-f997-4287-b3b5-41646d169f34@baylibre.com>
Date: Fri, 7 Feb 2025 14:51:52 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/9] iio: adc: adi-axi-adc: set data format
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
 <20250207140918.7814-7-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250207140918.7814-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 8:09 AM, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.
> 
> Add separate complatible string for the custom AD485X IP and implement
> the necessary changes.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> @@ -312,6 +324,45 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>  	return 0;
>  }
>  
> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)

This function only applies to AD485X so would be nice to have _ad485x_ in the
function name.


