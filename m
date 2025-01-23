Return-Path: <linux-pwm+bounces-4723-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB38A1AA50
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 20:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA98F188AF07
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294619B5B8;
	Thu, 23 Jan 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JMcoJ/Pg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C41BC4E
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660500; cv=none; b=mNKQg58RhZ8OG3rFxK1wF1rC43c74EUNEKWkMSlpIxE5yxI2tPqbg02Ozn24B1Q2Z745i3Ok+meu2hvP8SMPVIp7Et0dlTY7LdqV9UFT+s2Pm4k2ZIlTRIJQxS9I1dgsb6efYVRCCaFxMoonhDkI5nnnu53PyqT7w10AUz8m27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660500; c=relaxed/simple;
	bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvsFCdS7wFyK0njfDZnXS3aY5AX2yyKJ4zeuK72wuy+Qwc26MOD8IKpC3JLj7JbekyKM6wWhGuTl2L+2mf+pS6B6tNYbpp/8IX3fJ+/4xhYkLD2ypH6P7rP3Rxc/GtKrk0PzskqJ3NaV8wjFVmgreyWxehEzG/1lfLLrUW/qa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JMcoJ/Pg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46b1d40abbdso13393041cf.2
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737660496; x=1738265296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
        b=JMcoJ/PgwFATpOaSzQgsSKTvSrL22YCvDst8F6+ynjDewGatEOtqAHaKbBYrGaiSx1
         d9LYH8gKpOvQV2vHtDEfuOKuaMK0qhjBp9MzRXJvLn4BzPiTXO0cMCP8AC72CWpIRNoY
         AMaUGgpunXNenM0A8RANDWfBwweWu5GW61cakaIYfEgQr5gsco5EIQunVKsesqaxT6OS
         F1Z5ZNYkDPRJX9jgWvPSeiZBgEkyAmB7CgkcACSvrZVW08bI3R95ub/3M7lBsmO7h7/U
         3C4bjOyIRgcE7jdq+cL+LCYTvFCK5xYGG0lfK3lweX1iNA7pnsN5Z/U6lhTt+ygCsn2e
         GGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660496; x=1738265296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuLzbHGlNaVAXq6vPQ5Q6FydJO9jqhGmAg11BhVz9kU=;
        b=wSuCXVr5UiKfUAGd0a9S0Es2BHc5tl6sV7pIhktzpmR44ggctvVZb8Q3cUc5lc7DTT
         qJos2ti/fiPyXP8yRcJHN9xEiCZX7AKthrA1jG/2bBGd3/C9WNt0wkzsmq3FSo25tdFC
         CDXSGojsf1M4h9JzeJ/7t4jq57hsyorbyDl6WnkFIfL0+YN7nEinDvj6KR6sOOogl49Z
         dVG22Ej5F0YI/MFuAqna5Vb2TblekWBK/H7G3r0dwDem2k3b7WNf4k/fXv45IWjzLcQr
         HQie3f4uwnnslgOHIzXyjGrvNjJTjCv/vbXZCFyq0Ycje9nfE62nv3/VgE00O0yWalk0
         JY7A==
X-Forwarded-Encrypted: i=1; AJvYcCU7+8JWqBfHAU5Q4afCn5lYIaMcEDrDc2O3bYDl3E0OvCXp6uQlBGaJAfOESLynhWYoR1xUjquStio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0BrCtDbGToibmZmuJH1xm/i0s3MVui9JWfQRY+gEJsBmTBv5
	ts8+gy0gdaZfmweT3DHWrtC1NIPrq1yAEWxmfibDBtTKU0nPNB4zGa9AekXT02seAYJlaq5DAjg
	w5v4=
X-Gm-Gg: ASbGncsFlPuTpGntDtC+Qij72caTKDRCTvH4QCnjRe/TCGv2LMf2RvQRP/EG/QMJXow
	CmvVcT86255XWxXJkxvDbHzJkr/grnQjDdwzKUYQE1D4I9BQBWZ5XgHQTIA6VgUoO2D3Q0z/vaq
	p60JBQreszCSBImUnVBimOY9jeYkVbsjdQOfUC8RoFJN3HBHPNfLpWBCdO1lWZnp2lR1W4XN1N3
	ubearHv+G/GmwGSZgpLg2tXDucQ6r/IVC+u9YF3gkkDg+j7oeX1Clz8IawDBwIWhRtMPQk4syK3
	MHwsHQP3Q0ICN1H3qtHfxTf38f9SgBjedXEmZMRXICRqUedu
X-Google-Smtp-Source: AGHT+IHWuxy8lfcXRYEhJrnCbOsrkKR5OyVH+rveZqlHizJec8u1DneLTp+thr6+Zyl0btizwNn75A==
X-Received: by 2002:ac8:7d50:0:b0:46c:7276:eda6 with SMTP id d75a77b69052e-46e12a252cemr349090251cf.7.1737660494476;
        Thu, 23 Jan 2025 11:28:14 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e666d0e3fsm2188611cf.0.2025.01.23.11.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:28:13 -0800 (PST)
Message-ID: <bb204680-2c60-4928-8c3b-e87b1dfa39e7@baylibre.com>
Date: Thu, 23 Jan 2025 14:28:12 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: Ensure callbacks exist before calling them
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250123172709.391349-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-01-23 12:27, Uwe Kleine-König wrote:
> If one of the waveform functions is called for a chip that only supports
> .apply(), we want that an error code is returned and not a NULL pointer
> exception.
>
> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

