Return-Path: <linux-pwm+bounces-6024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC9ABC356
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A5C4A0E04
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D73B28688A;
	Mon, 19 May 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OOA6fHnq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB1286428
	for <linux-pwm@vger.kernel.org>; Mon, 19 May 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670277; cv=none; b=CjUWWz4vvdD5OA3ra1iZaSYKaGBtMCIPjrQW00xzMsIBSnJCTxaFyycDFsKxXzYFbHOrepQFs8d/vmYzauIG+1EslCo9IRcC15TnLaOnRJO1lbc3EFcnlpQA6Zh4CRUndjv2VGkXAcRldvipUL3YlD2Xx69vWHboWQWts3Oz3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670277; c=relaxed/simple;
	bh=kDzZH/2//KqHjtRhP0MAmXrUXCabtr3kxzCKj86U3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW+LqrLBR5mjSbb8jD9H5+X43QAsLmXMvIsQHgC12vd4uVOSkihxXug8zvlRD+7PUHbi3Wm9zi4VsJcJFTr8sOb1Vzp1i4FXcQYO96WDv/+oYtpRsWoc1fFk45kiMS4dsMTOJE85fZdP1BhvlD2vTbT09GdOo+QBla/399bz0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OOA6fHnq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c40235c34so1528308a34.3
        for <linux-pwm@vger.kernel.org>; Mon, 19 May 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747670274; x=1748275074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=OOA6fHnqrd8XpwQtTyQdHYmaSZpFJumVIbFkClc705xSbXWIGCW+QbGlkICp9cyLml
         HVoxuLjaMzrqxhGyKk0Hjs2Dp3Nz2hH2mtD2ilAx+4oLfzCewT7oBaHGW0yhr+eESPqF
         YT1OUyeXC18C2xq6s3wIE4dNZWqWaM9132fBM8KaqGSl1HAPabZ7gQsamyG9G8a06NF5
         YBq3KW1tquKYGwoaNY/QfBBawFLbQUg+5ckpO5HL7m2gpJ/OKZy5tiBPyLWa+iwU4/Uz
         t2T9JecbqPwLdAekw468cBJBEZMMtnDRM+d14VmSZPyUlxVj91uc80sicwP3xAW+WWRp
         VvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670274; x=1748275074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=gqo0Tw/Can87tknULyEEhIdL2hnadTdD63h/Cv+nrEuhbsoQS4DCTs2oMhGzmyjsgi
         67dOZChzASrhpYgDmkaEzS7OcYE4kXOc4no4G0Ik6DufVOt4Ww/g30ggDdGoTUvMjiCc
         pJH49R+o0aDfXJ6q02hwoC4vqL6kAW/0BTsntYkj5YilLv6tmuRaVlptQOoU4oM3zvgs
         8CZ+GTMvLpIRc39Z9c8ZkdxHTpBJ3b2KF2t7NU1MuvlGj8z0/Sj6zG72PPz7jc6rwppd
         FL2XIMOOA3K8EsA1OSG7hikkfXjD7Qz+r/JlIqt6sFgfI55UZ9PHNejPZ5W7kAweOJHD
         b3kg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrSw9gGTGEW+4hke8eh6Pv88Iif3ElUcTYI/ipXgscltWOwho002DpMDkNydzKLybdEMrfQIx1RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiCv+cQQk58kv5/sbdvvhAe9eechtmQy6Oi0CTMvwyzXwuO24
	yJiA7ubmYjw4ETEqNHPIke+YM9nidZO9BR6nQvZPU1Urpu+So6513/L/QyWV80fXm/k=
X-Gm-Gg: ASbGnct8VRq4TXaz6ursAVpBgej0vccc0+3GYLrc2kFX6rHEeUO0i41tNG+pUpbrpsU
	60XxeDDheU8rucLwt/abzX4oD0Lst5OF6JG5P/GHGO81QR27e0tdZiPFB0pP0SuC8DuM8aDIAhs
	zP1Bn8cBbgfEeXQ0kt7mQ/+tpFt5iyCDazboQ6woo+10w0aZk6/6noN66qMzSJWv6P4Ge+jymAn
	p1JU2wtoN+C9Ft7vuQ0d/SPZy+KdKTVgXXoX0adEGltJQMCmCmT1Dw0owgPngU3ydb5ZL8ghD8K
	4rgu8G0+TZdmWaYIJbVzlTkgZ5F/x2RWa+ItLa2IvqW4gVDV+s6H5NI5syjJl/OoKw7p3CejujI
	kSa+/WVi5i8tgO53kkvE8fIsV4Q==
X-Google-Smtp-Source: AGHT+IH8T8zg0xomQN28G1hezc6Z1gZDVp2eCOEmtHqiL0f9gIeNGI+bpJuOCxDdS9NlFECubITNsg==
X-Received: by 2002:a05:6830:61c4:b0:72b:a020:a2c0 with SMTP id 46e09a7af769-734f99582ddmr8068793a34.17.1747670274203;
        Mon, 19 May 2025 08:57:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b5f5e7sm1463565a34.65.2025.05.19.08.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:57:53 -0700 (PDT)
Message-ID: <adc2d646-06fd-4a9a-bebe-99d2a6cfd2d5@baylibre.com>
Date: Mon, 19 May 2025 10:57:52 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] clk: clk-axi-clkgen: improvements and some fixes
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
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/25 10:41 AM, Nuno Sá via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


