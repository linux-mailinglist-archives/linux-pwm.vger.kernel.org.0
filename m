Return-Path: <linux-pwm+bounces-5359-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9322A7DE48
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A3918870C9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E232512DB;
	Mon,  7 Apr 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QVJUwTwF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F672517B0
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030349; cv=none; b=PiTuCG1EybNoEBL8t6QmQnlBIJT6VO2QDxyAoeTDcJE+Rff0xNIEeDtavNLJHUYdAjtFz+7nQAWNKzWaaTEmMCGztlYGD1pIkB9iMoycQX7nTQJsGqZOy7OuEZGKPwNlGpvQIjal8DIdB8W3KD0wzs6XNhA+uO0oxHwMFv3rWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030349; c=relaxed/simple;
	bh=vvPy6WdiUPY2AXlM9TykqHpWcwjr0sYurFFOn0N16yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Okzdf34zlHFlN0JEVvfwcuxp3R+NNbJtb2bcHh996xY/M6X/sMmjqL4q6n47crCpuH6m6EIa3G21seKthdtzb2P87F0A5RVSTn0d8bqitbW51oQe+sRBQu6dq9BZt1HBQT9NocsQmw3WQdXU3bSPOK8vDHlAJOMjTtJ2Lrj+Xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QVJUwTwF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5e2fe5f17so434138985a.3
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744030346; x=1744635146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvPy6WdiUPY2AXlM9TykqHpWcwjr0sYurFFOn0N16yo=;
        b=QVJUwTwFf9YmJfPOG1l5HTRkD6PKKlinIM5Ls43GDLH2x+3k/5fX7sMbfKDZxlNneg
         o2O2GyIbO6J3sOx5I5kODMRz/zgqe6sWr/LgCZlMQF/ZqeTNDbMKRjlX68xs4/oX8IhQ
         fnv2HU1AQtHEOqB+I5s7HtmSY/T0ZpxNEDDDGYedSsnUmru/VhJ2RPb9R5bW0rtslZM6
         6b9o8i5NLQsdU0/ibnds4Je8CQworMDyBL8O/gp9uTTC3QP3XNOAOl2u9NBVeBnEK6MX
         E/fKLr7ymMdpf2YikgY0aSasAt4uawRLtvQeJb5AopmQiwxoYiyjYn0KjSVDx/Snyd6b
         44/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744030346; x=1744635146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvPy6WdiUPY2AXlM9TykqHpWcwjr0sYurFFOn0N16yo=;
        b=uRRI51s4OYJ8RgBMlS+mxXDuIglL8AtOCRS+gxKiwnehGmGARxXzOhr0TerYVTp+OA
         MFWgIpMfwZPJ6k4VLUwbPARsRTYNDJlmnuXl5Kazm63BcBLYnD+cM8U7t7hCwTHUngv1
         zgSyfOHUGp9twk7Sho0rcgmZzlHI79hoPsXya8s8NHv/yYtQ6H3yjrL7xjjwplSpIjvP
         Av6gbrh2GzkYNLcREZGyWi5xnHwWnRmrP/36NtfAUNSVgaCit6ZAcfOn/7Brpx6FoD/X
         aS+XUXiDA4FcxBDt3v+Ypw0yoRat9Lf6s8E5X60eHJ5JBbtN5ND1Oqrc+ztMhD7ZZtWr
         +LcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUImS3Ch1sE5iGNmoLMRXT/MqkdjoSYsAgG1sBN6Df0IjmbmgFiAEFr+9yS/T+lLCu7nj4pO8Y66dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LnS/wBQZhayFnOgj/t0j+iUjIP0gHDdpC9quWEs17TA6BHAI
	xLInfm1H/eqd8EvUjOr/eLb7NEb/niojXE5EKtmIZI2gcYVqgDIqIkiCgnC0x5ixnPrXf93D7Md
	VP0M=
X-Gm-Gg: ASbGncvd8nKsaUA6mqyCJqo06CUyEo/CGaVvj2mv2OeKb6cdL1iE99Wz82pQPRdmnJG
	SEb895YX60moJPfayDn2XlDRKELxTsBFb8wsbWSptS/Eb5SzwXtmtiynsEQEYPOeIW8J6NTacJ3
	nSpMJnW0kGn0Xm2bDPwOwWlyxI7A+b6UQEhModemEC/83V79pIldxEGLRsTwrLbFogF1k7X7AYC
	aMjoIS7ZlZqcLhL+X1QMvXc2lNaiXSgHlOmHY4yGP8X6hcSoxg2GYUDQsbEm/u0m633SRy1/5b/
	6F7PooSTRabOMS1PNg4AIcCxzPm2BE93NAgxRYIbrRRnchVO7IjdMYkuyeYez//NDU1ediGQTAF
	RaWia2MO/I8WB
X-Google-Smtp-Source: AGHT+IGXcePNxNTFGmlt8DxzrF/e7a/wPwFKCWoSc0AMn7K1eWotGvcxmZOjhszizP156b4/w+1gZQ==
X-Received: by 2002:a05:622a:1993:b0:476:aa7a:2f78 with SMTP id d75a77b69052e-47931113d77mr159226381cf.49.1744030345879;
        Mon, 07 Apr 2025 05:52:25 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b089e4asm61040901cf.47.2025.04.07.05.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 05:52:25 -0700 (PDT)
Message-ID: <910d7fc8-e4d1-4421-a118-b8a254a3fe37@baylibre.com>
Date: Mon, 7 Apr 2025 08:52:24 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] pwm: Let pwm_set_waveform() succeed even if lowlevel
 driver rounded up
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
 <353dc6ae31be815e41fd3df89c257127ca0d1a09.1743844730.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <353dc6ae31be815e41fd3df89c257127ca0d1a09.1743844730.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-04-05 05:27, Uwe Kleine-König wrote:
> Waveform parameters are supposed to be rounded down to the next value
> possible for the hardware. However when a requested value is too small,
> .round_waveform_tohw() is supposed to pick the next bigger value and
> return 1. Let pwm_set_waveform() behave in the same way.
>
> This creates consistency between pwm_set_waveform_might_sleep() with
> exact=false and pwm_round_waveform_might_sleep() +
> pwm_set_waveform_might_sleep() with exact=true.
>
> The PWM_DEBUG rounding check has to be adapted to only trigger if no
> uprounding happend.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

