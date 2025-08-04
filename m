Return-Path: <linux-pwm+bounces-6938-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86741B19DF1
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434FA3A5164
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9A23D294;
	Mon,  4 Aug 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lt4LunEh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD581917E3
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297375; cv=none; b=jCYL49gktSnM2dOGjtQfcJh2Y3BVZ30eikzkqaF/ZNHJMIHFZNAvtQtlOKMJFOK7iCPu9/Uv+YQ9OouE9Uh087eOOkSfpD62b0jluJpyrHD3swckQ+Tb2YYS4rZhXqFxW4Pu9iIFdDzyNP3g241zmLqditxDOob/CHyXVsLqc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297375; c=relaxed/simple;
	bh=kEGNcRKii091OoZOGBge+aHBW6zYX0bGJrlr0K3nWNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhHTvkduXyYuFglT2Q+YFAB4zhgZQt90jQYR1p4k/I8SoGhOHXr60aLsvz5+pQve9W9Pt9lNuiV43hNflSf9MJSwSBiiEeGjwwnAw2vpFR8e4ZAH7KpHHN6iwAIdJZf3OO/1IbbsgOAgbvYqltjyL8pV9Bq34wuWkKWtgNCbwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lt4LunEh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297372;
	bh=kEGNcRKii091OoZOGBge+aHBW6zYX0bGJrlr0K3nWNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lt4LunEh6xeDTdscoj61LEXgzFVU3LukujP6O2+cDi4VCjOw0rdF+GDsJzH5d2bQb
	 aE7xUdrIULgB6iNNO29i/cxHYGAmgmGfYaN63Z9iNvPKL0ZbDWxsCqcW0YKDaHvjQ0
	 UR4bwwwMmTR8P+eLFhATB7OsFEYn7fgcIDd8Ai9fMcDP2IUnd/CU0x5ZijxKdbwQlF
	 R6IZCSu5YEZERGMo6U8RghFdvshVOpcd4+UBSmGWEKPlQnINUcAqXBphTAMrqYwL7X
	 5KS3dLO0iT68XqpSUz2DuRlINkIBwPlkfgVR8/qtwG6XKRivHA7f/USgxeI9nryYmS
	 TDZzECPwqw4HQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB10D17E048E;
	Mon,  4 Aug 2025 10:49:31 +0200 (CEST)
Message-ID: <75a48820-a79d-41f3-9e96-b49332865eb0@collabora.com>
Date: Mon, 4 Aug 2025 10:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] pwm: mediatek: Convert to waveform API
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-18-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-18-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> Implement the new waveform callbacks which makes the usage of this
> hardware more flexible and allows to use it via the pwm character
> device.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



