Return-Path: <linux-pwm+bounces-6527-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA04AE78DE
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86571174D75
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0A215055;
	Wed, 25 Jun 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCMP9xau"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A8214A9B;
	Wed, 25 Jun 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837213; cv=none; b=P+jXjgjvcOHUOaUngMs+6w9JKIldO005CqOzSs80GkADOxs8iDdMctxlEo1hpNvvvKIG3uRFJ7LHU3qQm33J9csXt8Qh6gVn8LZEgBLGti/8et/n99CJTbJNjm+jjIcisdFKBMMCba0/qfV4YeAGFmowJ1xkHevO7ER7T4I9hSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837213; c=relaxed/simple;
	bh=Tnexy8VIH2rQcef019z5Q6p6P0/V1A80bedmE0nhGHo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VewrfZ8CDmPIhyVXpMxVit7m6i7odJB0YBov0fUscHnF4tneAmoUa9pFVHtJ6zPZQFHfkSFIXKD7H+d22tjZ52yigLAqKXCKMP3uLPZ8siMxei4LpRPtu5t1pQJ7VJW+QMNFOdMayoQkk2ODASX5ZSItoD7pBlLOifw3NlALVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCMP9xau; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso13645045e9.3;
        Wed, 25 Jun 2025 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750837210; x=1751442010; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u9dfcbXzjyN5uJZUzeEbPouxlZY5x+kHr1IrKlsLHzA=;
        b=TCMP9xauhJ13Nt+SefResNlyV6vxb5os9V6Y794xfLXTOsTfljCW6LwJwk3XNxeqki
         MAqI+qE6whngTowklqtlnKkpe09v+ln0ao9BvjiiJx/GYvNAkF7h8YQfD/E0r8Gw+3P0
         TxRKMBxq4maJ9Xquf385wcHtg3RSOLmoiT1BQPOr+fwXUnXX8MIP4+KYaNSkuldnN8QL
         tKRPvwAuEy6iZhSQWU9+EjVoki7Jo/9MNQB4QL3jo/4eKHisCSQ+ZyWg4lWenC31RNqQ
         oTG+MW7o/Z76BKRbslK4h+Po2FCbGc1UxL6pcGkd/Y+r/HN3vBQu/CiF1R6hgnZIQpuJ
         P02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750837210; x=1751442010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9dfcbXzjyN5uJZUzeEbPouxlZY5x+kHr1IrKlsLHzA=;
        b=YgRq67Zv3jUHwF9yrQHZSlsDE6rFYDuLfUFa60awIHFzxnTdz3P6EtKXLhfVUdPliF
         OYlzE4xJCoGhptZDLtXHRRCPnOJ3f8CqEOW+LKiMQPTnCHC7ml6iwj1tuJlCL2zKhxr4
         oGGyNf2YnebDhemsgB6LFDOrkeCI9cyH5CGzc4wQJw6ZWBlD08ApKO+BP6XhLiNcyIXE
         vBracjc/6JkUkf98FyjuV8SqAAZnGbY7PyOy+/Y06S5nhY5XPbMKUP+GJsIC0JVtTeY4
         +QDMUNA45Y9hzdMYab6kdqV5Czy7/vHifawn23YWm7ENoC8o0M2qQ+wGTVEC2J4KJgPD
         onkw==
X-Forwarded-Encrypted: i=1; AJvYcCWOcieRpPQSzXTqbIkAwQf1KkIxW0gCtjEAyxg+nhcaoxhf/yautv7RThr38QuHl+AXk8KVRWedqPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPpky4sGjdbHjMn9cmJn4rIBs1tyfXOYai7JkSDO9sFTs3ijc
	YfZLwoNRQfPangZD3AA/d2oGOTiSlq5GihyxloXvKGD/RtioGFkeAs13xae2vQ==
X-Gm-Gg: ASbGnct+KMHwQ4aMS0C3y7u0otrzJ3rN+Pdc/ljgu/X1xIAosLnJIQz/AQBUnWL3ReA
	4nhgeUrq3GUWoSsw0tLa5wP0YymXD7v8wR9SCURIN24VOcp0fHuZhDL+W90f1cpGhhJVQTQTKtg
	E0O+nXUWVaSchTuTQMqLhug0JiDcQQ9DOUXBlAnrK4p7gd95o/en5t1vjI6LzvLfLSefuGFVJXR
	rSXi/Cs7mhYEp9JaRriAO2CWnja6xuUe3/pKJu8bXUo5JLU7+icFMxYR9tTsNRLFm6U/jwr3hpz
	arXURjMQcDkBm+WskLszJiyiY3vq0VzPIAKI+MQOTJAFfaPjzDint9CYM6hD8MLWlFoE6YpysoW
	OtjM/cRGC6OWzh83HaQ==
X-Google-Smtp-Source: AGHT+IGkQ1tH1+xzBKxq0vaFTbX5sbnDYX6TLamLzgi0XZ3tgNq6GHnfKBMqaGPYeQ0qTOamr3Orlg==
X-Received: by 2002:a05:600c:698e:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-45381b0f4b5mr16759765e9.19.1750837209929;
        Wed, 25 Jun 2025 00:40:09 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d1e2sm3819663f8f.24.2025.06.25.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:40:09 -0700 (PDT)
Message-ID: <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>
X-Google-Original-Message-ID: <aFun18bVVcWfkdFl@Ansuel-XPS.>
Date: Wed, 25 Jun 2025 09:40:07 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <20250625000059.20040-2-ansuelsmth@gmail.com>
 <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>

On Wed, Jun 25, 2025 at 09:24:33AM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Wed, Jun 25, 2025 at 02:00:39AM +0200, Christian Marangi wrote:
> > +	/*
> > +	 * Period goes at 4ns step, normalize it to check if we can
> > +	 * share a generator.
> > +	 */
> > +	period_ns = rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> 
> I don't understand why you need that. If you clamp to
> AIROHA_PWM_PERIOD_MAX_NS first, you don't need the (expensive) 64-bit
> operation. If you compare using ticks instead of ns you don't even need
> to round down, but just do the division that you end up doing anyhow.
> 

Correct me if I'm wrong but 

#define NSEC_PER_SEC	1000000000L
#define AIROHA_PWM_PERIOD_MAX_NS       (1 * NSEC_PER_SEC)

doesn't fit u32 so an u64 is needed.

And using ns until the apply process is handy for bucket sharing. I can
change it to reference ticks but I think the round is necessary.

You want to change everything to reference tick? (honestly this is a
good chance to introduce this missing API, since I feel also other might
benefits from this)

-- 
	Ansuel

