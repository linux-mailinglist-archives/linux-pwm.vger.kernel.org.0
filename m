Return-Path: <linux-pwm+bounces-3603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A616599A55E
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C852A1C21A4A
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FE218D93;
	Fri, 11 Oct 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YjesxH2H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29921733D
	for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654473; cv=none; b=ZrhCdVLySn5tPs71oCpwIdk0d7jDPd4HQfj5LkQdJGjW3zTQgfDyvScbJzeRZ2ZmWhdY++guQ4KeNB9bUF+GURnFxFgycy5v8tWq0994tbXdGW83vA/6v+A3Ux9P8ourRt66fqNCWQem0+wZN6H/+R05gFyGRXhnvb+uU/Ml98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654473; c=relaxed/simple;
	bh=xol6+oqkqEtwPyNG/T0qpuSKB5mejCsxYo/fna8PeXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sylBmuiqegXKDv/N5onCFQhHF6KNfa8NifRhstbGjwSWMjZav8ONOakhj309zNFxQXMDzq8rXYSoHuAgdXPzxrvBBJgXfhlsBrhjqP2vV+ykdHe3p0EJ7OtdjtrcT/E0a3/gNNFEWiA3PdyMAOR/ILYsePde5jDSP+nLWtu9NlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YjesxH2H; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7157c2aca3eso1203281a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728654471; x=1729259271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IllKSGecey5qWktiICvboLBrDNTF07DwRxsCQfzPeA=;
        b=YjesxH2H3c9q2kgTXPlJLxonA8o0wnZpNrSV8AsBQ8KFRlhNZr4SlDe+4AwB4aLNV9
         J2m9tpUKMYkcsF6YHHG1T7il7v41LJso4fnRRy3KMnuqkOCMqkgNy7mrt5GFXk2YjPD+
         B7RvmTJthnlknZVGmkPVQJtNH1gKnn6zehM1X9Re5gAI+K4Ry3J41rVTMCJ25qvSyCtc
         6D4EIrgtmeJw2gck9yDQyHK5Az07i8CQGM5kaZTigIaqkprmn8DzA4TvOJ54nxpFVlzz
         PSeUvXYn3FAzRWczMnRBBFOUEyNsg5jc3U5/5Rg6PWK8X++1FcpcGrkIq587pX+iZ2U2
         zLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654471; x=1729259271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IllKSGecey5qWktiICvboLBrDNTF07DwRxsCQfzPeA=;
        b=WLZm7CFsAaysuXN5QbbQWbEyVeGCldqKzGEOtCwvGqptU9p9jsNOy8dk4ryR8yJ7AK
         xC53xfT18dD6XuI9/6nEq/u5hIj8c2+Mh3GW0C6d3uE5qjcxl6Jo0YzaBm2ASvaZvHnX
         GR4F3DQxADqh20VGf42XBLk1C+gHoANRM7QvxanwYYVV3RFJYutZXV54Gm4OfQ2h+XnM
         av3/v57+DBDMyCgZgJAfgyNXt0BVjY2AeBlhvplOf+VwWRPTQoERBBwF/wR1UcPbioTB
         CD4CjvmJlQH5Xy1Kt8R5Ih59iAly+LeiNVmhe0fzuYBHOMwDg8dBsQfNhvxuwnk6kY1o
         ZY/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7ahn61zsKSMnbIk7Wv5sURneAyESO1Z8qF6XqF2r9Icqbi0+OsHqIT/e8u+iYlxcUN4AzkEQcDFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkX08eJDtHmhQD+nwgNguOzS7E1kzoNzJcPZHlm4X4TocwGrb
	RyijOQnFG1EJh49pxBV212scToSMrC862TZv8Y0f9FIndJu7UFIkocC9dBebda4=
X-Google-Smtp-Source: AGHT+IFlag4FfVRPYfOwmoRNQk/fTAWY8jzG3YeWFKLCMLYaHcTiK3JfGI/Bszqx8uRfq7yjIqm3hA==
X-Received: by 2002:a05:6830:7303:b0:710:f83e:111b with SMTP id 46e09a7af769-717d643ce86mr1662012a34.8.1728654471127;
        Fri, 11 Oct 2024 06:47:51 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717cff38401sm591578a34.35.2024.10.11.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:47:49 -0700 (PDT)
Message-ID: <807d35e5-f479-4c1c-9761-b9dbb086fabc@baylibre.com>
Date: Fri, 11 Oct 2024 08:47:47 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
 <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
 <71c4a073-1b5e-42d3-8fee-a2a5215d5856@baylibre.com>
 <CY4PR03MB33992328530A8AC613C7A6C79B792@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB33992328530A8AC613C7A6C79B792@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 6:27 AM, Miclaus, Antoniu wrote:
>> On 10/8/24 5:48 AM, Miclaus, Antoniu wrote:
>>>>> +static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *val,
>> int
>>>> *val2)
>>>>> +{
>>>>> +       unsigned int reg_val;
>>>>> +       int gain;
>>>>
>>>> Should be u8 gain[2] and...
>>>
>>> As discussed in previous patch series, the bulk operations won't work for
>> these
>>> chips. The CS needs to be raised between each byte read/written.
>>>
>>
>> So the datasheet is wrong and Streaming Instruction Mode doesn't actually
>> work?
>>
>> There is also Nonstreaming Instruction Mode if we need to read/write
>> nonconsecutive
>> registers without deasserting CS.
> 
> The chip was set to Nonstreaming Instruction Mode from the start in the ad485x_setup() function.
> 
> And the datasheet specifies (page 49 of 70):
> "In nonstreaming instruction mode, one or more SPI transactions can be provided in
> a single SPI frame."
> 
> So I guess it is an error in the datasheet.

So maybe regmap bulk operations would work if we change it to
Streaming Instruction Mode (along with the correct increment
direction)?


