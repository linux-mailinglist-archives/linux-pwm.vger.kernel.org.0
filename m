Return-Path: <linux-pwm+bounces-3446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3E98F001
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720021F21F3B
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2619A2BD;
	Thu,  3 Oct 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q3X70QxI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19181199FD0
	for <linux-pwm@vger.kernel.org>; Thu,  3 Oct 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960942; cv=none; b=hyK72MAdml+UHJG4CsfVgYFBwquyFwcv93+yEG5IVm4Yi45wvQr6H5Qu70sjbKQ0l6up8bdpF+jUXu2ZyjLaq+mgumKuSKzE5TagOnjxwJ5f/vrg1Gk5+2k0LHvXsxpF0BKQ1Z45cL2uksBvArG/rd2arc0GIz9e8X6p/0FqWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960942; c=relaxed/simple;
	bh=/7hMe+OLn3ST3DlpMd1GrBbnMlB3ExpKWS6sMgQ0plQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjUp1U1lD6/83RR/F6ncEejT20M1ZJUf/BsWN6JUmd2rtJxKh6wSaj4tAbAWs5+8kWd22DIUrXo5G+gxsLUZlGe0islmHFyrhZwS4GQXhZK+/st39eK2kRBd7fwz+40gOMLKesNCUE4RWdWBbI0Lp4hqNWBKJAW0bw83MaYXqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q3X70QxI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e04b7b3c6dso501918b6e.2
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2024 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727960939; x=1728565739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PayjV8qvAjmCEvl9PWfax3Q5rkOmGBFJB0au/5/xjxM=;
        b=Q3X70QxI2s4fsdsA3CrT4W5PK9hwp/eVyszbbFr6DauIozMKFqZ+fcHsg4eIJd65Jz
         N8Nb+oG1rvobH8xzh8ONkmf0p2v7n0pceKGlpCpyr1RUqOTZYhs1D/VCYQAEGaTIq+wD
         OjRc44W/ms43FkeH8yxcSjJb9LldCi1Si6VTnwDxgCkOxlwy/gRurVCvrmhkVilPV0Bv
         IVajRWLaprdegZRaAHcvkyT/+1A2NO/VJ67RmWVw7NO2SBtbwq5x7RoWX8rO1hkNLWLM
         3AbrK7B3XaFzl7nTWRO6YvtKCE7hQxboOwzk4i429hNe1QnpkwbOvr1m3ZbIrGyyXAdt
         TgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960939; x=1728565739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PayjV8qvAjmCEvl9PWfax3Q5rkOmGBFJB0au/5/xjxM=;
        b=azvKlwGoK9Z2TRM+iRLIrY1eMiM7l/eoIojBbL64MBlBfbLpoudIJtWwoMMF0wFQrU
         UNSvZUPph4rsQtLqrylZcOcQgqZyJA/d4tKhRWoXzZp4F2003SI0x2a3O5zuGgwy6MDE
         NpETQGCcfdnH+7dytlL3/q7gdueKCbukGgppJkjlkVisyJ+EUmEg/OXpxCg85yv4HIOp
         mt0RcdGbcrCnVpD4NBpB4JZbvbW46xjD/4q7ysom2x+BfQBjrWNyhWzBAtT037RgeQlR
         EEecEG9/xbtx5nnKRMnh0o7h7oOLSsEkT9DA8xiwWLiGEX900+BoCRl9YZQ/z3TlgVjj
         VN0g==
X-Forwarded-Encrypted: i=1; AJvYcCXRBNenrp0dAcpaH4dryQKGTOQWasKna5hLGCI+eMeP7ryaYOZz9Y5VuK58Ep5P9V5pMztgN6DI96M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9n1Fi2FRm8obZ8Eqgfel0WFkZRsv2CkDp+TMhhqyuWTOs4l+
	RBXtjBRt9qfXF6CwuYrrf6ozbZxExA3xmkEyIzRz+dGF9XqZbvTC99rUWECY8fyr82ec2AflMZE
	c
X-Google-Smtp-Source: AGHT+IGl1J+uE4Yb9SF37/ZvYyR+VLBfk3NQhSKTc8eZyiFB7HryBEhWIcM4IQ4jPOQ7AGLwKbNX5Q==
X-Received: by 2002:a05:6808:14d3:b0:3e0:404a:4c26 with SMTP id 5614622812f47-3e3b40f6a00mr5325689b6e.15.1727960938918;
        Thu, 03 Oct 2024 06:08:58 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3bc39d959sm353055b6e.41.2024.10.03.06.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:08:57 -0700 (PDT)
Message-ID: <42165d2b-1103-4316-841c-45514a626be7@baylibre.com>
Date: Thu, 3 Oct 2024 08:08:55 -0500
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
 <4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
 <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 5:14 AM, Miclaus, Antoniu wrote:
>> On 10/1/24 8:51 AM, Miclaus, Antoniu wrote:
>>>>> Regarding the bulk writes/reads, the msb/mid/lsb registers need to be
>>>>> read/write in a specific order and the addresses are not incremental,
>>>>
>>>> We have _noinc() variants of regmap accessors.
>>> [Miclaus, Antoniu]
>>> I think _noinc() functions read from the same register address so it doesn't
>>> apply.
>>> I am reading values from multiple register addresses that are not reg_addr,
>>> reg_addr+1, reg_addr+2.
>>
>> I'm confused by the statement that the registers are not incremental.
>>
>> For example, this patch defines...
>>
>> +#define AD485X_REG_CHX_OFFSET_LSB(ch)
>> 	AD485X_REG_CHX_OFFSET(ch)
>> +#define AD485X_REG_CHX_OFFSET_MID(ch)
>> 	(AD485X_REG_CHX_OFFSET_LSB(ch) + 0x01)
>> +#define AD485X_REG_CHX_OFFSET_MSB(ch)
>> 	(AD485X_REG_CHX_OFFSET_MID(ch) + 0x01)
>>
>> This looks exactly like reg_addr, reg_addr+1, reg_addr+2 to me.
> Yes you are right. Although I tested with hardware and it seems that the registers
> are not properly written when using bulk operations. My guess is that holding CS low during
> the entire transaction might be a possible issue. Any suggestions are appreciated.

Is ADDR_DIR in SPI_CONFIG_A set to the correct value to match how
the regmap is configured for bulk writes?

I had to set this bit for AD4695 which has a similar register map
(although on that one I used two regmaps, an 8-bit one and a 16-bit
one, instead of doing bulk operations on the 8-bit one).

> 
>>>
>>>>> so I am not sure how the bulk functions fit. On this matter, we will need
>>>>> unsigned int (not u8) to store the values read via regmap_read, and in this
>>>>> case we will need extra casts and assignments to use get_unaligned.
>>>>
>>>> --
>>>> With Best Regards,
>>>> Andy Shevchenko
>>>>
>>>
> 


