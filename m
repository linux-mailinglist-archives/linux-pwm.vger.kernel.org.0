Return-Path: <linux-pwm+bounces-6110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB158AC28B1
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84334E7398
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A3296FC2;
	Fri, 23 May 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wbth+dAX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88D81749
	for <linux-pwm@vger.kernel.org>; Fri, 23 May 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021612; cv=none; b=kSr8D08R43DhlaX+xtWbR9DlJ5w/QYOQ9Pa1ZUTgDJE1k61fqBqG1Vzstfzu+rpCg5OfvYvf+dWHdnMRMpQhONFKErGRWuI+9ceNwB5uJQRQj7s+QbGTEIQvbVckd3HjvvofgHG0GvHKhDsiFby3eBjh1e2IlRPebE5dwnHCgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021612; c=relaxed/simple;
	bh=qt/HVkr9zL2lJNeN6p4tMwnsp0x3rx/30xKqdVxveFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpWSBZ8dYk4+q16SQI43peZavfhlyixAcmPRHcVr9eEeGyCNv8zPQOOKmv9Bnaj4uFtm79xNoQhF7ekD5SItood8jvHj7FU8JI87CFtu5SVyIcujoMoO6S/SasCl5XI/OC8veRYmA7VUX+a7qoyw6s1v7rx0NPgmqb2i8F22IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Wbth+dAX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8cf00d96fso1085606d6.0
        for <linux-pwm@vger.kernel.org>; Fri, 23 May 2025 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748021609; x=1748626409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qt/HVkr9zL2lJNeN6p4tMwnsp0x3rx/30xKqdVxveFw=;
        b=Wbth+dAXzBz7lwOEsCJZTtABNMJFUPNXtpVH5pdm0cKiz4a/FumZ/GwF8dp+73P2ep
         dEWQGvXf06lLcEcjKDiWu9IQdXzxJmU8QXElXPvfTsfpYJNs9WGSdrPtVYIJ16a09bv2
         McuNVBhP3VxVaV8M0BWgSJj0yPR0LS30RNn4aKcO8cEoQZiYf98CNJBMCknO+qJperM+
         HNuw9WcAtuFpuz5smi4wF7BDWpyLR8ak2xlPit6jtXD84EJCHFEMBykw4QscnD/hIbN/
         9ePn2rEGOK19OLAIEm6ArBJPFPCkAvdD7QoEz0k9GIGo49Cor8QWNRwHv2/eOzaVYIhi
         /jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021609; x=1748626409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt/HVkr9zL2lJNeN6p4tMwnsp0x3rx/30xKqdVxveFw=;
        b=m/796mkbwdzk+FQBZLLW4k5x+xDJjg+qM7gOy5Fald5d5pZsCRU4yYJXiLmo9sXi1m
         MfBjI6HYt45swsCKKodE5hHLV3nXJPSlu11oJm8IEi2kfDfGFMPd0iF68sBNj4qS9S8Y
         HBs6zZbyUNAWEg4woomoBFhKB+oey6qAqo4UJmO1mL8iUAA7/CAavKNnrSh7lfCH9T4G
         P6IGxbSHMsQZE6VSiGd7fh5OTxsXttPCeD0+BEbF4mN6HxivJTifUPIF1mi+UGJQ00Cj
         k5MI3a1K6MzPxF+I6oaesduRtcvu5JjVS2mGbGlQHn6Vt+/Bxn8UqppPrF2ygJezlsAT
         DHbg==
X-Gm-Message-State: AOJu0YyyUEBmJNajlfmhokOums5Vxju3zbMPV+tDW+WHcs939g0+cRYn
	uJ1lPqwBHEACInjCcw9w4sXixgiDBs6AN6Ai9zEagTcJGMu5n+buFGCDZgEx8Ls/8So=
X-Gm-Gg: ASbGncvzEgt3RR/l/qQypjEtL3oI3jxk+oZSBjnbYB4+lUnefsHPX1YotqGxQltruRc
	KdijcELvO6pjgmt3FFo4KumOmBmI3zc/GbHNnk1/cWyUj0JdMoTqnrELZThD/JswZB2f39ugoS6
	3YjCYcG/iOo7U1//kRtJGk9Fw0kBO4G9nmnAoT0PMMrM+IPN8jAJGTnNUnW8NMYY1R1NmGMWc3g
	GdF+8yiUTVbGwiPGXd2UVN129UVSawCG7+GG9CwWbYP2BE+KtI/3Mo5szZzp0pt9TvOq0RcIRBE
	IWXKlADB7sSElZNgH1Vh/e1fBGnaMkXSLJJdCIOGQ3iv1q3c5NF/YFhu2fY5P2IntAep0tGXe5H
	uFhBUP8L6EAwhaWdSWnc=
X-Google-Smtp-Source: AGHT+IGfoUQU6tMr9zPYUJ6jdUAQDnehNSnxPg9FvM8hXpb+wki2yPOFQiObmL3C04ljtIMxkfbFrg==
X-Received: by 2002:ad4:5dc4:0:b0:6d8:a1fe:7293 with SMTP id 6a1803df08f44-6fa9d2ec0dcmr4244776d6.42.1748021609392;
        Fri, 23 May 2025 10:33:29 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08afb37sm117198226d6.49.2025.05.23.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:33:28 -0700 (PDT)
Message-ID: <b8b0f11c-844d-4925-a8fb-cb92cc93f8cf@baylibre.com>
Date: Fri, 23 May 2025 13:33:26 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pwm: axi-pwmgen: fix missing separate external
 clock
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com>
 <20250522-pwm-axi-pwmgen-add-external-clock-v2-3-086ea9e6ecf0@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250522-pwm-axi-pwmgen-add-external-clock-v2-3-086ea9e6ecf0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-05-22 10:49, David Lechner wrote:
> Add proper support for external clock to the AXI PWM generator driver.
>
> In most cases, the HDL for this IP block is compiled with the default
> ASYNC_CLK_EN=1. With this option, there is a separate external clock
> that drives the PWM output separate from the peripheral clock. So the
> driver should be enabling the "axi" clock to power the peripheral and
> the "ext" clock to drive the PWM output.
>
> When ASYNC_CLK_EN=0, the "axi" clock is also used to drive the PWM
> output and there is no "ext" clock.
>
> Previously, if there was a separate external clock, users had to specify
> only the external clock and (incorrectly) omit the AXI clock in order
> to get the correct operating frequency for the PWM output.
>
> The devicetree bindings are updated to fix this shortcoming and this
> patch changes the driver to match the new bindings. To preserve
> compatibility with any existing dtbs that specify only one clock, we
> don't require the clock name on the first clock.
>
> Fixes: 41814fe5c782 ("pwm: Add driver for AXI PWM generator")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for fixing this!

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>


