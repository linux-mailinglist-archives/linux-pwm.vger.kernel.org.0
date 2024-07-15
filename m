Return-Path: <linux-pwm+bounces-2814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71461931B14
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4B1C21904
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C64130E4B;
	Mon, 15 Jul 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JPuuRaAF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5566E61B
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072282; cv=none; b=qisSWtWhhTMtRqZ61oEHuCzUYR/I1GwO7Pyd7yKJ+g2Lq8gcIMbYOZqp+opHMv+BqrmBjnurlDdsCtQTi9D3Jt4kiuK26B94BW3t3u385ba3Us3ylVnYFrb3jRkgPXayjKhxVDF+KxMGZVKW+OZkWWBJUgS9zrGnjASx2iMtnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072282; c=relaxed/simple;
	bh=Y8nRxveea1Pk+lgXW2CW3eFZFIsk5aB2qIkO+5RRUhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jErS9yHkpg3r/cq2eFv9VqV7RwsJf168RmKwuszroFFlzcP4kp4X/N5c5z+TiC3XG08HXiW4DmVIgmzthZIJKW0d//EwvhTwezGL8urhVHLjxPC0x63ikxyTQnB/aW3/HXI2gLw/cspAN6djA7oaQBIw70SRdsycIQppCfR4yik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JPuuRaAF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ce74defe43so883107eaf.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721072278; x=1721677078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEd+nf2hsGZIWhMcPczUfd86kyJ+Q7H4CIToaLWgtGI=;
        b=JPuuRaAFkLgYaVtlywwq7teGl7sxo8gHQUsVF5700wYHgwhLiNe0E0mwD+tGYyO+35
         h+AFV0vJlJZCr0wh+Q+SDtIWvOmfuSpTrhhmTnaphDUEUg4LFAuqwJDE9GzSqUvZKScY
         FAmZXX1q1uybvL1/Iq7oULi+Lij8t66WYMvRUdgF6KMUcXdBK7TJa1u3/8gF6eWQZzvZ
         I4O92n9Gmfo1D+9yIspgGEwvi59gmkv29EVMJ9IofYvN3Hf9u+wpnao4OW7xH+nLAHHm
         qlB12G3sQhyxZ8dhI1YHPQxuXoqaXQRwfR+M1eQMa4tkllh1qb+oSu5rl+ayYxpVv12I
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072278; x=1721677078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEd+nf2hsGZIWhMcPczUfd86kyJ+Q7H4CIToaLWgtGI=;
        b=wm3aZP27343gb3cF4oQhgFH3yeIBOe2atCVBKtkFsbkmTglImyfAoB4F6Wroe5Qy80
         MviVJGhuw0OKErpWXWZXRVX5a4YJ8QOWqHz+ltth5lflxXT2pTLdnY1X5cBN/37N34pw
         Tx7WwPLwBXGFRG4YGW2oBZJvT96lOROVRrvqAb/xaS/SolxGZ/aMrRDfS+gfsYLVzP+U
         bPh9D8UmoOLnbpKudiAYRXEFowzVq4yERW92/LK1e1dBYyRmr0Smnq+cqavym3pIjlz4
         FA17GmUk14HJEfEvha6huV8OM3xuJFzBQ/krPT30r50k1Q9FsaZYt1ZC3sAByEhtVSuw
         wf4w==
X-Forwarded-Encrypted: i=1; AJvYcCWe3n0yaVJ96iGAG3+gF5GqbxyS9ySpcbYexvoVjxOtv07u8Z8yu2l5Mwpioy0cVMzCK5PvZwHJzNhc2HePm8D4deEtyQrTTPAb
X-Gm-Message-State: AOJu0YwC4TcluQKw3Kx1Px8jpaTbct8H/JN3pbBMLue5DoQbCyoC+jEO
	U4BF7bjDTR6AstfGdBgXslSSrVOtaJIHPvZ8vkcnGAO1bYnzsgCBEr1UTXhx2WwllU9/mLJsjlr
	G
X-Google-Smtp-Source: AGHT+IGgXyK1yXiBnghBRCSGZUCYA2mByLJzmun3r9aBAhGLPqYv7VSAOuAQ8UyHQsmdMkumfXLlPQ==
X-Received: by 2002:a05:6820:1f03:b0:5c4:4aaa:d245 with SMTP id 006d021491bc7-5d288f470d7mr55175eaf.5.1721072278679;
        Mon, 15 Jul 2024 12:37:58 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce74df064esm944335eaf.6.2024.07.15.12.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 12:37:58 -0700 (PDT)
Message-ID: <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>
Date: Mon, 15 Jul 2024 14:37:57 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/24 6:16 AM, Uwe Kleine-König wrote:

> +#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)

What is the use case for PWM_IOCTL_GET_NUM_PWMS? This info is already available
from sysfs, and it doesn't seem like there would be any performance consideration
for using an ioctl to get the same info.


