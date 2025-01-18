Return-Path: <linux-pwm+bounces-4677-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E573A15E5B
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50FD3A6F52
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D31A2387;
	Sat, 18 Jan 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1/A4p9jc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9D2913
	for <linux-pwm@vger.kernel.org>; Sat, 18 Jan 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737221842; cv=none; b=ZDDJRjSraNyNcEMZkuqrkx4vxL5vxbcMT0oQJBwXQXCHBZETBTIAZ/pScAJ00EHNxwiEhTJJN+dhFA8DIiSKs+S7GmoQbDZ0AXbgrb0EvDxrBd2aTy21ddUvvZXXSDOJt7NNzv86rRnCgf6QjyyfwBEZ9hd2ruNAqcxx/Z05tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737221842; c=relaxed/simple;
	bh=5KbImRuF/5NpFTkcWvOpCTgTtv6Ro6DY1IS4jD2ffOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WM71jpFg3vJL58jzQRzRCPC9eZvajfarjMTO4VA7UI1QAcCLShG9Q4iwmdqq7w0LygRm97E1wSY/uKA/jEwtwVZVGZMQNGc0hi0CuRCwTgbjZjSgsAG5Xv3f4sgb0ePVl4MIpUMkQQB0nK4gegn0D+bm4SNbRH4SZ23mcqVUVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1/A4p9jc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7231e2ac9e4so779139a34.0
        for <linux-pwm@vger.kernel.org>; Sat, 18 Jan 2025 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737221839; x=1737826639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oUF4bH1WdmTIXkLPO2OLA3O+H+PKCUbXu0Y6uzH89nY=;
        b=1/A4p9jc1j67bm9Hv5rEWJt8lozmUQf0oKyoXxqCyryNN1fyx6Wg+LF90l47MSt3yy
         ASMr98MtvZso0CXzL1/SJ29fPP2U5xPgWxXPB8emMcQ3K32YNiPjqbdOHmHalGgD0RJv
         VaOd/Hjk8MAaEFZgy6DXRwTwO666vEQ8wt0MP9OMKdhHFDH7gc0hRH3A+EFQETp+lBol
         72NhDE9RY1Mh7a2gYt99V+NZUbT1uIo3txrbjN5zeAE0TE2raoOp1yWPGyEvZARGhIi+
         uKh9hPNNq/Pgad7U64pOBOjmctukfH6qYC9uTlGu8QhdpgBNXerrFNM4FDglMOE/T+7c
         txwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737221839; x=1737826639;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUF4bH1WdmTIXkLPO2OLA3O+H+PKCUbXu0Y6uzH89nY=;
        b=gwzlpFhPDXPcHpYCF1cM9wKKw2R0o/b4t/BCPi4Efn1mvyorA/FgG9qPbs3QsytUl9
         w2DRO9eAsSbz4V1CR9gceZoGu5LsMMON8/5Ti2dNwwxxOKatZmC0jUk85OAz9Aie0Wrf
         WygvyYjQXlDjBw7yJSvkty5l1EFymuBpDi7zM9NLnU5Cx3Hz0/PLiNWYhqHoqRQACY9X
         lSj6EwD/XGd1+Od5TLYskIXewi1fINmT0CSea9Mkgdk88FNNxWVvaRfTCyUCbF5uv/Y5
         lrcWZBcF4GaakVzipOLcl6ADKtVGr6QfRqIO069PwtvtTOvm4bW+PnyF1O9+VlPJ/QUz
         1fFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdcX2E4HTyK2aa/HHRQtv2i71QcleUzwGAK1bLqIjGb+sPQ3ScyCWjUeRPo9shV3xiGvTLVWAAVWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxEbMGE3B4wJf92zqGpqx2EnrFpfdUIjzotj/OK5E7aysHLgi
	UxW5TtH3Wlb3WRaGF7lWmp2+GtTxOo3zwz34TgnFV5k2CG2URSAR1i4JNJXPJ3Q=
X-Gm-Gg: ASbGncvadN7kD/ZmHmg0L7DZHVWWRJ2aB6L5W72RJpFjZK198qFu31MOPA6Mr7X3lkv
	OleMncmadwpxAVGKssk/E2TVV1wYHS64Jw3ldmqS8NKKyTHMALMTDcs0RLWrO/0PMSChnMZ09uC
	wjxQudopvZEC/J1edWIPSYu3Lr4k8J33XLDj0jM9ZyJLes0mMF7ynwWGknzRT9b4flAKXGvml1P
	Lcw3paFWDpQt/3KAR6guT6j8jLqdkLnfNLYiSVqIVm5QtPmReTaiVQPXLrFs3qm7Kw+AJTjpFl5
	2Pu+WNSWrV/Bw5zJmztAB6Ia1ZAXSJM=
X-Google-Smtp-Source: AGHT+IF2phH9N+7acPxIsWlMivwopcNK/+wJoDjwY5UuWgy4NyyY0G9Qpx9Eugtq3ILFnzMuo9wdYw==
X-Received: by 2002:a05:6830:d0c:b0:71d:f21b:a447 with SMTP id 46e09a7af769-7249dae0ab7mr3865118a34.17.1737221839059;
        Sat, 18 Jan 2025 09:37:19 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa36058274sm1427516eaf.40.2025.01.18.09.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:37:17 -0800 (PST)
Message-ID: <d0253e41-3cab-4263-91b2-81682529f9a0@baylibre.com>
Date: Sat, 18 Jan 2025 11:37:16 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
 <a45c60fe9fff0f517032a7e9eb3881cf340a8c1e.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <a45c60fe9fff0f517032a7e9eb3881cf340a8c1e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/18/25 9:10 AM, Nuno Sá wrote:
> On Fri, 2025-01-17 at 15:07 +0200, Antoniu Miclaus wrote:
>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>> differential, wide common-mode range inputs.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>> ---

...

> ...
> 
>> +static int ad4851_read_raw(struct iio_dev *indio_dev,
>> +			   const struct iio_chan_spec *chan,
>> +			   int *val, int *val2, long info)
>> +{
>> +	struct ad4851_state *st = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = st->cnv_trigger_rate_hz / st->osr;
>> +		return IIO_VAL_FRACTIONAL;
>> +	case IIO_CHAN_INFO_CALIBSCALE:
>> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return ad4851_get_scale(indio_dev, chan, val, val2);
> 
> Maybe this was discussed already and I missed it but I'm a bit puzzled. Don't we
> still need OFFSET for differential channels? How do you express negative voltages?
> 
> - Nuno Sá
> 
> 

It was discussed in early revisions of the series. :-)

There was an OFFSET back then, but we removed it because chip uses twos
complement encoding for bipolar single-ended and (bipolar) differential. We
have 's' and 'u' set in the scan_type.sign in those cases. The current
implementation looks correct to me in this regard.


