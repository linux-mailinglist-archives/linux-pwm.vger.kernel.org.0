Return-Path: <linux-pwm+bounces-3415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E698BF0E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87381F21A44
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE71C68BF;
	Tue,  1 Oct 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UUbYmXHv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782392A1D2
	for <linux-pwm@vger.kernel.org>; Tue,  1 Oct 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791711; cv=none; b=AnMS4lPBRQiB5K96CcSJ/tOv2JF4opfAhsaA0VKFHRP/3lJBuf2Cxi/7aLHZQhN7kK+KxwcJXdEXq8mWDx1prZxWt/xU9IZ/x7/gz7pnAcXCOoIUEGypRWWwNML6ktrSvoEvI3ym4jN2qoN/R0m+bhRZLWY3uPr+0bBRpbXsQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791711; c=relaxed/simple;
	bh=LxMk/y3rVIkpdyzZf1Og5DUR9rP9qmiEF0dsQLbC1II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDA25J/riQtI8kyQfebkE5/16pcauuyOmGZHDG9Z5zJk4HhLQpVrnGbbYOcD5CotTyznleIPH4LhFN67EfL7Rh1zaHyRKnmlA2taPTj6CYPtm+Y6TOMTNLtopMcKOLYQQIajiSoSWQ7LFvUhcwCg4fudMt4uJK5Jbt4Dn5YePII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UUbYmXHv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27cecdc5098so2789552fac.0
        for <linux-pwm@vger.kernel.org>; Tue, 01 Oct 2024 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727791708; x=1728396508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFO0hmNFsD4G4qShm99ZAaM1SpaTEf6DP+ldNadetMo=;
        b=UUbYmXHvplJLbO92movkLfvEXQZJ9xBQj1bVFT7UEyUpEVGPeN1jq3Et4XSNhZJWM4
         INDPbx0/N6uqyT6qcaEV2n6Z/fTB0Jda+Ejen0sW2eKKsQ6Cr3ejpmqlc7CxpaEBmD6z
         m/HQ8rsRguqHiby30BtKJ58thp6+jTQNK+qDvppGvNWiXS1Ex91phtNPNEs/usywm3kj
         +Dgg/fTptNLrJLbOpeKbPSXEG+VmPmE1X95JBf9mtj+Ejub/xAh2UvhLBcKRZKX2r07o
         3VubmsheD4RXVNEgVAC+tgniqwvVEIggLzRAcBtscPcJJQDogmlFOAVmy7GHZ3ZhaIND
         EAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791708; x=1728396508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFO0hmNFsD4G4qShm99ZAaM1SpaTEf6DP+ldNadetMo=;
        b=aqsmRlUtgux0tsNhtb3q+hzKLea9sg/piRKYRVTVS6MOWUgLbyUEFcVZB2I9zV6fkA
         VHzG42yI+ZtCKMpxgOEv4BNCavV3toYHPQI1HwXtYkj6gRpQDFgp2cHGrovkw6SndDaR
         gY3noI1o2OjOceGzjF49AGi10bYF8dozm7i9nk7LdK+cpDtxozS5Ty+GExdjuluuTULv
         35r2zk67RQIeuEK94BKsGpP9Kr2mjd1KfHTMf01dbDByqfEnMBPR7bbhlhORIVl2RGmz
         XRPumxWTp8rp3so0BO/GZGDuSKyuCcSVgrvVzcsXxGIVt/e9xUllVP1j+Iw6DJIH62dj
         MwMA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tFoDROVSnLhVJKPQUA/AKDQLkK6hfZYtiwkPp00WV02VYdlIWHMZ1LOvaE+ENetcAUSzT4+7TyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGspd94toj9jYwV/gR3aoW9s9VU3KgLbmZbNSyj2BTZHhOpc3z
	VniOpqAdBt/ozIiTrJaeeakInSvlgh2ZOnGCQ52OQT/6X9y/lhIvGd0wA2HVps0=
X-Google-Smtp-Source: AGHT+IElLO0MVEB7oOv84+nshnYaGtCpTDiF3nTZmiTrRq8956kEoE3s5ZNWsIo8c7z+uPLk2FidyQ==
X-Received: by 2002:a05:6870:d624:b0:270:6ec0:c00 with SMTP id 586e51a60fabf-28710a4c7c9mr10847923fac.12.1727791708433;
        Tue, 01 Oct 2024 07:08:28 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2870f7d8ae6sm3466490fac.19.2024.10.01.07.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:08:26 -0700 (PDT)
Message-ID: <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
Date: Tue, 1 Oct 2024 09:08:25 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
 <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 8:51 AM, Miclaus, Antoniu wrote:
>>> Regarding the bulk writes/reads, the msb/mid/lsb registers need to be
>>> read/write in a specific order and the addresses are not incremental,
>>
>> We have _noinc() variants of regmap accessors.
> [Miclaus, Antoniu] 
> I think _noinc() functions read from the same register address so it doesn't
> apply.
> I am reading values from multiple register addresses that are not reg_addr,
> reg_addr+1, reg_addr+2.

I'm confused by the statement that the registers are not incremental.

For example, this patch defines...

+#define AD485X_REG_CHX_OFFSET_LSB(ch)	AD485X_REG_CHX_OFFSET(ch)
+#define AD485X_REG_CHX_OFFSET_MID(ch)	(AD485X_REG_CHX_OFFSET_LSB(ch) + 0x01)
+#define AD485X_REG_CHX_OFFSET_MSB(ch)	(AD485X_REG_CHX_OFFSET_MID(ch) + 0x01)

This looks exactly like reg_addr, reg_addr+1, reg_addr+2 to me.

> 
>>> so I am not sure how the bulk functions fit. On this matter, we will need
>>> unsigned int (not u8) to store the values read via regmap_read, and in this
>>> case we will need extra casts and assignments to use get_unaligned.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
> 


