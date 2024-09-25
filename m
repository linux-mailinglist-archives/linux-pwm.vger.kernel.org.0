Return-Path: <linux-pwm+bounces-3360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03D9855AA
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 10:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB56B28418E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C015AD9C;
	Wed, 25 Sep 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lXZBOhQZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB142132124
	for <linux-pwm@vger.kernel.org>; Wed, 25 Sep 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253658; cv=none; b=Q9y22/VhZ12M7DSiTVcoCLuWiFREscdKxtyDFx4chswOKPw3uAqKD96Th9RVNi0aUb2IjAH8A5UUTpqadUt5a664VHR19UUjEpeP27NkHUgEJRjmmeJ8dcgYnXepTkvsk2VUwZjl9EvKTMG4TsNucBg/Nx1gmemzhwMD8Msjk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253658; c=relaxed/simple;
	bh=jzyeuOdmRqFn80/1joF8rMUBJXOJ48ZG0kA33e5fids=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE1KjvOWLuBPTfOBJEhlfY9jWwPuUovzN1y4Ilc6hSVcb8VOS0Rt/TOKuhgNYDD/dC9RXYktVLuIZOm8Yoanun6TQs8IzXRMatIekKtqyoprP8TtiYP+PX0uqvd5gp9NPFaLdqlcz+Hk6+at+2Z1G9qi52BlELTwRxcNw7R+p5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lXZBOhQZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso82326625e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 25 Sep 2024 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727253655; x=1727858455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gWh62e+9y3kqU90XZJ9SkxqBQCkgI99AUyA38n5F+A=;
        b=lXZBOhQZN+T9yricYMTA2PDuu5+ojKm5mcBblvECYF+zal58qwIhOiUbnMCMYruptJ
         bVoqXi3u61bQP/ws+AL337hRn22laDcc9nruOB7aBeiZg4D/x6FNmDs/+krCt8B8jsV2
         OQNU7Ki8FUUDRjwnE5mXlBN4CR5j6CcfGoasC7Qx1m7EA0Tw7EkxVSt3lRGTY82uTswl
         W0El6VlJWOK/oUaxORJoybhDRM4IJXqgLGtfQqDJSqNaXJa2Uk2DUGyrDh9HGn/TN0pY
         Z//CCAcjaJi6RJXqtLUDp5YPAdRP11j3Ebmf120SCTKc8xak0QxNAwStBGAzaGj1yOI/
         KYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253655; x=1727858455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gWh62e+9y3kqU90XZJ9SkxqBQCkgI99AUyA38n5F+A=;
        b=kjxIQin6/xZhFs4Syx2tio56+nDzs8L8vAHwpvzWEZ1gfnuPStZzmpg0u7L+14Uxpp
         RgDEReugRIeHXZtAWYvq61B3IiHSdugYEMmSEOPeehDbeZfdvSTph2VmLSyY7P24xyDL
         SvxoaxgTmK0xp/1WYlAkJtkFiBf+MEsERTOho+uWrquu42IYV5/cYN6zcBNVI4lQFptX
         vkflwXQ4xfGZ0r3bLcEXgKazQZuLngxwDcqipGz98F2npz/eimQfJ6xDMb5BhAOi+gjY
         jwoMlpwglNUn+qZ09pdl6TKylRvmGUovAOdLTjlEkoLqTgupWM0eqUdfABMRtg7Gx2/z
         /nOw==
X-Forwarded-Encrypted: i=1; AJvYcCXktJ31pxYT4CpOnzwqhn/8oLwTDrTKK4N1Omk3axB0DDuQoi1WYOXrgrKDlqtTOaRYbwMl6BrQpxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgwlm5foWlHmMzhxMPo8qzZV1OeZFEv5rMhl0BvEP7v6D0HQVO
	A50fuQFZR4CxuoKlhcd6+Jk9OWRTJ5Ycp+kl5dtrFNatb8B9MhAX8fcs5fL7E3M=
X-Google-Smtp-Source: AGHT+IH+9QVv57tkAFLswE82YK+fkKh996SQzxAWIqrqV2XZmJ2sMvCo6rPEjeuCpgizS1gmWqKNFQ==
X-Received: by 2002:a05:600c:4451:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-42e96242baemr14438675e9.35.1727253654873;
        Wed, 25 Sep 2024 01:40:54 -0700 (PDT)
Received: from [10.2.5.161] (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36287sm11223985e9.29.2024.09.25.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 01:40:54 -0700 (PDT)
Message-ID: <1ff1aaa7-7478-4b0c-a1ad-c119a11695ba@baylibre.com>
Date: Wed, 25 Sep 2024 10:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, jstephan@baylibre.com
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
 <CAMknhBGOn_vhvHJU8g89A2TDmA6yFv9urpZ4A96jOMLdTtR-Bw@mail.gmail.com>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <CAMknhBGOn_vhvHJU8g89A2TDmA6yFv9urpZ4A96jOMLdTtR-Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/24/24 17:28, David Lechner wrote:
> On Fri, Sep 20, 2024 at 7:33 PM Guillaume Stols <gstols@baylibre.com> wrote:
>> On the parallel version, the current implementation is only compatible
>> with id tables and won't work with fw_nodes, this commit intends to fix
>> it.
>>
>> Also, chip info is moved in the .h file so to be accessible to all the
>> driver files that can set a pointer to the corresponding chip as the
>> driver data.
> This sounds like two unrelated changes, so maybe we should have two patches?
Those changes are closely related to each other, in the sense that we 
now gather the ad7606_chip_info structure directly from the id or match 
structure, and not anymore the id which is an index where you can get it 
as an element. I will update the commit message to highlight it more.
>
>
>>   static const struct of_device_id ad7606_of_match[] = {
>> -       { .compatible = "adi,ad7605-4" },
>> -       { .compatible = "adi,ad7606-4" },
>> -       { .compatible = "adi,ad7606-6" },
>> -       { .compatible = "adi,ad7606-8" },
>> -       { .compatible = "adi,ad7606b" },
>> -       { .compatible = "adi,ad7616" },
>> +       { .compatible = "adi,ad7605-4", &ad7605_4_info },
>> +       { .compatible = "adi,ad7606-4", &ad7606_4_info },
>> +       { .compatible = "adi,ad7606-6", &ad7606_6_info },
>> +       { .compatible = "adi,ad7606-8", &ad7606_8_info },
>> +       { .compatible = "adi,ad7606b", &ad7606b_info },
>> +       { .compatible = "adi,ad7616", &ad7616_info },
> Since we have .compatible = , we should also have .data = for the chip info.
ack

