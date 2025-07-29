Return-Path: <linux-pwm+bounces-6902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C2B14BED
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A929B7A226B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF89263F4E;
	Tue, 29 Jul 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ULbWeeMO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DE19F135
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783675; cv=none; b=D9WrvVZReXmBugQDE1Hzt2NCCgabG/WVnorrzIHIExEaDTCAxD6EiORKnaaj0aBJ/WzbLroNC5CYJQNEFGxfGIruhPEVhVAX5rLxFF80At2+hUMw5q88rzHJoYgCVFa+r746GX0I3rI0HekI2mHXwT7LVZiMlifL/vYJRt3xhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783675; c=relaxed/simple;
	bh=o/WtOzmD0eqgF0NqPyOK0K28rcV98y6nu4G49mqiIsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkojluCL8TRo9sSsokKVotfcJEeOXQm/jpgIzHrWoTGggKzW4/h7cV8mWy9jkInzbqihbBBFJhsigsa3pM5GGJ3zbWMM9ysBuinpvd0fkBVamzHNN7l7q3fWcraTzmqr7XPvZdtrjkPdxuu8bP2W6MO3JSONGSgY7CBIxPMDeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ULbWeeMO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753783664;
	bh=o/WtOzmD0eqgF0NqPyOK0K28rcV98y6nu4G49mqiIsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ULbWeeMOHHXy+5q8edRndOYyouEGmLDHksHpclNESI2LteyNpH3PGnB8mgBneH4/W
	 B/E0352vsKkUHOhBDCMzRTucAJdjw/p1CnU1wExUBj/Wct+TqP65RjQoI3Mpb/R/CG
	 vyCbVzpt+H6NN7XHMdJ09rL3qyVwwWK8nwA8K/nKNK+zg4tH7CnhFQIYuDG+eKHTRt
	 W62fgblpj/QZbDJlqP/UUlpU5DOHQnVTMaRphPSmvgvRQ6gUkOfXX/vjkt/oG/rqvv
	 GuVZsYa87WprCnIJeoRj5bK8Qf7h1VjjKfrLN69Yk6oZlLPDFQHPNJj/oF6A3i0jrj
	 kSwWK9pO7LBdQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F46317E1315;
	Tue, 29 Jul 2025 12:07:44 +0200 (CEST)
Message-ID: <bb4d8100-ceb2-4ce1-bf27-86fe21ce2aad@collabora.com>
Date: Tue, 29 Jul 2025 12:07:43 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] pwm: mediatek: Fix duty and period setting
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 28/07/25 18:00, Uwe Kleine-König ha scritto:
> Hello,
> 
> here comes v3 of the (formerly patch, now) series to fix duty_cycle and
> period setting for the mediatek PWM driver.
> 
> v2: https://lore.kernel.org/linux-pwm/20250724210041.2513590-2-u.kleine-koenig@baylibre.com
> 
> Changes since v2:
> 
>   - Split changed clock handling into a separate patch (suggested by
>     AngeloGioacchino)
>   - Drop
> 
> 	if (err < 0)
> 	        return err;
> 
>     just before an unconditional
> 
> 	return err;
> 
>     .
> 
> 
> I didn't add a R-b for AngeloGioacchino yet, as it felt wrong to do that
> for a patch that he didn't see before. So assuming you're happy, please
> provide the tag again for this v3.
> 

For the whole series

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> v1: https://lore.kernel.org/linux-pwm/20250710163705.2095418-2-u.kleine-koenig@baylibre.com
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (2):
>    pwm: mediatek: Handle hardware enable and clock enable separately
>    pwm: mediatek: Fix duty and period setting
> 
>   drivers/pwm/pwm-mediatek.c | 71 ++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 34 deletions(-)
> 
> base-commit: 68b9272ca7ac948b71aba482ef8244dee8032f46



