Return-Path: <linux-pwm+bounces-4293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1D9E96D0
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DB1889A16
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29E1ACEBF;
	Mon,  9 Dec 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="twHfKoGU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE841ACEBE
	for <linux-pwm@vger.kernel.org>; Mon,  9 Dec 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750580; cv=none; b=dJnZP7qCrCECSMPWKxFtnX+X5NK+9DiMYJitg7ly0bobZKIZvVCEgEfYtdtaihncBagS45cZwanDjbLpvcrfPGsItN0XsjTBi1Xn4k+2nx1R8VgDqoAbIn5ObeUuV0blXbhMquwjXvYqulSzhzsqh+Yz9ry7wps6arfMrwh5Qq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750580; c=relaxed/simple;
	bh=obN/Fup3lM6BqgjXjChpYGnxmki/Om14WHmxJncGUEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxBTPjzckrOBUxekgF91NoxB8FIzhI7BL59FXmHkKa32TL5EvjuAsljbBRZdGGjF5fUXb62MYfC7tM+K7lOIOPWheVGKwG89LIa4IqV2dS5+VxUiYHhIOItOtiyPtZYajq7I6GkF/Az8PQkG+DLHZIMsN9cu0/b5WRPWszvBvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=twHfKoGU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-466847440a6so26430231cf.2
        for <linux-pwm@vger.kernel.org>; Mon, 09 Dec 2024 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733750576; x=1734355376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obN/Fup3lM6BqgjXjChpYGnxmki/Om14WHmxJncGUEk=;
        b=twHfKoGUVyVYNYJaZnO3UZMXGddtmX7o0j/LmGDMrCzVxzs5sbawoou1XV/zRw8VWm
         LpXRqWjI9UzvDC5lCQFAS+Jb+rkigl/jQjnmRa0PYZCMK4IM0BTsrNTBZzSbPaats9ns
         m+LLvEfZFGknYFVEeZ1S1DO0SIAEfZ9Cor8n2hGbLKmUEWhntK6XPmgco/fCK4nG6Mph
         SFE5QQNbMmfpVbYoDX9ZmOS50s44omEeHSnkFri3+7V5dz2l85rmxi/MElt7bj5iAl4f
         xOf7juhiJkaH78Akkxk1WHgf9sciudZWlgIBFQ02oV6C6b0gsKNhA2yZ3OlorH/Tkxe/
         GTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750576; x=1734355376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obN/Fup3lM6BqgjXjChpYGnxmki/Om14WHmxJncGUEk=;
        b=sNHhdPsoeLG1hs/ucnHRmANHwakGNVtW5RrS6hp4PvY+JNJyrIA1+lFGUAGDMgO0wg
         r1N71tvXbTbeDZXyopB0WpL/mY4HvcEPlfX2Jgh39q4JKlm5fhc3qd8QN8veHx127yyN
         WQ9TD59fFqmm50oWXULISaCkmCYmymNleENd6PmT+mZY2F8ZPAo8ZCnEAVQutk+uAQha
         dznxapOwqhEI4OtfSLMIjegAg6Ez9hctw47fnk0zDEmfgMDeiYGyWtoLvlblrCeBM0Po
         TUCnJkP4ADA4y35QKMyF1fQpCGv9aq8D2LZ+nRiJ8QRRTb+U2pKopIOixp0EowOVlklm
         EWsA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2JLS76ETjRJgfgaGuywCI97PgA5B1rEM3UqzXJSzIE3TXyAHiMheGyJy/cQAUNRAE+GSxol8H7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HG4mhTppWieGSDiAFpCmcFZcnyxn0KTzMHkMvWWmCXhRUB3e
	/oWWPKbVpjBiy3e2Sol/IslCGP1T153GL7giIAfqUdHfBlyKbmmDNdLta0C5ChXDen+U+pr/Mtc
	8
X-Gm-Gg: ASbGncuIx/cJn4NFHvtmIlDd28qNveKPcC431hOmQidJvzmsn7LZp5S1JlIUztgxJbA
	5PoXmrp+oZjMoLA5NlkHupZDRkjDFA2cYhBCNdK8RHoOjUkDa0kimBEO6ROI/8BJuN3Ab+Ck5um
	3uvxJuhOLODkTgbRCvIzGOedGuCzQ/PcyCgBFKPXww11O2bxHxf80dDspGB5GKvVJ6TD+qdtcIz
	AiL1br32GfNGkN6WvRkLINVyQoh2Nd0B8JhCuHhazL2Ld9cmb4dGhaYXtmSEUT2DL8QrAPvEvv0
	5Dglz79GU8glEsfDwQ==
X-Google-Smtp-Source: AGHT+IG+xAs73bYxu73v5slaTcLQjjeYSAx80IDn1MEZt7aBZNho+qYdCjkxNdOS01ULUhUnXJl6kg==
X-Received: by 2002:ac8:5fc6:0:b0:467:6505:e3c with SMTP id d75a77b69052e-4676505132dmr63004611cf.24.1733750575932;
        Mon, 09 Dec 2024 05:22:55 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672978dc20sm51086641cf.71.2024.12.09.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 05:22:55 -0800 (PST)
Message-ID: <b7706ac1-340e-4520-97d3-f8a65de78beb@baylibre.com>
Date: Mon, 9 Dec 2024 08:22:53 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
To: Chi-Wen Weng <cwweng.linux@gmail.com>, ukleinek@kernel.org,
 robh@kernel.org, krzysztof.kozlowski@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com
References: <20241206085501.2623772-1-cwweng.linux@gmail.com>
 <20241206085501.2623772-3-cwweng.linux@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241206085501.2623772-3-cwweng.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-12-06 03:55, Chi-Wen Weng wrote:
> This commit adds a generic PWM framework driver for Nuvoton MA35D1 PWM controller.
>
> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

