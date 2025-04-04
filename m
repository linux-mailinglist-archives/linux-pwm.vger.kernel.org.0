Return-Path: <linux-pwm+bounces-5332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C3A7BCB7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABD9173B31
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995FF1C84DC;
	Fri,  4 Apr 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CfC3T2lo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F86194A59
	for <linux-pwm@vger.kernel.org>; Fri,  4 Apr 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770132; cv=none; b=hiX5brVC6Yh3iHPAXYO/7daGRgDdK4ISwoblCEH4Vd2mQYNgpngUsEDj0JMUiG7YpBKJuq2mORpVLRLm2YRCFQEHQsqg3KKtOaG+bs55ZLox51jaH0J/vKAUmcKAYbPyXG/yNPlY40SnoFXNxLDQ/DpLT9tPSoNEVtk+40g/6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770132; c=relaxed/simple;
	bh=+DpASX9e1MA8uI7FHBHEckAnT4qZ0GFVcITf5633XCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E0tYXf8xAbfppHxJucVRYqCEyY0E+nJ+w0IXAPH87K0bqo2nC1u2Xod8NM93qm6WddpLbng39Cd0CSiCRj0o37E4KF0+dNu7RiXyJSp2qsCS7eiTum/o2DVToqRD9Kmrf+qJ8ocly9fAmg1q6CQMjwEIG+jKkWlsGSsEun1ml8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CfC3T2lo; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso17931366d6.1
        for <linux-pwm@vger.kernel.org>; Fri, 04 Apr 2025 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743770128; x=1744374928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DpASX9e1MA8uI7FHBHEckAnT4qZ0GFVcITf5633XCo=;
        b=CfC3T2lo2YeGHqbnIl9vBUdAmydTvmwRntOZODP8YcL3bQP9jISNVxd6FkeG1XPyvW
         SKIuvQHal0WGeXxOXKjDqqmfk7KySTjHVUSaHwzBEu0DHrNUKkb2DxKUbNgXl8auPibN
         X9yLT4HZnxtMhGE2CpzGg+F72qHSeIQUAM6rzPlFgtPIoQBdDPmQMuHgyJo82IEuwOAB
         Y5JRsPVfQKlFUghZ4EEaJ0FMrRMx0LQ3KS8rC6H0vhSa9x5bUwSAwSJC1jynT+1/8RSR
         tHkkjE3Z0Duv/hL3AOk0g96dnxEzGZARndRPnv0CqjM2XdKGemb/pFgviBPVOPGTYZKC
         exqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743770128; x=1744374928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DpASX9e1MA8uI7FHBHEckAnT4qZ0GFVcITf5633XCo=;
        b=D+779gSlEuvVlABIg9OlJc6Z0LXor9G86jAjj9Mz+eztOcvzCtmGs70PlCj5f3Qy4B
         kAKEe97WW0Qy5Hb7KeqPv6BWOceKAMFRgkK7jGUsHsAWrPFe8kfqd2fKfugmNWLqrtkd
         /1WTH7zGgCmjQDxV10yaQAfpCO9Mjn3o+rGuGongZqSnDetg7APGqpTuaYQ4aSbSWfQ1
         YgN5H0/Hl7jr+cUOFYrjzL1WJu90ZbuNJp0epCsUWIOC3DjfdM61mpC4PNkBj3c0ewTm
         M/6LJTbUsygh226MEU8Fpr0IU6rKKYf7VfoMouWFFennpBOHC35HAYaOfYpRzgWTMEZ3
         DkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAQ5GaIiyJrtWta9b1nraRJiBvFh0gYTcND+F5xMN9JbbBLK+2sBQXTKcXNQI1DjQ6XBDD/E0qa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJZWXPinfW6pJJufxuNTRqelgcEC+hT7Q4bAwSGu3aqvgajx3
	qNoKQ9/Q9LKegf472LxbXSw5DOXq+P9P73GlEHVRUIl4vRkdusNz6+zcVvpVoVN9XHvs41JBGEm
	qEdU=
X-Gm-Gg: ASbGncvWd/iHRHC0/NUOikk5lIf8MHAnd4DvORw/aXpt1dOlBZUd7ripmMYe81WFowI
	F6w44Yjc2PxKR8aISzz5RYNgX73/H70R+KXmgNeJqds/xt3PF37gcCYscoQIRqXBh7dt03NYS3X
	4gmQ5bhkbkLZpqzqtbTkYdYcsLdsL0f0NhUsBBlqjy69Wy9InFMVqTPhKxzdW9iH5/MVGzr4FrB
	UvUGY/V60gU1CH+nP5OYAWci2vBfriN+r6T76DDmvCE8I9R3tmLxewQSTHrSbYPmO4A7IXYMOWU
	/GzT9tMTCGzo1v4nubQeWt5V4ifAbDleH0m1hqQcTZH7DxQHK33ETg84REVXY+ppm4Kv2E6Ydho
	DQlj9aZK2WDKL
X-Google-Smtp-Source: AGHT+IGk7R0FkC2WmHTdZZGZP4nGZf6yttXiRhxSveVfnRTT0HGJ6TnNhcEBodv1aHNAf5MxwkqUeA==
X-Received: by 2002:a05:6214:19e2:b0:6eb:2fd4:30bd with SMTP id 6a1803df08f44-6f064aef171mr29167726d6.30.1743770128121;
        Fri, 04 Apr 2025 05:35:28 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f138d68sm20788766d6.75.2025.04.04.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 05:35:27 -0700 (PDT)
Message-ID: <86734011-f5af-4645-bab7-699f235b6884@baylibre.com>
Date: Fri, 4 Apr 2025 08:35:26 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: Add actual hardware state to pwm debugfs file
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
References: <20250404104844.543479-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250404104844.543479-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-04-04 06:48, Uwe Kleine-König wrote:
> Traditionally /sys/kernel/debug/pwm only contained info from pwm->state.
> Most of the time this data represents the last requested setting which
> might differ considerably from the actually configured in hardware
> setting.
>
> Expand the information in the debugfs file with the actual values.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

