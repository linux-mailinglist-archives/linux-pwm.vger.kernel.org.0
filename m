Return-Path: <linux-pwm+bounces-6944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD6B19DF9
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA32A16D4A3
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547E239E79;
	Mon,  4 Aug 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HZ9NsFYa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596A242D9D
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297402; cv=none; b=PCgR+R6VL4Vi5DQCAhj/6FUJXY+Y762eeVIHREwYliy7P269IwomO7HiQQqsf6cXyYpdIGwQufLvkBbPaM2k5WcPSQZMXaFnN68QAbTG44fV31Z/2wk4geSqZBP2JdjXXPuKZcaR2AqEU0/0cBH+vUrvFnbWBXqwqAooSuc4cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297402; c=relaxed/simple;
	bh=naqlfPKLXvb78dqLVocaBDc2QnhdiYMy5h3X2PMZnCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAnEpvntzlvq7F5YQ5CD7OfOf1C7YR40GhhynlaDnp6naGrZgpZe0EstMXgW6VZ5hd1WeKd90nUALlQoXCDBcZ9JpJDghkoSXhUS/yvN5782HGUIT0udvYnusNIOOWenFc1HgFzbGauT2WlIXH6HlazQ1vZoO1BL2a/2epcvE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HZ9NsFYa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297397;
	bh=naqlfPKLXvb78dqLVocaBDc2QnhdiYMy5h3X2PMZnCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HZ9NsFYaPzGXFEYCS6bOtJFzBi88MZL2y1sDBABQC9PxhjgaFgbg9jFtCpbAIMzeq
	 H6tTkbZnsBO4IGEJhbRny54r+vsng06HizbsUa840iB6F/c4hBSsM+42jUdKR7KsTg
	 Rpq0JN9hp9sl5Lkc1YQpoy5zzYZ08RzBYcruHetdwSyAKQH+6/3NaYJDEElLOyfUxd
	 2JC6+G4U5O1wJ5+IFree3ZB3qLYDttYFmBc4fOjolrbR4XcCodGDaQsGfBgvAHVI8O
	 UFJuF8F0VRtKuhPxz2t/Tcm9gDWwOAz0a3FWG9gHx0xGJ4WaQ6IGh4rapbOmQE7qhx
	 wqWtT/tDdtHng==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66C7217E0B8C;
	Mon,  4 Aug 2025 10:49:57 +0200 (CEST)
Message-ID: <3ec8df0d-5c2e-4c2e-a48a-333f904b56c8@collabora.com>
Date: Mon, 4 Aug 2025 10:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] pwm: mediatek: Implement .get_state() callback
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-15-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-15-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> The registers can be read out just fine on an MT8365. In the assumption
> that this works on all supported devices, a .get_state() callback can be
> implemented. This enables consumers to make use of pwm_get_state_hw() and
> improves the usefulness of /sys/kernel/debug/pwm.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



