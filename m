Return-Path: <linux-pwm+bounces-5932-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C3AB3BE5
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F7316A860
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314C22A7EB;
	Mon, 12 May 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mbVsRsCz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34F23AE96
	for <linux-pwm@vger.kernel.org>; Mon, 12 May 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063347; cv=none; b=VjWrkEcsFYW/owe8oHf5rXkTDm5Q1ZfZBHejPBqSq48rkFuxKccWaI/GryOg6ZgZ/fw79F5oxb1ZzTPvobULa+6baTUDptt4cyFNjhdPe6jc5xro+sqNWi0Y94FBfVW5Cbw6xH6yAXBgz4FVbaQuJotam80ZwAv0/uu7IIsEzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063347; c=relaxed/simple;
	bh=Q44I9l9A6bvt+4X1Jm8yKDlsTfz7OTm9T4HQgSxLV9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UByMV/dfI6CojIKPbuatDOFV4aUhBGdP+G7TdMGbKYD3tCMBPDdb24SqwIWiOa2/r6unPiBhKyun8S6IqsrzwxZrvYLqVLoCYwfP3EIw7v2rpoAfdqLhSrGDTuv5LgwHcjXxSqMR1AJXxB0TANydjK1JV1X8UdADWyNHGjcdjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mbVsRsCz; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72b0626c785so4130275a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 12 May 2025 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747063343; x=1747668143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehw97cZ7zSM30yNLRgq/QkB3dg1EfknESH7kBGZVvBE=;
        b=mbVsRsCzWPlROmO/4sbHdF+vsB/XjMas/p6KKCm61e2jARKKO21QzJNUOHNAE90eik
         cCUoHIuC68AuPvQCfisee/2dQPSwuvLuYeZyxyvzFSiUU13na2aUvSbhpTcgLGE67yvu
         hzYeel2U5bdLbqAdpdHInuzxUUXA805ybrC4sZjgchOY7joGVEsxUGuLeXV8/VUK9+Jr
         n5DTrrNw75QgBuMdrSMoMXYb0HMWVIrIOMrsRtqYEWDkuoeY6olKjcRgIt7HyUQTAyRG
         GIdxbxfD8Xlql016VfKTPzCG+avLge9HR8Tt/OHLsIFlJY7/lqUkNR7Yd+2SGeBZxqk7
         HGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063343; x=1747668143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehw97cZ7zSM30yNLRgq/QkB3dg1EfknESH7kBGZVvBE=;
        b=L3EF8BkR+kBhiWx6gy1v3CxsUK6UCLkH0QobTSjfn8W6ZXszeco6JV7sA0stsF/R3e
         aW4qYKqQvnCoTN8xQK88l2sCyHks62GBx64LLlpD1Ub0hHCHw9ItW9gvgGVLiVrugoWI
         frF7iifDtIK5OIxHwVXlpgRtKM1yo1O3T2ngeW6iXImd9h1SpFn8EAlQDTCA082gasrm
         gg1zIoIyaz6Gs8Lz9LN5FfnZFg0hsigRAIarSPFlyqaHkq3mehYp/7/7AG2J/vujqCk5
         9qhZXl7MrtIbwAI8yE3AwP6ggeprRVKxE2kZtWV+Nh9HrZ1lNyzuFgzFWwkFMmI/HQrG
         f4dA==
X-Forwarded-Encrypted: i=1; AJvYcCWnlzRtOyGWBBo5WxorYswcnPboVuyJNIQGWdLvfZjx3MTOGAHuf7oO9jh3Z/9Bk6hvs607LzU/YBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO1krjo29Qs68HJDcc+SyOlhw8N355U5TjplqNcF3wNhQvdod
	qK8IBnYzAah67e42kPGMmsAAvdXS5KrkY847e0DZcU9F7q1Zv7fdkIoXJJ5J2fE=
X-Gm-Gg: ASbGncswAvodDmMwuky/Uk/iu2NxpYNR/h84IOruVWOfWV+KeCTE6UFaGdIGsfWndyN
	ecUyfasWvtxpRXDQmUkfdRLMgbefODf/QHnweBMitHZvBV4AzvpMJRhbFFZmidGn/AT2Tt2R1Ju
	we00r9xFSQwF7YrsCb6uBuwugo7HJGpyrwKAUVz8XcV0dyl3E6ONusAwfIWs/imM/ea5OTF5SKc
	z9jzkA9IpIstAYw1QRsg4yWg8YcPfrY5+uyqWVHYk5jIb0Ljfxup2rJ6SJECzuYZ4zttxFrRkdy
	yqvC50hxLCZkey1zi50e4xj6OJVFQb0ccCoicQdFQD7ECDMJ9UDj3fPE/bbiMxK49dUUUyf2xtC
	8kAZbP+gvSMCb4zkPidhOkG4GejLNtZ9XNl722YA=
X-Google-Smtp-Source: AGHT+IFg8Sgjr8yxeNG/IhUScUIAVa1OFc7m7FxlwqSYuIM0xhwp6QZ1req1LRFjA6ZAnmsIbAxIvg==
X-Received: by 2002:a05:6830:648b:b0:72a:47ec:12da with SMTP id 46e09a7af769-732269d6a12mr9682527a34.10.1747063343145;
        Mon, 12 May 2025 08:22:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d78fbsm1584954a34.32.2025.05.12.08.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:22:22 -0700 (PDT)
Message-ID: <a810d8ff-535c-4d6c-bec3-8a275bcbe483@baylibre.com>
Date: Mon, 12 May 2025 10:22:21 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] clk: clk-axi-clkgen: improvements and some fixes
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> 
> ---
How we added the linux/adi-axi-common.h include to the clk-axi-clkgen
driver could have been tidier, but not strictly worth a v6 just for that.

Reviewed-by: David Lechner <dlechner@baylibre.com>

