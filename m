Return-Path: <linux-pwm+bounces-5360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F744A7DE4C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 14:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5433A8CD0
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F02512DB;
	Mon,  7 Apr 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NcpuByQk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3A250C1E
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030370; cv=none; b=njvEfynj4b6kbzbxhuZZLEPmQ4g9K6zvD5AHjuduqyUnwxIn0z3UKopYEiVRKENKdbyepk335JNIvfLpqMfU8L4sLwqAZsj5dn6OWn7j4akOPahhPNhKC/mxUG09/qR74gZUBv4ADFq2MuzF+tubOjIUDCfdx/sV8SYXnPgbv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030370; c=relaxed/simple;
	bh=UXiS6e53ATjOlg1moLZoLxv1EVd80kQyo2/El27n4ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGtWw2Zl7DxEJwIYT49HNpJMDXW2KJ33NAUUxef09NqdJNzXu4lON7IaRXCR6QLC4491/4PvkKzETJNxzw4pnlC/mPgaoGvqr7PHfDqSzlKgWyXU5HKCsNTq6LspmaGoKXUeQuXXAv7xuT+Rm/l7JfM+qf+2zXMBziCjFN3oMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NcpuByQk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c546334bdeso349216785a.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744030367; x=1744635167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXiS6e53ATjOlg1moLZoLxv1EVd80kQyo2/El27n4ho=;
        b=NcpuByQkxZHwkER1s7yM+CjwKLhf/6elDU088bRMFHXGiNR4QPpxV/SWgKfZiU2KbG
         TdecuOkz+6WLFAijtBDrfn/BGWabxD4fE4FkHyiMu8OVEihosibzAG5FpKPOPWLPVsN8
         Jmm+GatMe5vtE+AKpyncvMKIHLXS6I18Sfxq2tUt3yE+V0FjRXB20JSxL2PDT1LBJQHU
         UKyY95bXpCG4Wi/kF4E0OHQZJKv3piFlW4vPdhlpNNZE0k48pet1T7sPRdTZgM1vFoU2
         uP569FMxt3hv0f8+O/gHriOsc6s8G+xGR9GvzvLoF3WEkld717Ov9tc6IFoUsq/FUVG8
         0VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744030367; x=1744635167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXiS6e53ATjOlg1moLZoLxv1EVd80kQyo2/El27n4ho=;
        b=JZ8I/DuGRwG8P4nR77eSKywoNml/b6hM254upgXtt9j9PutcgJN9MhIoCiy1J9+fMF
         Z0R/APlgnmpxCOcI/VhLu76K8uFf7k7/451P8O1avG9Vxuf+6SIKIDoDN1xDIhsnXHZw
         6+w5LFOgmnrSgNF8yRoka/u8mym62ABMYBgqxuMDUIDVNv9d7WGE7UKF4OAz2zKn9UAC
         BkwYrs+tRYx0T2AZdu1EksWtzbGg4QP5uGuowV7JTFoJlwGDlgn+BaXHfEjNClsN8QI/
         XMpm0+pxEmnkNBVg6+utj5lpob6LhnCfEOLTeESgibOAAuVpnYOBtYA39Hz6VHQbaMh+
         UZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCW8bfqeuaK7KX1ymR5RJfQRItPJeKZPEvpa2wlDUhZmh2Y+QqKRW9QxcKY5D0Rj+YRY29/9pPsngv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9QztDIRmV+/iWnltyAbEQQ/lZjprOmZkWVRuuNIc7plphKVb
	Jl3TOqsl9kvyTM8CZMA939byQStqgOMQ7UwCMX0+HfGGBxBcC8tGwZQKLTVnuJY=
X-Gm-Gg: ASbGnctqW6fQYgLzLgaal5Jec/80g88sAS7ZfpbL9EbtbfowMR2/9sW1w1phrwWy4Uo
	xdeDtsten+FTlzhxF3DlMLhOlpNZkZ66Upd1IiJGlZ1qZ/Iuv8Wg9Um4D85CPmxkX8ol5m1UqN9
	V3/15STH+MNhZ25GqPNtt/wcxpjhkNsrb68QUsgY0G2PPBdaK+8QGE9jii08YpOA0ejIRe1iGL6
	p0jqIQrrGXjF+7wp2i9HC7Zi77CJxsf0ddu05salxE/jvX5Q3R9b0qNJlRjE5OffGDEHfWFErLh
	FkP4lbgJfVmBBuwqoVfN1Cq500/c3kfKZswvyJRmwxwQ+bA/UgsG8m8VA+IxPQ9Az3AGTnQEzwR
	lDUfZ6XhbYbN5
X-Google-Smtp-Source: AGHT+IFFujGf8/OpT8lH0erz6NHkVOvjXDhEBDliLgfZynIA49mD0iVlLuLiU9XRQecKr/w9OCmcAQ==
X-Received: by 2002:a05:620a:801c:b0:7c5:3c69:2bce with SMTP id af79cd13be357-7c774d1c888mr2175938985a.7.1744030367654;
        Mon, 07 Apr 2025 05:52:47 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea58d71sm591892685a.89.2025.04.07.05.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 05:52:47 -0700 (PDT)
Message-ID: <7de1c05b-5f52-4bd7-ac3f-ca5688d39a5d@baylibre.com>
Date: Mon, 7 Apr 2025 08:52:46 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] pwm: axi-pwmgen: Let .round_waveform_tohw() signal
 when request was rounded up
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
 <ba451573f0218d76645f068cec78bd97802cf010.1743844730.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <ba451573f0218d76645f068cec78bd97802cf010.1743844730.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-04-05 05:27, Uwe Kleine-König wrote:
> The .round_waveform_tohw() is supposed to return 1 if the requested
> waveform cannot be implemented by rounding down all parameters. Also
> adapt the corresponding comment to better describe why the implemented
> procedure is right.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

